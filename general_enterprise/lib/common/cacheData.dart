// cache table
import 'dart:convert';

import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CacheData {
  bool _change = true;

  set change(bool value) => _change = value;

  Future<bool> judgeTable() async {
    List list = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="CACHE"');
    return list.isNotEmpty;
  }

  Future<bool> createTable() async {
    if (!await judgeTable()) {
      await db.execute('''
        CREATE TABLE CACHE(
          id TEXT PRIMARY KEY NOT NULL,
          workStep INTEGER,
          context TEXT
        )
      ''');
    }
    return true;
  }

  Future<bool> dropTable() async {
    if (!await judgeTable()) {
      db.execute("DROP TABLE CACHE");
    }
    return true;
  }

  Future<dynamic> queryTable(
      {@required int id, int workStep = 0, @required String router}) async {
    await createTable();
    List _list = await db.query("CACHE",
        where: 'id = "$router$id" and workStep=$workStep');
    return _list.isEmpty ? [] : jsonDecode(_list[0]['context']);
  }

  saved(
      {@required int id,
      int workStep = 0,
      @required dynamic context,
      @required String router}) async {
    await createTable();
    if (_change) {
      await db.insert(
          "CACHE",
          {
            "id": router + id.toString(),
            "workStep": workStep,
            "context": jsonEncode(context),
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
      _change = true;
    } else {
      await db.delete("CACHE", where: 'id = "$router$id"');
    }
  }
}
