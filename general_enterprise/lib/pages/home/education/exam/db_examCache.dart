import 'dart:convert';
import 'dart:math';

import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

enum TopicTye {
  singe,
  mutiple,
  input,
  judge,
  FAQs,
}

class ExamCacheType {
  String question;
  List<String> choose;
  List<String> anwser;
  TopicTye type;
  String parsing;
  List<String> sumbit = [];
  List<String> topicList = ["单选题", "多选题", "填空题", "判断题", "问答题"];
  bool isRight = true;
  double grade = 0.0;
  double getGrade = 0.0;
  int id;
  String get typeString => topicList[type.index];
  ExamCacheType(
      {this.question = '',
      this.choose,
      this.type,
      @required this.anwser,
      this.grade = 1,
      @required this.id,
      this.parsing = ""});
  static List<String> getAnwser(String correctAnswer,
      {bool formalExam = false}) {
    List<String> answerList = [];
    if (correctAnswer == null) correctAnswer = '';
    if (!formalExam) {
      List<String> strs = correctAnswer.split(";");
      for (int i = 0; i < strs.length; i++) {
        answerList.add(strs[i]);
      }
    }
    return answerList;
  }

  static List<ExamCacheType> assgin(List topicData, {bool formalExam = false}) {
    List<ExamCacheType> data = [];
    for (int i = 0; i < topicData.length; i++) {
      switch (topicData[i]['questionType']) {
        // 1_单选2_多选3_填空4_判断5_问答
        case 1:
          List<String> _choosed1 = [];
          if (topicData[i]['aOption'] != null &&
              topicData[i]['aOption'] != '') {
            _choosed1.add(
              topicData[i]['aOption'],
            );
          }
          if (topicData[i]['bOption'] != null &&
              topicData[i]['bOption'] != '') {
            _choosed1.add(
              topicData[i]['bOption'],
            );
          }
          if (topicData[i]['cOption'] != null &&
              topicData[i]['cOption'] != '') {
            _choosed1.add(
              topicData[i]['cOption'],
            );
          }
          if (topicData[i]['dOption'] != null &&
              topicData[i]['dOption'] != '') {
            _choosed1.add(
              topicData[i]['dOption'],
            );
          }
          data.add(ExamCacheType(
              id: topicData[i]['id'],
              question: topicData[i]['questionMain'],
              choose: _choosed1,
              anwser: [topicData[i]['correctAnswer']],
              type: TopicTye.singe,
              parsing: topicData[i]['parsing'],
              grade: 2));
          break;
        case 2:
          data.add(ExamCacheType(
              id: topicData[i]['id'],
              question: topicData[i]['questionMain'],
              choose: [
                topicData[i]['aOption'],
                topicData[i]['bOption'],
                topicData[i]['cOption'],
                topicData[i]['dOption']
              ],
              anwser: getAnwser(topicData[i]['correctAnswer']),
              type: TopicTye.mutiple,
              parsing: topicData[i]['parsing'],
              grade: 4));
          break;
        case 3:
          List<String> _choosed = [];
          if (topicData[i]['aOption'] != null) {
            _choosed.add('');
          }
          if (topicData[i]['bOption'] != null) {
            _choosed.add('');
          }
          if (topicData[i]['cOption'] != null) {
            _choosed.add('');
          }
          if (topicData[i]['dOption'] != null) {
            _choosed.add('');
          }
          data.add(
            ExamCacheType(
                id: topicData[i]['id'],
                question: topicData[i]['questionMain'],
                choose: _choosed,
                anwser: getAnwser(topicData[i]['correctAnswer']),
                type: TopicTye.input,
                parsing: topicData[i]['parsing'],
                grade: 4),
          );
          break;
        case 4:
          data.add(ExamCacheType(
              id: topicData[i]['id'],
              question: topicData[i]['questionMain'],
              choose: ['正确', '错误'],
              anwser: topicData[i]['correctAnswer'] == '正确' ? ['A'] : ['B'],
              type: TopicTye.judge,
              parsing: topicData[i]['parsing'],
              grade: 2));
          break;
        case 5:
          data.add(ExamCacheType(
              id: topicData[i]['id'],
              question: topicData[i]['questionMain'],
              choose: formalExam ? [topicData[i]['aOption']] : [],
              anwser: [],
              type: TopicTye.FAQs,
              parsing: topicData[i]['parsing'],
              grade: 8));
          break;
        default:
      }
    }
    return data;
  }
}

