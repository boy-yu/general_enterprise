import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/myAppbar.dart';

class Normal extends StatefulWidget {
  Normal({this.arguments});
  final arguments;
  @override
  _NormalState createState() => _NormalState(arguments: arguments);
}

class _NormalState extends State<Normal> {
  SharedPreferences prefs;
  _NormalState({this.arguments});
  final arguments;
  List msgList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(arguments);
    double width = size.width;

    return MyAppbar(
        title: Text(arguments['title'].toString()),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: width * 30, right: width * 30, top: 28),
                    padding:
                        EdgeInsets.only(left: width * 30, right: width * 30),
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(width * 14),
                        border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(255, 255, 255, .2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 30,
                            offset: Offset(-1, 1), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: size.width * 30),
                          child: Row(
                            children: <Widget>[
                              Text("${index + 1}"),
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xffFFA0A0A0),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: width * 102),
                              child: Text("属地单位：精馏工段"),
                            ),
                            Text("作业区域：806A")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  right: width * 46,
                                  top: size.width * 24,
                                  bottom: size.width * 24),
                              child: Text("作业时间：2020年1月4日"),
                            ),
                            Text("作业内容：维修xxxx")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: width * 0),
                              child: Text("涉及作业：动火作业、高出作业"),
                            ),
                          ],
                        ),
                        Container(
                          height: size.width * 49,
                          width: width * 152,
                          margin:
                              EdgeInsets.only(bottom: 20, top: size.width * 20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.35),
                                offset:
                                    Offset(-1, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25.0),
                            gradient: LinearGradient(colors: <Color>[
                              Color(0xffFF3679FF),
                              Color(0xffFF1F3FE8),
                            ]),
                          ),
                          child: TextButton(
                            child: Text(
                              "详情",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)))),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }));
  }
}
