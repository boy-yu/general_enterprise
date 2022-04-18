// import 'dart:async';
import 'package:enterprise/common/myConfirmDialog.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/myAppbar.dart';
import '../../../tool/interface.dart';

class Apply extends StatefulWidget {
  Apply({this.arguments});
  final arguments;
  @override
  _ApplyState createState() => _ApplyState(arguments: arguments);
}

class _ApplyState extends State<Apply> {
  SharedPreferences prefs;
  _ApplyState({this.arguments});
  final arguments;
  Counter _context;
  int minutes = 0;
  List dropList = [
    {'title': '作业类型', 'data': [], 'value': '', "saveTitle": '作业类型'},
    {'title': '作业单位', 'data': [], 'value': '', "saveTitle": '作业单位'},
  ];

  List dropList2 = [
    {'title': '计划时间', 'data': [], 'value': '', "saveTitle": '计划时间'},
    {'title': '属地单位', 'data': [], 'value': '', "saveTitle": '属地单位'},
  ];

  List msgList = [];
  @override
  void initState() {
    super.initState();
    if (widget.arguments['title'] == '作业申请') {
      dropList2[0] = {
        'title': '相关作业',
        'data': [
          {"name": '本人作业'},
          {"name": '所有作业'}
        ],
        'value': '',
        "saveTitle": '相关作业'
      };
    }
    // print(widget.arguments['title']);
    _getDropList();
    _getDataList();
  }

  Future _getDataList() async {
    Map<String, dynamic> queryParameter = {
      "current": 1,
      "size": 50,
      "type": 0,
    };
    if (dropList[0]['value'] != '' && dropList[0]['value'] != '查看全部') {
      queryParameter['workTypes'] = dropList[0]['value'];
    }
    if (dropList[1]['value'] != '' && dropList[1]['value'] != '查看全部') {
      queryParameter['workUnit'] = dropList[1]['value'];
    }

    if (widget.arguments['title'] == '作业申请') {
      if (dropList2[0]['value'] != '') {
        queryParameter['type'] = dropList2[0]['value'] == '本人作业' ? 1 : 0;
      }
    } else {
      if (dropList2[0]['value'] != '') {
        queryParameter['startDate'] = dropList2[0]['value'].split('|')[0];
        queryParameter['endDate'] = dropList2[0]['value'].split('|')[1];
      }
    }

    if (dropList2[1]['value'] != '' && dropList2[1]['value'] != '查看全部') {
      queryParameter['territorialUnit'] = dropList2[1]['value'];
    }
    String url = Interface.workListUrl;
    if (arguments['title'] == '历史作业') {
      url = Interface.historyListUrl;
    }
    myDio
        .request(type: 'get', url: url, queryParameters: queryParameter)
        .catchError((onError) {
      Interface().error(onError, context);
    }).then((value) {
      if (value != null) {
        msgList = value['records'];
        // print(msgList[0]);

      }
      setState(() {});
    });
    return null;
  }

