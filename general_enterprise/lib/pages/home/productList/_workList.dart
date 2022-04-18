import 'dart:convert';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/risk/_riskCircle.dart';
import 'package:enterprise/pages/waitWork/_commonPage.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class CheckWorkList extends StatefulWidget {
  CheckWorkList({Key key}) : super(key: key);
  @override
  _CheckWorkListState createState() => _CheckWorkListState();
}

class _CheckWorkListState extends State<CheckWorkList> {
  @override
  void initState() {
    super.initState();
    queryParameters = {
      "current": 1,
      "size": 100,
      "oneId": null,
      "twoId": null,
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
    },
  ];

  dynamic queryParameters = {};
  List data = [];
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

  _getDropList() async {
    for (var i = 0; i < dropTempData.length; i++) {
      if (dropTempData[i]['title'] != '选择时间') {
        await myDio.request(
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
    _getData();
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
      queryParameters = {"current": 1, "size": 100};
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
    _getData();
  }

  _getData() {
    myDio.request(
            type: 'get',
            url: Interface.getListDayWorkThree,
            queryParameters: queryParameters,
            mounted: mounted)
        .then((value) {
      if (value != null) {
        data = value['records'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getText(int index) {
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

  _getValue(int index) {
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
    return Column(
      children: [
        TitleChoose(
          list: dropTempData,
          getDataList: _dropList,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(size.width * 20),
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
                                "widgetType": 'workListCommonPage',
                              });
                        },
                        child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  size.width * 30,
                                  size.width * 30,
                                  size.width * 10,
                                  size.width * 30
                                ),
                                child: Row(
                                children: [
                                  RiskCircle(
                                    width: size.width * 60,
                                    fontsize: size.width * 20,
                                    radius: 20,
                                    text: _getText(index),
                                    value: _getValue(index),
                                    level: data[index]['riskLevel'],
                                    initialRiskLevel: data[index]
                                        ['initialRiskLevel'],
                                  ),
                                  SizedBox(
                                    width: size.width * 40,
                                  ),
                                  Expanded(
                                      child: Column(
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
                                          Text(
                                            data[index]['riskPoint'],
                                            style: TextStyle(
                                                color: Color(0xff666666),
                                                fontSize: size.width * 20,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                          Text(
                                            data[index]['riskUnit'],
                                            style: TextStyle(
                                                color: Color(0xff666666),
                                                fontSize: size.width * 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '风险事件：',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              data[index]['riskItem'],
                                              style: TextStyle(
                                                  color: Color(0xff333333),
                                                  fontSize: size.width * 26,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                                  Container(
                                    width: size.width * 70,
                                    height: size.width * 34,
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
                              ),
                              Container(
                                width: double.infinity,
                                height: size.width * 1,
                                color: Color(0xffEFEFEF),
                                margin: EdgeInsets.symmetric(vertical: size.width * 5),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  size.width * 30,
                                  size.width * 30,
                                  size.width * 10,
                                  size.width * 30
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '风险描述：',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 22),
                                    ),
                                    Expanded(
                                      child: Text(
                                        data[index]['riskDescription'],
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 22),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                  )),
        )
      ],
    );
  }
}