class ExamCache {
  Future judgeTable() async {
    List list = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="Education"');
    if (list.isEmpty) {
      await createTable();
    }
    return Future.value();
  }

  Future createTable() async {
    await db.execute('''CREATE TABLE Education (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      textBook TEXT,
      testQuestion TEXT,
      alreadyQuestion TEXT
    )''');
  }

  Future dropTable() async {
    await judgeTable();
    await db.execute("DROP TABLE Education");
  }

  Future getList(int size) async {
    await judgeTable();
    List data = await db.query('Education',orderBy: 'id',limit: 3);
    List textBook = [];
    data.forEach((element) { 
      textBook.add(jsonDecode(element['textBook']));
    });
    return Future.value(textBook);
  }

  Future writeTable(Map map) async {
    await judgeTable();
    List find = await db.query('Education', where: 'id = ${map['id']}');
    if (find.isEmpty) {
      final value = await myDio.request(
          type: "get",
          url: Interface.getEducationQuestionLibraryByresourcesId +
              map['id'].toString());

      if (value is List) {
        await db.insert('Education', {
          "id": map['id'],
          "textBook": jsonEncode(map),
          "testQuestion": jsonEncode(value),
          "alreadyQuestion": jsonEncode([])
        });
        return Future.value(true);
      } else {
        return Future.error('获取试题失败,请稍候重试');
      }
    } else {
      return Future.value(true);
    }
  }

  Future<Map> getTextBook(int id) async {
    await judgeTable();
    List str = await db.query('Education', where: 'id = $id');
    if (str.isNotEmpty) {
      return jsonDecode(str[0]['textBook']);
    }
    return {};
  }

  Future<List> getAlreadyQuestion(int id) async {
    await judgeTable();
    List str = await db.query('Education', where: 'id = $id');
    if (str.isNotEmpty) {
      // print(str[0]['alreadyQuestion']);
      List already = jsonDecode(str[0]['alreadyQuestion']);
      if (already.isEmpty) {
        List textBook = jsonDecode(str[0]['testQuestion']);
        List<ExamCacheType> data = ExamCacheType.assgin(textBook);
        double grade = 0;
        data.forEach((element) {
          grade += element.grade;
        });
        if (grade < 100) {
          return data;
        }
        List<ExamCacheType> reData = [];
        calculationGrade(data, reDate: reData);
        reData.sort((a, b) => a.type.index.compareTo(b.type.index));

        return reData;
      }
      // this detail with cache topic
      return already;
    }
    return str;
  }

  calculationGrade(List<ExamCacheType> data,
      {double grade = 0, @required List<ExamCacheType> reDate}) {
    if (reDate == null) reDate = [];
    List<TopicTye> _tye = [
      TopicTye.singe,
      TopicTye.mutiple,
      TopicTye.judge,
      TopicTye.input,
      TopicTye.FAQs
    ];

    Random _random = Random();

    for (var i = _tye.length - 1; i > 0; i--) {
      int j = _random.nextInt(data.length);
      if (_tye.indexOf(data[j].type) > -1) {
        grade += data[j].grade;
        reDate.add(data[j]);
        data.removeAt(j);
        _tye.removeAt(i);
      }
    }
    if (grade < 90) {
      calculationGrade(data, grade: grade, reDate: reDate);
    } else {
      if (grade == 92) {
        reMain92(grade, data, reDate);
      } else if (grade == 94) {
        reMain94(grade, data, reDate);
      } else if (grade == 96) {
        reMain96(grade, data, reDate);
      } else if (grade == 98) {
        reMain98(grade, data, reDate);
      }
    }
  }

