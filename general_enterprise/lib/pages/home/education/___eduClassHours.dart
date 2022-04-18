import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class EduClassHours extends StatefulWidget {
  EduClassHours({this.title, this.userId});
  final String title;
  final int userId;
  @override
  _EduClassHoursState createState() => _EduClassHoursState();
}

class _EduClassHoursState extends State<EduClassHours> {
  int userId = -1;

  @override
  void initState() {
    super.initState();
    if(widget.userId == null){
      userId = myprefs.getInt('userId');
    }else{
      userId = widget.userId;
    }
    
    selectDate = DateTime.now();
    _getData();
  }

  DateTime selectDate;

  _getData() {
    myDio.request(
        type: "get",
        url: Interface.getpersonalTrainingDetails,
        queryParameters: {
          'userId': userId,
          'time': selectDate.toString().substring(0, 4),
        }).then((value) {
      if (value is Map) {
        data = value;
        if(widget.title == '线上培训情况'){
          monthDataList = data['monthOnline'];
          assessment = data['assessment'];
        }else if(widget.title == '线下培训情况'){
          monthDataList = data['monthOffline'];
        }
        totalHours = 0;
        if(monthDataList.isNotEmpty){
          for (int i = 0; i < monthDataList.length; i++) {
            totalHours += monthDataList[i]['classHours'];
          }
        }
        setState(() {});
      }
    });
  }

  Map data = {};

  Map assessment = {};

  List monthDataList = [];

