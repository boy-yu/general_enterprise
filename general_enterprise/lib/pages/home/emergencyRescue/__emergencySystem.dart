import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencySystem extends StatefulWidget {
  @override
  _EmergencySystemState createState() => _EmergencySystemState();
}

class _EmergencySystemState extends State<EmergencySystem> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    data = [];
    myDio.request(type: 'get', url: Interface.getCurrenOnDuty).then((value) {
      if (value is Map) {
        List _split = value['information'].toString().split(',');
        for (var i = 0; i < _split.length; i++) {
          data.add({"firstLine": '', 'phone': '', 'state': 0});
          List __split = _split[i].toString().split('|');
          for (var _i = 0; _i < __split.length; _i++) {
            if (_i < 2) {
              data[i]['firstLine'] += __split[_i];
            } else if (_i == 2) {
              data[i]['phone'] = __split[_i];
            } else if (_i == 3) {
              data[i]['state'] = __split[_i];
            }
          }
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomClipperOval(),
          child: Container(
            height: size.width * 360,
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: lineGradBlue)),
          ),
        ),
        Positioned(
          left: 5,
          top: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '当前值班人员:',
                style: TextStyle(color: Colors.white),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: size.width * 140,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    padding: EdgeInsets.only(right: size.width * 110),
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(right: size.width * 10),
                          child: Row(
                            children: [
                              Container(
                                  width: size.width * 15,
                                  height: size.width * 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xffEB6100),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(14),
                                          bottomLeft: Radius.circular(14)))),
                              Container(
                                height: size.width * 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(14),
                                      bottomRight: Radius.circular(14),
                                    )),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: size.width * 300,
                                        child: Text(data[index]['firstLine'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: size.width * 20))),
                                    SizedBox(height: size.width * 10),
                                    Row(
                                      children: [
                                        Text(data[index]['phone'],
                                            style: TextStyle(
                                                fontSize: size.width * 20)),
                                        SizedBox(width: size.width * 120),
                                        Text(
                                            data[index]['state'] == '1'
                                                ? '在岗'
                                                : '不在岗',
                                            style: TextStyle(
                                                fontSize: size.width * 20,
                                                color: themeColor))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
              ),
              DateDuty(),
            ],
          ),
        ),
        // Positioned(
        //     right: 0,
        //     bottom: 220,
        //     child: InkWell(
        //       onTap: () async {
        //         await WorkDialog.myDialog(context, () {}, 2,
        //             widget: Padding(
        //               padding:
        //                   EdgeInsets.symmetric(horizontal: size.width * 41),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     '值班日志',
        //                     style: TextStyle(
        //                         color: Color(0xff3574FA),
        //                         fontWeight: FontWeight.bold),
        //                   ),
        //                   Column(
        //                     children: [
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: dutyData
        //                             .map((e) => Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       e['title'] + ' :',
        //                                       style: TextStyle(
        //                                           color: Color(0xff666666)),
        //                                     ),
        //                                     Container(
        //                                       margin: EdgeInsets.symmetric(
        //                                           vertical: size.width * 10),
        //                                       decoration: BoxDecoration(
        //                                         borderRadius:
        //                                             BorderRadius.circular(5),
        //                                         color: Color(0xffF0F5FF),
        //                                       ),
        //                                       child: TextField(
        //                                         onChanged: (str) {
        //                                           e['control'] = str;
        //                                         },
        //                                         maxLines: 5,
        //                                         minLines: 3,
        //                                         style: TextStyle(
        //                                             fontSize: size.width * 24),
        //                                         decoration: InputDecoration(
        //                                             border: InputBorder.none,
        //                                             hintText: '请输入描述',
        //                                             contentPadding:
        //                                                 EdgeInsets.all(
        //                                                     size.width * 20)),
        //                                       ),
        //                                     )
        //                                   ],
        //                                 ))
        //                             .toList(),
        //                       )
        //                     ],
        //                   ),
        //                   Container(
        //                     alignment: Alignment.center,
        //                     margin:
        //                         EdgeInsets.symmetric(vertical: size.width * 20),
        //                     child: InkWell(
        //                       onTap: () {
        //                         print(dutyData);
        //                         // print(dutyData[1]['control']);
        //                         // print(dutyData[2]['control']);
        //                       },
        //                       child: Container(
        //                         width: MediaQuery.of(context).size.width - 150,
        //                         padding: EdgeInsets.symmetric(
        //                             vertical: size.width * 15),
        //                         decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(38),
        //                             gradient: LinearGradient(
        //                                 colors: [
        //                                   Color(0xff3174FF),
        //                                   Color(0xff1C3AEA)
        //                                 ],
        //                                 begin: Alignment.centerLeft,
        //                                 end: Alignment.centerRight)),
        //                         child: Center(
        //                           child: Text(
        //                             '确定',
        //                             style: TextStyle(
        //                                 color: Colors.white,
        //                                 fontSize: size.width * 36),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             ));
        //       },
        //       child: Container(
        //         height: size.width * 70,
        //         width: size.width * 151,
        //         // padding: EdgeInsets.only(
        //         //     top: size.width * 20,
        //         //     bottom: size.width * 20,
        //         //     left: size.width * 22),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.only(
        //               bottomLeft: Radius.circular(35),
        //               topLeft: Radius.circular(35)),
        //           color: Color(0xff3264F6),
        //         ),
        //         alignment: Alignment.centerRight,
        //         child: Text(
        //           '值班日志',
        //           style:
        //               TextStyle(color: Colors.white, fontSize: size.width * 28),
        //         ),
        //       ),
        //     ))
      ],
    );
  }
}

