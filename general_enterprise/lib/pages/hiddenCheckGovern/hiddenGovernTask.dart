import 'dart:convert';

import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/hiddenCheckGovern/hiddenGovernRecord.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HiddenGovernTask extends StatefulWidget {
  @override
  State<HiddenGovernTask> createState() => _HiddenGovernTaskState();
}

class _HiddenGovernTaskState extends State<HiddenGovernTask> {
  int chooseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Container(
          height: size.width * 72,
          width: size.width * 488,
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
                  width: size.width * 240,
                  alignment: Alignment.center,
                  decoration: chooseIndex == 0
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 46)))
                      : null,
                  child: Text(
                    '排查隐患',
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
                  width: size.width * 240,
                  alignment: Alignment.center,
                  decoration: chooseIndex == 1
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 46)))
                      : null,
                  child: Text(
                    '上报隐患',
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
        child: chooseIndex == 0 ? CheckHidden() : ReportedHidden());
  }
}

class CheckHidden extends StatefulWidget {
  @override
  State<CheckHidden> createState() => _CheckHiddenState();
}

class _CheckHiddenState extends State<CheckHidden> {
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
      "isFromCheck": 1
    };
    _getDropList();
  }

  _getDropList() {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        myDio
            .request(
          type: 'get',
          url: dropTempData[i]['dataUrl'],
        )
            .then((value) {
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
        "isFromCheck": 1
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
        map = {'riskObjectId': id};
      } else if (index == 1) {
        map = {'riskUnitId': id};
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
    _throwFunc.run(argument: queryParameters);
    if (mounted) {
      setState(() {});
    }
  }

  List stateList = ['全部', '待确认', '整改中', '待验收'];

  int stateSelect = 0;

  Widget _getButton(String dangerState) {
    // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
    switch (dangerState) {
      case '-1':
        return Container(
          height: size.width * 56,
          width: size.width * 140,
          decoration: BoxDecoration(
              color: Color(0xffFFCA0E),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 36))),
          alignment: Alignment.center,
          child: Text(
            "确认隐患",
            style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
        );
        break;
      case '0':
        return Container(
          height: size.width * 56,
          width: size.width * 140,
          decoration: BoxDecoration(
              color: Color(0xff5FD5EC),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 36))),
          alignment: Alignment.center,
          child: Text(
            "整改完毕",
            style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
        );
        break;
      case '1':
        return Container(
          height: size.width * 56,
          width: size.width * 140,
          decoration: BoxDecoration(
              color: Color(0xffF56271),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 36))),
          alignment: Alignment.center,
          child: Text(
            "整改审批",
            style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
        );
        break;
      default:
        return Container();
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
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 32, vertical: size.width * 20),
                child: Column(
                  children: [
                    Container(
                      height: size.width * 50,
                      child: ListView.builder(
                          itemCount: stateList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, indexState) {
                            return GestureDetector(
                              onTap: () {
                                stateSelect = indexState;
                                // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
                                if(stateList[stateSelect] == '全部'){
                                  queryParameters['dangerState'] = null;
                                }else if(stateList[stateSelect] == '待确认'){
                                  queryParameters['dangerState'] = '-1';
                                }else if(stateList[stateSelect] == '整改中'){
                                  queryParameters['dangerState'] = '0';
                                }else if(stateList[stateSelect] == '待验收'){
                                  queryParameters['dangerState'] = '1';
                                }
                                _throwFunc.run(argument: queryParameters);
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 24,
                                    vertical: size.width * 8),
                                margin: EdgeInsets.only(right: size.width * 20),
                                decoration: BoxDecoration(
                                    color: indexState == stateSelect
                                        ? Color(0xff3074FF)
                                        : Color(0xffECECEC),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 24))),
                                alignment: Alignment.center,
                                child: Text(
                                  stateList[indexState],
                                  style: TextStyle(
                                      color: indexState == stateSelect
                                          ? Colors.white
                                          : Color(0xff7F8A9C),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                        child: MyRefres(
                      child: (index, list) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/hiddenCheckGovern/taskHandle',
                                arguments: {
                                  "dangerState": list[index]['dangerState'],
                                  'id': list[index]['id']
                                }).then((value) {
                              _throwFunc.run();
                            });
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
                                      // offset: Offset(1, 2),
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
                                        topRight:
                                            Radius.circular(size.width * 20)),
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
                                  padding: EdgeInsets.fromLTRB(
                                      size.width * 32,
                                      size.width * 16,
                                      size.width * 32,
                                      size.width * 32),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      color:
                                                          Color(0xff333333))),
                                              TextSpan(
                                                  text: list[index]
                                                      ['riskObjectName'],
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff7F8A9C))),
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
                                                      color:
                                                          Color(0xff333333))),
                                              TextSpan(
                                                  text: list[index]
                                                      ['riskUnitName'],
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff7F8A9C))),
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
                                                      color:
                                                          Color(0xff333333))),
                                              TextSpan(
                                                  text: list[index]
                                                      ['riskEventName'],
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff7F8A9C))),
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
                                                      color:
                                                          Color(0xff333333))),
                                              TextSpan(
                                                  text: list[index]
                                                      ['riskMeasureDesc'],
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff7F8A9C))),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: size.width * 16,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 24,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                          text: '管控手段：',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff333333))),
                                                      TextSpan(
                                                          text: list[index][
                                                                      'checkMeans'] ==
                                                                  '0'
                                                              ? "现场确认"
                                                              : "拍照",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff7F8A9C))),
                                                    ]),
                                              ),
                                              SizedBox(
                                                height: size.width * 16,
                                              ),
                                              list[index]['dangerManageDeadline'] != null && list[index]['dangerManageDeadline'] != ''? RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 24,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                          text: '管控时限：',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff333333))),
                                                      TextSpan(
                                                          text: DateTime.fromMillisecondsSinceEpoch(list[index]['dangerManageDeadline']).toString().substring(0, 19),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff7F8A9C))),
                                                    ]),
                                              ) : Container(),
                                            ],
                                          ),
                                          Spacer(),
                                          _getButton(
                                              list[index]['dangerState']),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                      page: true,
                      url: Interface.getHiddenDangerTreatment,
                      listParam: "records",
                      queryParameters: queryParameters,
                      method: 'get',
                      throwFunc: _throwFunc,
                    ))
                  ],
                )))
      ],
    );
  }
}