  int totalHours = 0;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.title.toString()),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                DatePicker.showDatePicker(context,
                    pickerTheme: DateTimePickerTheme(
                      showTitle: true,
                      confirm: Text('确定', style: TextStyle(color: Colors.red)),
                      cancel: Text('取消', style: TextStyle(color: Colors.cyan)),
                    ),
                    minDateTime: DateTime.parse("1980-05-21"),
                    initialDateTime: selectDate,
                    dateFormat: "yyyy",
                    pickerMode: DateTimePickerMode.date,
                    locale: DateTimePickerLocale.zh_cn,
                    onConfirm: (dateTime, List<int> index) {
                  selectDate = dateTime;
                  _getData();
                });
              },
              child: Container(
                // width: size.width * 220,
                height: size.width * 70,
                margin: EdgeInsets.all(size.width * 30.0),
                padding: EdgeInsets.only(
                    left: size.width * 20.0, right: size.width * 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: size.width * 2,
                    color: Color(0xff999999),
                  ),
                  borderRadius: BorderRadius.circular(size.width * 10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      selectDate != null
                          ? selectDate.toString().substring(0, 4)
                          : '选择年份',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: size.width * 24),
                    ),
                    Image.asset(
                      'assets/images/icon_my_msg_date.png',
                      height: size.width * 28,
                      width: size.width * 28,
                    )
                  ],
                ),
              ),
            ),
            assessment.isNotEmpty ? Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 1
                  ),
                ]
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/cp@2x.png',
                              height: size.width * 32,
                              width: size.width * 32,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Text(
                              '考试测评情况',
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: size.width * 110,
                        width: size.width * 201,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/bg_my_msg_kaohefen.png',),  
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              assessment['avgScore'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 36
                              ),
                            ),
                            Text(
                              '考核平均分',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 24
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffEEEEEE),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '考试最高分',
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: size.width * 21
                              ),
                            ),
                            Text(
                              assessment['max'].toString() + '分',
                              style: TextStyle(
                                color: Color(0xff50A3EF),
                                fontSize: size.width * 26
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '考试最低分',
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: size.width * 21
                              ),
                            ),
                            Text(
                              assessment['min'].toString() + '分',
                              style: TextStyle(
                                color: Color(0xffD12926),
                                fontSize: size.width * 26
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '考试不合格',
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: size.width * 21
                              ),
                            ),
                            Text(
                              assessment['unqualified'].toString() + '次',
                              style: TextStyle(
                                color: Color(0xffFFAA72),
                                fontSize: size.width * 26
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ) : Container(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 25, vertical: size.width * 30),
              child: Row(
                children: [
                  Container(
                    height: size.width * 8,
                    width: size.width * 8,
                    decoration: BoxDecoration(
                      color: Color(0xff3E94F4),
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                  ),
                  SizedBox(
                    width: size.width * 10,
                  ),
                  Text(
                    '本年度累计学时：',
                    style: TextStyle(
                      color: Color(0xff4D4D4D),
                      fontSize: size.width * 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: size.width * 10,
                  ),
                  Text(
                    totalHours.toString() + '学时',
                    style: TextStyle(
                      color: Color(0xff3E94F4),
                      fontSize: size.width * 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: monthDataList.isNotEmpty ? ListView.builder(
                itemCount: monthDataList.length,
                itemBuilder: (context, index){
                  return Container(
                    height: size.width * 92,
                    color: index % 2 == 0 ? Color(0xff3E94F4).withOpacity(0.05) : Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 40),
                    child: Row(
                      children: [
                        Text(
                          monthDataList[index]['date'] + '累计学时：',
                          style: TextStyle(
                            color: Color(0xff4D4D4D),
                            fontSize: size.width * 26
                          ),
                        ),
                        Spacer(),
                        Text(
                          monthDataList[index]['classHours'].toString() + '学时',
                          style: TextStyle(
                            color: Color(0xff3E94F4 ),
                            fontSize: size.width * 26
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ) : Container(),
            )
            // Container(
            //   width: size.width * 690,
            //   padding: EdgeInsets.symmetric(vertical: size.width * 30),
            //   margin: EdgeInsets.symmetric(vertical: size.width * 30),
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/biaoqiamn@2x.png'),
            //       fit: BoxFit.cover
            //     ),
            //     boxShadow: [
            //       BoxShadow(
            //         blurRadius: 1.0,
            //         color: Colors.black12,
            //         spreadRadius: 1.0
            //       )
            //     ]
            //   ),
            //   alignment: Alignment.centerLeft,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             '线上培训累计总学时：',
            //             style: TextStyle(
            //               color: Color(0xff999999),
            //               fontSize: size.width * 24
            //             ),
            //           ),
            //           SizedBox(
            //             height: size.width * 5,
            //           ),
            //           Text(
            //             widget.totalClassHours.toString() + '学时',
            //             style: TextStyle(
            //               color: Color(0xff5570FF),
            //               fontSize: size.width * 40,
            //               fontWeight: FontWeight.bold
            //             ),
            //           )
            //         ],
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             '本月累计课时：',
            //             style: TextStyle(
            //               color: Color(0xff999999),
            //               fontSize: size.width * 24
            //             ),
            //           ),
            //           SizedBox(
            //             height: size.width * 5,
            //           ),
            //           Text(
            //             widget.currentMonthClassHours.toString() + '学时',
            //             style: TextStyle(
            //               color: Color(0xff5570FF),
            //               fontSize: size.width * 40,
            //               fontWeight: FontWeight.bold
            //             ),
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: widget.yearClassHours.length,
            //     itemBuilder: (context, index){
            //       return Container(
            //         color: index % 2 == 0 ? Color(0xff3E94F4).withOpacity(0.05) : Colors.white,
            //         padding: EdgeInsets.all(size.width * 30),
            //         alignment: Alignment.centerLeft,
            //         child: Row(
            //           children: [
            //             Text(
            //               widget.yearClassHours[index]['year'].toString() + '年累计课时：',
            //               style: TextStyle(
            //                 color: Color(0xff4D4D4D),
            //                 fontSize: size.width * 34
            //               ),
            //             ),
            //             Spacer(),
            //             Text(
            //               widget.title == '线上培训情况' ? widget.yearClassHours[index]['yearOnLineClassHours'].toString() + '课时' : widget.yearClassHours[index]['yearOfflineClassHours'].toString() + '课时',
            //               style: TextStyle(
            //                 color: Color(0xff3E94F4),
            //                 fontSize: size.width * 34
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     }
            //   )
            // )
          ],
        ),
      ),
    );
  }
}
