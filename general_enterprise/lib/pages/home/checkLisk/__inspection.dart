import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/checkLisk/data/alreadySubmitData.dart';
import 'package:enterprise/pages/home/checkLisk/data/spotCheckData.dart';
import 'package:enterprise/pages/waitWork/_commonPage.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<_CheckInpectionState> _globalKey = GlobalKey();

class CheckInpection extends StatefulWidget {
  CheckInpection({this.qrMessage}) : super(key: _globalKey);
  final Map qrMessage;
  @override
  _CheckInpectionState createState() => _CheckInpectionState();
}

class _CheckInpectionState extends State<CheckInpection> {
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
  List _data = [];
  dynamic _queryParameters = {};
  int page = 1, taskType = 1;
  bool scroll = true;
  bool init = true;
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

  _getDropList() {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        myDio.request(
            type: 'get',
            url: dropTempData[i]['dataUrl'],
            queryParameters: {
              'type': taskType == 3 ? 0 : 1,
              'taskType': taskType,
              'controlType': 2
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
    _queryParameters = {
      "current": page,
      "size": 30,
      "taskType": taskType,
      "controlType": 2,
    };
    if (dropTempData[index]['value'] == '查看全部') {
      _deleteIndex(index);
      _getData();
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
            'controlType': 2,
          }).then((value) {
        dropTempData[index + 1]['data'] = value;
        if (mounted) {
          setState(() {});
        }
      });
    }

    _queryParameters[dropTempData[index]['limit'].toString()] =
        dropTempData[index]['id'];

    _getData();
  }

  _getData() {
    _queryParameters['taskType'] = taskType;
    _throwFunc.run(argument: _queryParameters);
  }

  _sumbit() {
    int id = -1;
    dropTempData[2]['data'].forEach((ele) {
      if (ele['name'] == dropTempData[2]['value']) {
        id = ele['id'];
      }
    });
    if (id > -1) {
      myDio.request(type: 'post', url: Interface.postCheckBatchControl, data: {
        "controlType": 2,
        "threeId": id,
        "taskType": taskType
      }).then((value) {
        successToast('提交成功');
        _getData();
      });
    }
  }

