import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/education/My/_examinePersonList.dart';
import 'package:enterprise/pages/home/education/My/train.dart';
import 'package:enterprise/pages/home/education/_eduMy.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduMySponsorPlan extends StatefulWidget {
  @override
  _EduMySponsorPlanState createState() => _EduMySponsorPlanState();
}

class _EduMySponsorPlanState extends State<EduMySponsorPlan> {
  PageController _controller;

  List workData = [
    {
      "index": 0,
      "title": "在线计划",
      "descript": "选择需要使用的",
      "img": "assets/images/look.png",
      "isClick": false
    },
    {
      "index": 1,
      "title": "现场计划",
      "descript": "选择需要使用的",
      "img": "assets/images/apply.png",
      "isClick": true
    },
  ];

  int choosed = 0;
  int oldPage = 0;

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
    if (item['title'] == '在线计划')
      _widget = MyStudyPlan();
    else if (item['title'] == '现场计划') _widget = MyOfflinePlan();
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
    );
  }
}

class MyStudyPlan extends StatefulWidget {
  @override
  _MyStudyPlanState createState() => _MyStudyPlanState();
}

class _MyStudyPlanState extends State<MyStudyPlan> {
  ThrowFunc _throwFunc = new ThrowFunc();
  int type = 2;
  Map queryParameters = {'type': 2};
  List dropList = [
    {
      'title': '我参与的',
      'data': [
        {
          'name': '我发起的',
        },
        {
          'name': '我参与的',
        },
      ],
      'value': '',
      'saveTitle': '我参与的'
    },
  ];
  List dropList1 = [
    {'title': '选择部门', 'data': [], 'value': '', 'saveTitle': '查看全部'},
  ];

  @override
  void initState() {
    super.initState();
    _getMyDepartment();
  }

  _getMyDepartment() {
    myDio.request(
        type: "get",
        url: Interface.getPlanMyDepartment,
        queryParameters: {'type': type}).then((value) {
      if (value is List) {
        dropList1[0]['data'] = value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 培训类型
              Expanded(
                child: DropDown(
                  dropList,
                  0,
                  callbacks: (val) {
                    print(val);
                    if (val['status'] == '我发起的') {
                      type = 1;
                    } else {
                      type = 2;
                    }
                    queryParameters = {'type': type};
                    dropList1 = [
                      {
                        'title': '选择部门',
                        'data': [],
                        'value': '',
                        'saveTitle': '查看全部'
                      },
                    ];
                    _getMyDepartment();
                    _throwFunc.run(argument: queryParameters);
                    setState(() {});
                  },
                ),
              ),
              // 培训方式
              Expanded(
                child: TrainDropDown(
                  dropList1,
                  0,
                  callbacks: (val) {
                    if (val['sponsorDepartment'] == '查看全部') {
                      queryParameters = {'type': type};
                    } else {
                      queryParameters = {
                        'type': type,
                        'departmentId': val['departmentId']
                      };
                    }
                    _throwFunc.run(argument: queryParameters);
                  },
                ),
              ),
            ]),
        Expanded(
            child: MyRefres(
                child: (index, list) => EduMyStylePlan(data: list[index]),
                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, "/home/education/styduPlanDetail",
                //         arguments: {'planId': list[index]['id']});
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //         horizontal: size.width * 20, vertical: size.width * 10),
                //     child: Container(
                //       padding: EdgeInsets.symmetric(
                //           vertical: size.width * 20, horizontal: size.width * 30),
                //       decoration: BoxDecoration(
                //         borderRadius:
                //             BorderRadius.all(Radius.circular(size.width * 20)),
                //         gradient: LinearGradient(
                //           begin: Alignment.centerLeft,
                //           end: Alignment.centerRight,
                //           colors: [
                //             Color(0xffF9BE64),
                //             Color(0xffF58635),
                //           ],
                //         ),
                //       ),
                //       child: Row(
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 list[index]['name'],
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: size.width * 30,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               Text(
                //                 list[index]['isParticipateAll'] == 1 ? '全厂' : '参训部门：${list[index]['num']}个部门',
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: size.width * 28,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               Text(
                //                 '计划发起时间：${DateTime.fromMillisecondsSinceEpoch(list[index]['createDate']).toString().substring(0, 10)}',
                //                 style: TextStyle(
                //                     color: Colors.white, fontSize: size.width * 22),
                //               ),
                //               Text(
                //                 '计划结束时间：${DateTime.fromMillisecondsSinceEpoch(list[index]['studyDeadline']).toString().substring(0, 10)}',
                //                 style: TextStyle(
                //                     color: Colors.white, fontSize: size.width * 22),
                //               )
                //             ],
                //           ),
                //           Spacer(),
                //           Container(
                //             height: size.width * 47,
                //             width: size.width * 132,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.all(
                //                   Radius.circular(size.width * 23)),
                //             ),
                //             alignment: Alignment.center,
                //             child: Text(
                //               DateTime.now().millisecondsSinceEpoch <
                //                       list[index]['studyDeadline']
                //                   ? '进行中'
                //                   : '台账',
                //               style: TextStyle(
                //                   color: Color(0xffF58635),
                //                   fontSize: size.width * 22),
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // data: data,
                // type: '风险不受控',
                listParam: "records",
                throwFunc: _throwFunc,
                page: true,
                url: Interface.getEducationTrainingPlanSponsorList,
                queryParameters: queryParameters,
                method: 'get'))
      ],
    ),
    );
  }
}

