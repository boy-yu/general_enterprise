import 'dart:convert';

import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myInput.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

const PI = 3.1415926;

class CancelWorkApply extends StatefulWidget {
  CancelWorkApply({this.arguments});

  final arguments;
  // message Map  All data
  @override
  _CancelWorkApplyState createState() => _CancelWorkApplyState();
}

class _CancelWorkApplyState extends State<CancelWorkApply> {
  List data = [];
  List tempData = [
    {'title': '作业名称', 'type': 'text', 'interfaceName': 'workName', "value": ''},
    {
      'title': '属地单位',
      'type': 'text',
      'interfaceName': 'territorialUnit',
      "value": ''
    },
    {'title': '作业区域', 'type': 'text', 'interfaceName': 'region', "value": ''},
    {
      'title': '申请人名字',
      'type': 'text',
      'interfaceName': 'applicantName',
      "value": ''
    },
    {
      'title': '申请原因',
      'type': 'text',
      'interfaceName': 'applicantReason',
      "value": ''
    },
    {
      'title': '确认取消作业原因(可空)',
      'type': 'texts',
      'interfaceName': 'applicantReason',
      "value": ''
    },
    {
      'title': '申请取消作业人签字',
      'type': 'sign',
      'interfaceName': 'confirmedSignature',
      "value": ''
    },
  ];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    Map special = jsonDecode(jsonEncode(widget.arguments['message']));
    special.forEach((key, value) {
      for (var i = 0; i < tempData.length; i++) {
        if (tempData[i]['interfaceName'] == key) {
          tempData[i]['value'] = value;
        }
      }
    });
    print(widget.arguments['message']);
    setState(() {});
  }

  _sumbit(Counter _context, int state) {
    bool next = false;
    String value = '';
    String reason = '';
    if (_context.submitDates['取消作业'] == null) {
      Fluttertoast.showToast(msg: '请确认签字');
    }
    _context.submitDates['取消作业'].forEach((ele) {
      if (ele['title'] == '签字' && ele['value'] != '') {
        value = ele['value'];
        next = true;
      } else if (ele['title'] == '确认取消作业原因(可空)') {
        reason = ele['value'];
      }
    });
    if (value == '') {
      Fluttertoast.showToast(msg: '请确认签字');
    }
    if (next) {
      myDio.request(
          type: 'put',
          url: Interface.putConfirmationWork +
              widget.arguments['message']['id'].toString(),
          queryParameters: {
            'dismissed': state,
            'confirmedSignature': value,
            'confirmedMemo': reason,
          }).then((value) {
        Fluttertoast.showToast(msg: '成功');
        _context.emptySubmitDates();
        Navigator.pop(context);
      }).catchError((onError) {
        Interface().error(onError, context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    Counter _context = Provider.of<Counter>(context);
    return MyAppbar(
      child: Stack(
        children: [
          Container(
            height: width * 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffA8CCFD), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            margin: EdgeInsets.only(
                left: width * 20, right: width * 20, top: width * 20),
          ),
          Container(
            decoration: BoxDecoration(),
            margin: EdgeInsets.only(
                left: width * 20, right: width * 20, top: width * 60),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    Widget _widget;
                    switch (tempData[index]['type']) {
                      case 'text':
                        _widget = Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 30),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xffEDEDED)))),
                            padding: EdgeInsets.symmetric(vertical: width * 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(tempData[index]['title'] + ":",
                                    style: TextStyle(color: themeColor)),
                                Text(tempData[index]['value'].toString())
                              ],
                            ),
                          ),
                        );
                        break;
                      case 'texts':
                        _widget = Container(
                          child: MyInput(
                            title: tempData[index]['title'],
                            line: 3,
                            purview: '取消作业',
                          ),
                          color: Colors.white,
                        );
                        // _widget = Container(
                        //   decoration: BoxDecoration(color: Colors.white),
                        //   padding: EdgeInsets.symmetric(
                        //       vertical: width * 40, horizontal: width * 30),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         tempData[index]['title'],
                        //         style: TextStyle(color: themeColor),
                        //       ),
                        //       Text(
                        //         tempData[index]['value'],
                        //         maxLines: 3,
                        //         style: TextStyle(color: placeHolder),
                        //       ),
                        //     ],
                        //   ),
                        // );
                        break;
                      case 'sign':
                        _widget = Container(
                          padding: EdgeInsets.symmetric(
                              vertical: width * 40, horizontal: width * 30),
                          decoration: BoxDecoration(color: Colors.white),
                          child: CancelSign(),
                        );
                        break;
                      default:
                    }
                    return _widget;
                  },
                  itemCount: tempData.length,
                )),
                SizedBox(
                  height: width * 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(StadiumBorder()),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(218, 229, 251, 1))),
                      onPressed: () {
                        _sumbit(_context, 2);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 80, vertical: width * 20),
                        child: Text(
                          '驳回',
                          style: TextStyle(color: themeColor),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(StadiumBorder()),
                          backgroundColor:
                              MaterialStateProperty.all(themeColor)),
                      onPressed: () {
                        _sumbit(_context, 1);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 80, vertical: width * 20),
                        child: Text('确定', style: TextStyle(color: themeColor)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: width * 40,
                )
              ],
            ),
          ),
          Positioned(
            child: CustomPaint(
              painter: MyClippers(startAngle: -1.5 * PI, sweepAngle: 1 * PI),
            ),
            left: width * 12,
            top: width * 20,
          ),
          Positioned(
            child: CustomPaint(
              painter: MyClippers(startAngle: 1.5 * PI, sweepAngle: 1 * PI),
            ),
            right: width * 28,
            top: width * 20,
          )
        ],
      ),
      title: Text('取消作业审批'),
    );
  }
}

class MyClippers extends CustomPainter {
  MyClippers({this.startAngle, this.sweepAngle});

  final startAngle, sweepAngle;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromLTWH(0.0, 0.0, 10.0, 10.0),
        startAngle,
        sweepAngle,
        true,
        Paint()
          ..color = themeColor
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CancelSign extends StatefulWidget {
  @override
  _CancelSignState createState() => _CancelSignState();
}

class _CancelSignState extends State<CancelSign> {
  generateImg(Counter contexts) {
    Widget _widget;
    _widget = Container();
    if (contexts.submitDates['取消作业'] != null) {
      if (contexts.submitDates['取消作业'].toString().indexOf('http') > -1) {
        String url = '';
        contexts.submitDates['取消作业']?.forEach((ele) {
          if (ele['title'] == '签字') {
            url = ele['value'];
          }
        });
        _widget = Image.network(url);
      }
    }

    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    Counter contexts = Provider.of<Counter>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Text(
              '签字',
              style: TextStyle(fontSize: width * 30, color: themeColor),
            )),
            Text(
              DateTime.now()
                  .toString()
                  .substring(0, DateTime.now().toString().length - 10),
              style: TextStyle(fontSize: width * 24),
            ),
          ],
        ),
        Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign',
                    arguments: {"purview": "取消作业", 'title': "签字"});
              },
              child: Container(
                margin: EdgeInsets.only(top: width * 20),
                constraints: BoxConstraints(minHeight: width * 160),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: underColor)),
                width: double.infinity,
                child: generateImg(contexts),
              ),
            ),
            Positioned(
              child: Icon(
                Icons.create,
                color: placeHolder,
                size: width * 30,
              ),
              bottom: 20,
              right: 20,
            ),
          ],
        ),
      ],
    );
  }
}
