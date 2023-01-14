import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final _tablename = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('not null db');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE $_tablename (id INTEGER PRIMARY KEY AUTOINCREMENT, '
              ' title STRING, note TEXT, date STRING, '
              'startTime STRING, endTime STRING, '
              'remind INTEGER, repeat STRING, '
              'color INTEGER, '
              'isCompleted INTEGER)');
        });
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task task) async {
    print(';insert');
    return await _db!.insert(_tablename, task.toJson());
  }

  static Future<int> delete(Task task) async {
    print(';delete');
    return await _db!.delete(_tablename, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> update(int id) async {
    print(';update');
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
''', [1, id]);
  }

  static Future<List<Map<String, dynamic>>> query(int id) async {
    print(';query');
    return await _db!.query(_tablename);
  }
}
