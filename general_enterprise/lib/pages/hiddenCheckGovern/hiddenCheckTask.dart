import 'dart:convert';

import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HiddenCheckTask extends StatefulWidget {
  @override
  State<HiddenCheckTask> createState() => _HiddenCheckTaskState();
}

class _HiddenCheckTaskState extends State<HiddenCheckTask> {
  int chooseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Container(
          height: size.width * 72,
          width: size.width * 408,
          decoration: BoxDecoration(
              color: Color(0xff1E62EB),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 46))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  chooseIndex = 0;
                  setState(() {});
                },
                child: Container(
                  height: size.width * 64,
                  width: size.width * 200,
                  alignment: Alignment.center,
                  decoration: chooseIndex == 0
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 46)))
                      : null,
                  child: Text(
                    '部门',
                    style: TextStyle(
                        fontSize: size.width * 28,
                        color:
                            chooseIndex == 0 ? Color(0xff3074FF) : Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  chooseIndex = 1;
                  setState(() {});
                },
                child: Container(
                  height: size.width * 64,
                  width: size.width * 200,
                  alignment: Alignment.center,
                  decoration: chooseIndex == 1
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 46)))
                      : null,
                  child: Text(
                    '个人',
                    style: TextStyle(
                        fontSize: size.width * 28,
                        color:
                            chooseIndex == 1 ? Color(0xff3074FF) : Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        child: chooseIndex == 0 ? DepartmentTask() : PersonalTask());
  }
}

class DepartmentTask extends StatefulWidget {
  @override
  State<DepartmentTask> createState() => _DepartmentTaskState();
}

