import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/checkLisk/data/alreadySubmitData.dart';
import 'package:enterprise/pages/home/checkLisk/data/hiddenData.dart';
import 'package:enterprise/pages/waitWork/_commonPage.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<_CheckHiddenPageState> _globalKey = GlobalKey();

class CheckHiddenPage extends StatefulWidget {
  CheckHiddenPage() : super(key: _globalKey);
  @override
  _CheckHiddenPageState createState() => _CheckHiddenPageState();
}

class _CheckHiddenPageState extends State<CheckHiddenPage> {
  List dropList = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getCheckOneListAll,
      'limit': 'oneId'
    },
    {
      'title': '风险分析单元',
      'data': [],
      'value': '',
      "saveTitle": '风险分析单元',
      'dataUrl': Interface.getCheckTwoListAll + '/?oneId=',
      'limit': 'twoId'
    },
    {
      'title': '风险事件',
      'data': [],
      'value': '',
      "saveTitle": '风险事件',
      'dataUrl': Interface.getCHeckThreeListAll + '/?twoId=',
      'limit': 'threeId'
    },
  ];
  ThrowFunc _throwFunc = ThrowFunc();
  List dropTempData = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getCheckOneListAll,
      'limit': 'oneId'
    },
  ];
  List _data = [];
  int page = 1, taskType = 1;

  bool scroll = true;
  dynamic queryParameters = {};
  dynamic queryParameter;

  _getDropList() {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        myDio.request(
            type: 'get',
            url: dropTempData[i]['dataUrl'],
            queryParameters: {
              'type': taskType == 3 ? 0 : 1,
              'taskType': taskType,
              'controlType': 1
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

  _getData() {
    queryParameters['taskType'] = taskType;
    _throwFunc.run(argument: queryParameters);
  }

  _deleteIndex(int index) {
    for (var i = dropTempData.length - 1; i > index; i--) {
      dropTempData.removeAt(i);
      if (mounted) {
        setState(() {});
      }
    }
  }

  // int x = 0;
  _dropList({int index, String msg}) {
    queryParameters = {
      "current": page,
      "size": 30,
      "taskType": taskType,
      "controlType": 1,
    };
    if (dropTempData[index]['value'] == '查看全部') {
      _deleteIndex(index);
      _throwFunc.run(argument: queryParameters);
      return;
    }
    _deleteIndex(index);
    int id = -1;
    dropTempData[index]['data'].forEach((ele) {
      if (dropTempData[index]['value'] == ele['name']) {
        id = ele['id'];
        dropTempData[index]['id'] = ele['id'];
      }
    });
    if (index + 1 < dropList.length && dropTempData.length <= index + 1) {
      dropTempData.add(jsonDecode(jsonEncode(dropList[index + 1])));
      myDio.request(
          type: 'get',
          url: dropTempData[index + 1]['dataUrl'] + id.toString(),
          queryParameters: {
            'type': taskType == 3 ? 3 : 1,
            'taskType': taskType,
            'controlType': 1
          }).then((value) {
        dropTempData[index + 1]['data'] = value;
        if (mounted) {
          setState(() {});
        }
      });
    }

    queryParameters[dropTempData[index]['limit'].toString()] =
        dropTempData[index]['id'];

    queryParameters['taskType'] = taskType;
    _throwFunc.run(argument: queryParameters);
  }

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    queryParameters = {
      "current": page,
      "size": 30,
      "taskType": taskType,
      'controlType': 1,
    };
    // 检测网络
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool network = true;

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        // setState(() => _connectionStatus = result.toString());
        if (result.toString() == 'ConnectivityResult.none') {
          network = false;
          setState(() {});
        } else {
          network = true;
          queryParameters = {
            "current": page,
            "size": 30,
            "taskType": taskType,
            'controlType': 1,
          };
          // _getData();
          _getDropList();
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  _sumbit() {
    int id = dropTempData[2]['id'];
    if (id > -1) {
      myDio.request(type: 'post', url: Interface.postCheckBatchControl, data: {
        "controlType": 1,
        "threeId": id,
        "taskType": taskType
      }).then((value) {
        successToast('提交成功');
        Future.delayed(Duration(milliseconds: 500), () {
          _throwFunc.run(argument: queryParameters);
        });
      });
    }
  }

  List state = [
    {"title": '待排查', "button": '排查'},
    {"title": '待确认', "button": '确认隐患'},
    {"title": '整改中', "button": '整改完毕'},
    {"title": '整改完毕', "button": '整改审批'},
    {"title": '已完成', "button": '已完成'},
    {"title": '已逾期', "button": '已逾期'},
  ];

  _getDownloadColor(int fourId) {
    for (int i = 0; i < HiddenData.instance.download.length; i++) {
      if (HiddenData.instance.download[i]['fourId'] == fourId) {
        return Color(0xff999999);
      }
    }
    return Color(0xff3073FE);
  }

  _getDownloadText(int fourId) {
    for (int i = 0; i < HiddenData.instance.download.length; i++) {
      if (HiddenData.instance.download[i]['fourId'] == fourId) {
        return '已下载';
      }
    }
    return '离线下载';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          network
              ? TitleChoose(
                  list: dropTempData,
                  getDataList: _dropList,
                )
              : Container(),
          network
              ? Expanded(
                  child: MyRefres(
                      child: (index, list) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 40,
                                vertical: size.width * 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipPath(
                                  clipper: MyCustomClipper(),
                                  child: Container(
                                      // margin: EdgeInsets.only(
                                      //     left: size.width * 10),
                                      color: themeColor,
                                      padding: EdgeInsets.only(
                                          left: size.width * 20,
                                          right: size.width * 40),
                                      child: Text(
                                        list[index]['keyParameterIndex'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.width * 32,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12
                                                .withOpacity(0.15),
                                            blurRadius: 0.5,
                                            spreadRadius: 0.5)
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // 离线下载点击
                                      GestureDetector(
                                          onTap: () {
                                            String add = '';
                                            int hiddenIndex;
                                            if (HiddenData.instance.download ==
                                                []) {
                                              HiddenData.instance.download
                                                  .add(list[index]);
                                              return;
                                            } else {
                                              HiddenData.instance.download
                                                  .asMap()
                                                  .forEach((key, hiddenValue) {
                                                if (hiddenValue['fourId'] ==
                                                    list[index]['fourId']) {
                                                  add = 'no';
                                                  hiddenIndex = key;
                                                }
                                              });
                                            }
                                            if (add == 'no') {
                                              HiddenData.instance.download
                                                  .remove(HiddenData.instance
                                                      .download[hiddenIndex]);
                                            } else {
                                              HiddenData.instance.download
                                                  .add(list[index]);
                                            }
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 30,
                                                vertical: size.width * 20),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: size.width * 380,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '风险分析对象：${list[index]['riskPoint'].toString()}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width * 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: size.width * 15,
                                                      ),
                                                      Text(
                                                        '风险分析单元：${list[index]['riskUnit'].toString()}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width * 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: size.width * 15,
                                                      ),
                                                      Text(
                                                        '风险事件：${list[index]['riskItem'].toString()}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width * 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: size.width * 20),
                                                  alignment: Alignment.center,
                                                  constraints:
                                                      BoxConstraints.expand(
                                                          height:
                                                              size.width * 34.0,
                                                          width: size.width *
                                                              102.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      color: HiddenData.instance
                                                                  .download ==
                                                              []
                                                          ? Color(0xff3073FE)
                                                          : _getDownloadColor(
                                                              list[index]
                                                                  ['fourId'])),
                                                  child: Text(
                                                    HiddenData.instance
                                                                .download ==
                                                            []
                                                        ? '离线下载'
                                                        : _getDownloadText(
                                                            list[index]
                                                                ['fourId']),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 20),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                      Container(
                                        height: size.width * 1,
                                        width: double.infinity,
                                        color: Color(0xffEFEFEF),
                                      ),
                                      // 操作手段点击
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/home/hiddenScreening',
                                              arguments: {
                                                "id": list[index]['id'],
                                                "fourId": list[index]['fourId'],
                                                "type": list[index]['status'],
                                                "title":
                                                    state[list[index]['status']]
                                                            ['title']
                                                        .toString(),
                                                "authority": 1,
                                                "data": list[index],
                                                'genre': '隐患'
                                              }).then((value) {
                                            _throwFunc.run(
                                                argument: queryParameters);
                                          });
                                        },
                                        child: Padding(
                                            padding:
                                                EdgeInsets.all(size.width * 20),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: size.width * 400,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                          text: '排查措施:      ',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff3074FE),
                                                              fontSize:
                                                                  size.width *
                                                                      20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: list[index][
                                                                  'controlMeasures']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff666666),
                                                            fontSize:
                                                                size.width * 20,
                                                          ),
                                                        )
                                                      ])),
                                                      SizedBox(
                                                        height: size.width * 10,
                                                      ),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                          text: '排查手段:      ',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff3074FE),
                                                              fontSize:
                                                                  size.width *
                                                                      20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: list[index][
                                                                  'controlMeans']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff666666),
                                                            fontSize:
                                                                size.width * 20,
                                                          ),
                                                        )
                                                      ])),
                                                      SizedBox(
                                                        height: size.width * 10,
                                                      ),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                          text:
                                                              '排查时${taskType == 3 ? '间' : '限'}:      ',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff3074FE),
                                                              fontSize:
                                                                  size.width *
                                                                      20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: taskType == 3
                                                              ? list[index][
                                                                      'reportingTime']
                                                                  .toString()
                                                              : list[index][
                                                                      'beyondDate']
                                                                  .toString(),
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff666666),
                                                            fontSize:
                                                                size.width * 20,
                                                          ),
                                                        )
                                                      ])),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: size.width * 20),
                                                  alignment: Alignment.center,
                                                  constraints:
                                                      BoxConstraints.expand(
                                                          height:
                                                              size.width * 34.0,
                                                          width: size.width *
                                                              102.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                    border: Border.all(
                                                        width: size.width * 1,
                                                        color:
                                                            Color(0xff3073FE)),
                                                  ),
                                                  child: Text(
                                                    state[list[index]['status']]
                                                            ['button']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff3073FE),
                                                        fontSize:
                                                            size.width * 20),
                                                  ),
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      queryParameters: queryParameters,
                      throwFunc: _throwFunc,
                      listParam: 'records',
                      url: Interface.getCHeckRiskControlList,
                      callback: (data) {
                        setState(() {
                          _data = data;
                        });
                      },
                      method: 'get'))
              // 下载的离线数据列表
              : HiddenData.instance.download.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: HiddenData.instance.download.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 40,
                                  vertical: size.width * 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipPath(
                                    clipper: MyCustomClipper(),
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: size.width * 10),
                                        color: themeColor,
                                        padding: EdgeInsets.only(
                                            left: size.width * 20,
                                            right: size.width * 40),
                                        child: Text(
                                          HiddenData.instance.download[index]
                                              ['keyParameterIndex'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 32,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12
                                                  .withOpacity(0.15),
                                              blurRadius: 0.5,
                                              spreadRadius: 0.5)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 30,
                                              vertical: size.width * 20),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: size.width * 380,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '风险分析对象：${HiddenData.instance.download[index]['riskPoint'].toString()}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: size.width * 15,
                                                    ),
                                                    Text(
                                                      '风险分析单元：${HiddenData.instance.download[index]['riskUnit'].toString()}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: size.width * 15,
                                                    ),
                                                    Text(
                                                      '风险事件：${HiddenData.instance.download[index]['riskItem'].toString()}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: size.width * 1,
                                          width: double.infinity,
                                          color: Color(0xffEFEFEF),
                                        ),
                                        // 操作手段点击
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                '/home/hiddenScreening',
                                                arguments: {
                                                  "id": HiddenData.instance
                                                      .download[index]['id'],
                                                  "fourId": HiddenData.instance
                                                          .download[index]
                                                      ['fourId'],
                                                  "type": HiddenData.instance
                                                          .download[index]
                                                      ['status'],
                                                  "title": state[HiddenData
                                                              .instance
                                                              .download[index]
                                                          ['status']]['title']
                                                      .toString(),
                                                  "authority": 1,
                                                  "data": HiddenData
                                                      .instance.download[index],
                                                  'genre': '隐患'
                                                }).then((value) {
                                              if (AlreadySubmitData.instance
                                                  .submitData.isNotEmpty) {
                                                for (int i = 0;
                                                    i <
                                                        HiddenData.instance
                                                            .download.length;
                                                    i++) {
                                                  for (int j = 0;
                                                      j <
                                                          AlreadySubmitData
                                                              .instance
                                                              .submitData
                                                              .length;
                                                      j++) {
                                                    if (HiddenData.instance
                                                                .download[i]
                                                            ['id'] ==
                                                        AlreadySubmitData
                                                                .instance
                                                                .submitData[j]
                                                            ['id']) {
                                                      HiddenData
                                                          .instance.download
                                                          .remove(HiddenData
                                                              .instance
                                                              .download[i]);
                                                    }
                                                  }
                                                }
                                              }
                                              setState(() {});
                                              // _throwFunc.run(
                                              //     argument: queryParameters);
                                            });
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.all(
                                                  size.width * 20),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: size.width * 400,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text.rich(
                                                            TextSpan(children: [
                                                          TextSpan(
                                                            text: '排查措施:      ',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff3074FE),
                                                                fontSize:
                                                                    size.width *
                                                                        20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text: HiddenData
                                                                .instance
                                                                .download[index]
                                                                    [
                                                                    'controlMeasures']
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff666666),
                                                              fontSize:
                                                                  size.width *
                                                                      20,
                                                            ),
                                                          )
                                                        ])),
                                                        SizedBox(
                                                          height:
                                                              size.width * 10,
                                                        ),
                                                        Text.rich(
                                                            TextSpan(children: [
                                                          TextSpan(
                                                            text: '排查手段:      ',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff3074FE),
                                                                fontSize:
                                                                    size.width *
                                                                        20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text: HiddenData
                                                                .instance
                                                                .download[index]
                                                                    [
                                                                    'controlMeans']
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff666666),
                                                              fontSize:
                                                                  size.width *
                                                                      20,
                                                            ),
                                                          )
                                                        ])),
                                                        SizedBox(
                                                          height:
                                                              size.width * 10,
                                                        ),
                                                        Text.rich(
                                                            TextSpan(children: [
                                                          TextSpan(
                                                            text:
                                                                '排查时${HiddenData
                                                                    .instance
                                                                    .download[
                                                                        index][
                                                                        'reportingTime'] != null ? '间' : '限'}:      ',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff3074FE),
                                                                fontSize:
                                                                    size.width *
                                                                        20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text: HiddenData
                                                                    .instance
                                                                    .download[
                                                                        index][
                                                                        'reportingTime'] != null
                                                                ? HiddenData
                                                                    .instance
                                                                    .download[
                                                                        index][
                                                                        'reportingTime']
                                                                    .toString()
                                                                : HiddenData
                                                                    .instance
                                                                    .download[
                                                                        index][
                                                                        'beyondDate']
                                                                    .toString(),
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff666666),
                                                              fontSize:
                                                                  size.width *
                                                                      20,
                                                            ),
                                                          )
                                                        ])),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: size.width * 20),
                                                    alignment: Alignment.center,
                                                    constraints:
                                                        BoxConstraints.expand(
                                                            height: size.width *
                                                                34.0,
                                                            width: size.width *
                                                                102.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      border: Border.all(
                                                          width: size.width * 1,
                                                          color: Color(
                                                              0xff3073FE)),
                                                    ),
                                                    child: Text(
                                                      state[HiddenData.instance
                                                                      .download[
                                                                  index][
                                                              'status']]['button']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff3073FE),
                                                          fontSize:
                                                              size.width * 20),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }))
                  : Center(
                      child: Text('暂无离线数据'),
                    ),
          dropTempData.length == 3 &&
                  dropTempData[2]['title'] != dropTempData[2]['saveTitle'] &&
                  taskType != 3 &&
                  _data.isNotEmpty &&
                  network
              ? Center(
                  child: ElevatedButton(
                    onPressed: _sumbit,
                    child: Text(
                      '一键提交',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : Container()
        ]));
  }
}

