import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/pages/home.dart';
import 'package:enterprise/pages/home/education/___eduAddTextBook.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:provider/provider.dart';

class EducationOverview extends StatefulWidget {
  @override
  _EducationOverviewState createState() => _EducationOverviewState();
}

class _EducationOverviewState extends State<EducationOverview>
    with TickerProviderStateMixin {
  bool show = false;
  int eduPermission = 1; // 个人权限  不等于1部门权限

  @override
  void initState() {
    super.initState();
    selectDate = DateTime.now();

    // 获取权限列表
    _getPermissionDropList();
    // 三个卡片数据
    _getOverview();

    // 教育培训达标情况
    _getQualificationList();
    // 年度总体评估
    _getOverallAssessment();

    // 学习教材
    _getStatisticsLearningMaterials();

    // 个人培训考核排名
    _getMyExamRanking();
    // 培训考核排名
    _getExamRanking();
    // 培训完成总学时排名
    _getLearnRanking();

    Future.delayed(Duration(milliseconds: 1000), () {
      show = true;
      setState(() {});
    });
  }

  List myExamRanking = [];

  _getMyExamRanking() {
    myDio
        .request(
      type: "get",
      url: Interface.getMyExamRanking,
    )
        .then((value) {
      if (value is List) {
        myExamRanking = value;
      }
      setState(() {});
    });
  }

  _getQualificationList() {
    myDio.request(
        type: "get",
        url: Interface.getQualificationList,
        queryParameters: {'path': permissionPath}).then((value) {
      if (value is List) {
        standardsCaseTabs = value;
        _tabController =
            TabController(vsync: this, length: standardsCaseTabs.length);
        _tabController.addListener(() {
          setState(() {});
        });
      }
      setState(() {});
    });
  }

  List standardsCaseTabs = [];
  TabController _tabController;

  double overallRating = 0.0;
  double passRate = 0.0;
  int planProcessingStatistics = 0;
  _getOverview() {
    myDio.request(
        type: "get",
        url: Interface.getOverview,
        queryParameters: {'path': permissionPath}).then((value) {
      if (value is Map) {
        overallRating = value['overallRating'];
        passRate = value['passRate'];
        planProcessingStatistics = value['planProcessingStatistics'];
      }
      setState(() {});
    });
  }

  List<MutipleXAxisSturct> statisticsLearningMaterials = [];

  _getStatisticsLearningMaterials() {
    myDio
        .request(type: "get", url: Interface.getStatisticsLearningMaterials)
        .then((value) {
      if (value is List) {
        statisticsLearningMaterials.clear();
        for (int i = 0; i < value.length; i++) {
          statisticsLearningMaterials.add(
            MutipleXAxisSturct(
                names: value[i]['name'],
                color: [Color(0xff31B2FF)],
                nums: [value[i]['num'] * 1.0]),
          );
        }
      }
      setState(() {});
    });
  }

  int type = 1;
  String date = '';

  Map overallAssessment = {
    "avgClassHours": 0, // 平均课时
    "haveParticipatedList": [],
    "checkInRate": 0, // 平均实时率
    "planNum": 0, // 培训计划数
    "notInvolvedNum": 0, // 未计划培训人数
    "haveParticipatedNum": 0, // 已计划培训人数
    "notInvolvedList": [],
    "totalPeopleNum": 0, // 总人数
    "totalAvgScore": 0.0, // 考核平均分
  };

  _getOverallAssessment() {
    myDio.request(
        type: "get",
        url: Interface.getOverallAssessment,
        queryParameters: {
          'isYear': planType,
          'type': type,
          'path': permissionPath,
          'date': selectDate.toString().substring(0, 4),
        }).then((value) {
      if (value is Map) {
        overallAssessment = value;
      }
      setState(() {});
    });
  }

  List dropList = [
    {
      'title': '全部培训',
      'data': [
        {
          'name': '线上培训',
        },
        {
          'name': '现场培训',
        },
        {
          'name': '全部培训',
        },
      ],
      'value': '',
      'saveTitle': '全部培训'
    },
  ];

  List dropList1 = [
    {
      'title': '年度培训',
      'data': [
        {
          'name': '普通培训',
        },
        {
          'name': '年度培训',
        },
      ],
      'value': '',
      'saveTitle': '年度培训'
    },
  ];

  List permissionDropList = [
    {
      'title': '个人',
      'data': [
        {'name': '个人', 'id': 0, 'path': ''},
        {'name': '全公司', 'id': 1, 'path': '全公司'},
        {'name': '部门1', 'id': 2, 'path': '部门1'},
        {'name': '部门2', 'id': 3, 'path': '部门2'},
        {'name': '部门3', 'id': 4, 'path': '部门3'},
        {'name': '部门4', 'id': 5, 'path': '部门4'},
      ],
      'value': '',
      'saveTitle': '个人'
    },
  ];

  _getPermissionDropList() {
    myDio.request(type: "get", url: Interface.getJurisdiction).then((value) {
      if (value is List) {
        permissionDropList[0]['data'] = value;
      }
      setState(() {});
    });
  }

  Widget _getWidget(int type) {
    switch (type) {
      case 1: // 全部培训
        return Container(
          width: size.width * 180,
        );
        break;
      case 2: // 线上培训  考核平均分
        return Column(
          children: [
            Text(
              '考核平均分',
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: size.width * 26,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.width * 10,
            ),
            Row(
              children: [
                Container(
                  width: size.width * 84,
                  height: size.width * 68,
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/images/kaohepingjunfen@2x.png',
                    height: size.width * 60,
                    width: size.width * 60,
                  ),
                ),
                SizedBox(
                  width: size.width * 10,
                ),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Color(0xff7DEFF6),
                          fontWeight: FontWeight.bold),
                      children: <InlineSpan>[
                        TextSpan(
                            text: overallAssessment['totalAvgScore'] == null
                                ? '0'
                                : overallAssessment['totalAvgScore']
                                    .toStringAsFixed(1),
                            style: TextStyle(fontSize: size.width * 28)),
                        TextSpan(
                            text: '分',
                            style: TextStyle(fontSize: size.width * 14)),
                      ]),
                ),
              ],
            )
          ],
        );
        break;
      case 3: // 线下培训  平均实到率
        return GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, "/home/education/eduSponsorPlan",
            //     arguments: {'date': date, 'type': 1});
          },
          child: Column(
            children: [
              Text(
                '平均实到率',
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: size.width * 26,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.width * 10,
              ),
              Row(
                children: [
                  Stack(children: [
                    Container(
                      width: size.width * 84,
                      height: size.width * 68,
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/images/shidaolv@2x.png',
                        height: size.width * 60,
                        width: size.width * 60,
                      ),
                    ),
                    // Positioned(
                    //     top: 0,
                    //     right: 0,
                    //     child: Container(
                    //       height: size.width * 18,
                    //       width: size.width * 50,
                    //       decoration: BoxDecoration(
                    //           color: Color(0xff7DEFF6),
                    //           borderRadius: BorderRadius.all(
                    //               Radius.circular(size.width * 2))),
                    //       alignment: Alignment.center,
                    //       child: Text(
                    //         '可点击',
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: size.width * 12,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ))
                  ]),
                  SizedBox(
                    width: size.width * 10,
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Color(0xff7DEFF6),
                            fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                              text: overallAssessment['checkInRate'] == null
                                  ? '0'
                                  : (overallAssessment['checkInRate'] * 100).toString().length >= 4 ? (overallAssessment['checkInRate'] * 100).toString().substring(0, 4) : (overallAssessment['checkInRate'] * 100).toString(),
                              style: TextStyle(fontSize: size.width * 28)),
                          TextSpan(
                              text: '%',
                              style: TextStyle(fontSize: size.width * 14)),
                        ]),
                  ),
                ],
              )
            ],
          ),
        );
        break;
      default:
        return Container();
    }
  }

  List titleBar2 = [
    {
      "title": "培训考核平均分排名",
    },
    {
      "title": "培训完成总学时排名",
    },
  ];

  int choosed1 = 0;
  int choosed2 = 0;
  dynamic titleBarQueryParameters1;
  dynamic titleBarQueryParameters2;
  Counter _counter2 = Provider.of(myContext);

  _getLearnRanking() {
    myDio.request(type: "get", url: Interface.getLearnRanking).then((value) {
      if (value is List) {
        periodRankingData = value;
      }
      setState(() {});
    });
  }

  List periodRankingData = [];

  _getExamRanking() {
    myDio.request(type: "get", url: Interface.getExamRanking).then((value) {
      if (value is List) {
        gPARankingData = value;
      }
      setState(() {});
    });
  }

  List gPARankingData = [];

  _getImage(int index) {
    switch (index) {
      case 0:
        return 'assets/images/rank1@2x.png';
        break;
      case 1:
        return 'assets/images/rank2@2x.png';
        break;
      case 2:
        return 'assets/images/rank3@2x.png';
        break;
      default:
    }
  }

  int permission = 1;

  DateTime selectDate;

  int planType = 1;

  String permissionPath = '';

  _showText(int type, int total, Map data) {
    if (permission == 1) {
      if (type == 1) {
        if (total == 1) {
          return Text(
            '已持证',
            style: TextStyle(
                color: Color(0xff67c666),
                fontSize: size.width * 30,
                fontWeight: FontWeight.bold),
          );
        } else {
          return Text(
            '未持证',
            style: TextStyle(
                color: Color(0xffFF6363),
                fontSize: size.width * 30,
                fontWeight: FontWeight.bold),
          );
        }
      } else {
        return Text('总学时: ' + data['total'].toString(),
                style: TextStyle(
                    color: Color(0xff656565), fontSize: size.width * 26));
      }
    } else {
      return Text('总人数:' + data['total'].toString(),
              style: TextStyle(
                  color: Color(0xff656565), fontSize: size.width * 26));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transtion(
        ListView(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // 权限筛选
                  MyPermissionDropDown(
                    permissionDropList,
                    0,
                    callbacks: (val) {
                      permissionPath = val['path'];
                      if (val['status'] == '个人') {
                        permission = 1;
                      } else {
                        permission = 2;
                      }
                      _getOverview();
                      _getQualificationList();
                      _getOverallAssessment();
                      setState(() {});
                    },
                  ),
                  // 统计卡片
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: size.width * 110,
                        width: size.width * 220,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 10,
                            vertical: size.width * 5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/1q@2x.png'),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              overallRating.toString().length > 4
                                  ? overallRating.toString().substring(0, 4) +
                                      '分'
                                  : overallRating.toString() + '分',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              '教育培训\n综合评分',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 110,
                        width: size.width * 220,
                        padding: EdgeInsets.all(size.width * 10),
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/qq@2x.png'),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (passRate * 100).toString().length > 4
                                  ? (passRate * 100)
                                          .toString()
                                          .substring(0, 4) +
                                      '%'
                                  : (passRate * 100).toString() + '%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              '安全教育培训\n计划合格率',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 110,
                        width: size.width * 220,
                        padding: EdgeInsets.all(size.width * 10),
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/plan@2x.png'),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '安全教育培训计划',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 18,
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      planProcessingStatistics.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '正在进行',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
            // 教育培训达标情况
            Container(
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: size.width * 20, left: size.width * 30),
                          child: Text('教育培训达标情况',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size.width * 28,
                                  color: Color(0xff404040),
                                  fontWeight: FontWeight.bold))),
                      Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffF7F7F7),
                        margin: EdgeInsets.only(top: size.width * 20),
                      ),
                      TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          controller: _tabController,
                          isScrollable: true,
                          tabs: standardsCaseTabs
                              .asMap()
                              .keys
                              .map((index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 10),
                                  child: Text(standardsCaseTabs[index]['name'],
                                      style: TextStyle(
                                          color: index == _tabController.index
                                              ? Color(0xff306CFD)
                                              : placeHolder,
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold))))
                              .toList()),
                      Container(
                          height: size.width * 300,
                          child: TabBarView(
                              controller: _tabController,
                              children: standardsCaseTabs
                                  .asMap()
                                  .keys
                                  .map((index) => standardsCaseTabs[index]['status'] == 0 
                                  ? Center(
                                    child: Text(
                                      '当前权限下该人员类别暂无数据'
                                    ),
                                  )
                                  : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 80,
                                            vertical: size.width * 15),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _showText(
                                                    standardsCaseTabs[index]
                                                        ['type'],
                                                    standardsCaseTabs[index]
                                                        ['total'],
                                                    standardsCaseTabs[index]),
                                                SizedBox(
                                                  height: size.width * 50,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: size.width * 18,
                                                      height: size.width * 18,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff24ABFD),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    1.0)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 20,
                                                    ),
                                                    Text(
                                                        permission == 1
                                                            ? '已学学时：'
                                                            : standardsCaseTabs[
                                                                            index][
                                                                        'type'] ==
                                                                    1
                                                                ? '持证人数：'
                                                                : '合格人数：',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff656565),
                                                            fontSize:
                                                                size.width *
                                                                    22)),
                                                    SizedBox(
                                                      width: size.width * 10,
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 90,
                                                      child: Text(
                                                        standardsCaseTabs[index]
                                                                ['completed']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: placeHolder,
                                                            fontSize:
                                                                size.width *
                                                                    22),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: size.width * 30,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: size.width * 18,
                                                      height: size.width * 18,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffeeeeee),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    1.0)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 20,
                                                    ),
                                                    Text(
                                                        permission == 1
                                                            ? '剩余学时：'
                                                            : standardsCaseTabs[
                                                                            index][
                                                                        'type'] ==
                                                                    1
                                                                ? '未持证人数：'
                                                                : '暂未合格人数：',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff656565),
                                                            fontSize:
                                                                size.width *
                                                                    22)),
                                                    SizedBox(
                                                      width: size.width * 10,
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 90,
                                                      child: Text(
                                                        standardsCaseTabs[index]
                                                                ['incomplete']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: placeHolder,
                                                            fontSize:
                                                                size.width *
                                                                    22),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * 280,
                                              child: PieChartSample2(roundUi: [
                                                XAxisSturct(
                                                    names: '已完成',
                                                    color: Color(0xff24ABFD),
                                                    nums:
                                                        standardsCaseTabs[index]
                                                                ['completed'] *
                                                            1.0),
                                                XAxisSturct(
                                                    names: '未完成',
                                                    color: Color(0xffeeeeee),
                                                    nums:
                                                        standardsCaseTabs[index]
                                                                ['incomplete'] *
                                                            1.0),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList())),
                    ])),
            SizedBox(
              height: size.width * 10,
            ),
            // 年度总体评估
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 30,
                        right: size.width * 30,
                        top: size.width * 20),
                    child: Text(
                      '年度总体评估',
                      style: TextStyle(
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff404040)),
                    ),
                  ),
                  Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffF7F7F7),
                        margin: EdgeInsets.only(top: size.width * 20),
                      ),
                  // 总体评估下拉选择
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // 培训类型
                        Expanded(
                          child: MyEduDropDown(
                            dropList1,
                            0,
                            callbacks: (val) {
                              if (val['status'] == '年度培训') {
                                planType = 1;
                              } else {
                                planType = 0;
                              }
                              _getOverallAssessment();
                              setState(() {});
                            },
                          ),
                        ),
                        // 培训方式
                        Expanded(
                          child: MyEduDropDown(
                            dropList,
                            0,
                            callbacks: (val) {
                              if (val['status'] == '全部培训') {
                                type = 1;
                              } else if (val['status'] == '线上培训') {
                                type = 2;
                              } else if (val['status'] == '现场培训') {
                                type = 3;
                              }
                              _getOverallAssessment();
                              setState(() {});
                            },
                          ),
                        ),
                        // 选择年份
                        InkWell(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                pickerTheme: DateTimePickerTheme(
                                  showTitle: true,
                                  confirm: Text('确定',
                                      style: TextStyle(color: Colors.red)),
                                  cancel: Text('取消',
                                      style: TextStyle(color: Colors.cyan)),
                                ),
                                minDateTime: DateTime.parse("1980-05-21"),
                                initialDateTime: selectDate,
                                dateFormat: "yyyy",
                                pickerMode: DateTimePickerMode.date,
                                locale: DateTimePickerLocale.zh_cn,
                                onConfirm: (dateTime, List<int> index) {
                              selectDate = dateTime;
                              _getOverallAssessment();
                              setState(() {});
                            });
                          },
                          child: Container(
                            width: size.width * 220,
                            height: size.width * 53,
                            margin: EdgeInsets.only(
                                top: 10.0,
                                left: size.width * 10.0,
                                right: size.width * 10.0),
                            padding: EdgeInsets.only(
                                left: size.width * 20.0,
                                right: size.width * 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: size.width * 1,
                                color: Color(0xffDCDCDC),
                              ),
                              borderRadius:
                                  BorderRadius.circular(size.width * 10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  selectDate != null
                                      ? selectDate.toString().substring(0, 4)
                                      : '选择年份',
                                  style: TextStyle(
                                      color: Color(0xff898989),
                                      fontSize: size.width * 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xff898989),
                                  size: size.width * 30,
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                  SizedBox(
                    height: size.width * 30,
                  ),
                  permission == 1
                      // 个人
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // 培训计划数
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, "/home/education/eduSponsorPlan",
                                    //     arguments: {'date': date, 'type': 0});
                                    // if(planType == 1){  //普通
                                    //   Navigator.pushNamed(context, "/home/education/eduMySponsorPlan");
                                    // }else if(planType == 2){  //年度
                                    //   Navigator.pushNamed(context, "/home/education/eduMyAnnualPlan");
                                    // }
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        '培训计划数',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Row(
                                        children: [
                                          Stack(children: [
                                            Container(
                                              width: size.width * 84,
                                              height: size.width * 68,
                                              alignment: Alignment.bottomLeft,
                                              child: Image.asset(
                                                'assets/images/peixunjihua_edu@2x.png',
                                                height: size.width * 60,
                                                width: size.width * 60,
                                              ),
                                            ),
                                            // Positioned(
                                            //     top: 0,
                                            //     right: 0,
                                            //     child: Container(
                                            //       height: size.width * 18,
                                            //       width: size.width * 50,
                                            //       decoration: BoxDecoration(
                                            //           color: Color(0xffFDB92B),
                                            //           borderRadius:
                                            //               BorderRadius.all(
                                            //                   Radius.circular(
                                            //                       size.width * 2))),
                                            //       alignment: Alignment.center,
                                            //       child: Text(
                                            //         '可点击',
                                            //         style: TextStyle(
                                            //             color: Colors.white,
                                            //             fontSize: size.width * 12,
                                            //             fontWeight:
                                            //                 FontWeight.bold),
                                            //       ),
                                            //     ))
                                          ]),
                                          SizedBox(
                                            width: size.width * 10,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Color(0xffFDB92B),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: overallAssessment[
                                                              'planNum']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 28)),
                                                  TextSpan(
                                                      text: '次',
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 14)),
                                                ]),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // 平均课时
                                Column(
                                  children: [
                                    Text(
                                      '平均课时',
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontSize: size.width * 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: size.width * 84,
                                          height: size.width * 68,
                                          alignment: Alignment.bottomLeft,
                                          child: Image.asset(
                                            'assets/images/pingjunkeshi_edu2@2x.png',
                                            height: size.width * 60,
                                            width: size.width * 60,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Color(0xff3376FF),
                                                  fontWeight: FontWeight.bold),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                    text: overallAssessment[
                                                            'avgClassHours']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 28)),
                                                TextSpan(
                                                    text: '课时',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 14)),
                                              ]),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                _getWidget(type)
                              ],
                            ),
                          ],
                        )
                      // 部门/企业
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // 公司总人数
                                Column(
                                  children: [
                                    Text(
                                      '公司总人数',
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontSize: size.width * 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: size.width * 84,
                                          height: size.width * 68,
                                          alignment: Alignment.bottomLeft,
                                          child: Image.asset(
                                            'assets/images/zongrenshu_edu@2x.png',
                                            height: size.width * 60,
                                            width: size.width * 60,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Color(0xff3376FF),
                                                  fontWeight: FontWeight.bold),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                    text: overallAssessment[
                                                            'totalPeopleNum']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 28)),
                                                TextSpan(
                                                    text: '人',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 14)),
                                              ]),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                // 已计划培训人数
                                GestureDetector(
                                  onTap: () {
                                    if (type == 1) {
                                      Navigator.of(context).pushNamed(
                                          '/home/education/eduHaveParticipatedList',
                                          arguments: {
                                            'haveParticipatedList':
                                                overallAssessment[
                                                    'haveParticipatedList'],
                                            'planType': planType
                                          }).then((value) {
                                        // 返回值
                                      });
                                    } else {
                                      Navigator.of(context).pushNamed(
                                          '/home/education/eduHaveParticipatedAloneList',
                                          arguments: {
                                            'haveParticipatedList':
                                                overallAssessment[
                                                    'haveParticipatedList'],
                                            'type': type, // 2: 线上  3：线下
                                            'planType': planType
                                          }).then((value) {
                                        // 返回值
                                      });
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        '已计划培训人数',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Row(
                                        children: [
                                          Stack(children: [
                                            Container(
                                              width: size.width * 84,
                                              height: size.width * 68,
                                              alignment: Alignment.bottomLeft,
                                              child: Image.asset(
                                                'assets/images/canjiapeixun_edu@2x.png',
                                                height: size.width * 60,
                                                width: size.width * 60,
                                              ),
                                            ),
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  height: size.width * 18,
                                                  width: size.width * 50,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff7DEFF6),
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              size.width * 2))),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '可点击',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ))
                                          ]),
                                          SizedBox(
                                            width: size.width * 10,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Color(0xff7DEFF6),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: overallAssessment[
                                                              'haveParticipatedNum']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 28)),
                                                  TextSpan(
                                                      text: '人',
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 14)),
                                                ]),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // 未计划培训人数
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/home/education/notInvolvedPersonList',
                                        arguments: {
                                          'notInvolvedList': overallAssessment[
                                              'notInvolvedList']
                                        }).then((value) {
                                      // 返回值
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        '未计划培训人数',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Row(
                                        children: [
                                          Stack(children: [
                                            Container(
                                              width: size.width * 84,
                                              height: size.width * 68,
                                              alignment: Alignment.bottomLeft,
                                              child: Image.asset(
                                                'assets/images/jige_edu@2x.png',
                                                height: size.width * 60,
                                                width: size.width * 60,
                                              ),
                                            ),
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  height: size.width * 18,
                                                  width: size.width * 50,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFDB92B),
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              size.width * 2))),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '可点击',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ))
                                          ]),
                                          SizedBox(
                                            width: size.width * 10,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Color(0xffFDB92B),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: overallAssessment[
                                                              'notInvolvedNum']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 28)),
                                                  TextSpan(
                                                      text: '人',
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 14)),
                                                ]),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // 培训计划数
                                GestureDetector(
                                  onTap: () {
                                    // if(planType == 1){  //普通

                                    // }else if(planType == 1){  //年度

                                    // }
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        '培训计划数',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Row(
                                        children: [
                                          Stack(children: [
                                            Container(
                                              width: size.width * 84,
                                              height: size.width * 68,
                                              alignment: Alignment.bottomLeft,
                                              child: Image.asset(
                                                'assets/images/peixunjihua_edu@2x.png',
                                                height: size.width * 60,
                                                width: size.width * 60,
                                              ),
                                            ),
                                            // Positioned(
                                            //     top: 0,
                                            //     right: 0,
                                            //     child: Container(
                                            //       height: size.width * 18,
                                            //       width: size.width * 50,
                                            //       decoration: BoxDecoration(
                                            //           color: Color(0xffFDB92B),
                                            //           borderRadius:
                                            //               BorderRadius.all(
                                            //                   Radius.circular(
                                            //                       size.width * 2))),
                                            //       alignment: Alignment.center,
                                            //       child: Text(
                                            //         '可点击',
                                            //         style: TextStyle(
                                            //             color: Colors.white,
                                            //             fontSize: size.width * 12,
                                            //             fontWeight:
                                            //                 FontWeight.bold),
                                            //       ),
                                            //     ))
                                          ]),
                                          SizedBox(
                                            width: size.width * 10,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Color(0xffFDB92B),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: overallAssessment[
                                                              'planNum']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 28)),
                                                  TextSpan(
                                                      text: '次',
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 14)),
                                                ]),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // 平均课时
                                Column(
                                  children: [
                                    Text(
                                      '平均课时',
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontSize: size.width * 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: size.width * 84,
                                          height: size.width * 68,
                                          alignment: Alignment.bottomLeft,
                                          child: Image.asset(
                                            'assets/images/pingjunkeshi_edu2@2x.png',
                                            height: size.width * 60,
                                            width: size.width * 60,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Color(0xff3376FF),
                                                  fontWeight: FontWeight.bold),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                    text: overallAssessment[
                                                            'avgClassHours']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 28)),
                                                TextSpan(
                                                    text: '课时',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 14)),
                                              ]),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                _getWidget(type)
                              ],
                            ),
                          ],
                        ),
                  SizedBox(
                    height: size.width * 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.width * 10,
            ),
            // 学习教材
            Container(
              color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: size.width * 20, left: size.width * 30),
                          child: Text('学习教材',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size.width * 28,
                                  color: Color(0xff404040),
                                  fontWeight: FontWeight.bold))),
                      Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffF7F7F7),
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                      ),
                      homeBar(
                        width: size.width * 10,
                        height: size.width * 250,
                        yAxis: 100,
                        xAxisList: statisticsLearningMaterials,
                      )
                    ])),
            SizedBox(
              height: size.width * 10,
            ),
            // 培训考核平均分排名 | 培训完成总学时排名
            permission == 1
                ? Container(
                      color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: size.width * 20, left: size.width * 30),
                          child: Text(
                              '考核情况（' + myExamRanking.length.toString() + '次）',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size.width * 28,
                                  color: Color(0xff404040),
                                  fontWeight: FontWeight.bold))),
                      Container(
                        height: size.width * 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xffF7F7F7),
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                      ),
                      Container(
                        height: size.width * 500,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              height: size.width * 66,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: size.width * 300,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '教育培训主题',
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 26),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 110,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '考核分数',
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 26),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 250,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '考核时间',
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 26),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: gPARankingData.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: myExamRanking.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: size.width * 66,
                                          color: index % 2 == 0
                                              ? Color(0xffF9F8F9)
                                              : Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.width * 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: size.width * 300,
                                                alignment: Alignment.center,
                                                child: Text(
                                                    myExamRanking[index]['name']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontSize:
                                                            size.width * 24),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              Container(
                                                width: size.width * 110,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  myExamRanking[index]['score']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize:
                                                          size.width * 24),
                                                ),
                                              ),
                                              // Container(
                                              //   width: size.width * 130,
                                              //   alignment: Alignment.center,
                                              //   child: Text(
                                              //       gPARankingData[index]['deAndPo']
                                              //                   .toString()
                                              //                   .split('、')
                                              //                   .length >
                                              //               1
                                              //           ? gPARankingData[index]
                                              //                       [
                                              //                       'deAndPo']
                                              //                   .toString()
                                              //                   .split(
                                              //                       '、')[0] +
                                              //               '...'
                                              //           : gPARankingData[index]
                                              //                   ['deAndPo']
                                              //               .toString()
                                              //               .split('、')[0],
                                              //       style: TextStyle(
                                              //           color:
                                              //               Color(0xff333333),
                                              //           fontSize:
                                              //               size.width * 24),
                                              //       maxLines: 1,
                                              //       overflow: TextOverflow.ellipsis),
                                              // ),
                                              Container(
                                                width: size.width * 250,
                                                alignment: Alignment.center,
                                                child: Text(
                                                    DateTime.fromMillisecondsSinceEpoch(
                                                            myExamRanking[index]
                                                                ['createDate'])
                                                        .toString()
                                                        .substring(0, 19),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontSize:
                                                            size.width * 24),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: Text('暂无排名'),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ]))
                : Container(
                  color: Colors.white,
                        child: Column(children: [
                      Row(
                          children: titleBar2
                              .asMap()
                              .keys
                              .map((index) => Expanded(
                                  child: CustomPaint(
                                      painter: SliverStyle(
                                          choosed2, index, titleBar2.length),
                                      child: InkWell(
                                          onTap: () {
                                            titleBarQueryParameters2 = null;
                                            _counter2.changeDateStyle(false);
                                            choosed2 = index;
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  top: size.width * 20,
                                                  bottom: size.width * 20),
                                              child: Text(
                                                  titleBar2[index]['title']
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: size.width * 28,
                                                      color: index == choosed2
                                                          ? Color(0xff306CFD)
                                                          : placeHolder,
                                                      fontWeight:
                                                          FontWeight.bold)))))))
                              .toList()),
                      choosed2 == 1
                          // 培训完成总学时排名
                          ? Container(
                              height: size.width * 500,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: size.width * 66,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: size.width * 100,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '名次',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 26),
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 100,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '学时',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 26),
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 120,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '姓名',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 26),
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 370,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '部门-职位',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 26),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: periodRankingData.isNotEmpty
                                          ? ListView.builder(
                                              itemCount:
                                                  periodRankingData.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height: size.width * 66,
                                                  color: index % 2 == 0
                                                      ? Color(0xffF9F8F9)
                                                      : Colors.white,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: size.width * 5),
                                                  child: Row(
                                                    children: [
                                                      index < 3
                                                          ? Container(
                                                              width:
                                                                  size.width *
                                                                      100,
                                                              child:
                                                                  Image.asset(
                                                                _getImage(
                                                                    index),
                                                                height:
                                                                    size.width *
                                                                        36,
                                                                width:
                                                                    size.width *
                                                                        29,
                                                              ),
                                                            )
                                                          : Container(
                                                              width:
                                                                  size.width *
                                                                      100,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                (index + 1)
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff333333),
                                                                    fontSize:
                                                                        size.width *
                                                                            24),
                                                              ),
                                                            ),
                                                      Container(
                                                        width: size.width * 100,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          periodRankingData[
                                                                      index]
                                                                  ['classHours']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff333333),
                                                              fontSize:
                                                                  size.width *
                                                                      24),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: size.width * 120,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            periodRankingData[
                                                                        index]
                                                                    ['nickname']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff333333),
                                                                fontSize:
                                                                    size.width *
                                                                        24),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                      Container(
                                                        width: size.width * 370,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          periodRankingData[index]
                                                                          [
                                                                          'deAndPo']
                                                                      .toString()
                                                                      .split(
                                                                          '、')
                                                                      .length >
                                                                  1
                                                              ? periodRankingData[index]
                                                                              [
                                                                              'deAndPo']
                                                                          .toString()
                                                                          .split(
                                                                              '、')[
                                                                      0] +
                                                                  '...'
                                                              : periodRankingData[
                                                                          index]
                                                                      [
                                                                      'deAndPo']
                                                                  .toString()
                                                                  .split(
                                                                      '、')[0],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff333333),
                                                              fontSize:
                                                                  size.width *
                                                                      24),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                          : Center(
                                              child: Text('暂无排名'),
                                            )),
                                ],
                              ),
                            )
                          // 培训考核排名
                          : Container(
                              height: size.width * 500,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: size.width * 66,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: size.width * 100,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '名次',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 26),
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 120,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '总平均分',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 26),
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 120,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '姓名',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 26),
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 350,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '部门-职位',
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 26),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: gPARankingData.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: gPARankingData.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                height: size.width * 66,
                                                color: index % 2 == 0
                                                    ? Color(0xffF9F8F9)
                                                    : Colors.white,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: size.width * 5),
                                                child: Row(
                                                  children: [
                                                    index < 3
                                                        ? Container(
                                                            width: size.width *
                                                                100,
                                                            child: Image.asset(
                                                              _getImage(index),
                                                              height:
                                                                  size.width *
                                                                      36,
                                                              width:
                                                                  size.width *
                                                                      29,
                                                            ),
                                                          )
                                                        : Container(
                                                            width: size.width *
                                                                100,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              (index + 1)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff333333),
                                                                  fontSize:
                                                                      size.width *
                                                                          24),
                                                            ),
                                                          ),
                                                    Container(
                                                      width: size.width * 120,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        gPARankingData[index][
                                                                        'avgScore']
                                                                    .toString()
                                                                    .length >
                                                                4
                                                            ? gPARankingData[
                                                                        index]
                                                                    ['avgScore']
                                                                .toString()
                                                                .substring(0, 4)
                                                            : gPARankingData[
                                                                        index]
                                                                    ['avgScore']
                                                                .toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff333333),
                                                            fontSize:
                                                                size.width *
                                                                    24),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width * 120,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          gPARankingData[index]
                                                                  ['nickname']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff333333),
                                                              fontSize:
                                                                  size.width *
                                                                      24),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    Container(
                                                      width: size.width * 350,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          gPARankingData[index]['deAndPo']
                                                                      .toString()
                                                                      .split(
                                                                          '、')
                                                                      .length >
                                                                  1
                                                              ? gPARankingData[index]['deAndPo'].toString().split('、')[0] +
                                                                  '...'
                                                              : gPARankingData[index]['deAndPo']
                                                                  .toString()
                                                                  .split(
                                                                      '、')[0],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff333333),
                                                              fontSize:
                                                                  size.width *
                                                                      24),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                        : Center(
                                            child: Text('暂无排名'),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                    ])),
          ],
        ),
        show);
  }

  Widget homeBar(
      {height = 250.0,
      width = 30.0,
      @required double yAxis,
      @required List<MutipleXAxisSturct> xAxisList,
      List<Color> color,
      double yWidth = 20.0}) {
    List yAxisList = [];
    int xNum = (yAxis / 4).ceil().toInt();
    for (var i = 4; i > -1; i--) {
      yAxisList.add(xNum * i);
    }
    return HomeEducationBar(
        width: width,
        height: height,
        yAxis: yAxis,
        xAxisList: xAxisList,
        color: color,
        yWidth: yWidth,
        yAxisList: yAxisList);
  }
}

