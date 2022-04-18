import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueSingleTeam extends StatefulWidget {
  EmergencyRescueSingleTeam({this.title});
  final String title;
  @override
  _EmergencyRescueSingleTeamState createState() =>
      _EmergencyRescueSingleTeamState();
}

class _EmergencyRescueSingleTeamState extends State<EmergencyRescueSingleTeam> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getSingleTeam();
  }

  _getSingleTeam() {
    myDio
        .request(type: 'get', url: Interface.getERRescueTeam, queryParameters: {
      'current': 1,
      'size': 1000,
      "rescueTeamType": widget.title,
    }).then((value) {
      if (value is Map) {
        data = value['records'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.title.toString()),
      child: data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/emergencyRescue/____emergencyRescueSingleTeamDetails',
                        arguments: {'id': data[index]['id']});
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 25),
                    margin: EdgeInsets.only(bottom: size.width * 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: size.width * 30,
                              width: size.width * 6,
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 20),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [
                                        0.0,
                                        1.0
                                      ], //[渐变起始点, 渐变结束点]
                                      colors: [
                                        Color(0xff2AC79B),
                                        Color(0xff3174FF),
                                      ])),
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Text(
                              data[index]['rescueTeamName'],
                              style: TextStyle(
                                  color: Color(0xff1C1C1D),
                                  fontSize: size.width * 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: size.width * 15,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 1,
                                  horizontal: size.width * 15),
                              decoration: BoxDecoration(
                                  color: Color(0xff3174FF).withOpacity(0.14),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              alignment: Alignment.center,
                              child: Text(
                                data[index]['rescueTeamType'],
                                style: TextStyle(
                                    color: Color(0xff3174FF),
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 1,
                                  horizontal: size.width * 15),
                              decoration: BoxDecoration(
                                  color: Color(0xff3174FF).withOpacity(0.14),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              alignment: Alignment.center,
                              child: Text(
                                data[index]['qualificationLevel'],
                                style: TextStyle(
                                    color: Color(0xff3174FF),
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: size.width * 1,
                          width: double.infinity,
                          color: Color(0xffDCDCDC),
                          margin: EdgeInsets.only(bottom: size.width * 10),
                        ),
                        Row(
                          children: [
                            Container(
                              width: size.width * 180,
                              child: Text(
                                '负责人：  ',
                                style: TextStyle(
                                    color: Color(0xff858888),
                                    fontSize: size.width * 26),
                              ),
                            ),
                            Text(
                              data[index]['mainHead'],
                              style: TextStyle(
                                color: Color(0xff1C1C1D),
                                fontSize: size.width * 26,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: size.width * 180,
                              child: Text(
                                '地址：  ',
                                style: TextStyle(
                                    color: Color(0xff858888),
                                    fontSize: size.width * 26),
                              ),
                            ),
                            Text(
                              data[index]['rescueTeamAddress'],
                              style: TextStyle(
                                color: Color(0xff1C1C1D),
                                fontSize: size.width * 26,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: size.width * 180,
                              child: Text(
                                '值班电话：  ',
                                style: TextStyle(
                                    color: Color(0xff858888),
                                    fontSize: size.width * 26),
                              ),
                            ),
                            Text(
                              data[index]['onDutyPhone'],
                              style: TextStyle(
                                color: Color(0xff1C1C1D),
                                fontSize: size.width * 26,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: size.width * 50,
                          width: double.infinity,
                          color: Color(0xffF4F8FF),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: size.width * 15),
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 20),
                          child: Row(
                            children: [
                              Text(
                                '成立时间：',
                                style: TextStyle(
                                    color: Color(0xff858888),
                                    fontSize: size.width * 26),
                              ),
                              Text(
                                data[index]['setUpTime'].toString().length > 10
                                    ? data[index]['setUpTime']
                                        .toString()
                                        .substring(0, 10)
                                    : data[index]['setUpTime'].toString(),
                                style: TextStyle(
                                  color: Color(0xff1C1C1D),
                                  fontSize: size.width * 26,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
          : Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: size.width * 300),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/empty@2x.png",
                    height: size.width * 288,
                    width: size.width * 374,
                  ),
                  Text('暂无数据'),
                ],
              )),
    );
  }
}
