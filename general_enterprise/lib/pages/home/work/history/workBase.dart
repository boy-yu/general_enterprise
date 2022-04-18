import 'package:enterprise/tool/funcType.dart';

class WorkDateBase {
  Future<bool> judgeIsexist() async {
    List list = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="Work"');
    return Future.value(list.isNotEmpty);
  }

  Future<bool> createTable() async {
    if (!await judgeIsexist()) {
      await db.execute('''CREATE TABLE Work(id INTEGER PRIMARY KEY NOT NULL,
        workType TEXT NOT NULL, workStep INTEGER, workStepNext INTEGER, context TEXT
      )''');
    }
    return true;
  }

  Future<bool> dropTable() async {
    if (await judgeIsexist()) {
      await db.execute('DROP table  Work');
    }
    return true;
  }

  insertTable(int id, String workType, int workStep, Map values) async {
    await createTable();

    // print(values);
    // db.insert("Work", values);
  }
}