class _DepartmentTaskState extends State<DepartmentTask> {
  List dropTempData = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getRiskObjectByDepartmentId,
      'limit': 'riskObjectId'
    }
  ];

  _deleteIndex(int index) {
    for (var i = dropTempData.length - 1; i > index; i--) {
      dropTempData.removeAt(i);
      if (mounted) {
        setState(() {});
      }
    }
  }

  Map queryParameters = {};
  ThrowFunc _throwFunc = new ThrowFunc();

  List dropList = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getRiskObjectByDepartmentId,
      'limit': 'riskObjectId'
    },
    {
      'title': '风险分析单元',
      'data': [],
      'value': '',
      "saveTitle": '风险分析单元',
      'dataUrl': Interface.getRiskUnitByDepartmentId,
      'limit': 'riskUnitId'
    },
    {
      'title': '风险事件',
      'data': [],
      'value': '',
      "saveTitle": '风险事件',
      'dataUrl': Interface.getRiskEventByDepartmentId,
      'limit': 'riskEventId'
    },
  ];

  @override
  void initState() {
    super.initState();
    queryParameters = {
      "riskObjectId": null,
      "riskUnitId": null,
      "riskEventId": null,
      "type": 1
    };
    _getDropList();
  }

  _getDropList() {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        myDio.request(
            type: 'get',
            url: dropTempData[i]['dataUrl'],
            queryParameters: {
              'departmentId': myprefs.getString('departmentId'),
              'userId': ''
            }).then((value) {
          dropTempData[i]['data'] = value;
          dropTempData[i]['data'].insert(0, {"name": "查看全部"});
          if (mounted) {
            setState(() {});
          }
        });
      }
    }
  }

  _dropList({int index, String msg}) {
    if (dropTempData[index]['value'] == '查看全部') {
      _deleteIndex(index);
      queryParameters = {
        "riskObjectId": null,
        "riskUnitId": null,
        "riskEventId": null,
        "type": 1
      };
      print(queryParameters);
      _throwFunc.run(argument: queryParameters);
      if (mounted) {
        setState(() {});
      }
      return;
    }
    _deleteIndex(index);
    String id = '';
    dropTempData[index]['data'].forEach((ele) {
      if (dropTempData[index]['value'] == ele['name']) {
        id = ele['id'];
        dropTempData[index]['id'] = ele['id'];
      }
    });
    if (index + 1 < dropList.length && dropTempData.length <= index + 1) {
      dynamic map = {};
      if (index == 0) {
        map = {
          'riskObjectId': id,
          'departmentId': myprefs.getString('departmentId'),
          'userId': ''
        };
      } else if (index == 1) {
        map = {
          'riskUnitId': id,
          'departmentId': myprefs.getString('departmentId'),
          'userId': ''
        };
      }
      dropTempData.add(jsonDecode(jsonEncode(dropList[index + 1])));
      myDio
          .request(
              type: 'get',
              url: dropTempData[index + 1]['dataUrl'],
              queryParameters: map)
          .then((value) {
        dropTempData[index + 1]['data'] = value;
        if (mounted) {
          setState(() {});
        }
      });
    }

    dropTempData.forEach((element) {
      if (element['id'] != null) {
        queryParameters[element['limit'].toString()] = element['id'];
      }
    });
    if (index == 0) {
      queryParameters["riskUnitId"] = null;
    }
    print(queryParameters);

    _throwFunc.run(argument: queryParameters);
    if (mounted) {
      setState(() {});
    }
  }

  String _getCheckMeans(String checkMeans) {
    // 0_现场确认；1_拍照；2_热成像；3_震动
    switch (checkMeans) {
      case '0':
        return '现场确认';
        break;
      case '1':
        return '拍照';
        break;
      case '2':
        return '热成像';
        break;
      case '3':
        return '震动';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleChoose(
          list: dropTempData,
          getDataList: _dropList,
        ),
        Expanded(
            child: Container(
          color: Color(0xffF8FAFF),
          padding: EdgeInsets.symmetric(horizontal: size.width * 32),
          child: MyRefres(
            child: (index, list) => GestureDetector(
                onTap: () {
                  if(DateTime.now().millisecondsSinceEpoch < list[index]['checkStartDate']){
                    Fluttertoast.showToast(msg: '未到排查开始时间');
                  }else{
                    Navigator.pushNamed(context, '/hiddenCheckGovern/taskHandle',
                        arguments: {
                          "dangerState": 'check',
                          'id': list[index]['id'],
                          'checkMeans': list[index]['checkMeans'],
                        }).then((value) {
                      _throwFunc.run();
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: size.width * 32),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * 20),
                        bottomLeft: Radius.circular(size.width * 20),
                        bottomRight: Radius.circular(size.width * 20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff7F8A9C).withOpacity(0.1),
                            blurRadius: size.width * 8,
                            spreadRadius: size.width * 2)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 20)),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff2276FC).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 16),
                        child: Text(
                          '隐患排查内容：${list[index]['troubleshootContent']}',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(size.width * 32,
                            size.width * 16, size.width * 32, size.width * 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '风险分析对象：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['riskObjectName'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '风险分析单元：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['riskUnitName'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '风险事件：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['riskEventName'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '管控措施：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['riskMeasureDesc'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w400),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: '管控手段：',
                                            style: TextStyle(
                                                color: Color(0xff333333))),
                                        TextSpan(
                                            text: _getCheckMeans(
                                                list[index]['checkMeans']),
                                            style: TextStyle(
                                                color: Color(0xff7F8A9C))),
                                      ]),
                                ),
                                Spacer(),
                                Container(
                                  height: size.width * 56,
                                  width: size.width * 140,
                                  decoration: BoxDecoration(
                                      color: DateTime.now().millisecondsSinceEpoch < list[index]['checkStartDate'] ? Color(0xff7F8A9C) : Color(0xff3074FF),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 36))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    DateTime.now().millisecondsSinceEpoch < list[index]['checkStartDate'] ? "待排查": "排查",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 2,
                        width: double.infinity,
                        color: Color(0xffF2F2F2),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: size.width * 40,
                                  width: size.width * 40,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3074FF).withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '起',
                                    style: TextStyle(
                                        fontSize: size.width * 20,
                                        color: Color(0xff3074FF),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 8,
                                ),
                                Text(
                                  DateTime.fromMillisecondsSinceEpoch(
                                          list[index]['checkStartDate'])
                                      .toString()
                                      .substring(0, 19),
                                  style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: size.width * 40,
                                  width: size.width * 40,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3074FF).withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '止',
                                    style: TextStyle(
                                        fontSize: size.width * 20,
                                        color: Color(0xff3074FF),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 8,
                                ),
                                Text(
                                  DateTime.fromMillisecondsSinceEpoch(
                                          list[index]['checkEndDate'])
                                      .toString()
                                      .substring(0, 19),
                                  style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            page: true,
            url: Interface.getRiskControlDataList,
            listParam: "records",
            queryParameters: queryParameters,
            method: 'get',
            throwFunc: _throwFunc,
          ),
        ))
      ],
    );
  }
}

class PersonalTask extends StatefulWidget {
  @override
  State<PersonalTask> createState() => _PersonalTaskState();
}