class MyPermissionDropDown extends StatefulWidget {
  const MyPermissionDropDown(this.list, this.index, {Key key, this.callbacks})
      : super(key: key);
  final int index;
  final List list;
  final callbacks;
  @override
  _MyPermissionDropDownState createState() => _MyPermissionDropDownState();
}

class _MyPermissionDropDownState extends State<MyPermissionDropDown> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.list.asMap().keys.map((i) {
      return Expanded(
          child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              // elevation: 0,
              builder: (_) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 200,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                                widget.list[i]['data'].map<Widget>((_ele) {
                              Color _juegeColor() {
                                Color _color = widget.list[i]['value'] == '' &&
                                        _ele['name'] == '查看全部'
                                    ? themeColor
                                    : widget.list[i]['value'] == _ele['name']
                                        ? themeColor
                                        : Colors.white;
                                return _color;
                              }

                              Color _conColors = _juegeColor();
                              return GestureDetector(
                                onTap: () {
                                  widget.list[i]['value'] = _ele['name'];
                                  if (_ele['name'] == '查看全部') {
                                    widget.list[i]['title'] =
                                        widget.list[i]['saveTitle'];
                                  } else {
                                    widget.list[i]['title'] = _ele['name'];
                                  }
                                  widget.callbacks({
                                    'status': _ele['name'],
                                    'id': _ele['id'],
                                    'path': _ele['path'],
                                  });
                                  setState(() {});
                                  // widget.getDataList();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 32),
                                  decoration: BoxDecoration(
                                      color: _conColors,
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: underColor))),
                                  child: Center(
                                    child: Text(
                                      _ele['name'],
                                      style: TextStyle(
                                          fontSize: size.width * 30,
                                          color: _conColors.toString() ==
                                                  'Color(0xff6ea3f9)'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Expanded(child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ))
                    ],
                  ),
                );
              });
        },
        child: Container(
          width: size.width * 220,
          height: size.width * 80,
          margin: EdgeInsets.only(
              top: 10.0, left: size.width * 20.0, right: size.width * 20.0),
          padding: EdgeInsets.only(
              left: size.width * 20.0, right: size.width * 10.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: size.width * 1,
              color: Color(0xffDCDCDC),
            ),
            borderRadius: BorderRadius.circular(size.width * 26.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.list[i]['title'].toString(),
                style: TextStyle(
                    color: Color(0xff898989),
                    fontSize: size.width * 28,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff898989),
                size: size.width * 40,
              ),
            ],
          ),
        ),
      ));
    }).toList());
  }
}
