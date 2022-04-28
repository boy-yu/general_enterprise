import 'dart:convert';

import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

typedef VideoCallBackFunc = void Function(List listUrl);
typedef WillPopScopeCallBackFunc = void Function(String msg);
typedef ReturnIntStringCallback = void Function({int index, String msg});
typedef HiddenSpecificItemCallBackFunc = void Function(String title);
typedef SpotCheckFourCallBackFunc = void Function(String title);
typedef SetstateFunc = void Function(VoidCallback fn);
Database db;

class PeopleStructure {
  final int id;
  bool choose;
  String sort;
  final String name, department, position, telephone, photoUrl, account;
  final int nums;
  final List children;
  PeopleStructure({
    String photoUrl,
    this.children,
    this.position,
    this.department,
    this.sort,
    @required this.id,
    this.telephone = '',
    this.choose = false,
    this.name = '',
    this.account,
    this.nums,
  }) : photoUrl = photoUrl == null || photoUrl == ''
            ? 'https://shuangkong.oss-cn-qingdao.aliyuncs.com/temp/1605800477920/lALPDg7mO1OQqJHMyMzI_200_200.png'
            : photoUrl;
  static bool state = false;

  static List<PeopleStructure> staticPeople = [];
  static bool couldOper = false;
  static Future<List<PeopleStructure>> getStaticPeople() async {
    if (staticPeople.isEmpty) {
      await getSqlpeopel();
    }
    return Future.value(staticPeople);
  }

  static List<PeopleStructure> changeStucture(List list) {
    List<PeopleStructure> _list = [];
    list.forEach((element) {
      _list.add(PeopleStructure(
          id: element['id'],
          name: element['name'],
          // position: element['positionIds'] ?? '暂无职位',
          department: element['departmentIds'],
          telephone: element['telephone'],
          nums: element['num'] ?? null,
          photoUrl: element['photoUrl'],
          account: element['account']));
    });
    return _list;
  }

  void change(bool willChange) {
    this.choose = willChange;
  }

  static Future<bool> getNetpeople({bool delete = false}) async {
    if (!state) {
      state = true;
      List list = await db.rawQuery(
          'SELECT * FROM sqlite_master WHERE type="table" AND name="People"');
      if (list.isNotEmpty && delete) {
        await db.execute('DROP table People');
      }
      if (!couldOper) {
        couldOper = true;
        if (delete) {
          await db.execute(
              '''CREATE TABLE People (id INTEGER PRIMARY KEY, name TEXT, 
          departmentIds TEXT, 
          telephone TEXT, photoUrl TEXT, account TEXT)''');
          final res = await myDio.request(
            type: 'get',
            url: Interface.getAllPeople,
          );
          if (res is List) {
            List temp = res;
            temp.forEach((element) {
              db.insert('People', {
                "id": element['id'],
                "name": element['nickname'],
                // "positionIds": jsonEncode(element['positionIds']),
                "departmentIds": jsonEncode(element['departmentIds']),
                "telephone": element['mobile'],
                "photoUrl": element['avatar'],
                "account": element['account']
              });
            });
          }
          await getOrganization(delete: true);
          couldOper = false;
          staticPeople.clear();
        }
      }
      state = false;
    }
    return Future.value(true);
  }