class _PersonalTaskState extends State<PersonalTask> {
  List dropTempData = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getRiskObjectByDepartmentId,
      'limit': 'riskObjectId'
    }
  ];

  _deleteIndex(int index) {
    for (var i = dropTempData.length - 1; i > index; i--) {
      dropTempData.removeAt(i);
      if (mounted) {
        setState(() {});
      }
    }
  }

  Map queryParameters = {};
  ThrowFunc _throwFunc = new ThrowFunc();

  List dropList = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getRiskObjectByDepartmentId,
      'limit': 'riskObjectId'
    },
    {
      'title': '风险分析单元',
      'data': [],
      'value': '',
      "saveTitle": '风险分析单元',
      'dataUrl': Interface.getRiskUnitByDepartmentId,
      'limit': 'riskUnitId'
    },
    {
      'title': '风险事件',
      'data': [],
      'value': '',
      "saveTitle": '风险事件',
      'dataUrl': Interface.getRiskEventByDepartmentId,
      'limit': 'riskEventId'
    },
  ];

  @override
  void initState() {
    super.initState();
    queryParameters = {
      "riskObjectId": null,
      "riskUnitId": null,
      "riskEventId": null,
      "type": 2
    };
    _getDropList();
  }

  _getDropList() {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        myDio.request(
            type: 'get',
            url: dropTempData[i]['dataUrl'],
            queryParameters: {
              'departmentId': '',
              'userId': myprefs.getString('userId')
            }).then((value) {
          dropTempData[i]['data'] = value;
          dropTempData[i]['data'].insert(0, {"name": "查看全部"});
          if (mounted) {
            setState(() {});
          }
        });
      }
    }
  }

  _dropList({int index, String msg}) {
    if (dropTempData[index]['value'] == '查看全部') {
      _deleteIndex(index);
      queryParameters = {
        "riskObjectId": null,
        "riskUnitId": null,
        "riskEventId": null,
        "type": 2
      };
      print(queryParameters);
      _throwFunc.run(argument: queryParameters);
      if (mounted) {
        setState(() {});
      }
      return;
    }
    _deleteIndex(index);
    String id = '';
    dropTempData[index]['data'].forEach((ele) {
      if (dropTempData[index]['value'] == ele['name']) {
        id = ele['id'];
        dropTempData[index]['id'] = ele['id'];
      }
    });
    if (index + 1 < dropList.length && dropTempData.length <= index + 1) {
      dynamic map = {};
      if (index == 0) {
        map = {
          'riskObjectId': id,
          'departmentId': '',
          'userId': myprefs.getString('userId')
        };
      } else if (index == 1) {
        map = {
          'riskUnitId': id,
          'departmentId': '',
          'userId': myprefs.getString('userId')
        };
      }
      dropTempData.add(jsonDecode(jsonEncode(dropList[index + 1])));
      myDio
          .request(
              type: 'get',
              url: dropTempData[index + 1]['dataUrl'],
              queryParameters: map)
          .then((value) {
        dropTempData[index + 1]['data'] = value;
        if (mounted) {
          setState(() {});
        }
      });
    }

    dropTempData.forEach((element) {
      if (element['id'] != null) {
        queryParameters[element['limit'].toString()] = element['id'];
      }
    });
    if (index == 0) {
      queryParameters["riskUnitId"] = null;
    }
    print(queryParameters);

    _throwFunc.run(argument: queryParameters);
    if (mounted) {
      setState(() {});
    }
  }

  String _getCheckMeans(String checkMeans) {
    // 0_现场确认；1_拍照；2_热成像；3_震动
    switch (checkMeans) {
      case '0':
        return '现场确认';
        break;
      case '1':
        return '拍照';
        break;
      case '2':
        return '热成像';
        break;
      case '3':
        return '震动';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleChoose(
          list: dropTempData,
          getDataList: _dropList,
        ),
        Expanded(
            child: Container(
          color: Color(0xffF8FAFF),
          padding: EdgeInsets.symmetric(horizontal: size.width * 32),
          child: MyRefres(
            child: (index, list) => GestureDetector(
                onTap: () {
                  if(DateTime.now().millisecondsSinceEpoch < list[index]['checkStartDate']){
                    Fluttertoast.showToast(msg: '未到排查开始时间');
                  }else{
                    Navigator.pushNamed(context, '/hiddenCheckGovern/taskHandle',
                        arguments: {
                          "dangerState": 'check',
                          'id': list[index]['id'],
                          'checkMeans': list[index]['checkMeans'],
                        }).then((value) {
                      _throwFunc.run();
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: size.width * 32),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * 20),
                        bottomLeft: Radius.circular(size.width * 20),
                        bottomRight: Radius.circular(size.width * 20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff7F8A9C).withOpacity(0.1),
                            blurRadius: size.width * 8,
                            spreadRadius: size.width * 2)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 20)),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff2276FC).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 16),
                        child: Text(
                          '隐患排查内容：${list[index]['troubleshootContent']}',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(size.width * 32,
                            size.width * 16, size.width * 32, size.width * 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '风险分析对象：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['riskObjectName'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '风险分析单元：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['riskUnitName'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '风险事件：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['riskEventName'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '管控措施：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['riskMeasureDesc'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w400),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: '管控手段：',
                                            style: TextStyle(
                                                color: Color(0xff333333))),
                                        TextSpan(
                                            text: _getCheckMeans(
                                                list[index]['checkMeans']),
                                            style: TextStyle(
                                                color: Color(0xff7F8A9C))),
                                      ]),
                                ),
                                Spacer(),
                                Container(
                                  height: size.width * 56,
                                  width: size.width * 140,
                                  decoration: BoxDecoration(
                                      color: DateTime.now().millisecondsSinceEpoch < list[index]['checkStartDate'] ? Color(0xff7F8A9C) : Color(0xff3074FF),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 36))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    DateTime.now().millisecondsSinceEpoch < list[index]['checkStartDate'] ? "待排查" : "排查",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 2,
                        width: double.infinity,
                        color: Color(0xffF2F2F2),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: size.width * 40,
                                  width: size.width * 40,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3074FF).withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '起',
                                    style: TextStyle(
                                        fontSize: size.width * 20,
                                        color: Color(0xff3074FF),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 8,
                                ),
                                Text(
                                  DateTime.fromMillisecondsSinceEpoch(
                                          list[index]['checkStartDate'])
                                      .toString()
                                      .substring(0, 19),
                                  style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: size.width * 40,
                                  width: size.width * 40,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3074FF).withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '止',
                                    style: TextStyle(
                                        fontSize: size.width * 20,
                                        color: Color(0xff3074FF),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 8,
                                ),
                                Text(
                                  DateTime.fromMillisecondsSinceEpoch(
                                          list[index]['checkEndDate'])
                                      .toString()
                                      .substring(0, 19),
                                  style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            page: true,
            url: Interface.getRiskControlDataList,
            listParam: "records",
            queryParameters: queryParameters,
            method: 'get',
            throwFunc: _throwFunc,
          ),
        ))
      ],
    );
  }
}

