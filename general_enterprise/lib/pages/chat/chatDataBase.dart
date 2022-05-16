import 'dart:convert';

import 'package:enterprise/tool/funcType.dart';

class AssChat {
  String groups, message, time, userID;
  AssChat({this.userID, this.message, this.groups, String time})
      : time = DateTime.now().toLocal().toString();
}

bool isLoading = false;

int timeindex = 0;

class ChatData {
  Future createTable() async {
    isLoading = true;
    await db.execute(
        'CREATE TABLE CHAT (time TEXT PRIMARY KEY,userID TEXT, message TEXT, groups TEXT)');
    isLoading = false;
    return Future.value();
  }

  Future dropTable() async {
    await _judgeDbIsExit();
    await db.execute('DROP TABLE CHAT');
    return Future.value();
  }

  Future _judgeDbIsExit() async {
    List list = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="CHAT"');

    if (list.isEmpty && !isLoading) {
      await createTable();
      return Future.value();
    }
  }

  assginData(AssChat data) async {
    await _judgeDbIsExit();
    timeindex++;
    await db.insert('CHAT', {
      "groups": data.groups,
      "message": data.message,
      "userID": data.userID,
      "time": data.time.toString() + timeindex.toString(),
    });
  }

  Future<List> chatRecord(String groups) async {
    await _judgeDbIsExit();
    return await db.query('CHAT', where: "groups ='$groups'");
  }

  Future<List> chatList() async {
    await _judgeDbIsExit();
    List _list = await db.query('CHAT',
        // where: "userID != '${myprefs.getString('account')}'",
        groupBy: 'userID');
    return jsonDecode(jsonEncode(_list));
  }

  Future<bool> delete(Map map) async {
    await _judgeDbIsExit();
    await db.delete('CHAT', where: "groups ='${map['groups']}'");
    return Future.value(true);
  }
}
