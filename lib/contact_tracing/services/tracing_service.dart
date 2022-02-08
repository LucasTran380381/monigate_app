import 'dart:convert';

import 'package:collection/src/iterable_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/common/service/dio_client.dart';
import 'package:monigate_app/contact_tracing/models/close_contact.dart';
import 'package:monigate_app/database/db_helpers.dart';
import 'package:monigate_app/notification/models/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

final tracingServiceProvider = Provider((ref) {
  return TracingService(ref);
});

class TracingService {
  final Ref _ref;

  TracingService(this._ref);

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

  Future<Database> _openDb() async {
    final path = await getDatabasesPath() + '/monigate';
    return await openDatabase(path);
  }

  syncData() async {
    late final Database? db;
    try {
      final path = await getDatabasesPath() + '/monigate';
      db = await openDatabase(path);
      // await db.delete('closeContacts', where: 'isSynced = ?', whereArgs: [0]);
      final result = await db.query('closeContacts', where: 'isSynced = ?', whereArgs: [0]);
      print('needSyncedCloseContacts: $result');
      final needSyncedCloseContacts = result.map((element) => CloseContact.fromMap(element));
      _saveToDb(needSyncedCloseContacts);
      db.close();
    } catch (e) {
      db?.close();
    }

    // final pref = await SharedPreferences.getInstance();
    // await pref.reload();
    // final json = pref.getString('close_contacts');
    // if (json != null) {
    //   final List decode = jsonDecode(json);
    //
    //   final needSyncedCloseContacts = decode.map((element) => CloseContact.fromJson(element)).where((element) => !element.isSynced);
    //
    // }
  }

  clearTracingData() async {
    final db = await _openDb();
    db.delete('closeContacts');
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
      final userIds = closeContacts.where((contact) => contact.date.compareTo(date) == 0).map((contact) => contact.contactWithUserId);
      return CloseContactForManipulation(date, userIds.toList());
    });

    result.addAll(filteredContact);
    return result;
  }

  Future<void> _updateCloseContact(Iterable<CloseContact> closeContacts) async {
    final db = await _openDb();
    final batch = db.batch();
    for (var value in closeContacts) {
      batch.update('closeContacts', {'isSynced': 1}, where: 'id = ?', whereArgs: [value.id]);
    }
    await batch.commit(noResult: true);
    await db.close();
    // final pref = await SharedPreferences.getInstance();
    // await pref.reload();
    // final json = pref.getString('close_contacts');
    // if (json == null) {
    //   return;
    // }
    //
    // final List decodedList = jsonDecode(json);
    //
    // final localData = decodedList.map((element) => CloseContact.fromJson(element)).toList();
    //
    // for (var value in closeContacts) {
    //   localData.firstWhereOrNull((element) => element.id == value.id)?.isSynced = true;
    // }
    //
    // print('localData : ${jsonEncode(localData)}');
    //
    // pref.setString('close_contacts', jsonEncode(localData));
  }

  noticeCloseContact(String userId, int dateRange) async {
    final day = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    final date = DateTime(year, month, day).subtract(Duration(days: dateRange));
    final pref = await SharedPreferences.getInstance();
    await pref.reload();
    final json = pref.getString('close_contacts');
    if (json != null) {
      final List decode = jsonDecode(json);
      final noticeDate = decode
          .map((element) => CloseContact.fromJson(element))
          .where((closeContact) => closeContact.contactWithUserId == userId && closeContact.date.isAfter(date))
          .map((closeContact) => closeContact.date);
    }
  }

  Future<List<DateTime>?> findCloseContactDate(Notification notification) async {
    List<String> whereArgs = [notification.sourceUserId];
    for (int i = 0; i < notification.dateRange; i++) {
      final dateString = notification.dateReceived.subtract(Duration(days: i)).toIso8601String();
      whereArgs.add(dateString.substring(0, dateString.length - 4));
    }
    final db = await _ref.read(dbHelperProvider).openDb();
    final whereCondition = 'contactWithUserId = ? and date IN (${('?' * (whereArgs.length - 1)).split('').join(', ')})';
    final result = await db.query('closeContacts', where: whereCondition, whereArgs: whereArgs);
    final dates = result.map((element) {
      final dateString = element['date'] as String;
      return DateTime.parse(dateString);
    }).toList();

    print('date: $dates');
    return dates;
  }
}