class TitleChoose extends StatefulWidget {
  TitleChoose({this.list, this.getDataList});
  final List list;
  final ReturnIntStringCallback getDataList;
  @override
  _TitleChooseState createState() => _TitleChooseState();
}

class _TitleChooseState extends State<TitleChoose> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
          children: widget.list.asMap().keys.map((i) {
        return Expanded(
            child: GestureDetector(
          onTap: () {
            Color _juegeColor(Map _ele) {
              if (widget.list[i]['id'] == null) {
                widget.list[i]['id'] = -1;
              }
              Color _color = Colors.white;
              if (widget.list[i]['value'] == '' && _ele['name'] == '查看全部') {
                _color = themeColor;
              } else {
                if (widget.list[i]['id'] == _ele['id']) {
                  _color = themeColor;
                } else {
                  _color = Colors.white;
                }
              }

              return _color;
            }

            if (widget.list[i]['data'].isEmpty) {
              Fluttertoast.showToast(msg: '没有数据');
              return;
            }
            showModalBottomSheet(
                context: context,
                builder: (_) {
                  return SingleChildScrollView(
                    child: Column(
                      children: widget.list[i]['data'].map<Widget>((_ele) {
                        Color _conColors = _juegeColor(_ele);
                        return GestureDetector(
                          onTap: () {
                            widget.list[i]['value'] = _ele['name'];
                            if (_ele['name'] == '查看全部') {
                              widget.list[i]['title'] =
                                  widget.list[i]['saveTitle'];
                              widget.list[i]['id'] = _ele['id'];
                            } else {
                              widget.list[i]['title'] = _ele['name'];
                              widget.list[i]['id'] = _ele['id'];
                            }

                            widget.getDataList(index: i);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: size.width * 20),
                            decoration: BoxDecoration(
                                color: _conColors,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: underColor))),
                            child: Center(
                              child: Text(
                                _ele['name'],
                                style: TextStyle(
                                    fontSize: size.width * 30,
                                    color: _conColors.toString() ==
                                            'Color(0xff2674fd)'
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right:
                        BorderSide(width: 1, color: underColor.withOpacity(.2)),
                  )),
              padding: EdgeInsets.all(size.width * 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.list[i]['title'].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff333333)),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xff7F8A9C),
                  )
                ],
              )),
        ));
      }).toList()),
    );
  }
}
