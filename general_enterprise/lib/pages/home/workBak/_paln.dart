import 'package:enterprise/common/MychooseTime.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myInput.dart';
import 'package:enterprise/common/myMutipleChoose.dart';
import 'package:enterprise/common/myText.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/myAppbar.dart';
import '../../../common/myCustomColor.dart';
import '../../../common/myDrop.dart';
import '../../../tool/interface.dart';
// import 'dart:convert' as convert;

class WorkPlan extends StatefulWidget {
  WorkPlan({this.arguments});

  final arguments;

  @override
  _WorkPlanState createState() => _WorkPlanState(arguments: arguments);
}

class _WorkPlanState extends State<WorkPlan> {
  SharedPreferences prefs;

  _WorkPlanState({this.arguments});

  final arguments;

  final List uiData = [
    {'title': '作业名称', 'type': 'input'},
    {'title': '作业区域', 'type': 'choose', "data": [], "dataUrl": "areaUrl"},
    {
      'title': '作业地点',
      'type': 'input',
    },
    {
      'title': '属地单位', //title
      'type': 'text', //类型 一般输入框是 Input
      'value': ''
    },
    {
      'title': '作业内容',
      'type': 'input', //单选框
    },
    {
      'title': '涉及特殊作业',
      'type': 'checkbox',
      "data": [],
      "dataUrl": "workTypeList"
    },
    {
      'title': '作业单位',
      'type': 'choose',
      "data": [
        {
          "name": "承包商作业",
          "addtion": {
            'title': '请选择承包商作业',
            'type': 'choose',
            "data": [],
            "dataUrl": "contractorListUrl"
          }
        },
        {
          "name": "内部作业",
          "addtion": {
            'title': '内部作业',
            'type': 'choose',
            "data": [],
            "dataUrl": 'generalUrl/internal'
          }
        },
      ]
    },
    {'title': '负责工位', 'type': 'choose', "data": [], "dataUrl": "principal"},
    {'title': '计划时间', 'type': 'chooseTime', 'value': ''}
  ];

  @override
  void dispose() {
    super.dispose();
  }

  var io = false;

  _submit(data, Counter _context) {
    String tempTitle = widget.arguments['title'];
    Map post = {
      "workName": _assginValue(data, '作业名称', tempTitle),
      "region": _assginValue(data, '作业区域', tempTitle),
      "location": _assginValue(data, '作业地点', tempTitle),
      "description": _assginValue(data, '作业内容', tempTitle),
      "territorialUnit": _assginValue(data, '属地单位', tempTitle),
      "workUnit": _assginValue(data, '作业单位', tempTitle),
      "workUnitId":
          _assginValue(data, '作业单位', tempTitle, index: 0, field: 'id') == 'null'
              ? 0
              : _assginValue(data, '作业单位', tempTitle, index: 0, field: 'id'),
      "workTypes": _assginValue(data, '涉及特殊作业', tempTitle),
      // "applicantUnitId":
      //     _assginValue(data, '负责人', tempTitle, index: 0, field: 'id'),
      "planDate": _assginValue(data, '计划时间', tempTitle),
    };

    if (tempTitle == '作业计划') {
      post['applicantUnitId'] =
          _assginValue(data, '负责工位', tempTitle, index: 0, field: 'id');
    }
    for (var item in post.values) {
      if (item == '') {
        Fluttertoast.showToast(msg: '请填写完整');
        break;
      }
    }
    if (io) return;
    io = true;
    myDio
        .request(
      type: 'post',
      url: Interface.sumbitPlan,
      data: post,
    )
        .then((value) {
      io = false;
      if ('作业申请' == widget.arguments['title']) {
        Fluttertoast.showToast(msg: '成功');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: '成功');
        Navigator.pop(context);
      }
    }).catchError((onError) {
      io = false;
      print(onError);
      Interface().error(onError, context);
    });
  }

  String _assginValue(data, name, title, {int index, String field}) {
    String value = '';

    data[title].forEach((element) {
      if (element['title'] == name) {
        if (element['value'] is String) {
          if (field != null) {
            value = element['id'].toString();
          } else {
            value = element['value'];
          }
        }
      }
    });
    return value;
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    final _context = Provider.of<Counter>(context);
    return MyAppbar(
      title: Text(
        arguments['title'],
      ),
      child: WillPopScope(
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Column(
                  children: uiData.map<Widget>((element) {
                    Widget name;
                    switch (element['type']) {
                      case 'text':
                        String tempValue = element['value'];
                        _context.submitDates[widget.arguments['title']]
                            ?.forEach((element) {
                          if (element['title'] == '属地单位') {
                            tempValue = element['value'];
                          }
                        });
                        name = MyText(
                          title: element['title'],
                          value: tempValue,
                        );
                        break;
                      case 'input':
                        name = MyInput(
                          title: element['title'],
                          purview: arguments['title'],
                        );
                        break;
                      case 'choose':
                        // print(element['title'] == null);
                        // 作业申请　need hide widget
                        if ('作业申请' == widget.arguments['title'] &&
                            element['title'] == '负责人') {
                          name = Container();
                        } else {
                          name = MyDrop(
                            title: element['title'],
                            dataUrl: element['dataUrl'],
                            data: element['data'],
                            purview: arguments['title'],
                            callSetstate: () {
                              setState(() {});
                            },
                          );
                        }
                        break;
                      case 'checkbox':
                        name = MutipleDrop(
                            title: element['title'],
                            purview: arguments['title'],
                            data: element['data'],
                            dataUrl: element['dataUrl']);
                        break;
                      case 'chooseTime':
                        name = MychooseTime(
                          title: element['title'],
                          purview: arguments['title'],
                        );
                        break;
                      default:
                        name = Text(element['title']);
                    }
                    return name;
                  }).toList(),
                ),
                GestureDetector(
                  onTap: () {
                    _submit(_context.submitDates, _context);
                  },
                  child: Container(
                      margin: EdgeInsets.all(width * 40),
                      padding: EdgeInsets.symmetric(vertical: width * 30),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: lineGradBlue),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          widget.arguments['title'] == '作业申请' ? '下一步' : '提交保存',
                          style: TextStyle(
                              fontSize: width * 30, color: Colors.white),
                        ),
                      )),
                )
              ],
            ),
          )),
          onWillPop: () async {
            return true;
          }),
    );
  }
}
