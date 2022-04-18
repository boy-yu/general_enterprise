import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  Map data = {};

  List<PieSturct> fireMapResiduePie = [];

  List<MutipleXAxisSturct> mutipleBar = [];
  double yxais = 0.0;
  @override
  void initState() {
    super.initState();
    _getData();
    _getEquiment();
    _getEquimentBar();
  }

  _getData() {
    _funTime(Map element) {
      // if (name == '早班') {
      //   return '8:00-12:00';
      // } else if (name == '中班') {
      //   return '12:00-18:00';
      // } else {
      //   return '18:00-22:00';
      // }
      if (element['startDate'] == null || element['endDate'] == null) return '';
      return element['startDate'].toString().split(' ')[1].substring(0, 5) +
          ' - ' +
          element['endDate'].toString().split(' ')[1].substring(0, 5);
    }

    data = {};
    myDio.request(type: 'get', url: Interface.getCurrenOnDuty).then((value) {
      data['message'] = [];
      if (value is Map) {
        data['name'] = value['shiftName'];
        data['time'] = _funTime(value);
        List _split = value['information'].toString().split(',');
        for (var i = 0; i < _split.length; i++) {
          data['message'].add({"firstLine": '', 'phone': ''});
          List __split = _split[i].toString().split('|');
          for (var _i = 0; _i < __split.length; _i++) {
            if (_i < 2) {
              data['message'][i]['firstLine'] += __split[_i];
            } else if (_i == 2) {
              data['message'][i]['phone'] = __split[_i];
            } else if (_i == 2) {
              data['message'][i]['state'] = __split[_i];
            }
          }
        }

        setState(() {});
      }
    });
  }


  String fireMapResiduePieTotal = '';
  _getEquiment() {
    myDio.request(type: 'get', url: Interface.getFireStatistics).then((value) {
      if (value is Map) {   
        fireMapResiduePie.clear();
        fireMapResiduePie.add(PieSturct(
            color: Color(0xff3CE49C),
            nums: value['controlledNum'] * 1.0,
            title: '受控'));
        fireMapResiduePie.add(PieSturct(
            color: Color(0xffFDCB60),
            nums: value['uncontrolledNum'] * 1.0,
            title: '不受控'));
        fireMapResiduePieTotal = (value['controlledNum'] + value['uncontrolledNum']).toString();
        setState(() {});
      }
    });
  }

  _getEquimentBar() {
    myDio
        .request(type: 'get', url: Interface.getFireStatisticsRisk)
        .then((value) {
      if (value is Map) {
        double _double = 0.0;
        value.forEach((key, value) {
          mutipleBar.add(MutipleXAxisSturct(names: key, color: [], nums: []));
          if (value is List) {
            value.forEach((element) {
              if (element['num'] > _double) {
                _double = element['num'] + 20.0;
              }

              mutipleBar[mutipleBar.length - 1].nums.add(element['num'] * 1.0);
              if (element['fireType'] == '个体防护') {
                mutipleBar[mutipleBar.length - 1].color.add(Color(0xff3AA3FF));
              } else if (element['fireType'] == '消防器材') {
                mutipleBar[mutipleBar.length - 1].color.add(Color(0xff10D1FF));
              } else {
                mutipleBar[mutipleBar.length - 1].color.add(Color(0xff6C73FF));
              }
            });
          }
        });
        yxais = _double;
        setState(() {});
      }
    });
  }

  Widget commonMark({Color color, String text}) {
    return Row(
      children: [
        Container(
          width: size.width * 13,
          height: size.width * 13,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          margin: EdgeInsets.only(right: size.width * 10),
        ),
        Text(
          text,
          style: TextStyle(color: Color(0xff616B7B), fontSize: size.width * 16),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(size.width * 20),
      child: Column(
        children: [
          data.isNotEmpty
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 30, vertical: size.width * 20),
                  color: Color(0xff6C9CFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '当前值守',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['name'] != null && data['time'] != null
                            ? data['name'].toString() +
                                '   (' +
                                data['time'].toString() +
                                ')'
                            : '',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 24),
                      ),
                      Column(
                        children: data['message'].map<Widget>((ele) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width * 10,
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomPaint(
                                        painter: CustomPainterRadio(),
                                        child: Text('值班人: ',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      Expanded(
                                          child: Text(
                                        ele['firstLine'].toString(),
                                        style: TextStyle(color: Colors.white),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('联系电话: ',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Expanded(
                                          child: Text(
                                        ele['phone'].toString(),
                                        style: TextStyle(color: Colors.white),
                                      ))
                                    ],
                                  )
                                ],
                              ))
                            ],
                          );
                        }).toList(),
                      )
                    ],
                  ),
                )
              : Container(),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: size.width * 20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      offset: Offset(0, 1),
                      blurRadius: 3)
                ],
                borderRadius: BorderRadius.circular(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: size.width * 20, top: size.width * 20),
                  child: Text(
                    '消防设备设施状态统计',
                    style: TextStyle(
                        color: Color(0xff125FFF),
                        fontSize: size.width * 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CustomEchart().pie(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '受控状态',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                fireMapResiduePieTotal,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 26,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          width: 90,
                          radius: 35,
                          strokeWidth: 8,
                          state: false,
                          data: fireMapResiduePie
                        ),
                        Row(
                          children: [
                            Container(
                              height: size.width * 13,
                              width: size.width * 13,
                              color: Color(0xff3CE49C),
                            ),
                            SizedBox(
                              width: size.width * 10,
                            ),
                            Text(
                              '受控',
                              style: TextStyle(
                                fontSize: size.width * 16,
                                color: Color(0xff666666)
                              ),
                            ),
                            SizedBox(
                              width: size.width * 50,
                            ),
                            Container(
                              height: size.width * 13,
                              width: size.width * 13,
                              color: Color(0xffFDCB60),
                            ),
                            SizedBox(
                              width: size.width * 10,
                            ),
                            Text(
                              '不受控',
                              style: TextStyle(
                                fontSize: size.width * 16,
                                color: Color(0xff666666)
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 20,
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: size.width * 20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      offset: Offset(0, 1),
                      blurRadius: 3)
                ],
                borderRadius: BorderRadius.circular(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: size.width * 20, top: size.width * 20),
                  child: Text(
                    '消防设备设施数量统计',
                    style: TextStyle(
                        color: Color(0xff125FFF),
                        fontSize: size.width * 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Spacer(),
                    commonMark(color: Color(0xff10D1FF), text: '消防器材'),
                    SizedBox(width: size.width * 30),
                    commonMark(color: Color(0xff3AA3FF), text: '个体防护'),
                    SizedBox(width: size.width * 30),
                    commonMark(color: Color(0xff6C73FF), text: '防雷防静电'),
                    SizedBox(width: size.width * 30),
                  ],
                ),
                CustomEchart()
                    .mutipleBar(yWidth: 10, yAxis: yxais, xAxisList: mutipleBar)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomPainterRadio extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.white
    ..strokeWidth = 1
    ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    Offset _offset = Offset(-5, 10);
    canvas.drawCircle(_offset, 2, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