  static getSqlpeopel({int departmentId, List filter}) async {
    List list = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="People"');
    if (list.isEmpty) await getNetpeople(delete: true);
    String ids = '';

    if (filter is List) {
      for (var i = 0; i < filter.length; i++) {
        if (i != filter.length - 1) {
          ids += filter[i].toString() + ',';
        } else {
          ids += filter[i].toString();
        }
      }
    }

    List data = jsonDecode(
        jsonEncode(await db.query('People', where: "id not in ($ids)")));
    // List positionList = await queryPosition();
    List departmentList = await queryDepartment();

    if (departmentId is int) {
      for (var i = data.length - 1; i > -1; i--) {
        if (data[i]['departmentIds']
                .toString()
                .indexOf(departmentId.toString()) ==
            -1) {
          data.removeAt(i);
        } else {
          // jsonDecode(data[i]['positionIds']).forEach((ele) {
          //   String _str = '';
          //   positionList.forEach((_element) {
          //     if (_element['id'] == ele) {
          //       _str += _element['name'] + ',';
          //     }
          //   });
          //   if (_str.isNotEmpty) {
          //     data[i]['positionIds'] = _str.substring(0, _str.length - 1);
          //   }
          // });

          jsonDecode(data[i]['departmentIds']).forEach((ele) {
            String _str = '';
            departmentList.forEach((_element) {
              if (_element['id'] == ele) {
                _str += _element['name'] + ',';
              }
            });
            if (_str.isNotEmpty) {
              data[i]['departmentIds'] = _str.substring(0, _str.length - 1);
            }
          });
        }
      }
    } else {
      for (var i = 0; i < data.length; i++) {
        // jsonDecode(data[i]['positionIds']).forEach((ele) {
        //   String _str = '';
        //   positionList.forEach((_element) {
        //     if (_element['id'] == ele) {
        //       _str += _element['name'] + ',';
        //     }
        //   });
        //   if (_str.isNotEmpty) {
        //     data[i]['positionIds'] = _str.substring(0, _str.length - 1);
        //   }
        // });
        jsonDecode(data[i]['departmentIds']).forEach((ele) {
          String _str = '';
          departmentList.forEach((_element) {
            if (_element['id'] == ele) {
              _str += _element['name'] + ',';
            }
          });
          if (_str.isNotEmpty) {
            data[i]['departmentIds'] = _str.substring(0, _str.length - 1);
          }
        });
      }
      staticPeople = changeStucture(data);
    }
    return data;
  }

  static Future<PeopleStructure> getAccountPeople(String account) async {
    List list = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="People"');
    if (list.isEmpty) {
      await getNetpeople(delete: true);
    }

    List _list = jsonDecode(
        jsonEncode(await db.query('People', where: "account = '$account'")));

    // for (var i = 0; i < _list.length; i++) {
    //   _list[i]['positionIds'] =
    //       await queryPosition(ids: jsonDecode(_list[i]['positionIds']));
    // }
    _list = changeStucture(_list);
    if (_list.isNotEmpty)
      return _list[0];
    else
      return Future.error('未找到此人 $account');
  }

  static Future<List<PeopleStructure>> getSecharPeople(
      {String input = '', int id, List filterId}) async {
    List list = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="People"');
    if (list.isEmpty) await getNetpeople(delete: true);
    String ids = '';

    if (filterId is List) {
      for (var i = 0; i < filterId.length; i++) {
        if (i != filterId.length - 1) {
          ids += filterId[i].toString() + ',';
        } else {
          ids += filterId[i].toString();
        }
      }
    }
    List data = [];
    if (id is int) {
      data = jsonDecode(jsonEncode(
          await db.rawQuery('SELECT * FROM People WHERE id = "$id"')));
    } else {
      data = jsonDecode(jsonEncode(await db.rawQuery(
          'SELECT * FROM People WHERE name LIKE "$input%" AND id not in  ($ids )')));
    }
    for (var i = 0; i < data.length; i++) {
      // data[i]['positionIds'] =
      //     await queryPosition(ids: jsonDecode(data[i]['positionIds']));
      data[i]['departmentIds'] =
          await queryDepartment(ids: jsonDecode(data[i]['departmentIds']));
    }

    return Future.value(changeStucture(data));
  }

  static Future<List> getListPeople(int department) async {
    List list = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="People"');
    if (list.isEmpty) getNetpeople(delete: true);
    List data =
        jsonDecode(jsonEncode(await db.rawQuery("SELECT * FROM People")));
    List _list = [];
    data.forEach((element) {
      List _department = jsonDecode(element['departmentIds']);
      if (_department.indexOf(department) > -1) {
        _list.add(element);
      }
    });

    return Future.value(_list);
  }

  // new organ
  static Future getOrganization({bool delete = false}) async {
    List list = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="Department"');
    List positionList = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="Position"');

    if (delete) {
      if (list.isNotEmpty) {
        await db.execute('DROP table Department');
      }
      if (positionList.isNotEmpty) {
        await db.execute('DROP table Position');
      }
      await db.execute(
          'CREATE TABLE Department (id INTEGER PRIMARY KEY, name TEXT, parentId INTEGER , uId TEXT, path TEXT)');
      await db.execute(
          'CREATE TABLE Position (id INTEGER PRIMARY KEY, name TEXT, parentId INTEGER)');
    }

    if (delete) {
      final res = await myDio.request(
        type: 'get',
        url: Interface.getAlldeparment,
      );
      if (res is Map) {
        // List _position = res['positions'];
        // _position.forEach((element) {
        //   db.insert('Position', {
        //     "id": element['id'],
        //     "name": element['name'],
        //     "parentId": element['parentId']
        //   });
        // });
        List _deparment = res['departments'];
        print(_deparment);
        _deparment.forEach((element) {
          db.insert('Department', {
            // "id": element['id'],
            "name": element['name'],
            // "parentId": element['parentId'],
            "uId": element['id'],
            "path": element['path']
          });
        });
      }
    }
  }