  bool isLoading = false;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _queryParameters = {
            "current": page,
            "size": 30,
            "taskType": taskType,
            'controlType': 2,
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
          _queryParameters = {
            "current": page,
            "size": 30,
            "taskType": taskType,
            'controlType': 2,
          };
          _getDropList();
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  _getDownloadColor(int id) {
    for (int i = 0; i < SpotCheckData.instance.download.length; i++) {
      if (SpotCheckData.instance.download[i]['id'] == id) {
        return Color(0xff999999);
      }
    }
    return Color(0xff3073FE);
  }

  _getDownloadText(int id) {
    for (int i = 0; i < SpotCheckData.instance.download.length; i++) {
      if (SpotCheckData.instance.download[i]['id'] == id) {
        return '已下载';
      }
    }
    return '离线下载';
  }

  List status = ['点检', '待确认', '待整改', '待审批'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          widget.qrMessage == null && network
              ? TitleChoose(list: dropTempData, getDataList: _dropList)
              : Container(),
          network ? Expanded(
              child: MyRefres(
                  child: (index, list) => Container(
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
                                    list[index]['keyParameterIndex'].toString(),
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
                                        color: Colors.black12.withOpacity(0.15),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 离线下载点击
                                  GestureDetector(
                                      onTap: () {
                                        String add = '';
                                        int spotCheckIndex;
                                        if (SpotCheckData.instance.download ==
                                            []) {
                                          SpotCheckData.instance.download
                                              .add(list[index]);
                                          return;
                                        } else {
                                          SpotCheckData.instance.download
                                              .asMap()
                                              .forEach((key, spotCheckValue) {
                                            if (spotCheckValue['id'] ==
                                                list[index]['id']) {
                                              add = 'no';
                                              spotCheckIndex = key;
                                            }
                                          });
                                        }
                                        if (add == 'no') {
                                          SpotCheckData.instance.download.remove(
                                              SpotCheckData.instance
                                                  .download[spotCheckIndex]);
                                        } else {
                                          SpotCheckData.instance.download
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '风险分析对象：${list[index]['riskPoint'].toString()}',
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
                                                    '风险分析单元：${list[index]['riskUnit'].toString()}',
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
                                                    '风险事件：${list[index]['riskItem'].toString()}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 22,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                      height: size.width * 34.0,
                                                      width:
                                                          size.width * 102.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                  color: SpotCheckData.instance
                                                              .download ==
                                                          []
                                                      ? Color(0xff3073FE)
                                                      : _getDownloadColor(
                                                          list[index]
                                                              ['id'])),
                                              child: Text(
                                                SpotCheckData.instance.download ==
                                                        []
                                                    ? '离线下载'
                                                    : _getDownloadText(
                                                        list[index]['id']),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: size.width * 20),
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
                                            "title": list[index]['keyParameterIndex'],
                                            "authority": 1,
                                            'data': list[index],
                                            'controlType': 2,
                                            'genre': '巡检'
                                          }).then((value) {
                                        _getData();
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                      text: '排查措施:      ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff3074FE),
                                                          fontSize:
                                                              size.width * 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text: list[index][
                                                              'controlMeasures']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff666666),
                                                        fontSize:
                                                            size.width * 20,
                                                      ),
                                                    )
                                                  ])),
                                                  SizedBox(
                                                    height: size.width * 10,
                                                  ),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                      text: '排查手段:      ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff3074FE),
                                                          fontSize:
                                                              size.width * 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text: list[index]
                                                              ['controlMeans']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff666666),
                                                        fontSize:
                                                            size.width * 20,
                                                      ),
                                                    )
                                                  ])),
                                                  SizedBox(
                                                    height: size.width * 10,
                                                  ),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                      text:
                                                          '排查时${taskType == 3 ? '间' : '限'}:      ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff3074FE),
                                                          fontSize:
                                                              size.width * 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text: taskType == 3 ? list[index]
                                                              ['reportingTime']
                                                          .toString() : list[index]
                                                              ['beyondDate']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff666666),
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
                                                      height: size.width * 34.0,
                                                      width:
                                                          size.width * 102.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                border: Border.all(
                                                    width: size.width * 1,
                                                    color: Color(0xff3073FE)),
                                              ),
                                              child: Text(
                                                status[list[index]['status']].toString(),
                                                style: TextStyle(
                                                    color: Color(0xff3073FE),
                                                    fontSize: size.width * 20),
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
                  url: Interface.getCHeckRiskControlList,
                  throwFunc: _throwFunc,
                  queryParameters: _queryParameters,
                  listParam: 'records',
                  callback: (data) {
                    setState(() {
                      _data = data;
                    });
                  },
                  method: 'get'))
              // 下载的离线数据列表
              : SpotCheckData.instance.download.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: SpotCheckData.instance.download.length,
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
                                          SpotCheckData.instance.download[index]
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
                                                      '风险分析对象：${SpotCheckData.instance.download[index]['riskPoint'].toString()}',
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
                                                      '风险分析单元：${SpotCheckData.instance.download[index]['riskUnit'].toString()}',
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
                                                      '风险事件：${SpotCheckData.instance.download[index]['riskItem'].toString()}',
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
                                            Navigator.pushNamed(
                                                context, '/home/hiddenScreening',
                                                arguments: {
                                                  "id": SpotCheckData.instance.download[index]['id'],
                                                  "fourId": SpotCheckData.instance.download[index]['fourId'],
                                                  "type": SpotCheckData.instance.download[index]['status'],
                                                  "title": SpotCheckData.instance.download[index]['keyParameterIndex'],
                                                  "authority": 1,
                                                  'data': SpotCheckData.instance.download[index],
                                                  'controlType': 2,
                                                  'genre': '巡检'
                                                }).then((value) {
                                              // _getData();
                                                if(AlreadySubmitData.instance.submitData.isNotEmpty){
                                                    for (int i = 0; i < SpotCheckData.instance.download.length; i++) {
                                                      for (int j = 0; j < AlreadySubmitData.instance.submitData.length; j++) {
                                                        if(SpotCheckData.instance.download[i]['id'] == AlreadySubmitData.instance.submitData[j]['id']){
                                                          SpotCheckData.instance.download.remove(SpotCheckData.instance.download[i]);
                                                        }
                                                      }
                                                    }
                                                  }
                                                  setState(() {});
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
                                                            text: SpotCheckData.instance.download[index][
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
                                                            text: SpotCheckData.instance.download[index][
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
                                                                '排查时${SpotCheckData.instance.download[index]['reportingTime'] != null ? '间' : '限'}:      ',
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
                                                            text: SpotCheckData.instance.download[index]['reportingTime'] != null ? SpotCheckData.instance.download[index]['reportingTime'].toString() : SpotCheckData.instance.download[index]['beyondDate'].toString(),
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
                                                      status[SpotCheckData.instance.download[index]['status']].toString(),
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
                  network &&
                  _data.isNotEmpty
              ? ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(themeColor)),
                  onPressed: _sumbit,
                  child: Text('一键提交'),
                )
              : Container(),
          widget.qrMessage != null && _data.isNotEmpty && network
              ? ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(themeColor)),
                  onPressed: _sumbit,
                  child: Text('一键提交'),
                )
              : Container()
        ],
      ),
    );
  }
}