class CheckHiddenTitle extends StatefulWidget {
  @override
  _CheckHiddenTitleState createState() => _CheckHiddenTitleState();
}

class _CheckHiddenTitleState extends State<CheckHiddenTitle> {
  List<String> data = ['今日', '提前', '异常'];

  int choosed = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: size.width * 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: data
            .asMap()
            .keys
            .map((index) => InkWell(
                  onTap: () {
                    choosed = index;
                    if (mounted) {
                      setState(() {});
                    }
                    _globalKey.currentState.taskType = index + 1;
                    _globalKey.currentState.dropTempData = [
                      {
                        'title': '风险分析对象',
                        'data': [],
                        'value': '',
                        "saveTitle": '风险分析对象',
                        'dataUrl': Interface.getCheckOneListAll,
                        'limit': 'oneId'
                      }
                    ];
                    _globalKey.currentState.queryParameters = {
                      "current": 1,
                      "size": 30,
                      "taskType": index + 1,
                      "controlType": 1,
                    };
                    _globalKey.currentState._getDropList();
                    _globalKey.currentState._getData();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        color: choosed == index
                            ? Colors.white
                            : Color(0xff295DF7)),
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    child: Text(
                      data[index],
                      style: TextStyle(
                          fontSize: size.width * 30,
                          color: choosed == index
                              ? Color(0xff295DF7)
                              : Colors.white),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    Path path2 = Path();
    final centerPoint = (size.height / 2).clamp(32 / 2, 50 / 2);
    path.moveTo(size.width, size.height);
    path.lineTo(size.width - 17, centerPoint - 15);
    path.lineTo(size.width - 17, size.height);
    path.close();
    path2.addRect(Rect.fromLTRB(
      0,
      0,
      (size.width - 17),
      size.height,
    ));

    path.addPath(path2, Offset(0, 0));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