  _getDropList() {
    myDio.request(type: 'get', url: Interface.getDropTypeList).then((value) {
      if (value.length != 0) {
        dropList[0]['data'] = value;
        dropList[0]['data'].insert(0, {"name": "查看全部"});
      }
      setState(() {});
    }).catchError((onError) {
      Interface().error(onError, context);
    });
    myDio.request(type: 'get', url: Interface.getWorkDrop).then((value) {
      dropList[1]['data'] = value;
      dropList[1]['data'].insert(0, {"name": "查看全部"});
    }).catchError((onError) {
      Interface().error(onError, context);
    });

    myDio
        .request(type: 'get', url: Interface.dropTerritorialUnitList)
        .then((value) {
      dropList2[1]['data'] = value;
      dropList2[1]['data'].insert(0, {"name": "查看全部"});
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  _judgeButton(data) {
    if (data['operable'] == 0) {
      switch (data['executionType']) {
        case 0:
          data['buttonName'] = '作业计划';
          data['buttonColor'] = Color.fromRGBO(10, 178, 160, 1);
          break;
        case 4:
          data['buttonName'] = '作业进行';
          data['buttonColor'] = Color.fromRGBO(244, 143, 55, 1);
          break;
        default:
          data['buttonName'] = '作业申请';
          data['buttonColor'] = themeColor;
      }
      data['buttonClick'] = false;
    } else if (data['operable'] == 1) {
      switch (data['executionType']) {
        case 0:
          data['buttonName'] = '申请';
          data['buttonColor'] = Color.fromRGBO(10, 178, 160, 1);
          break;
        case 4:
          data['buttonName'] = '关闭';
          data['buttonColor'] = themeColor;
          break;
        case 1:
          data['buttonName'] = '措施确认';
          data['buttonColor'] = Color.fromRGBO(244, 143, 55, 1);
          break;
        case 2:
          data['buttonName'] = '安全交底';
          data['buttonColor'] = Color.fromRGBO(244, 143, 55, 1);
          break;
        default:
          data['buttonName'] = '审批';
          data['buttonColor'] = Color.fromRGBO(244, 143, 55, 1);
      }
      data['buttonClick'] = true;
    } else {
      data['buttonName'] = '已完成';
      data['buttonClick'] = false;
    }
    return data['buttonClick'];
  }

  assginTimeState(bool state) {
    if (state) {
      minutes = -1;
    }
    setState(() {});
  }

  _showChoose(
    context,
    width,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (contexts) => Container(
        height: width * 535,
        child: DateTimePickerWidget(
          locale: DateTimePickerLocale.zh_cn,
          dateFormat: 'yyyy-MM-dd HH:mm',
          onCancel: () {
            dropList2[0]['value'] = '';
          },
          onConfirm: (dateTime, selectedIndex) {
            dropList2[0]['value'] = dateTime.toString();
            Future.delayed(Duration(microseconds: 300), () {
              showModalBottomSheet(
                context: context,
                builder: (contexts) => Container(
                  height: width * 535,
                  child: DateTimePickerWidget(
                    locale: DateTimePickerLocale.zh_cn,
                    dateFormat: 'yyyy-MM-dd HH:mm',
                    onConfirm: (dateTime, selectedIndex) {
                      dropList2[0]['value'] =
                          dropList2[0]['value'] + '|' + dateTime.toString();
                      _getDataList();
                    },
                    onCancel: () {
                      dropList2[0]['value'] = '';
                    },
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    _context = Provider.of<Counter>(context);
    return arguments['title'] == '历史作业'
        ? MyAppbar(
            title: Text(arguments['title']),
            child: Column(
              children: <Widget>[
                TitleChoose(width, dropList, size.height, 0, _getDataList),
                TitleChoose(width, dropList2, size.height, 1, _getDataList),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyRich(msgList[index]['workName'].toString(),
                                  '作业名称'),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyRich(
                                msgList[index]['closeDate'].toString(),
                                '关闭时间',
                                maxWord: 20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyRich(msgList[index]['workUnit'].toString(),
                                  '作业单位'),
                              MyRich(msgList[index]['description'].toString(),
                                  '作业内容')
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyRich(
                                  msgList[index]['region'].toString(), '作业区域'),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromRGBO(
                                    54,
                                    121,
                                    255,
                                    1,
                                  ))),
                                  onPressed: () {
                                    print(msgList[index]['id']);
                                    Navigator.pushNamed(
                                        context, '/home/work/flow', arguments: {
                                      "id": msgList[index]['id'],
                                      "context": _context
                                    });
                                  },
                                  child: Text(
                                    // msgList[index]['buttonName'].toString(),
                                    '查看',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 24),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(width * 20),
                      padding: EdgeInsets.all(width * 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    );
                  },
                  itemCount: msgList.length,
                ))
              ],
            ),
          )
        : Column(
            children: <Widget>[
              TitleChoose(width, dropList, size.height, 0, _getDataList),
              TitleChoose(width, dropList2, size.height, 1, _getDataList),
              Expanded(
                  child: RefreshIndicator(
                      child: SingleChildScrollView(
                        child: Column(
                          children: msgList.asMap().keys.map((index) {
                            _judgeButton(msgList[index]);
                            return GestureDetector(
                              onTap: () {
                                if (!msgList[index]['buttonClick']) {
                                  String type =
                                      msgList[index]['executionType'] == 0
                                          ? '作业详情'
                                          : '审批详情';
                                  // print(object)
                                  print(msgList[index]['id']);
                                  _context.emptySignState();
                                  _context.emptySubmitDates();
                                  _context.emtpySignArrs();
                                  Navigator.pushNamed(
                                      context, '/home/work/applyDetail',
                                      arguments: {
                                        'id': msgList[index]['id'],
                                        "title": type,
                                        "contexts": _context,
                                        "execution": msgList[index]
                                            ['executionType'],
                                        'type': false
                                      });
                                }
                              },
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: width * 40),
                                          width: width * 50,
                                          height: width * 50,
                                          child: Center(
                                            child: Text(
                                              (index + 1).toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 28),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: msgList[index]
                                                  ['buttonColor']),
                                        ),
                                        SizedBox(
                                          width: width * 40,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: width * 20,
                                            ),
                                            MyRich(
                                                msgList[index]['workName']
                                                    .toString(),
                                                '作业名称'),
                                            SizedBox(
                                              height: width * 20,
                                            ),
                                            MyRich(
                                                msgList[index]
                                                        ['territorialUnit']
                                                    .toString(),
                                                '属地单位'),
                                            SizedBox(
                                              height: width * 20,
                                            ),
                                            MyRich(
                                                msgList[index]['region']
                                                    .toString(),
                                                '作业区域'),
                                            SizedBox(
                                              height: width * 20,
                                            ),
                                            Container(
                                              width: width * 300,
                                              child: MyRich(
                                                  msgList[index]['description']
                                                      .toString(),
                                                  '作业内容'),
                                            ),
                                            SizedBox(
                                              height: width * 20,
                                            ),
                                            MyRich(
                                                msgList[index]['workUnit']
                                                    .toString(),
                                                '作业单位'),
                                            SizedBox(
                                              height: width * 20,
                                            ),
                                            MyRich(
                                                msgList[index]['applicantUnit']
                                                    .toString(),
                                                '负责工位'),
                                          ],
                                        ),
                                        Spacer(),
                                        // Mycir(
                                        //   minutes: minutes,
                                        //   color: msgList[index]['buttonColor'],
                                        // ),
                                        SizedBox(
                                          width: width * 40,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: List.generate(5, (indexs) {
                                            return Container(
                                              width: width * 100,
                                              height: msgList[index]
                                                          ['executionType'] ==
                                                      indexs
                                                  ? width * 10
                                                  : width * 5,
                                              color: msgList[index]
                                                      ['buttonColor']
                                                  .withOpacity(1 - indexs / 5),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    msgList[index]['freeze'] == 0
                                        ? Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              SizedBox(
                                                width: width * 100,
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(StadiumBorder()),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(themeColor)),
                                                onPressed: () {
                                                  List<String> choose = [
                                                    '变更监护人',
                                                    '作业关闭人',
                                                    '数据录入',
                                                    '取消作业'
                                                  ];
                                                  if (msgList[index]
                                                          ['executionType'] ==
                                                      0) {
                                                    choose = ['取消作业'];
                                                  }
                                                  int seleted = -1;
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (_) =>
                                                          StatefulBuilder(
                                                              builder: (context,
                                                                  state) {
                                                            return Container(
                                                                height: size
                                                                        .width *
                                                                    500,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white),
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('取消'),
                                                                        ),
                                                                        ElevatedButton(
                                                                            style:
                                                                                ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              if (seleted > -1) {
                                                                                if (choose[seleted] == '数据录入') {
                                                                                  _context.emptySubmitDates();
                                                                                  String route = '/home/work/applyDetail', title = '数据录入';
                                                                                  if (msgList[index]['preData'] == '1') {
                                                                                    Navigator.pushNamed(context, route, arguments: {
                                                                                      "id": msgList[index]['id'],
                                                                                      "title": title,
                                                                                      "contexts": _context,
                                                                                      "execution": msgList[index]['executionType']
                                                                                    });
                                                                                  } else {
                                                                                    Navigator.pushNamed(context, '/home/work/changeGuardian', arguments: {
                                                                                      "workUnit": msgList[index]['workUnit'],
                                                                                      "id": msgList[index]['id'],
                                                                                      "type": '变更数据录入人'
                                                                                    });
                                                                                  }
                                                                                } else if (choose[seleted] == '取消作业') {
                                                                                  String route = '/home/work/apply/cancel';
                                                                                  _context.emptySubmitDates();
                                                                                  Navigator.pushNamed(context, route, arguments: {
                                                                                    "id": msgList[index]['id'],
                                                                                  });
                                                                                  // /home/work/apply/cancel
                                                                                } else {
                                                                                  Navigator.pushNamed(context, '/home/work/changeGuardian', arguments: {
                                                                                    "workUnit": msgList[index]['workUnit'],
                                                                                    "id": msgList[index]['id'],
                                                                                    "type": choose[seleted]
                                                                                  });
                                                                                }
                                                                              }
                                                                            },
                                                                            child: Text(
                                                                              '确定',
                                                                              style: TextStyle(color: themeColor),
                                                                            ))
                                                                      ],
                                                                    ),
                                                                    Expanded(
                                                                      child: ListView
                                                                          .builder(
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              seleted = index;
                                                                              state(() {});
                                                                            },
                                                                            child: Container(
                                                                                width: double.infinity,
                                                                                decoration: BoxDecoration(color: seleted == index ? themeColor : Colors.white, border: Border(bottom: BorderSide(width: 1, color: underColor.withOpacity(.2)))),
                                                                                padding: EdgeInsets.symmetric(vertical: width * 20),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    choose[index],
                                                                                    style: TextStyle(color: seleted == index ? Colors.white : Colors.black),
                                                                                  ),
                                                                                )),
                                                                          );
                                                                        },
                                                                        itemCount:
                                                                            choose.length,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ));
                                                          }));
                                                },
                                                child: Text('变更操作'),
                                              ),
                                              Spacer(),
                                              msgList[index]['buttonClick']
                                                  ? ElevatedButton(
                                                      style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all(StadiumBorder(
                                                                  side: BorderSide(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .transparent))),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(msgList[
                                                                          index]
                                                                      [
                                                                      'buttonColor'])),
                                                      onPressed: () {
                                                        _context
                                                            .emptySubmitDates();
                                                        String route =
                                                                '/home/work/applyDetail',
                                                            title = '作业申请';
                                                        if (msgList[index][
                                                                'buttonName'] !=
                                                            '申请') {
                                                          title = '作业许可证';
                                                        }
                                                        print("_apply");
                                                        print(msgList[index]
                                                            ['id']);
                                                        // print(msgList[index]);
                                                        _context
                                                            .emptySignState();
                                                        _context
                                                            .emptySubmitDates();
                                                        _context
                                                            .emtpySignArrs();
                                                        Navigator.pushNamed(
                                                            context, route,
                                                            arguments: {
                                                              "id":
                                                                  msgList[index]
                                                                      ['id'],
                                                              "title": title,
                                                              "contexts":
                                                                  _context,
                                                              "execution": msgList[
                                                                      index][
                                                                  'executionType']
                                                            });
                                                      },
                                                      child: Text(
                                                        msgList[index]
                                                                ['buttonName']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 24),
                                                      ),
                                                    )
                                                  : Container(
                                                      child: Text(
                                                        msgList[index][
                                                                    'buttonName']
                                                                .toString() +
                                                            '中',
                                                        style: TextStyle(
                                                          color: msgList[index]
                                                              ['buttonColor'],
                                                        ),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          right: width * 30),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  width * 15),
                                                    ),
                                              SizedBox(
                                                width: width * 100,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(StadiumBorder(
                                                            side: BorderSide(
                                                                width: 1,
                                                                color: Colors
                                                                    .transparent))),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(msgList[index][
                                                                'buttonColor'])),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) => MyDialog(
                                                            title: '',
                                                            content:
                                                                '确认撤销作业取消申请？',
                                                            okCallBack: () {
                                                              myDio
                                                                  .request(
                                                                type: 'delete',
                                                                url: Interface
                                                                        .deleteCancelWorkApply +
                                                                    msgList[index]
                                                                            [
                                                                            'id']
                                                                        .toString(),
                                                              )
                                                                  .then(
                                                                      (value) {
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            '撤销成功');
                                                                _getDropList();
                                                                _getDataList();
                                                                // Navigator.pop(
                                                                //     context);
                                                              }).catchError(
                                                                      (onError) {
                                                                Interface()
                                                                    .error(
                                                                        onError,
                                                                        context);
                                                              });
                                                            },
                                                            rightText: '确定',
                                                            leftText: '取消',
                                                          ));
                                                },
                                                child: Text(
                                                  '撤销作业取消申请',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width * 24),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 100,
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.all(width * 20),
                                // padding: EdgeInsets.all(width * 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      onRefresh: _getDataList)),
            ],
          );
  }

  Widget titleChoose(double width, List list) {
    return Row(
      children: list.asMap().keys.map((e) {
        // print(dropList[e]);
        if (list[e]['title'] == '计划时间') {
          return Expanded(
              child: GestureDetector(
            onTap: () {
              _showChoose(context, width);
            },
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                            width: 2, color: underColor.withOpacity(.2)))),
                height: width * 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: width * 30,
                    ),
                    Expanded(
                      child: Center(
                        child: Text('计划时间',
                            style: TextStyle(
                                fontSize: width * 30, color: placeHolder)),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: placeHolder,
                    ),
                  ],
                )),
          ));
        }

        return Expanded(
            child: Center(
          child: Container(
              padding: EdgeInsets.only(left: width * 30),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          width: 2, color: underColor.withOpacity(.2)))),
              child: DropdownButton(
                  isExpanded: true,
                  itemHeight: width * 100,
                  icon: Icon(Icons.arrow_drop_down),
                  underline: Container(
                    height: 0,
                  ),
                  hint: Center(
                    child: Text(
                      list[e]['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: width * 30),
                    ),
                  ),
                  value: list[e]['value'] == '' ? null : list[e]['value'],
                  items: list[e]['data'].map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value['name'],
                      child: Center(
                        child: Text(
                          value['name'].toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    list[e]['value'] = value;
                    _getDataList();

                    setState(() {});
                  })),
        ));
      }).toList(),
    );
  }
}

