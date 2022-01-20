import 'dart:convert';

import 'package:collection/src/iterable_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/service/dio_client.dart';
import 'package:monigate_app/contact_tracing/models/close_contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tracingServiceProvider = Provider((ref) {
  return TracingService();
});

class TracingService {
  startBle() async {
    final result = await const MethodChannel('dev.lucas.tracing').invokeMethod('startTracingService');
  }

  stopBle() async {
    final result = await const MethodChannel('dev.lucas.tracing').invokeMethod('stopTracingService');
  }

  Future<String?> getHistory() async {
    final pref = await SharedPreferences.getInstance();
    // await pref.reload();
    return pref.getString('scan');
  }

  syncData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.reload();
    final json = pref.getString('close_contacts');
    if (json != null) {
      final List decode = jsonDecode(json);

      final needSyncedCloseContacts = decode.map((element) => CloseContact.fromJson(element)).where((element) => !element.isSynced);

      _saveToDb(needSyncedCloseContacts);
    }
  }

  clearTracingData() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('close_contacts');
  }

  void _saveToDb(Iterable<CloseContact> closeContacts) {
    if (closeContacts.isEmpty) {
      return;
    }

    final body = _convertToManipulationModel(closeContacts);

    try {
      DioClient.instance.post('/CloseContactHistory/bulk', data: jsonEncode(body));
      _updateCloseContact(closeContacts);
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  List<CloseContactForManipulation> _convertToManipulationModel(Iterable<CloseContact> closeContacts) {
    List<CloseContactForManipulation> result = [];
    List<DateTime> dates = [];

    for (var value in closeContacts) {
      final isNotDuplicate = dates.firstWhereOrNull((date) => date.compareTo(value.date) == 0) == null;

      if (isNotDuplicate) {
        dates.add(value.date);
      }
    }

    final filteredContact = dates.map((date) {
      final userIds = closeContacts.where((contact) => contact.date.compareTo(date) == 0).map((contact) => contact.userId);
      return CloseContactForManipulation(date, userIds.toList());
    });

    result.addAll(filteredContact);
    return result;
  }

  Future<void> _updateCloseContact(Iterable<CloseContact> closeContacts) async {
    final pref = await SharedPreferences.getInstance();
    await pref.reload();
    final json = pref.getString('close_contacts');
    if (json == null) {
      return;
    }

    final List decodedList = jsonDecode(json);

    final localData = decodedList.map((element) => CloseContact.fromJson(element)).toList();

    for (var value in closeContacts) {
      localData.firstWhereOrNull((element) => element.id == value.id)?.isSynced = true;
    }

    print('localData : ${jsonEncode(localData)}');

    pref.setString('close_contacts', jsonEncode(localData));
  }
}