  static Future<dynamic> queryPosition({List ids}) async {
    List positionList = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="Position"');

    if (positionList.isEmpty) await getOrganization(delete: true);

    if (ids is List) {
      String _list = '';
      for (var i = 0; i < ids.length; i++) {
        List data =
            await db.rawQuery('SELECT name FROM Position WHERE id = ${ids[i]}');
        _list += data[0]['name'].toString() + ',';
      }
      if (_list.isNotEmpty) {
        _list = _list.substring(0, _list.length - 1);
      }
      return Future.value(_list);
    } else {
      return await db.query('Position');
    }
  }

  static Future<dynamic> queryDepartment(
      {List ids, int department = -1, List filterId}) async {
    List positionList = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="Department"');
    if (positionList.isEmpty) await getOrganization(delete: true);
    dynamic _list;
    List _data = await db.query('Department');
    if (_data.isEmpty) {
      await getOrganization(delete: true);
    }
    if (ids is List) {
      _list = '';
      for (var i = 0; i < ids.length; i++) {
        List data = await db
            .rawQuery('SELECT name FROM Department WHERE id = ${ids[i]}');
        _list += data[0]['name'].toString() + ',';
      }
      if (_list.isNotEmpty) {
        _list = _list.substring(0, _list.length - 1);
      }
    } else if (ids == null && department != -1) {
      _list = [];
      _list = jsonDecode(jsonEncode(await db.rawQuery(
          'SELECT name,id ,(SELECT COUNT(1) FROM Department as children WHERE children.parentId = Department.id )as num  FROM   Department WHERE parentId = $department')));
      List _people = [];
      if (_list is List) {
        if (department != 0) {
          _people =
              await getSqlpeopel(departmentId: department, filter: filterId);
        }

        _list.addAll(_people);
      }
      _list = changeStucture(_list);
    } else {
      _list = await db.query('Department');
    }
    return Future.value(_list);
  }

  static Future<List> queryOnlyDepartment(int department) async {
    List positionList = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE type="table" AND name="Department"');
    if (positionList.isEmpty) await getOrganization(delete: true);
    List _list = [];
    // _list = jsonDecode(jsonEncode(await db.rawQuery(
    //     'SELECT name,id ,(SELECT COUNT(1) FROM Department as children WHERE children.parentId = Department.id )as num  FROM   Department WHERE parentId = $department')));

    // List data = jsonDecode(jsonEncode(await db.rawQuery(
    //     'SELECT name,id FORM Department WHERE parentId = $department')));

    List data = jsonDecode(jsonEncode(await db
        .rawQuery('SELECT * FROM Department WHERE parentId = $department ')));

    for (var i = 0; i < data.length; i++) {
      List _nums = await db.rawQuery(
          "SELECT count(1) as num FROM Department WHERE path like '%${data[i]['uId']}%' and uId != '${data[i]['uId']}' ");
      data[i]['num'] = _nums[0]['num'];
    }
    _list = data;

    return Future.value(changeStucture(_list));
  }
}

extension getMax on List {
  double getmax(List list) {
    int max = -1;
    list.forEach((element) {
      if (max < int.parse(element.toString())) {
        max = int.parse(element.toString());
      }
    });
    return max.toDouble();
  }
}

class ThrowFunc {
  SetstateFunc states;
  List<Function> listFuns;
  Function({dynamic argument}) detailFun;
  void init(
    List<Function> listFun, {
    SetstateFunc state,
  }) {
    states = state;
    listFuns = listFun ?? [];
  }

  void detailInit(Function({dynamic argument}) fun) {
    detailFun = fun;
  }

  void run({dynamic argument, SetstateFunc stat, bool clear = false}) {
    if (listFuns is List) {
      listFuns.forEach((element) {
        if (clear == true) {
          element(clear: true);
        } else if (argument == null) {
          element();
        } else {
          element(
            argument: argument,
          );
        }
      });
      if (states != null) {
        states(() {});
      }
    }
    if (stat != null) {
      stat(() {});
    }
  }

  void detail({dynamic argument}) {
    if (detailFun is Function({dynamic argument})) {
      detailFun(
        argument: argument,
      );
    }
  }
}