class MyRich extends StatelessWidget {
  MyRich(this.data, this.title, {this.maxWord = 8});
  final data, title;
  final int maxWord;
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: title + ': ',
          style: TextStyle(color: Colors.black.withOpacity(.3))),
      TextSpan(
        text: data.toString().length > maxWord
            ? data.toString().substring(0, maxWord) + '...'
            : data.toString(),
        style: TextStyle(
          color: Colors.black.withOpacity(.6),
        ),
      )
    ]));
  }
}

class TitleChoose extends StatefulWidget {
  TitleChoose(this.width, this.list, this.height, this.index, this.getDataList);
  final double width, height;
  final int index;
  final List list;
  final Function getDataList;
  @override
  _TitleChooseState createState() => _TitleChooseState();
}

class _TitleChooseState extends State<TitleChoose> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.list.asMap().keys.map((i) {
      return Expanded(
          child: GestureDetector(
        onTap: () {
          double showHeight = widget.height -
              (context.size.height * (widget.index + 1) + size.width * 145);

          if (widget.list[i]['title'] == '计划时间') {
            showModalBottomSheet(
              context: context,
              builder: (contexts) => Container(
                height: widget.width * 535,
                child: DateTimePickerWidget(
                  locale: DateTimePickerLocale.zh_cn,
                  dateFormat: 'yyyy-MM-dd HH:mm',
                  onCancel: () {
                    widget.list[i]['value'] = '';
                  },
                  onConfirm: (dateTime, selectedIndex) {
                    widget.list[i]['value'] = dateTime.toString();
                    Future.delayed(Duration(microseconds: 300), () {
                      showModalBottomSheet(
                        context: context,
                        builder: (contexts) => Container(
                          height: widget.width * 535,
                          child: DateTimePickerWidget(
                            locale: DateTimePickerLocale.zh_cn,
                            dateFormat: 'yyyy-MM-dd HH:mm',
                            onConfirm: (dateTime, selectedIndex) {
                              widget.list[i]['value'] = widget.list[i]
                                      ['value'] +
                                  '|' +
                                  dateTime.toString();
                              widget.getDataList();
                            },
                            onCancel: () {
                              widget.list[i]['value'] = '';
                            },
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            );
          } else {
            showBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    height: showHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.only(bottom: showHeight / 2),
                          constraints: BoxConstraints(
                            maxHeight: showHeight / 2,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  widget.list[i]['data'].map<Widget>((_ele) {
                                Color _juegeColor() {
                                  Color _color = widget.list[i]['value'] ==
                                              '' &&
                                          _ele['name'] == '查看全部'
                                      ? themeColor
                                      : widget.list[i]['value'] == _ele['name']
                                          ? themeColor
                                          : Colors.white;
                                  return _color;
                                }

                                Color _conColors = _juegeColor();
                                return GestureDetector(
                                  onTap: () {
                                    widget.list[i]['value'] = _ele['name'];
                                    if (_ele['name'] == '查看全部') {
                                      widget.list[i]['title'] =
                                          widget.list[i]['saveTitle'];
                                    } else {
                                      widget.list[i]['title'] = _ele['name'];
                                    }
                                    setState(() {});
                                    widget.getDataList();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: widget.width * 32),
                                    decoration: BoxDecoration(
                                        color: _conColors,
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: underColor))),
                                    child: Center(
                                      child: Text(
                                        _ele['name'],
                                        // _conColors.toString(),
                                        style: TextStyle(
                                            fontSize: widget.width * 30,
                                            color: _conColors.toString() ==
                                                    'Color(0xff6ea3f9)'
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Expanded(child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ))
                      ],
                    ),
                  );
                });
          }
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1, color: underColor.withOpacity(.2)),
                  right:
                      BorderSide(width: 1, color: underColor.withOpacity(.2)),
                )),
            padding: EdgeInsets.symmetric(vertical: widget.width * 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.list[i]['title'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: widget.width * 30),
                ),
                Icon(Icons.keyboard_arrow_right)
              ],
            )),
      ));
    }).toList());
  }
}
