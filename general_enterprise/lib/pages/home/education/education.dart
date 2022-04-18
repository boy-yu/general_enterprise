import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'exam/db_examCache.dart';

/*
 *  安全教育培训首页 统计|学习
 */
class Education extends StatefulWidget {
  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  PageController _controller;

  List workData = [
    {
      "index": 0,
      "title": "总览",
      "descript": "选择需要使用的",
      "img": "assets/images/look.png",
      "isClick": false
    },
    {
      "index": 1,
      "title": "学习",
      "descript": "选择需要使用的",
      "img": "assets/images/apply.png",
      "isClick": true
    },
  ];

  int choosed = 1;
  int oldPage = 1;

  List dropList = [];
  void initState() {
    super.initState();
    _controller = PageController(initialPage: choosed);
    _controller.addListener(() {
      if (oldPage != _controller.page.toInt()) {
        choosed = _controller.page.toInt();
        oldPage = choosed;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Widget _changeTitle(width, item) {
    Widget _widget;
    if (item['title'] == '总览')
      _widget = Container();
    else if (item['title'] == '学习') _widget = Study();
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      elevation: 0,
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(.2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(28))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: workData.map<Widget>((ele) {
            return GestureDetector(
              onTap: () {
                choosed = ele['index'];
                _controller.animateToPage(choosed,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: choosed == ele['index'] ? Colors.white : null,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text(
                  ele['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          choosed == ele['index'] ? themeColor : Colors.white,
                      fontSize: size.width * 35),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 40, vertical: size.width * 10),
              ),
            );
          }).toList(),
        ),
      ),
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (context, index) =>
            _changeTitle(size.width, workData[index]),
        itemCount: workData.length,
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.control_camera),
            onPressed: () {
              Navigator.pushNamed(context, '/home/education/WebActiveControl',
                  arguments: {});
            }),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(
              '/home/education/educationKnowledgeBase',
            )
                .then((value) {
              // 返回值
            });
          },
          child: Container(
              padding: EdgeInsets.all(size.width * 30),
              child: Image.asset(
                "assets/images/icon_education_knowledge_base.png",
                height: size.width * 40,
                width: size.width * 40,
              )),
        ),
      ],
    );
  }
}

class Study extends StatefulWidget {
  @override
  _StudyState createState() => _StudyState();
}

class _StudyState extends State<Study> {
  List priorityData = [
    {
      'title': '2021年培训计划需求问卷',
      'type': 1, //1是问卷2是计划
      'abortTime': '2020.09.17  20:00',
    },
    {
      'title': '2021年培训计划需求问卷',
      'type': 1, //1是问卷2是计划
      'abortTime': '2020.09.17  20:00',
    },
    {
      'title': '2021年年度学习计划',
      'type': 2, //1是问卷2是计划
      'abortTime': '2020.09.17  20:00',
      'examination': '请在截至日期内完成考核',
    },
  ];

  bool show = false;
  List boxData = [];
  @override
  void initState() {
    super.initState();
    _getYearClassHours();
    _getMyEducationTrainingTaskStatistics();
    init();
    _getNewCourse();
    _getHistory();
  }

  init() {
    myDio
        .request(type: "get", url: Interface.getResourcesTypeLeveLOne)
        .then((value) {
      if (value is List) {
        boxData = value;
      }
      setState(() {
        show = true;
      });
    });
  }

  List newCourse = [];
  List histryCourse = [];

  _getHistory() {
    ExamCache().getList(3).then((value) {
      setState(() {
        histryCourse = value;
      });
    });
  }

  _getNewCourse() {
    myDio
        .request(
      type: "get",
      url: Interface.getEducationTrainingResourcesList,
    )
        .then((value) {
      if (value is Map) {
        if (value['records'] is List) {
          for (var i = 0; i < value['records'].length; i++) {
            if (i > 2) {
              break;
            }
            newCourse.add(value['records'][i]);
          }
        }
      }
      setState(() {});
    });
  }

  int myPlanNum;

  _getMyEducationTrainingTaskStatistics() {
    myDio
        .request(
      type: "get",
      url: Interface.getMyEducationTrainingTaskStatistics,
    )
        .then((value) {
      if (value is Map) {
        myPlanNum = value['educationTrainingPlanProcessingNum'] +
            value['educationTrainingOfflinePlanNum'] +
            value['educationTrainingPlanYearProcessingNum'] +
            value['educationTrainingOfflinePlanYearNum'];
      }
      setState(() {});
    });
  }

  int yearClassHours = 0;

