import 'dart:convert';

import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myDateSelect.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/hiddenCheckGovern/hiddenCheckTask.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HiddenCheckRecord extends StatefulWidget {
  @override
  State<HiddenCheckRecord> createState() => _HiddenCheckRecordState();
}

class _HiddenCheckRecordState extends State<HiddenCheckRecord> {
  Map queryParameters = {};
  ThrowFunc _throwFunc = ThrowFunc();
  String startDate;
  String endDate;

  @override
  void initState() {
    super.initState();
    queryParameters = {
      "riskObjectId": null,
      "riskUnitId": null,
      "riskEventId": null
    };
    _getDropList();
    DateTime dateTime = DateTime.now();
    startDate = dateTime.toString().substring(0, 10);
    endDate = dateTime.toString().substring(0, 10);
  }

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
        "riskEventId": null
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
    print(queryParameters);

    _throwFunc.run(argument: queryParameters);
    if (mounted) {
      setState(() {});
    }
  }

  List stateList = ['全部', '逾期', '已完成'];
  String stateStr = '';

  // 0_现场确认；1_拍照；2_热成像；3_震动
  List checkMeansList = ['全部', '拍照', '现场确认', '热成像', '震动'];
  String checkMeansStr = '';

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('隐患排查记录', style: TextStyle(fontSize: size.width * 32)),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: Container(
            color: Color(0xffF8FAFF),
            child: Column(
              children: [
                TitleChoose(
                  list: dropTempData,
                  getDataList: _dropList,
                ),
                Container(
                  height: size.width * 2,
                  width: double.infinity,
                  color: Color(0xffF2F2F2),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // 筛选 状态 管控手段
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: false,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  builder: (BuildContext context) {
                                    return ListView.builder(
                                      itemCount: stateList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            stateStr = stateList[index].toString();
                                            if(stateStr == '全部'){
                                              queryParameters['checkStatus'] = '';
                                            }else if(stateStr == '逾期'){
                                              queryParameters['checkStatus'] = '2';
                                            }else if(stateStr == '已完成'){
                                              queryParameters['checkStatus'] = '0';
                                            }
                                            _throwFunc.run(argument: queryParameters);
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: Text(
                                                stateList[index].toString()),
                                          ),
                                        );
                                      },
                                    );
                                  });
                            },
                            child: Container(
                              width: size.width * 328,
                              height: size.width * 60,
                              margin: EdgeInsets.only(top: size.width * 12),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 16,
                                  vertical: size.width * 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: size.width * 2,
                                  color: Color(0xffF2F2F2),
                                ),
                                borderRadius:
                                    BorderRadius.circular(size.width * 8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    stateStr == '' ? "请选择状态" : stateStr,
                                    style: TextStyle(
                                        color: Color(0xff7F8A9C),
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xff7F8A9C),
                                    size: size.width * 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: false,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  builder: (BuildContext context) {
                                    return ListView.builder(
                                      itemCount: checkMeansList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            checkMeansStr = checkMeansList[index].toString();
                                            // 0_现场确认；1_拍照；2_热成像；3_震动
                                            if(checkMeansStr == '全部'){
                                              queryParameters['checkMeans'] = '';
                                            }else if(checkMeansStr == '现场确认'){
                                              queryParameters['checkMeans'] = '0';
                                            }else if(checkMeansStr == '拍照'){
                                              queryParameters['checkMeans'] = '1';
                                            }else if(checkMeansStr == '热成像'){
                                              queryParameters['checkMeans'] = '2';
                                            }else if(checkMeansStr == '震动'){
                                              queryParameters['checkMeans'] = '3';
                                            }
                                            _throwFunc.run(argument: queryParameters);
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: Text(checkMeansList[index]
                                                .toString()),
                                          ),
                                        );
                                      },
                                    );
                                  });
                            },
                            child: Container(
                              width: size.width * 328,
                              height: size.width * 60,
                              margin: EdgeInsets.only(top: size.width * 12),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 16,
                                  vertical: size.width * 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: size.width * 2,
                                  color: Color(0xffF2F2F2),
                                ),
                                borderRadius:
                                    BorderRadius.circular(size.width * 8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    checkMeansStr == ''
                                        ? "请选择管控手段"
                                        : checkMeansStr,
                                    style: TextStyle(
                                        color: Color(0xff7F8A9C),
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xff7F8A9C),
                                    size: size.width * 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 筛选 时间
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MyDateSelect(
                            title: 'startDate',
                            purview: 'startDate',
                            hintText: '开始时间',
                            callback: (value) {
                              startDate = value;
                              queryParameters['startDate'] = startDate;
                            },
                            icon: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_calendar.png',
                              height: size.width * 28,
                              width: size.width * 28,
                            ),
                          ),
                          MyDateSelect(
                            title: 'endDate',
                            purview: 'endDate',
                            hintText: '结束时间',
                            callback: (value) {
                              endDate = value;
                              if(queryParameters['startDate'] == null){
                                Fluttertoast.showToast(msg: '请先选择开始时间');
                              }else{
                                queryParameters['startDate'] = DateTime.parse(queryParameters['startDate']).millisecondsSinceEpoch;
                                queryParameters['endDate'] = DateTime.parse(endDate).millisecondsSinceEpoch;
                              }
                              _throwFunc.run(argument: queryParameters);
                              setState(() {});
                            },
                            icon: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_calendar.png',
                              height: size.width * 28,
                              width: size.width * 28,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: MyRefres(
                  child: (index, list) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/hiddenCheckGovern/hiddenCheckRecordDetails', arguments: {'id': list[index]['id']});
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: size.width * 32,
                          right: size.width * 32,
                          left: size.width * 32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(size.width * 20),
                            bottomLeft: Radius.circular(size.width * 20),
                            bottomRight: Radius.circular(size.width * 20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 20,
                                vertical: size.width * 16),
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 16,
                                        vertical: size.width * 6),
                                    decoration: BoxDecoration(
                                        color: list[index]['checkStatus'] == '2'
                                            ? Color(0xffF56271)
                                            : Color(0xff5FD5EC),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 8))),
                                    child: Text(
                                      list[index]['checkStatus'] == '2' ? '逾期' : '已完成',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  Spacer(),
                                Text(
                                  '详情 >',
                                  style: TextStyle(
                                    color: Color(0xff3074FF),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 24,
                                vertical: size.width * 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff2276FC).withOpacity(0.12),
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(size.width * 20),
                                  bottomRight:
                                      Radius.circular(size.width * 20)),
                            ),
                            constraints: BoxConstraints(
                              minWidth: size.width * 686,
                            ),
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
                                            text: '管控措施：',
                                            style: TextStyle(
                                                color: Color(0xff333333))),
                                        TextSpan(
                                            text: list[index]
                                                ['riskMeasureDesc'],
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
                                            text: '隐患内容：',
                                            style: TextStyle(
                                                color: Color(0xff333333))),
                                        TextSpan(
                                            text: list[index]
                                                ['troubleshootContent'],
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
                                            text: '排查人：',
                                            style: TextStyle(
                                                color: Color(0xff333333))),
                                        TextSpan(
                                            text: list[index]['checkUser'],
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
                                            text: '排查时间：',
                                            style: TextStyle(
                                                color: Color(0xff333333))),
                                        TextSpan(
                                            text: DateTime.fromMillisecondsSinceEpoch(list[index]['checkTime']).toString().substring(0, 19),
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
                                            text: '管控手段：',
                                            style: TextStyle(
                                                color: Color(0xff333333))),
                                        TextSpan(
                                            text: list[index]['checkMeans'],
                                            style: TextStyle(
                                                color: Color(0xff7F8A9C))),
                                      ]),
                                ),
                                SizedBox(
                                  height: size.width * 16,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  page: true,
                  url: Interface.getCheckRecordList,
                  listParam: "records",
                  queryParameters: queryParameters,
                  method: 'get',
                  throwFunc: _throwFunc,
                  // data: data,
                ))
              ],
            ),
          ),
        ));
  }
}
