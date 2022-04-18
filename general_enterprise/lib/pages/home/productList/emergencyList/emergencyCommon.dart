import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

import '../../../../common/refreshList.dart';

GlobalKey<_EmergencyCommonPageState> workListglobalKey = GlobalKey();

class EmergencyCommonPage extends StatefulWidget {
  EmergencyCommonPage({this.title, this.id, this.throwFunc});
  final String title;
  final int id;
  final ThrowFunc throwFunc;
  @override
  _EmergencyCommonPageState createState() => _EmergencyCommonPageState();
}

class _EmergencyCommonPageState extends State<EmergencyCommonPage> {
  String title;
  List<HiddenDangerInterface> leftBarList = [];
  @override
  void initState() {
    super.initState();
    // widget.throwFunc?.init([_getData]);
    // _getData({"id": widget.id});
  }

  // _getData({dynamic argument}) {
  //   myDio.request(
  //       type: 'get',
  //       url: Interface.getListMajorFireEmergencyFour,
  //       queryParameters: {
  //         'threeId': argument['id'],
  //         'type': 3,
  //       }).then((value) {
  //     riskFourList = value['records'];
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }

  List riskFourList = [
    {
      "fourId": -1,
      "controlMeasures": "",
      "keyParameterIndex": "",
      "controlType": "",
      "controlMeans": ""
    },
  ];

  List<List> spotCheckDropList = [
    [
      {
        'title': "点检结果",
        "data": [
          '无隐患',
          '一般隐患',
          '重大隐患',
        ],
        'value': '',
        'saveTitle': '点检结果',
        'bindKey': "investigationResults"
      },
      {
        'title': "点检状态",
        "data": [
          '待确认',
          '整改中',
          '整改完毕',
          '已完成',
          '逾期',
        ],
        'value': '',
        'saveTitle': '点检状态',
        'bindKey': "status"
      }
    ]
  ];

  int fourId = -1;

  List<List> hiddenDropList = [
    [
      {
        'title': "排查结果",
        "data": [
          '无隐患',
          '一般隐患',
          '重大隐患',
        ],
        'value': '',
        'saveTitle': '排查结果',
        'bindKey': "investigationResults"
      },
      {
        'title': "排查状态",
        "data": [
          '待确认',
          '整改中',
          '整改完毕',
          '已完成',
          '逾期',
        ],
        'value': '',
        'saveTitle': '排查状态',
        'bindKey': "status"
      }
    ]
  ];

  Future<List> _getEmergencyHistory(
    String status,
    String startDate,
    String endDate,
  ) async {
    int investigationResult, statu;
    spotCheckDropList.forEach((element) {
      element.forEach((_element) {
        if (_element['bindKey'] == 'investigationResults' &&
            _element['value'] != '') {
          investigationResult = _element['value'];
        } else if (_element['bindKey'] == 'status' && _element['value'] != '') {
          statu = _element['value'];
        }
      });
    });
    final res = await myDio.request(
        type: 'get',
        url: Interface.getListMajorFireEmergencyHistory,
        queryParameters: {
          "current": 1,
          "size": 1000,
          "startDate": startDate,
          "endDate": endDate,
          "fourId": fourId,
          "investigationResults": investigationResult,
          "status": statu is int ? statu + 1 : null
        });
    if (res['records'] is List) {
      return Future.value(res['records']);
    } else {
      return Future.error([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: MyRefres(
        child: (index, list) => Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(size.width * 20),
                  child: Text(
                    riskFourList[index]['keyParameterIndex'],
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 26,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffEFEFEF),
              ),
              Padding(
                  padding: EdgeInsets.all(size.width * 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 400,
                            child: RichText(
                              text: TextSpan(
                                  text: '管控措施：',
                                  style: TextStyle(
                                      color: Color(0xff3073FE),
                                      fontSize: size.width * 20,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: riskFourList[index]
                                            ['controlMeasures'],
                                        style:
                                            TextStyle(color: Color(0xff666666)))
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 20,
                          ),
                          Row(
                            children: [
                              Text(
                                '管控手段：',
                                style: TextStyle(
                                    color: Color(0xff3073FE),
                                    fontSize: size.width * 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                riskFourList[index]['controlMeans'],
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          fourId = riskFourList[index]['fourId'];
                          if (riskFourList[index]['controlType'] == '巡检点检') {
                            Navigator.pushNamed(context, '/home/Queryhistory',
                                arguments: {
                                  "callback": _getEmergencyHistory,
                                  "listTitle": ['点检人', '所在工位', '点检时间', '点检状态'],
                                  "layer": 'item',
                                  "listTable": [
                                    'reportingUser',
                                    'reportingDepartment',
                                    'reportingTime',
                                    'status'
                                  ],
                                  "showRiskAccountDialogDrop": false,
                                  "title": riskFourList[index]
                                      ['keyParameterIndex'],
                                  "dropList": spotCheckDropList,
                                  "noTime": true,
                                }).then((value) {
                              spotCheckDropList.forEach((element) {
                                element.forEach((_element) {
                                  _element['value'] = '';
                                  _element['title'] = _element['saveTitle'];
                                });
                              });
                            });
                          } else if (riskFourList[index]['controlType'] ==
                              '隐患排查') {
                            Navigator.pushNamed(context, '/home/Queryhistory',
                                arguments: {
                                  "callback": _getEmergencyHistory,
                                  "listTitle": ['排查人', '所在工位', '排查时间', '排查状态'],
                                  "layer": 'item',
                                  "listTable": [
                                    'reportingUser',
                                    'reportingDepartment',
                                    'reportingTime',
                                    'status'
                                  ],
                                  "showRiskAccountDialogDrop": false,
                                  "title": riskFourList[index]
                                      ['keyParameterIndex'],
                                  "dropList": hiddenDropList,
                                  "noTime": true,
                                }).then((value) {
                              hiddenDropList.forEach((element) {
                                element.forEach((_element) {
                                  _element['value'] = '';
                                  _element['title'] = _element['saveTitle'];
                                });
                              });
                            });
                          }
                        },
                        child: Container(
                          width: size.width * 70,
                          height: size.width * 34,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                                width: size.width * 1,
                                color: Color(0xff3073FE)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '台账',
                            style: TextStyle(
                                color: Color(0xff367AFF),
                                fontSize: size.width * 22),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
        url: Interface.getListMajorFireEmergencyFour,
        throwFunc: widget.throwFunc,
        method: "get",
        listParam: 'records',
        queryParameters: {
          'threeId': widget.id,
          'type': 3,
        },
      ),
    );
  }
}