class ReportedHidden extends StatefulWidget {
  @override
  State<ReportedHidden> createState() => _ReportedHiddenState();
}

class _ReportedHiddenState extends State<ReportedHidden> {
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

  @override
  void initState() {
    super.initState();
    queryParameters = {
      "riskObjectId": null,
      "riskUnitId": null,
      "riskEventId": null,
      "isFromCheck": 0
    };
    _getDropList();
  }

  List dropTempData = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getCheckRiskObjectList,
      'limit': 'riskObjectId'
    }
  ];

  List dropList = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getCheckRiskObjectList,
      'limit': 'riskObjectId'
    },
  ];

  _getDropList() {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        myDio
            .request(
          type: 'get',
          url: dropTempData[i]['dataUrl'],
        )
            .then((value) {
          dropTempData[i]['data'] = value;
          dropTempData[i]['data'].insert(0, {"riskObjectName": "查看全部"});
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
        "isFromCheck": 0
      };
      print(queryParameters);
      _throwFunc.run(argument: queryParameters);
      if (mounted) {
        setState(() {});
      }
      return;
    }
    _deleteIndex(index);

    dropTempData.forEach((element) {
      if (element['id'] != null) {
        queryParameters[element['limit'].toString()] = element['id'];
      }
    });
    print(queryParameters);

    _throwFunc.run(argument: queryParameters);
    if (mounted) {
      setState(() {});
    }
  }

  List stateList = ['全部', '待确认', '整改中', '待验收'];

  int stateSelect = 0;

  Widget _getButton(String dangerState) {
    // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
    switch (dangerState) {
      case '-1':
        return Container(
          height: size.width * 56,
          width: size.width * 140,
          decoration: BoxDecoration(
              color: Color(0xffFFCA0E),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 36))),
          alignment: Alignment.center,
          child: Text(
            "确认隐患",
            style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
        );
        break;
      case '0':
        return Container(
          height: size.width * 56,
          width: size.width * 140,
          decoration: BoxDecoration(
              color: Color(0xff5FD5EC),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 36))),
          alignment: Alignment.center,
          child: Text(
            "整改完毕",
            style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
        );
        break;
      case '1':
        return Container(
          height: size.width * 56,
          width: size.width * 140,
          decoration: BoxDecoration(
              color: Color(0xffF56271),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 36))),
          alignment: Alignment.center,
          child: Text(
            "整改审批",
            style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
        );
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GovernObjectNameTitleChoose(
          list: dropTempData,
          getDataList: _dropList,
        ),
        Expanded(
            child: Container(
                color: Color(0xffF8FAFF),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 32, vertical: size.width * 20),
                child: Column(
                  children: [
                    Container(
                      height: size.width * 50,
                      child: ListView.builder(
                          itemCount: stateList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, indexState) {
                            return GestureDetector(
                              onTap: () {
                                stateSelect = indexState;
                                // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
                                if(stateList[stateSelect] == '全部'){
                                  queryParameters['dangerState'] = null;
                                }else if(stateList[stateSelect] == '待确认'){
                                  queryParameters['dangerState'] = '-1';
                                }else if(stateList[stateSelect] == '整改中'){
                                  queryParameters['dangerState'] = '0';
                                }else if(stateList[stateSelect] == '待验收'){
                                  queryParameters['dangerState'] = '1';
                                }
                                _throwFunc.run(argument: queryParameters);
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 24,
                                    vertical: size.width * 8),
                                margin: EdgeInsets.only(right: size.width * 20),
                                decoration: BoxDecoration(
                                    color: indexState == stateSelect
                                        ? Color(0xff3074FF)
                                        : Color(0xffECECEC),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 24))),
                                alignment: Alignment.center,
                                child: Text(
                                  stateList[indexState],
                                  style: TextStyle(
                                      color: indexState == stateSelect
                                          ? Colors.white
                                          : Color(0xff7F8A9C),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                        child: MyRefres(
                      child: (index, list) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/hiddenCheckGovern/taskHandle',
                                arguments: {
                                  "dangerState": list[index]['dangerState'],
                                  'id': list[index]['id']
                                }).then((value) {
                              _throwFunc.run();
                            });
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
                                        topRight:
                                            Radius.circular(size.width * 20)),
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
                                    '风险分析对象：${list[index]['riskObjectName']}',
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      size.width * 32,
                                      size.width * 16,
                                      size.width * 32,
                                      size.width * 32),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: size.width * 450,
                                            child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 24,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                          text: '地点：',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff333333))),
                                                      TextSpan(
                                                          text: list[index]['address'],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff7F8A9C))),
                                                    ]),
                                              ),
                                              SizedBox(
                                                height: size.width * 16,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 24,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                          text: '隐患描述：',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff333333))),
                                                      TextSpan(
                                                          text: list[index]
                                                              ['dangerDesc'],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff7F8A9C))),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                          ),
                                          Spacer(),
                                          _getButton(
                                              list[index]['dangerState']),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                      page: true,
                      url: Interface.getHiddenDangerTreatment,
                      listParam: "records",
                      queryParameters: queryParameters,
                      method: 'get',
                      throwFunc: _throwFunc,
                    ))
                  ],
                )))
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
