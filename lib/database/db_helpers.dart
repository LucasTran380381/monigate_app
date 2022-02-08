import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

final dbHelperProvider = Provider((ref) {
  return DbHelpers();
});

class DbHelpers {
  Future<Database> openDb() async {
    final path = await getDatabasesPath() + '/monigate';
    return await openDatabase(path);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    print('update db');
    const sqlCommand = 'create table notifications(id text primary key, sourceUserId text,dateRange integer)';
    db.execute(sqlCommand);
  }
}