  reMain98(double grade, List<ExamCacheType> data, List<ExamCacheType> reDate) {
    for (var i = 0; i < data.length; i++) {
      if ((data[i].type == TopicTye.singe || data[i].type == TopicTye.judge) &&
          reDate.indexOf(data[i]) == -1) {
        grade += data[i].grade;
        reDate.add(data[i]);
        break;
      }
    }
    if (grade == 98) {
      successToast('系统无法补足100分试卷，本次考试满分为98分，请联系系统管理员补充题库');
    }
  }

  reMain94(double grade, List<ExamCacheType> data, List<ExamCacheType> reDate) {
    for (var i = 0; i < data.length; i++) {
      if ((data[i].type == TopicTye.input ||
              data[i].type == TopicTye.mutiple) &&
          reDate.indexOf(data[i]) == -1) {
        grade += data[i].grade;
        reDate.add(data[i]);
        break;
      }
    }
    if (grade == 94) {
      int length = 3;
      for (var i = 0; i < data.length; i++) {
        if ((data[i].type == TopicTye.singe ||
                data[i].type == TopicTye.judge) &&
            reDate.indexOf(data[i]) == -1) {
          grade += data[i].grade;
          reDate.add(data[i]);
          length--;

          if (length == 0) break;
        }
      }
      if (grade != 100) {
        successToast(
            '系统无法补足100分试卷，本次考试满分为${grade + 6 - length * 2}分，请联系系统管理员补充题库');
      }
    } else {
      reMain98(grade, data, reDate);
    }
  }

  reMain96(double grade, List<ExamCacheType> data, List<ExamCacheType> reDate) {
    for (var i = 0; i < data.length; i++) {
      if ((data[i].type == TopicTye.input ||
              data[i].type == TopicTye.mutiple) &&
          reDate.indexOf(data[i]) == -1) {
        grade += data[i].grade;
        reDate.add(data[i]);
        break;
      }
    }
    int length = 2;
    if (grade == 96) {
      for (var i = 0; i < data.length; i++) {
        if ((data[i].type == TopicTye.singe ||
                data[i].type == TopicTye.judge) &&
            reDate.indexOf(data[i]) == -1) {
          grade += data[i].grade;
          reDate.add(data[i]);
          length--;
          if (length == 0) break;
        }
      }
    }
  }

  reMain92(
    double grade,
    List<ExamCacheType> data,
    List<ExamCacheType> reDate,
  ) {
    for (var i = 0; i < data.length; i++) {
      if (data[i].type == TopicTye.FAQs && reDate.indexOf(data[i]) == -1) {
        grade += data[i].grade;
        reDate.add(data[i]);
        break;
      }
    }

    int length = 2;
    if (grade == 92) {
      for (var i = 0; i < data.length; i++) {
        if ((data[i].type == TopicTye.input ||
                data[i].type == TopicTye.mutiple) &&
            reDate.indexOf(data[i]) == -1) {
          grade += data[i].grade;
          reDate.add(data[i]);
          length--;
          if (length == 0) break;
        }
      }
    }
    if (grade == 92) {
      int length = 4;
      for (var i = 0; i < data.length; i++) {
        if ((data[i].type == TopicTye.singe ||
                data[i].type == TopicTye.judge) &&
            reDate.indexOf(data[i]) == -1) {
          length--;
          reDate.add(data[i]);
          grade += data[i].grade;
          if (length == 0) break;
        }
      }
      if (grade < 100) {
        successToast(
            '系统无法补足100分试卷，本次考试满分为${grade + 8 - length * 2}分，请联系系统管理员补充题库');
      }
    } else if (grade == 96) {
      reMain96(grade, data, reDate);
    }

    // reMain(grade, data, reDate, same: grade == 92 ? same : false);
  }
}