class MyOfflinePlan extends StatefulWidget {
  @override
  _MyOfflinePlanState createState() => _MyOfflinePlanState();
}

class _MyOfflinePlanState extends State<MyOfflinePlan> {
  ThrowFunc _throwFunc = new ThrowFunc();
  int type = 2;
  Map queryParameters = {'type': 2};
  List dropList = [
    {
      'title': '我参与的',
      'data': [
        {
          'name': '我发起的',
        },
        {
          'name': '我参与的',
        },
      ],
      'value': '',
      'saveTitle': '我参与的'
    },
  ];
  List dropList1 = [
    {'title': '选择部门', 'data': [], 'value': '', 'saveTitle': '查看全部'},
  ];

    @override
  void initState() {
    super.initState();
    _getMyDepartment();
  }

  _getMyDepartment() {
    myDio.request(
        type: "get",
        url: Interface.getMyDepartmentOfflineApp,
        queryParameters: {'type': type}).then((value) {
      if (value is List) {
        dropList1[0]['data'] = value;
      }
      setState(() {});
    });
  }

  _getState(int startDate, int endDate){
    if(DateTime.now().millisecondsSinceEpoch < startDate){
      return '未开始';
    }else if(startDate <= DateTime.now().millisecondsSinceEpoch && DateTime.now().millisecondsSinceEpoch < endDate){
      return '进行中';
    }else{
      return '台账';
    }
  }