class DateDuty extends StatefulWidget {
  @override
  _DateDutyState createState() => _DateDutyState();
}

class _DateDutyState extends State<DateDuty> {
  List<String> day = ['日', '一', '二', '三', '四', '五', '六'];
  List<int> dayHasday = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  List<String> dateDay = [];
  DateTime _dateTime;
  int chooseYear = 0;
  int chooseMonth = 0;
  int currenDay = 0;
  int normal = 25;
  int abnormal = 13;
  int roster = 22;
  List dutyList = [
    {
      "title": '早班',
      "time": '8:00-12:00',
      'firstLine': '赵伟（xx部门xx职务）',
      'phone': '15625426351'
    },
    {
      "title": '下午班',
      "time": '12:00-18:00',
      'firstLine': '赵伟（xx部门xx职务）',
      'phone': '15625426351'
    },
    {
      "title": '晚班',
      "time": '18:00-22:00',
      'firstLine': '赵伟（xx部门xx职务）',
      'phone': '15625426351'
    },
  ];

  _getData() {
    _funTime(element) {
      // if (element['shiftName'] == '早班') {
      //   return element['startDate'].toString().split(' ')[1].substring(0, 5) +
      //       ' - ' +
      //       element['endDate'].toString().split(' ')[1].substring(0, 5);
      // } else if (element['shiftName'] == '下午班') {
      //   return '12:00-18:00';
      // } else {
      //   return '18:00-22:00';
      // }
      if (element['startDate'] == null || element['endDate'] == null) return '';
      return element['startDate'].toString().split(' ')[1].substring(0, 5) +
          ' - ' +
          element['endDate'].toString().split(' ')[1].substring(0, 5);
    }

    dutyList = [];
    myDio.request(type: 'get', url: Interface.getEronDuty, queryParameters: {
      "time": '$chooseYear-$chooseMonth-$currenDay'
    }).then((value) {
      if (value is List) {
        for (var j = 0; j < value.length; j++) {
          dutyList.add({
            "firstLine": '',
            'phone': '',
            'title': value[j]['shiftName'],
            'time': _funTime(value[j]),
            'id': value[j]['id'],
            'dutyReport': value[j]['dutyReport']
          });
          if (value[j]['information'] != null) {
            List _split = value[j]['information'].toString().split(',');
            for (var i = 0; i < _split.length; i++) {
              List __split = _split[i].toString().split('|');
              for (var _i = 0; _i < __split.length; _i++) {
                if (_i < 2) {
                  dutyList[j]['firstLine'] += __split[_i];
                } else if (_i == 2) {
                  dutyList[j]['phone'] = __split[_i];
                } else if (_i == 3) {
                  dutyList[j]['state'] = __split[_i];
                }
              }
            }
            setState(() {});
          }
        }
      }
    });
  }

