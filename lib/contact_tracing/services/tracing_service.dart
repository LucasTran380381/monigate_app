import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/service/dio_client.dart';
import 'package:monigate_app/contact_tracing/models/contact_tracing.dart';
import 'package:monigate_app/contact_tracing/models/tracing.dart';
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
    final json = pref.getString('contact_tracing');
    if (json != null) {
      final List decode = jsonDecode(json);

      final List<ContactTracing> contactTracings = [];
      for (var element in decode) {
        final contactTracing = ContactTracing.fromJson(element);
        final notSyncedContact = contactTracing.contacts.where((contact) => !contact.isSynced).toList();
        if (notSyncedContact.isNotEmpty) {
          contactTracings.add(ContactTracing(contactTracing.date, notSyncedContact));
        }
      }

      print('contact tracing: ${jsonEncode(contactTracings)}');
      // final notSyncedContactTracing = decode.map((element) {
      //   final contactTracing = ContactTracing.fromJson(element);
      //   final notSyncedContact = contactTracing.contacts.where((contact) => !contact.isSynced);
      //   if (notSyncedContact.isNotEmpty) {
      //     return ContactTracing(contactTracing.date, notSyncedContact.toList());
      //   }
      // });
      // _saveToDb(tracings);

      try {
        await DioClient.instance.post('/CloseContactHistory/bulk', data: jsonEncode(contactTracings));
      } on DioError catch (e) {
        print(e.error);
      }
    }
    // pref.setString('lasted_sync', DateTime.now().toString());
  }

  clearTracingData() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('contact_tracing');
  }

  void _saveToDb(Iterable<Tracing> tracings) {}
}