  _getYearClassHours() {
    myDio
        .request(
      type: "get",
      url: Interface.getYearClassHours,
    )
        .then((value) {
      if (value is Map) {
        yearClassHours = value['total'];
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Color(0xffFFFFFF),
        child: Transtion(
            ListView(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(bottom: size.width * 20),
                  child: Column(
                    children: [
                      // 排名/正在进行计划
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: size.width * 145,
                                width: size.width * 340,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 30,
                                    vertical: size.width * 15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/kh@2x.png'),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('本年度总学时',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: size.width * 28)),
                                    Spacer(),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.white),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: yearClassHours.toString(),
                                                style: TextStyle(
                                                    fontSize: size.width * 50,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: '学时',
                                                style: TextStyle(
                                                    fontSize: size.width * 28)),
                                          ]),
                                    ),
                                  ],
                                )),
                            Container(
                                height: size.width * 145,
                                width: size.width * 340,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 30,
                                    vertical: size.width * 15),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/xuex@2x.png'),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('学习计划正在进行',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: size.width * 28)),
                                    Spacer(),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.white),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: myPlanNum.toString(),
                                                style: TextStyle(
                                                    fontSize: size.width * 50,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: '项',
                                                style: TextStyle(
                                                    fontSize: size.width * 28)),
                                          ]),
                                    ),
                                  ],
                                )),
                            // InkWell(
                            //   onTap: () {
                            //     // Navigator.of(context).pushNamed(
                            //     //   '/checkList/studyPlan',
                            //     // );
                            //   },
                            //   child: Container(
                            //     height: size.width * 145,
                            //     width: size.width * 340,
                            //     padding: EdgeInsets.only(
                            //         top: size.width * 10,
                            //         left: size.width * 30),
                            //     decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //         image:
                            //             AssetImage('assets/images/xuex@2x.png'),
                            //       ),
                            //     ),
                            //     child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Padding(
                            //           padding:
                            //               EdgeInsets.only(top: size.width * 15),
                            // child:
                            //         ),
                            //         SizedBox(
                            //           width: size.width * 10,
                            //         ),
                            //         Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             RichText(
                            //               text: TextSpan(
                            //                   style: TextStyle(
                            //                       color: Colors.white),
                            //                   children: <InlineSpan>[
                            //                     TextSpan(
                            //                         text: myPlanNum.toString(),
                            //                         style: TextStyle(
                            //                             fontSize:
                            //                                 size.width * 50,
                            //                             fontWeight:
                            //                                 FontWeight.bold)),
                            //                     TextSpan(
                            //                         text: '项',
                            //                         style: TextStyle(
                            //                             fontSize:
                            //                                 size.width * 28)),
                            //                   ]),
                            //             ),
                            //             Text(
                            //               '学习计划正在进行',
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: size.width * 26,
                            //               ),
                            //             ),
                            //             // Text(
                            //             //   '点击查看详情>',
                            //             //   style: TextStyle(
                            //             //     color: Colors.white,
                            //             //     fontSize: size.width * 20,
                            //             //   ),
                            //             // ),
                            //           ],
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 教材
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  '/home/education/eduTextbookType',
                                  arguments: {
                                    "boxData": boxData
                                  }).then((value) {
                                // 返回值
                              });
                            },
                            child: Container(
                              width: size.width * 220,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/icon_edu_home_jc@2x.png',
                                    height: size.width * 90,
                                    width: size.width * 90,
                                  ),
                                  SizedBox(
                                    height: size.width * 20,
                                  ),
                                  Text(
                                    '教材',
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // 我的
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/home/education/eduMy');
                            },
                            child: Container(
                              width: size.width * 220,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/wode@2x.png',
                                    height: size.width * 90,
                                    width: size.width * 90,
                                  ),
                                  SizedBox(
                                    height: size.width * 20,
                                  ),
                                  Text(
                                    '我的',
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // 收藏
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/home/education/eduCollectList');
                            },
                            child: Container(
                              width: size.width * 220,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/icon_edu_my_collect.png',
                                    height: size.width * 90,
                                    width: size.width * 90,
                                  ),
                                  SizedBox(
                                    height: size.width * 20,
                                  ),
                                  Text(
                                    '收藏',
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 10,
                ),
                // 近期学习教材
                Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.width * 20,
                              left: size.width * 25,
                              right: size.width * 25),
                          child: Text(
                                '近期学习教材',
                                style: TextStyle(
                                    fontSize: size.width * 28,
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.bold),
                              ),
                        ),
                        Column(
                            children: histryCourse
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.all(size.width * 25),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                '/home/education/study',
                                                arguments: {
                                                  'id': e['id'],
                                                }).then((value) {
                                              // 返回值
                                            });
                                          },
                                          child: Container(
                                            height: size.width * 166,
                                            width: size.width * 277,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(
                                                          size.width * 10)),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  e['coverUrl'],
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              width: double.infinity,
                                              height: size.width * 40,
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        size.width * 10)),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '开始学习',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width * 26,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 10,
                                              vertical: size.width * 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: size.width * 363,
                                                child: Text(e['title'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 26,
                                                        color:
                                                            Color(0xff333333),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: size.width * 300,
                                                    child: Text(
                                                        e['introduction'],
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.width * 22,
                                                          color:
                                                              Color(0xff666666),
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              true,
                                                          builder: (BuildContext
                                                              context) {
                                                            return ShowDialog(
                                                                child: Center(
                                                              child: Container(
                                                                height:
                                                                    size.width *
                                                                        500,
                                                                width:
                                                                    size.width *
                                                                        690,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(size.width *
                                                                            10))),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          size.width *
                                                                              20,
                                                                      vertical:
                                                                          size.width *
                                                                              10),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Spacer(),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              size: size.width * 40,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        e['title'],
                                                                        style: TextStyle(
                                                                            fontSize: size.width *
                                                                                36,
                                                                            color:
                                                                                Color(0xff0059FF),
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            size.width *
                                                                                30,
                                                                      ),
                                                                      Text(
                                                                        e['introduction']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: size.width *
                                                                                30,
                                                                            color:
                                                                                Color(0xff9D9D9D)),
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
                                                          color:
                                                              Color(0xff3869FC),
                                                          fontSize:
                                                              size.width * 24),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // SizedBox(
                                              //   height: size.width * 20,
                                              // ),
                                              // Row(
                                              //   children: [
                                              //     Image.asset(
                                              //       'assets/images/icon_edu_star.png',
                                              //       width: size.width * 30,
                                              //       height: size.width * 30,
                                              //     ),
                                              //     SizedBox(
                                              //       width: size.width * 10,
                                              //     ),
                                              //     Text(
                                              //       (3.3).toString() + '分',
                                              //       style: TextStyle(
                                              //         color: Color(0xff999999),
                                              //         fontSize: size.width * 22,
                                              //       ),
                                              //     )
                                              //   ],
                                              // )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList()),
                      ],
                    )),
                SizedBox(
                  height: size.width * 10,
                ),
                // 上新课程
                Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.width * 20,
                              left: size.width * 25,
                              right: size.width * 25),
                          child: Text(
                                '上新课程',
                                style: TextStyle(
                                    fontSize: size.width * 28,
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.bold),
                              ),
                        ),
                        Column(
                            children: newCourse
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.all(size.width * 25),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            ExamCache()
                                                .writeTable(e)
                                                .then((value) {
                                              Navigator.of(context).pushNamed(
                                                  '/home/education/study',
                                                  arguments: {
                                                    'id': e['id'],
                                                  }).then((value) {
                                                    _getHistory();
                                                // 返回值
                                              });
                                            });
                                          },
                                          child: Container(
                                            height: size.width * 166,
                                            width: size.width * 277,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(
                                                          size.width * 10)),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  e['coverUrl'],
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              width: double.infinity,
                                              height: size.width * 40,
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        size.width * 10)),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '开始学习',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width * 26,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 10,
                                              vertical: size.width * 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: size.width * 363,
                                                child: Text(e['title'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 26,
                                                        color:
                                                            Color(0xff333333),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: size.width * 300,
                                                    child: Text(
                                                        e['introduction'],
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.width * 22,
                                                          color:
                                                              Color(0xff666666),
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              true,
                                                          builder: (BuildContext
                                                              context) {
                                                            return ShowDialog(
                                                                child: Center(
                                                              child: Container(
                                                                height:
                                                                    size.width *
                                                                        500,
                                                                width:
                                                                    size.width *
                                                                        690,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(size.width *
                                                                            10))),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          size.width *
                                                                              20,
                                                                      vertical:
                                                                          size.width *
                                                                              10),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Spacer(),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              size: size.width * 40,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        e['title'],
                                                                        style: TextStyle(
                                                                            fontSize: size.width *
                                                                                36,
                                                                            color:
                                                                                Color(0xff0059FF),
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            size.width *
                                                                                30,
                                                                      ),
                                                                      Text(
                                                                        e['introduction']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: size.width *
                                                                                30,
                                                                            color:
                                                                                Color(0xff9D9D9D)),
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
                                                          color:
                                                              Color(0xff3869FC),
                                                          fontSize:
                                                              size.width * 24),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // SizedBox(
                                              //   height: size.width * 20,
                                              // ),
                                              // Row(
                                              //   children: [
                                              //     Image.asset(
                                              //   'assets/images/icon_edu_star.png',
                                              //   width: size.width * 30,
                                              //   height: size.width * 30,
                                              // ),
                                              // SizedBox(
                                              //   width: size.width * 10,
                                              // ),
                                              // Text(
                                              //       (3.3).toString() + '分',
                                              //       style: TextStyle(
                                              //         color: Color(0xff999999),
                                              //         fontSize: size.width * 22,
                                              //       ),
                                              //     )
                                              //   ],
                                              // )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList()),
                        SizedBox(
                          height: size.width * 10,
                        ),
                      ],
                    )),
              ],
            ),
            show));
  }
}