class CheckInpectionTitle extends StatefulWidget {
  @override
  _CheckInpectionTitleState createState() => _CheckInpectionTitleState();
}

class _CheckInpectionTitleState extends State<CheckInpectionTitle> {
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
                    _globalKey.currentState.taskType = index + 1;
                    _globalKey.currentState._data = [];
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
                    _globalKey.currentState._queryParameters = {
                      "current": 1,
                      "size": 30,
                      "taskType": index + 1,
                      'controlType': 2,
                    };
                    _globalKey.currentState._getDropList();
                    _globalKey.currentState.init = true;
                    // _globalKey.currentState._getData();
                    if (mounted) {
                      setState(() {});
                    }
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

// ignore: must_be_immutable
class ChecklistInspection extends StatelessWidget {
  final Function callback;
  final Map dataMap;
  ChecklistInspection({this.callback, this.dataMap});
  List status = ['点检', '待确认', '待整改', '待审批'];
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, //阴影颜色
                    offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                    blurRadius: 5.0, //阴影大小
                    spreadRadius: 0.0 //阴影扩散程度
                    ),
              ]),
          child: Padding(
            padding: EdgeInsets.all(size.width * 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '风险分析对象：${dataMap['riskPoint'].toString()}',
                            style: TextStyle(
                                fontSize: size.width * 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '风险分析单元：${dataMap['riskUnit'].toString()}',
                            style: TextStyle(
                                fontSize: size.width * 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '风险事件：${dataMap['riskItem'].toString()}',
                            style: TextStyle(
                                fontSize: size.width * 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 100,
                    ),
                    Container(
                      height: size.width * 34,
                      width: size.width * 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: themeColor, width: 1),
                          borderRadius: BorderRadius.circular(size.width * 10)),
                      alignment: Alignment.center,
                      child: Text(
                        status[dataMap['status']],
                        style: TextStyle(
                            color: themeColor, fontSize: size.width * 22),
                      ),
                    )
                  ],
                ),
                Divider(),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '点检措施：',
                      style: TextStyle(
                          color: Color(0xff3073FE),
                          fontSize: size.width * 20,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: dataMap['controlMeasures'].toString(),
                      style: TextStyle(fontSize: size.width * 20))
                ])),
                SizedBox(
                  height: size.width * 20,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '点检手段：',
                      style: TextStyle(
                          color: Color(0xff3073FE),
                          fontSize: size.width * 20,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: dataMap['controlMeans'].toString(),
                      style: TextStyle(fontSize: size.width * 20))
                ])),
                Text.rich(TextSpan(children: [
                  // 点检时限：11:00-16:00
                  TextSpan(
                      text: '点检时限：',
                      style: TextStyle(
                          color: Color(0xff3073FE),
                          fontSize: size.width * 20,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: dataMap['beyondDate'].toString(),
                      style: TextStyle(fontSize: size.width * 20))
                ]))
              ],
            ),
          ),
        ));
  }
}
