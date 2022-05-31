import 'dart:convert';

import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SafetyRiskList extends StatefulWidget {
  @override
  State<SafetyRiskList> createState() => _SafetyRiskListState();
}

class _SafetyRiskListState extends State<SafetyRiskList> {
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
      "riskEventId": null
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

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffF8FAFF),
        child: Column(
          children: [
            TierChoose(
              list: dropTempData,
              getDataList: _dropList,
            ),
            Expanded(
              child: MyRefres(
                  child: (index, list) => Container(
                      margin: EdgeInsets.only(
                          left: size.width * 32,
                          right: size.width * 32,
                          top: size.width * 32),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 20),
                              bottomLeft: Radius.circular(size.width * 20),
                              bottomRight: Radius.circular(size.width * 20)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff7F8A9C).withOpacity(0.05),
                                blurRadius: size.width * 8,
                                spreadRadius: size.width * 2)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 32,
                                vertical: size.width * 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(size.width * 16)),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff2276FC).withOpacity(0.12),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '风险分析对象：${list[index]['riskObjectName']}',
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                Container(
                                  height: size.width * 46,
                                  width: size.width * 104,
                                  decoration: BoxDecoration(
                                      color: list[index]['isControl'] == 0
                                          ? Color(0xffF56271)
                                          : Color(0xff5FD5EC),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 8))),
                                  alignment: Alignment.center,
                                  child: Text(
                                    list[index]['isControl'] == 0 ? '异常' : '正常',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 32,
                                vertical: size.width * 16),
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
                                            text: list[index]
                                                ['riskMeasureDesc'],
                                            style: TextStyle(
                                                color: Color(0xff7F8A9C))),
                                      ]),
                                ),
                                SizedBox(
                                  height: size.width * 16,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: size.width * 2,
                            width: double.infinity,
                            color: Color(0xffECECEC),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.width * 24, bottom: size.width * 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/safetyRiskList/details',
                                        arguments: {'id': list[index]['id']});
                                  },
                                  child: Container(
                                    height: size.width * 64,
                                    width: size.width * 200,
                                    decoration: BoxDecoration(
                                      color: Color(0xff3074FF).withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 32)),
                                      border: Border.all(
                                          width: size.width * 2,
                                          color: Color(0xff3074FF)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '详情',
                                      style: TextStyle(
                                          color: Color(0xff3074FF),
                                          fontSize: size.width * 28,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        '/safetyRiskList/controlSituation',
                                        arguments: {'id': list[index]['id']});
                                  },
                                  child: Container(
                                    height: size.width * 64,
                                    width: size.width * 200,
                                    decoration: BoxDecoration(
                                      color: Color(0xff3074FF),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 32)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '管控情况',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 28,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  page: true,
                  url: Interface.getRiskTemplateFourList,
                  listParam: "records",
                  queryParameters: queryParameters,
                  throwFunc: _throwFunc,
                  method: 'get'
                  // data: data,
                  ),
            )
          ],
        ));
  }
}

class TierChoose extends StatefulWidget {
  TierChoose({this.list, this.getDataList});
  final List list;
  final ReturnIntStringCallback getDataList;
  @override
  _TierChooseState createState() => _TierChooseState();
}

class _TierChooseState extends State<TierChoose> {
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
