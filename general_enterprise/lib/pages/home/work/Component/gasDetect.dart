import 'dart:convert';
import 'package:enterprise/common/MychooseTime.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myText.dart';
import 'package:enterprise/pages/home/workBak/__cancelWork.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class GasDetect extends StatefulWidget {
  GasDetect(
      {@required this.title,
      this.detectionSite,
      @required this.id,
      @required this.type});
  final String title;
  final List detectionSite;
  final int id, type;
  @override
  _GasDetectState createState() => _GasDetectState();
}

class _GasDetectState extends State<GasDetect> {
  List<List> data = [];

  List<Map> ui = [
    {"title": '检测点位', "type": 'text', "value": 'ABC'},
    {
      "title": '请选择时间',
      "type": 'chooseTime',
      "value": '',
      "bindContent": "detectionDate"
    },
    {
      "title": '可燃气体含量%',
      "type": 'input',
      "value": '',
      "bindContent": "combustibleContent"
    },
    {
      "title": '取样部位',
      "type": 'input',
      "value": '',
      "bindContent": "detectionSite"
    },
    {
      "title": '氧气测试含量%',
      "type": 'input',
      "value": '',
      "bindContent": "oxygenContent"
    },
    {
      "title": '有毒气体含量%',
      "type": 'input',
      "value": '',
      "bindContent": "poisonContent"
    }
  ];
  Counter _counter = Provider.of<Counter>(myContext);
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    for (var i = 0; i < widget.detectionSite.length; i++) {
      data.add(jsonDecode(jsonEncode(ui)));
      data[i][0]['value'] = widget.detectionSite[i];
    }
  }

  _sumbit() {
    bool isSign = false;
    String signUrl = '';
    if (_counter.submitDates['清单作业'] is List) {
      _counter.submitDates['清单作业'].forEach((ele) {
        if (ele['title'] == widget.title.toString()) {
          signUrl = ele['value'];
          isSign = true;
        }
      });
    }

    if (isSign) {
      List<Map> workGasDetectionBookVo = [];
      bool sumbit = true;
      for (var i = 0; i < data.length; i++) {
        workGasDetectionBookVo.add({});
        for (var _i = 0; _i < data[i].length; _i++) {
          if (data[i][_i]['value'] == '') {
            Fluttertoast.showToast(
                msg: '"${data[i][_i]['title']}"' + ' 为空',
                gravity: ToastGravity.CENTER,
                backgroundColor: themeColor,
                textColor: Colors.white);
            sumbit = false;
            return;
          }
          if (data[i][_i]['bindContent'] != null) {
            workGasDetectionBookVo[i][data[i][_i]['bindContent']] =
                data[i][_i]['value'];
          }
        }
      }

      if (sumbit) {
        myDio.request(type: 'post', url: Interface.postAddWorkGas, data: {
          "id": widget.id,
          "type": widget.type,
          "inspectorSign": signUrl,
          "workGasDetectionBookVo": workGasDetectionBookVo
        }).then((value) {
          Navigator.pop(context);
        });
      }
    } else {
      Fluttertoast.showToast(
          msg: "该选项，需要您的签字",
          gravity: ToastGravity.CENTER,
          backgroundColor: themeColor,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(widget.title.toString()),
        child: Container(
            padding: EdgeInsets.all(size.width * 40),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: data.map((ele) {
                      return Column(
                        children: ele.map((_ele) {
                          Widget _widget;

                          switch (_ele['type']) {
                            case 'text':
                              _widget = MyText(
                                title: _ele['title'],
                                value: _ele['value'],
                              );
                              break;
                            case 'chooseTime':
                              _widget = MychooseTime(
                                title: _ele['title'],
                                value: _ele['value'],
                                callback: (msg) {
                                  _ele['value'] = msg;
                                },
                              );
                              break;
                            case 'input':
                              _widget = Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _ele['title'],
                                    style: TextStyle(
                                      fontSize: size.width * 26,
                                    ),
                                  ),
                                  Container(
                                    decoration:
                                        BoxDecoration(color: Color(0xffEEEEEE)),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: size.width * 30),
                                        border: InputBorder.none,
                                        hintText: _ele['value'],
                                        fillColor: Color(0xffEEEEEE),
                                      ),
                                      onChanged: (value) {
                                        _ele['value'] = value;
                                      },
                                    ),
                                  )
                                ],
                              );
                              break;
                            default:
                              _widget = Text(_ele['title'].toString() + '暂未开发');
                          }
                          return _widget;
                        }).toList(),
                      );
                    }).toList(),
                  ),
                )),
                Container(
                  margin: EdgeInsets.all(size.width * 20),
                  child: CancelSign(
                    purview: '清单作业',
                    title: widget.title.toString(),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(themeColor)),
                  onPressed: _sumbit,
                  child: Text('确定'),
                )
              ],
            )));
  }
}
