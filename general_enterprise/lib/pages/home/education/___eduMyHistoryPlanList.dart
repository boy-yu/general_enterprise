import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduMyHistoryPlanList extends StatefulWidget {
  EduMyHistoryPlanList({this.planId, this.title});
  final int planId;
  final String title;
  @override
  _EduMyHistoryPlanListState createState() => _EduMyHistoryPlanListState();
}

class _EduMyHistoryPlanListState extends State<EduMyHistoryPlanList> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    myDio.request(
        type: "get",
        url: Interface.getMyResourcesBookListByPlanId,
        queryParameters: {
          'planId': widget.planId,
        }
    ).then((value) {
      if (value is Map) {
        compulsoryList = value['compulsoryList'];
        electiveList = value['electiveList'];
      }
      setState(() {
        show = true;
      });
    });
    
  }

  List compulsoryList = []; //必修
  List electiveList = [];  //选修

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.title),
      child: Transtion(
        ListView(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_textbook_type.png',
                        width: size.width * 30,
                        height: size.width * 30,
                      ),
                      SizedBox(
                        width: size.width * 30,
                      ),
                      Text(
                        '必修教材',
                        style: TextStyle(
                          fontSize: size.width * 28,
                          color: Color(0xffA3A3A3),
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: compulsoryList.asMap().keys.map((index) => 
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1.0,
                            spreadRadius: 1.0
                          )
                        ]
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            compulsoryList[index]['coverUrl'],
                            height: size.width * 139,
                            width: size.width * 209,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 350,
                                    child: Text(
                                      compulsoryList[index]['title'],
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.bold
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Text(
                                    compulsoryList[index]['status'] == 1 ? '已完成' : '未完成',
                                    style: TextStyle(
                                      color: compulsoryList[index]['status'] == 1 ? Color(0xff78C78D) : Color(0xff666666),
                                      fontSize: size.width * 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: size.width * 350,
                                    child: Text(
                                      compulsoryList[index]['introduction'],
                                      style: TextStyle(
                                        fontSize: size.width * 22,
                                        color: Color(0xff999999)
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return ShowDialog(
                                              child: Center(
                                            child: Container(
                                              height: size.width * 500,
                                              width: size.width * 690,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          size.width * 10))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: size.width * 20,
                                                    vertical: size.width * 10),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Icon(
                                                            Icons.clear,
                                                            size: size.width * 40,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                      compulsoryList[index]['title'],
                                                      style: TextStyle(
                                                          fontSize: size.width * 36,
                                                          color: Color(0xff0059FF),
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: size.width * 30,
                                                    ),
                                                    Text(
                                                      compulsoryList[index]['introduction'],
                                                      style: TextStyle(
                                                          fontSize: size.width * 30,
                                                          color: Color(0xff9D9D9D)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                        });
                                    },
                                    child: Text(
                                      '[详情]',
                                      style: TextStyle(
                                        color: Color(0xff1D3DEB),
                                        fontSize: size.width * 20
                                      ),
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
                                    width: size.width * 300,
                                    child: Text(
                                      '本教材包含${compulsoryList[index]['classHours']}个课时',
                                      style: TextStyle(
                                        fontSize: size.width * 16,
                                        color: Color(0xff16CAA2)
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  compulsoryList[index]['status'] == 1 ? Container() : InkWell(
                                    onTap: (){
                                      Navigator.of(context)
                                            .pushNamed(
                                          '/home/education/study',
                                          arguments: {
                                            'id': compulsoryList[index]['resourcesId'],
                                          }
                                        ).then((value) {
                                          // 返回值
                                        });
                                    },
                                    child: Container(
                                      height: size.width * 42,
                                      width: size.width * 112,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
                                        color: Color(0xff3869FC),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '开始学习',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 20
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ).toList()),
                ],
              ),
            ),
            SizedBox(
              height: size.width * 20,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_textbook_type.png',
                        width: size.width * 30,
                        height: size.width * 30,
                      ),
                      SizedBox(
                        width: size.width * 30,
                      ),
                      Text(
                        '选修教材',
                        style: TextStyle(
                          fontSize: size.width * 28,
                          color: Color(0xffA3A3A3),
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: electiveList.asMap().keys.map((index) => 
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size.width * 15),
                      padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1.0,
                            spreadRadius: 1.0
                          )
                        ]
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            electiveList[index]['coverUrl'],
                            height: size.width * 139,
                            width: size.width * 209,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 350,
                                    child: Text(
                                      electiveList[index]['title'],
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.bold
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Text(
                                    electiveList[index]['status'] == 1 ? '已完成' : '未完成',
                                    style: TextStyle(
                                      color: electiveList[index]['status'] == 1 ? Color(0xff78C78D) : Color(0xff666666),
                                      fontSize: size.width * 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: size.width * 350,
                                    child: Text(
                                      electiveList[index]['introduction'],
                                      style: TextStyle(
                                        fontSize: size.width * 22,
                                        color: Color(0xff999999)
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return ShowDialog(
                                              child: Center(
                                            child: Container(
                                              height: size.width * 500,
                                              width: size.width * 690,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          size.width * 10))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: size.width * 20,
                                                    vertical: size.width * 10),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Icon(
                                                            Icons.clear,
                                                            size: size.width * 40,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                      electiveList[index]['title'],
                                                      style: TextStyle(
                                                          fontSize: size.width * 36,
                                                          color: Color(0xff0059FF),
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: size.width * 30,
                                                    ),
                                                    Text(
                                                      electiveList[index]['introduction'],
                                                      style: TextStyle(
                                                          fontSize: size.width * 30,
                                                          color: Color(0xff9D9D9D)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                        });
                                    },
                                    child: Text(
                                      '[详情]',
                                      style: TextStyle(
                                        color: Color(0xff1D3DEB),
                                        fontSize: size.width * 20
                                      ),
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
                                    width: size.width * 300,
                                    child: Text(
                                      '本教材包含${electiveList[index]['classHours']}个课时',
                                      style: TextStyle(
                                        fontSize: size.width * 16,
                                        color: Color(0xff16CAA2)
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  electiveList[index]['status'] == 1 ? Container() : InkWell(
                                    onTap: (){
                                      Navigator.of(context)
                                            .pushNamed(
                                          '/home/education/study',
                                          arguments: {
                                            'id': electiveList[index]['resourcesId'],
                                          }
                                        ).then((value) {
                                          // 返回值
                                        });
                                    },
                                    child: Container(
                                      height: size.width * 42,
                                      width: size.width * 112,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
                                        color: Color(0xff3869FC),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '开始学习',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 20
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ).toList()),
                ],
              ),
            ),
          ],
        ),
        show,
      ),
    );
  }
}