  _initData() {
    _dateTime = DateTime(chooseYear, chooseMonth);
    dateDay = [];
    if (chooseMonth != DateTime.now().month) {
      currenDay = -1;
    } else {
      // currenDay = DateTime.now().toLocal().day;
    }
    int _worship = DateTime(_dateTime.year, _dateTime.month, 1).weekday;
    if (_worship != 7) {
      for (var i = 0; i < _worship; i++) {
        dateDay.add('');
      }
    }

    for (var i = 0; i < dayHasday[_dateTime.month - 1]; i++) {
      dateDay
          .add(((i + 1) < 10 ? '0' + (i + 1).toString() : (i + 1)).toString());
    }
  }

  @override
  void initState() {
    super.initState();
    chooseYear = DateTime.now().year;
    chooseMonth = DateTime.now().month;
    currenDay = DateTime.now().toLocal().day;
    _initData();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - size.width * 150,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: Offset(-2, 5),
                    blurRadius: 5)
              ], color: Colors.white, borderRadius: BorderRadius.circular(9)),
              margin: EdgeInsets.all(size.width * 10),
              padding: EdgeInsets.all(size.width * 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   '值班电话：12345988752',
                  //   style: TextStyle(fontSize: size.width * 20),
                  // ),
                  Padding(
                      padding: EdgeInsets.all(size.width * 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (chooseMonth <= 1) {
                                    chooseMonth = 12;
                                    chooseYear--;
                                    currenDay = -1;
                                    // if (chooseYear == DateTime.now().year &&
                                    //     chooseMonth == DateTime.now().month) {
                                    //   currenDay = currenDay =
                                    //       DateTime.now().toLocal().day;
                                    // }
                                    _initData();
                                  } else {
                                    chooseMonth--;
                                    currenDay = -1;
                                    // if (chooseYear == DateTime.now().year &&
                                    //     chooseMonth == DateTime.now().month) {
                                    //   currenDay = currenDay =
                                    //       DateTime.now().toLocal().day;
                                    // }
                                    _initData();
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: themeColor, shape: BoxShape.circle),
                                child: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(chooseYear.toString() +
                                '年' +
                                chooseMonth.toString() +
                                '月'),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (chooseMonth >= 12) {
                                    chooseMonth = 1;
                                    chooseYear++;
                                    currenDay = -1;
                                    // if (chooseYear == DateTime.now().year &&
                                    //     chooseMonth == DateTime.now().month) {
                                    //   currenDay = currenDay =
                                    //       DateTime.now().toLocal().day;
                                    // }
                                    _initData();
                                  } else {
                                    chooseMonth++;
                                    currenDay = -1;
                                    // if (chooseYear == DateTime.now().year &&
                                    //     chooseMonth == DateTime.now().month) {
                                    //   currenDay = currenDay =
                                    //       DateTime.now().toLocal().day;
                                    // }
                                    _initData();
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: themeColor, shape: BoxShape.circle),
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ])),
                  Wrap(
                    children: day
                        .map((e) => Container(
                              width: (MediaQuery.of(context).size.width -
                                      size.width * 205) /
                                  7,
                              child: Center(
                                child: Text(e),
                              ),
                            ))
                        .toList(),
                  ),
                  Wrap(
                    children: dateDay
                        .map((e) => Container(
                              width: (MediaQuery.of(context).size.width -
                                      size.width * 205) /
                                  7,
                              padding: EdgeInsets.only(top: size.width * 10),
                              child: GestureDetector(
                                onTap: () {
                                  currenDay = int.parse(e);
                                  _getData();
                                  setState(() {});
                                },
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(size.width * 5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            e != '' && currenDay == int.parse(e)
                                                ? themeColor
                                                : null),
                                    child: Column(
                                      children: [
                                        Text(
                                          e,
                                          style: TextStyle(
                                            fontSize: size.width * 26,
                                            color: e != '' &&
                                                    currenDay == int.parse(e)
                                                ? Colors.white
                                                : null,
                                          ),
                                        ),
                                        // normal.toString() == e
                                        //     ? Container(
                                        //         width: size.width * 9,
                                        //         height: size.width * 9,
                                        //         decoration: BoxDecoration(
                                        //             color: Color(0xff3ED5BA),
                                        //             shape: BoxShape.circle),
                                        //       )
                                        //     : Container(),
                                        // abnormal.toString() == e
                                        //     ? Container(
                                        //         width: size.width * 9,
                                        //         height: size.width * 9,
                                        //         decoration: BoxDecoration(
                                        //             color: Color(0xffF37272),
                                        //             shape: BoxShape.circle),
                                        //       )
                                        //     : Container(),
                                        // roster.toString() == e
                                        //     ? Container(
                                        //         width: size.width * 9,
                                        //         height: size.width * 9,
                                        //         decoration: BoxDecoration(
                                        //             color: Color(0xff999999),
                                        //             shape: BoxShape.circle),
                                        //       )
                                        //     : Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: size.width * 10),
                ],
              ),
            ),
            dutyList.isEmpty || currenDay == -1
                ? Container(
                    margin: EdgeInsets.only(top: size.width * 60),
                    width: MediaQuery.of(context).size.width - size.width * 120,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/emergencySystemEmpty.png',
                          width: size.width * 291,
                          height: size.width * 231,
                        ),
                        Text('暂无排班',
                            style: TextStyle(fontSize: size.width * 30))
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: dutyList
                        .map((e) => Row(
                              children: [
                                Container(
                                  width: size.width * 160,
                                  child: Column(
                                    children: [
                                      Text(
                                        e['title'].toString(),
                                        style: TextStyle(
                                            color: Color(0xff787D93),
                                            fontSize: size.width * 30),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      Text(
                                        e['time'].toString(),
                                        style: TextStyle(
                                            color: Color(0xff787D93),
                                            fontSize: size.width * 26),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 20,
                                      top: size.width * 10),
                                  constraints: BoxConstraints(
                                      minWidth: size.width * 420),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 30,
                                      vertical: size.width * 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft:
                                          Radius.circular(size.width * 20),
                                      topLeft: Radius.circular(size.width * 20),
                                    ),
                                    color: Color(0xffFDF1DB),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width * 350,
                                        child: Text(
                                          e['firstLine'].toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 24),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Text(
                                        e['phone'].toString(),
                                        style: TextStyle(
                                            fontSize: size.width * 24),
                                      ),
                                      e['dutyReport'] is String
                                          ? Text('日志: ' + e['dutyReport'])
                                          : Container(),
                                      InkWell(
                                        onTap: () async {
                                          await WorkDialog.myDialog(
                                              context, () {}, 2,
                                              widget: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 41),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '值班日志',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff3574FA),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      e['title'] + ' :',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff666666)),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  size.width *
                                                                      10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color:
                                                            Color(0xffF0F5FF),
                                                      ),
                                                      child: TextField(
                                                        onChanged: (str) {
                                                          e['control'] = str;
                                                        },
                                                        maxLines: 5,
                                                        minLines: 3,
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width *
                                                                    24),
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                e['control'] ??
                                                                    '请输入描述',
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    size.width *
                                                                        20)),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  size.width *
                                                                      20),
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (e['control'] !=
                                                                  null &&
                                                              e['control'] !=
                                                                  '') {
                                                            myDio.request(
                                                                type: 'put',
                                                                url: Interface
                                                                    .putChangeDutyReport,
                                                                data: {
                                                                  "id": e['id'],
                                                                  "dutyReport":
                                                                      e['control']
                                                                }).then(
                                                                (value) {
                                                              Navigator.pop(
                                                                  context);
                                                              _getData();
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              150,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      size.width *
                                                                          15),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      38),
                                                              gradient: LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xff3174FF),
                                                                    Color(
                                                                        0xff1C3AEA)
                                                                  ],
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight)),
                                                          child: Center(
                                                            child: Text(
                                                              '确定',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      size.width *
                                                                          30),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ));
                                        },
                                        child: Text(
                                          '值班日志',
                                          style: TextStyle(
                                              color: themeColor,
                                              fontSize: size.width * 22),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }
}

class CustomClipperOval extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path _path = Path();
    _path.lineTo(0, size.height - 50);
    _path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    _path.lineTo(size.width, 0);
    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