  _getStateColor(int startDate, int endDate){
    if(DateTime.now().millisecondsSinceEpoch < startDate){
      return Color(0xff999999);
    }else if(startDate <= DateTime.now().millisecondsSinceEpoch && DateTime.now().millisecondsSinceEpoch < endDate){
      return Color(0xffFF6600);
    }else{
      return Color(0xff236DFF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 培训类型
              Expanded(
                child: DropDown(
                  dropList,
                  0,
                  callbacks: (val) {
                    print(val);
                    if (val['status'] == '我发起的') {
                      type = 1;
                    } else {
                      type = 2;
                    }
                    queryParameters = {'type': type};
                    dropList1 = [
                      {
                        'title': '选择部门',
                        'data': [],
                        'value': '',
                        'saveTitle': '查看全部'
                      },
                    ];
                    _getMyDepartment();
                    _throwFunc.run(argument: queryParameters);
                    setState(() {});
                  },
                ),
              ),
              // 培训方式
              Expanded(
                child: TrainDropDown(
                  dropList1,
                  0,
                  callbacks: (val) {
                    if (val['sponsorDepartment'] == '查看全部') {
                      queryParameters = {'type': type};
                    } else {
                      queryParameters = {
                        'type': type,
                        'departmentId': val['departmentId']
                      };
                    }
                    _throwFunc.run(argument: queryParameters);
                  },
                ),
              ),
            ]),
        Expanded(
            child: MyRefres(
                child: (index, list) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, "/home/education/styduOfflinePlanDetail",
                          arguments: {
                            'planId': list[index]['id'],
                            'title': list[index]['title']
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 20,
                          vertical: size.width * 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 20)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff0059FF).withOpacity(0.1),
                                blurRadius: 1.0,
                                spreadRadius: 1.0)
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * 20,
                                horizontal: size.width * 30),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/icon_edu_my_xuexi_jihua.png',
                                  height: size.width * 70,
                                  width: size.width * 70,
                                ),
                                SizedBox(
                                  width: size.width * 15,
                                ),
                                Container(
                                  width: size.width * 420,
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[index]['title'],
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 22),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: '培训地点：',
                                                style: TextStyle(
                                                  color: Color(0xff666666),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            TextSpan(
                                                text: list[index]
                                                        ['trainingLocation']
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Color(0xff236DFF),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 22),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: '课时：',
                                                style: TextStyle(
                                                  color: Color(0xff666666),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            TextSpan(
                                                text: list[index]['classHours']
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Color(0xff236DFF),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ]),
                                    ),
                                  ],
                                ),
                                ),
                                Spacer(),
                                Text(
                                  _getState(list[index]['startDate'], list[index]['endDate']),
                                  style: TextStyle(
                                      color: _getStateColor(list[index]['startDate'], list[index]['endDate']),
                                      fontSize: size.width * 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Color(0xffE8E8E8),
                            height: size.width * 1,
                            width: double.infinity,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 15,
                                  horizontal: size.width * 30),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: size.width * 30,
                                            width: size.width * 30,
                                            decoration: BoxDecoration(
                                              color: Color(0xffeef0fd),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '起',
                                              style: TextStyle(
                                                  color: Color(0xff5A68E7),
                                                  fontSize: size.width * 18),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 10,
                                          ),
                                          Text(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    list[index]['startDate'])
                                                .toString()
                                                .substring(0, 19),
                                            style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: size.width * 22),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: size.width * 30,
                                            width: size.width * 30,
                                            decoration: BoxDecoration(
                                              color: Color(0xffeef0fd),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '止',
                                              style: TextStyle(
                                                  color: Color(0xff5A68E7),
                                                  fontSize: size.width * 18),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 10,
                                          ),
                                          Text(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    list[index]['endDate'])
                                                .toString()
                                                .substring(0, 19),
                                            style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: size.width * 22),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            '学习计划内容：${list[index]['content']}',
                                            style: TextStyle(
                                                color: Color(0xff8E8D92),
                                                fontSize: size.width * 22,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(
                                        width: size.width * 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
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
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    size.width *
                                                                        10))),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: size
                                                                      .width *
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
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Icon(
                                                                  Icons.clear,
                                                                  size:
                                                                      size.width *
                                                                          40,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Text(
                                                            list[index]
                                                                ['title'],
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.width *
                                                                        36,
                                                                color: Color(
                                                                    0xff0059FF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 30,
                                                          ),
                                                          Text(
                                                            list[index]
                                                                    ['content']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.width *
                                                                        30,
                                                                color: Color(
                                                                    0xff9D9D9D)),
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
                                              color: Color(0xff3869FC),
                                              fontSize: size.width * 24),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )),
                listParam: "records",
                    page: true,
                    throwFunc: _throwFunc,
                    url: Interface.getEducationTrainingOfflinePlanSponsorList,
                    queryParameters: queryParameters,
                    method: 'get'))
      ],
    ),
    );
  }
}
