import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class ClosedManagement extends StatefulWidget {
  @override
  State<ClosedManagement> createState() => _ClosedManagementState();
}

class _ClosedManagementState extends State<ClosedManagement> {
  List closedManagementList = [
    // {
    //   "name": "封闭化总览",
    //   "router": "/closedManagement/_closedManagementLeftList",
    //   "icon": 'assets/images/fengbi_overview.png'
    // },
    {
      "name": "出入记录",
      "router": "/closedManagement/_closedManagementLeftList",
      "icon": 'assets/images/fengbi_access.png'
    },
    {
      "name": "预约管理",
      "router": "/closedManagement/_closedManagementLeftList",
      "icon": 'assets/images/fengbi_order.png'
    },
    {
      "name": "我的预约记录",
      "router": "/closedManagement/_closedManagementLeftList",
      "icon": 'assets/images/my_fengbi_record.png'
    },
    // {"name": "我的消息", "router": "/closedManagement/_closedManagementLeftList", "icon": 'assets/images/fengbi_information.png'},
  ];
  Map data = {};
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MyAppbar(
      title: Text("封闭化管理"),
      child: Container(
          color: Colors.white,
          height: height,
          child: Stack(
            children: [
              ListView.builder(
                itemCount: closedManagementList.length,
                shrinkWrap: true,
                itemBuilder: (builder, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: size.width * 31,
                        left: size.width * 33,
                        top: size.width * 35.0),
                    // InkWell 添加 Material触摸水波效果
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, closedManagementList[index]['router'],
                              arguments: {
                                'index': index,
                              });
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  closedManagementList[index]['icon'],
                                  height: size.width * 42,
                                  width: size.width * 42,
                                ),
                                SizedBox(
                                  width: size.width * 34,
                                ),
                                Text(
                                  closedManagementList[index]['name'],
                                  style: TextStyle(
                                      color: Color(0xff3C3C3C),
                                      fontSize: size.width * 26),
                                ),
                                Spacer(),
                                Container(
                                  height: size.width * 31,
                                  width: size.width * 90,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: Color(0xff2E6CFD),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '查看',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 20),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.width * 35,
                            ),
                            index != closedManagementList.length - 1
                                ? Container(
                                    color: Color(0xffEFEFEF),
                                    height: size.width * 1,
                                    width: double.infinity,
                                  )
                                : Container(),
                          ],
                        )),
                  );
                },
              ),
              Positioned(
                  right: size.width * 50,
                  bottom: size.width * 100,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/home/closedManagement/appointment',
                          arguments: {
                            'data': data,
                          });
                    },
                    child: Container(
                        height: size.width * 120,
                        width: size.width * 120,
                        decoration: BoxDecoration(
                          color: Color(0xff3174FF),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, size.width * 6),
                                color: Color(0xff3174FF).withOpacity(0.2),
                                blurRadius: size.width * 6,
                                spreadRadius: size.width * 1)
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/add-small.png',
                              width: size.width * 80,
                              height: size.width * 80,
                            ),
                            Text(
                              "预约",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 24),
                            ),
                          ],
                        )),
                  ))
            ],
          )),
    );
  }
}
