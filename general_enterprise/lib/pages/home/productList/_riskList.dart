import 'dart:convert';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/risk/_riskCircle.dart';
import 'package:enterprise/pages/waitWork/_commonPage.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class CheckRiskList extends StatefulWidget {
  CheckRiskList({Key key, this.type}) : super(key: key);
  final int type;
  @override
  _CheckRiskListState createState() => _CheckRiskListState();
}

class _CheckRiskListState extends State<CheckRiskList> {
  @override
  void initState() {
    super.initState();
    queryParameters = {
      "current": 1,
      "size": 30,
      "oneId": null,
      "twoId": null,
      // 'type': widget.type ?? 1
    };
    _getDropList();
  }

  List dropTempData = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      "saveTitle": '风险分析对象',
      'dataUrl': Interface.getCheckOneListAll,
      'limit': 'oneId'
    }
  ];
  bool init = true;
  dynamic queryParameters = {};
  ThrowFunc _throwFunc = ThrowFunc();
  // List data = [];
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
  ];

  _getDropList() {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        myDio.request(
            type: 'get',
            url: dropTempData[i]['dataUrl'],
            queryParameters: {'type': 2}).then((value) {
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

  _dropList({int index, String msg}) {
    if (dropTempData[index]['value'] == '查看全部') {
      _deleteIndex(index);
      queryParameters = {
        "current": 1,
        "size": 30,
        "oneId": null,
        "twoId": null,
        // 'type': widget.type ?? 1
      };
      _throwFunc.run(argument: queryParameters);
      if (mounted) {
        setState(() {});
      }
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
          queryParameters: {'type': 2}).then((value) {
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
      queryParameters["twoId"] = null;
    }

    _throwFunc.run(argument: queryParameters);
    if (mounted) {
      setState(() {});
    }
  }

  _getText(int index, List data) {
    String text;
    if (data[index]["threeId"] != null) {
      text = data[index]["riskItem"].toString().substring(0, 2);
    } else if (data[index]["twoId"] != null) {
      text = data[index]["riskUnit"].toString().substring(0, 2);
    } else {
      text = data[index]["riskPoint"].toString().substring(0, 2);
    }
    return text;
  }

  _getValue(int index, List data) {
    int value;
    if (data[index]['totalNum'] == 0 ||
        data[index]['totalNum'] == null ||
        data[index]['uncontrolledNum'] == null) {
      value = 10;
    } else {
      value = 10 -
          (((data[index]['totalNum'] - data[index]['uncontrolledNum']) /
                  data[index]['totalNum'] *
                  10)
              .toInt()
              .abs());
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TitleChoose(
        list: dropTempData,
        getDataList: _dropList,
      ),

      Expanded(
          child: MyRefres(
              child: (index, data) => Container(
                    margin: EdgeInsets.fromLTRB(
                        size.width * 20, size.width * 20, size.width * 20, 0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          List<HiddenDangerInterface> _leftbar = [];
                          _leftbar = _leftbar.changeHiddenDangerInterfaceType(
                              data,
                              title: 'riskItem',
                              icon: null,
                              iconWidget: null,
                              type: 0,
                              id: 'threeId');
                          _leftbar[index].color = Colors.white;
                          Navigator.pushNamed(
                              context, '/index/productList/CommonPage',
                              arguments: {
                                "leftBar": _leftbar,
                                "index": index,
                                "widgetType": 'riskListCommonPage'
                              });
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 30,
                              size.width * 30,
                              size.width * 0,
                              size.width * 30),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  RiskCircle(
                                    width: size.width * 60,
                                    fontsize: size.width * 20,
                                    radius: 20,
                                    text: _getText(index, data),
                                    value: _getValue(index, data),
                                    level: data[index]['riskLevel'],
                                    initialRiskLevel: data[index]
                                        ['initialRiskLevel'],
                                  ),
                                  SizedBox(
                                    width: size.width * 40,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '风险分析对象：',
                                            style: TextStyle(
                                                color: Color(0xff666666),
                                                fontSize: size.width * 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                              width: size.width * 180,
                                              child: Text(
                                                data[index]['riskPoint'],
                                                style: TextStyle(
                                                    color: Color(0xff666666),
                                                    fontSize: size.width * 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '风险分析单元：',
                                            style: TextStyle(
                                                color: Color(0xff666666),
                                                fontSize: size.width * 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: size.width * 180,
                                            child: Text(
                                              data[index]['riskUnit'],
                                              style: TextStyle(
                                                  color: Color(0xff666666),
                                                  fontSize: size.width * 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '风险事件：',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: size.width * 180,
                                            child: Text(
                                              data[index]['riskItem'],
                                              style: TextStyle(
                                                  color: Color(0xff333333),
                                                  fontSize: size.width * 26,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    width: size.width * 60,
                                    height: size.width * 34,
                                    margin: EdgeInsets.only(
                                        top: size.width * 80,
                                        right: size.width * 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      border: Border.all(
                                          width: size.width * 1,
                                          color: Color(0xff367AFF)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '查看',
                                      style: TextStyle(
                                          color: Color(0xff367AFF),
                                          fontSize: size.width * 22),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
              url: Interface.getListMajorFireEmergencyThree,
              listParam: 'records',
              throwFunc: _throwFunc,
              queryParameters: queryParameters,
              method: 'get'))
    ]);
  }
}
