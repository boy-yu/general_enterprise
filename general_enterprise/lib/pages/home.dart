import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int chooseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Container(
          height: size.width * 72,
          width: size.width * 408,
          decoration: BoxDecoration(
              color: Color(0xff1E62EB),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 46))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  chooseIndex = 0;
                  setState(() {});
                },
                child: Container(
                  height: size.width * 64,
                  width: size.width * 200,
                  alignment: Alignment.center,
                  decoration: chooseIndex == 0
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 46)))
                      : null,
                  child: Text(
                    '总览',
                    style: TextStyle(
                        fontSize: size.width * 28,
                        color:
                            chooseIndex == 0 ? Color(0xff3074FF) : Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  chooseIndex = 1;
                  setState(() {});
                },
                child: Container(
                  height: size.width * 64,
                  width: size.width * 200,
                  alignment: Alignment.center,
                  decoration: chooseIndex == 1
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 46)))
                      : null,
                  child: Text(
                    '我的',
                    style: TextStyle(
                        fontSize: size.width * 28,
                        color:
                            chooseIndex == 1 ? Color(0xff3074FF) : Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        child: chooseIndex == 0 ? Overview() : MyOverview());
  }
}

class Overview extends StatefulWidget {
  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  // 初始风险数据数组
  List<PieSturct> initialPie = [];
  // 剩余风险数据数组
  List<PieSturct> residuePie = [];
  // 区域分布数据
  List<MutipleXAxisSturct> xAxisList = [];
  double maxYAxis = 0.0;
  // 异常处置数据数组
  List<PieSturct> abnormalPie = [];
  // 结果实时数据数组
  List<PieSturct> currentPie = [];

  @override
  void initState() {
    super.initState();
    _getRiskData();
    _getAreaDistribution();
    _getAbnormalData();
    _getCurrentPieData();
  }

  // 获取风险管控统计数据
  _getRiskData() {
    initialPie.add(PieSturct(color: Color(0xffF56271), nums: 5, title: '重大风险'));
    initialPie.add(PieSturct(color: Color(0xffFF9900), nums: 5, title: '较大风险'));
    initialPie
        .add(PieSturct(color: Color(0xffFFCA0E), nums: 10, title: '一般风险'));
    initialPie.add(PieSturct(color: Color(0xff2276FC), nums: 3, title: '低风险'));
    residuePie
        .add(PieSturct(color: Color(0xffF56271), nums: 12, title: '重大风险'));
    residuePie.add(PieSturct(color: Color(0xffFF9900), nums: 2, title: '较大风险'));
    residuePie.add(PieSturct(color: Color(0xffFFCA0E), nums: 5, title: '一般风险'));
    residuePie.add(PieSturct(color: Color(0xff2276FC), nums: 3, title: '低风险'));
  }

  // 获取区域分布统计数据
  _getAreaDistribution() {
    xAxisList = [
      MutipleXAxisSturct(names: "LNG厂区", nums: [41.0, 30.0, 50.0, 24.0]),
      MutipleXAxisSturct(names: "循环水站", nums: [41.0, 30.0, 50.0, 20.0]),
      MutipleXAxisSturct(names: "天然气预处理区", nums: [41.0, 30.0, 50.0, 20.0]),
      MutipleXAxisSturct(names: "液化工序", nums: [41.0, 30.0, 100.0, 24.0]),
    ];
    maxYAxis = 100.0 + 25.0;
  }

  // 获取排查、巡检异常处置情况
  _getAbnormalData() {
    abnormalPie
        .add(PieSturct(color: Color(0xff2276FC), nums: 123, title: '待确认'));
    abnormalPie
        .add(PieSturct(color: Color(0xffF56271), nums: 30, title: '待整改'));
    abnormalPie
        .add(PieSturct(color: Color(0xffFFCA0E), nums: 49, title: '待审批'));
  }

  // 排查、巡检结果实时统计
  _getCurrentPieData() {
    currentPie
        .add(PieSturct(color: Color(0xffF56271), nums: 130, title: '重大隐患'));
    currentPie
        .add(PieSturct(color: Color(0xffFFCA0E), nums: 49, title: '一般隐患'));
  }

  // 管控分类数据数组
  List data = [
    {'name': '工程技术', 'num': 123},
    {'name': '维护保养', 'num': 123},
    {'name': '操作行为', 'num': 123},
    {'name': '异常措施', 'num': 123},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF8FAFF),
      child: ListView(
        children: [
          SizedBox(
            height: size.width * 34,
          ),
          // 双控运行状况 饼状图
          Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 32),
              padding: EdgeInsets.all(size.width * 32),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 20))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        color: Color(0xff3074FF),
                        height: size.width * 28,
                        width: size.width * 8,
                      ),
                      SizedBox(
                        width: size.width * 16,
                      ),
                      Text(
                        "风险管控",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.width * 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomEchart().pie(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '10',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '初始风险',
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          width: 100,
                          radius: 40,
                          strokeWidth: 10,
                          state: false,
                          data: initialPie),
                      SizedBox(
                        width: size.width * 10,
                      ),
                      data.isNotEmpty
                          ? CustomPaint(
                              painter: DoubleControlPaint(),
                              child: Container(
                                  margin:
                                      EdgeInsets.only(right: size.width * 60),
                                  width: size.width * 160,
                                  child: ListView.builder(
                                      itemCount: data.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Container(
                                              height: size.width * 35,
                                              width: size.width * 160,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff3074FF)
                                                      .withOpacity(0.1)),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * 5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    data[index]['name']
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff3074FF),
                                                        fontSize:
                                                            size.width * 20),
                                                  )),
                                                  Text(
                                                    data[index]['num']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff3074FF),
                                                        fontSize:
                                                            size.width * 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.width * 1,
                                            ),
                                          ],
                                        );
                                      })))
                          : Container(),
                      SizedBox(
                        width: size.width * 10,
                      ),
                      CustomEchart().pie(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '20',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '剩余风险',
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          width: 100,
                          radius: 40,
                          state: false,
                          strokeWidth: 10,
                          data: residuePie),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xffF56271),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 8,
                          ),
                          Text(
                            "重大风险",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xffFF9900),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 8,
                          ),
                          Text(
                            "较大风险",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xffFFCA0E),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 8,
                          ),
                          Text(
                            "一般风险",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xff2276FC),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 8,
                          ),
                          Text(
                            "低风险",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 30,
                  ),
                ],
              )),
          SizedBox(
            height: size.width * 32,
          ),
          // 区域分布
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 32),
            padding: EdgeInsets.all(size.width * 32),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 20))),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      color: Color(0xff3074FF),
                      height: size.width * 28,
                      width: size.width * 8,
                    ),
                    SizedBox(
                      width: size.width * 16,
                    ),
                    Text(
                      "区域分布",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 32,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 40,
                ),
                CustomEchart()
                    .mutipleBar(xAxisList: xAxisList, yAxis: maxYAxis, color: [
                  Color(0xffF56271),
                  Color(0xffFF9900),
                  Color(0xffFFCA0E),
                  Color(0xff2276FC),
                ]),
                SizedBox(
                  height: size.width * 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 50,
                    ),
                    Container(
                      width: size.width * 300,
                      child: Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xffF56271),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 8,
                          ),
                          Text(
                            "重大风险总计(12)",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.width * 20,
                      width: size.width * 20,
                      decoration: BoxDecoration(
                          color: Color(0xffFF9900),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 4))),
                    ),
                    SizedBox(
                      width: size.width * 8,
                    ),
                    Text(
                      "较大风险总计(31)",
                      style: TextStyle(
                          color: Color(0xff7F8A9C), fontSize: size.width * 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 50,
                    ),
                    Container(
                      width: size.width * 300,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: size.width * 20,
                                width: size.width * 20,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFCA0E),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 4))),
                              ),
                              SizedBox(
                                width: size.width * 8,
                              ),
                              Text(
                                "一般风险总计(47)",
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.width * 20,
                      width: size.width * 20,
                      decoration: BoxDecoration(
                          color: Color(0xff2276FC),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 4))),
                    ),
                    SizedBox(
                      width: size.width * 8,
                    ),
                    Text(
                      "低风险总计(129)",
                      style: TextStyle(
                          color: Color(0xff7F8A9C), fontSize: size.width * 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 30,
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 32,
          ),
          // 排查、巡检异常处置情况
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 32),
            padding: EdgeInsets.all(size.width * 32),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 20))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Container(
                    color: Color(0xff3074FF),
                    height: size.width * 28,
                    width: size.width * 8,
                  ),
                  SizedBox(
                    width: size.width * 16,
                  ),
                  Text(
                    "排查、巡检异常处置情况",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 32,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: size.width * 60,
              ),
              Row(
                children: [
                  CustomEchart().pie(
                      width: size.width * 220,
                      radius: size.width * 90,
                      strokeWidth: size.width * 25,
                      state: false,
                      data: abnormalPie),
                  SizedBox(
                    width: size.width * 80,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xff2276FC),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 20,
                          ),
                          Text(
                            "待确认   123",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.width * 24,
                      ),
                      Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xffF56271),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 20,
                          ),
                          Text(
                            "整改中   3",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.width * 24,
                      ),
                      Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xffFFCA0E),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 20,
                          ),
                          Text(
                            "待验收   49",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: size.width * 28,
              ),
            ]),
          ),
          SizedBox(
            height: size.width * 32,
          ),
          // 排查、巡检结果实时统计
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 32),
            padding: EdgeInsets.all(size.width * 32),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 20))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Container(
                    color: Color(0xff3074FF),
                    height: size.width * 28,
                    width: size.width * 8,
                  ),
                  SizedBox(
                    width: size.width * 16,
                  ),
                  Text(
                    "排查、巡检结果实时统计",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 32,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: size.width * 60,
              ),
              Row(
                children: [
                  CustomEchart().pie(
                      width: size.width * 220,
                      radius: size.width * 90,
                      strokeWidth: size.width * 25,
                      state: false,
                      data: currentPie),
                  SizedBox(
                    width: size.width * 80,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xffF56271),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 20,
                          ),
                          Text(
                            "重大隐患   130",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.width * 24,
                      ),
                      Row(
                        children: [
                          Container(
                            height: size.width * 20,
                            width: size.width * 20,
                            decoration: BoxDecoration(
                                color: Color(0xffFFCA0E),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 4))),
                          ),
                          SizedBox(
                            width: size.width * 20,
                          ),
                          Text(
                            "一般隐患   49",
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: size.width * 28,
              ),
            ]),
          ),
          SizedBox(
            height: size.width * 78,
          ),
        ],
      ),
    );
  }
}

class MyOverview extends StatefulWidget {
  @override
  State<MyOverview> createState() => _MyOverviewState();
}

class _MyOverviewState extends State<MyOverview> {
  List myTask = [
    {
      'icon': 'assets/images/doubleRiskProjeck/icon_home_pie.png',
      'name': '排查任务完成率',
      'num': '58'
    },
    {
      'icon': 'assets/images/doubleRiskProjeck/icon_home_report.png',
      'name': '待排查任务',
      'num': '15'
    },
    {
      'icon': 'assets/images/doubleRiskProjeck/icon_home_alarm.png',
      'name': '待整改隐患',
      'num': '15'
    },
  ];

  List unitOperationEffect = [
    {
      'name': '装置名称',
      'riskLevel': '4',
    },
    {
      'name': '装置名称装置名称装置名称',
      'riskLevel': '1',
    },
    {
      'name': '装置名称',
      'riskLevel': '2',
    },
    {
      'name': '装置名称装置名称装置名称',
      'riskLevel': '3',
    },
    {
      'name': '装置名称',
      'riskLevel': '1',
    },
    {
      'name': '装置名称装置名称装置名称装置名称',
      'riskLevel': '1',
    },
  ];

  String _getRiskLevel(String riskLevel) {
    switch (riskLevel) {
      case '1':
        return '重大风险';
        break;
      case '2':
        return '较大风险';
        break;
      case '3':
        return '一般风险';
        break;
      case '4':
        return '低风险';
        break;
      default:
        return '';
    }
  }

  List hiddenReminder = [
    {
      'troubleshootContent': '隐患排查任务',
      'dangerManageDeadline': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'dangerManageDeadline': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'dangerManageDeadline': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'dangerManageDeadline': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'dangerManageDeadline': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'dangerManageDeadline': 1652169600
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF8FAFF),
      child: ListView(
        children: [
          SizedBox(
            height: size.width * 34,
          ),
          // 我的任务
          Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 32),
              padding: EdgeInsets.all(size.width * 32),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 20))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        color: Color(0xff3074FF),
                        height: size.width * 28,
                        width: size.width * 8,
                      ),
                      SizedBox(
                        width: size.width * 16,
                      ),
                      Text(
                        "我的任务",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.width * 40,
                  ),
                  ListView.builder(
                      itemCount: myTask.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, myTaskIndex) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: size.width * 32),
                          child: Row(
                            children: [
                              // Image.asset('assets/images/doubleRiskProjeck/icon_home_pie.png')
                              Container(
                                height: size.width * 64,
                                width: size.width * 64,
                                decoration: BoxDecoration(
                                    color: Color(0xff5FD5EC),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 20))),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  myTask[myTaskIndex]['icon'],
                                  height: size.width * 36,
                                  width: size.width * 36,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 24,
                              ),
                              Text(
                                myTask[myTaskIndex]['name'],
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Text(
                                myTask[myTaskIndex]['num'],
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                myTaskIndex == 0 ? '%' : '条',
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 32,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              )),
          SizedBox(
            height: size.width * 32,
          ),
          // 单位运行效果
          Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 32),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 20))),
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 32,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 32),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              color: Color(0xff3074FF),
                              height: size.width * 28,
                              width: size.width * 8,
                            ),
                            SizedBox(
                              width: size.width * 16,
                            ),
                            Text(
                              "单位运行效果",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 32,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.width * 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: size.width * 104,
                              width: size.width * 136,
                              decoration: BoxDecoration(
                                  color: Color(0xffF56271).withOpacity(0.1),
                                  border: Border.all(
                                      width: size.width * 2,
                                      color: Color(0xffFECBD0)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 16))),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    '5',
                                    style: TextStyle(
                                        color: Color(0xffF56271),
                                        fontSize: size.width * 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '重大风险',
                                    style: TextStyle(
                                        color: Color(0xffF56271),
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: size.width * 104,
                              width: size.width * 136,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF9900).withOpacity(0.1),
                                  border: Border.all(
                                      width: size.width * 2,
                                      color: Color(0xffFEDEAE)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 16))),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    '5',
                                    style: TextStyle(
                                        color: Color(0xffFF9900),
                                        fontSize: size.width * 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '重大风险',
                                    style: TextStyle(
                                        color: Color(0xffFF9900),
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: size.width * 104,
                              width: size.width * 136,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFCA0E).withOpacity(0.1),
                                  border: Border.all(
                                      width: size.width * 2,
                                      color: Color(0xffFFEBA3)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 16))),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    '5',
                                    style: TextStyle(
                                        color: Color(0xffFFCA0E),
                                        fontSize: size.width * 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '重大风险',
                                    style: TextStyle(
                                        color: Color(0xffFFCA0E),
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: size.width * 104,
                              width: size.width * 136,
                              decoration: BoxDecoration(
                                  color: Color(0xff2276FC).withOpacity(0.1),
                                  border: Border.all(
                                      width: size.width * 2,
                                      color: Color(0xffB8D3FF)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 16))),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    '5',
                                    style: TextStyle(
                                        color: Color(0xff2276FC),
                                        fontSize: size.width * 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '低风险',
                                    style: TextStyle(
                                        color: Color(0xff2276FC),
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 40,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 100,
                          padding: EdgeInsets.only(bottom: size.width * 24),
                          alignment: Alignment.center,
                          child: Text(
                            '序号',
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: size.width * 350,
                          padding: EdgeInsets.only(bottom: size.width * 24),
                          alignment: Alignment.center,
                          child: Text(
                            '装置名称',
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: size.width * 150,
                          padding: EdgeInsets.only(bottom: size.width * 24),
                          alignment: Alignment.center,
                          child: Text(
                            '风险等级',
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: size.width * 2,
                    color: Color(0xffF2F2F2),
                  ),
                  ListView.builder(
                      itemCount: unitOperationEffect.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, unitIndex) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * 100,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.width * 24),
                                    child: Text(
                                      (unitIndex + 1).toString(),
                                      style: TextStyle(
                                          color: Color(0xff7F8A9C),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 350,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.width * 24),
                                    child: Text(
                                      unitOperationEffect[unitIndex]['name'],
                                      style: TextStyle(
                                          color: Color(0xff7F8A9C),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 150,
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.width * 24),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _getRiskLevel(
                                          unitOperationEffect[unitIndex]
                                              ['riskLevel']),
                                      style: TextStyle(
                                          color: Color(0xff7F8A9C),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            unitIndex != unitOperationEffect.length - 1
                                ? Container(
                                    width: double.infinity,
                                    height: size.width * 2,
                                    color: Color(0xffF2F2F2),
                                  )
                                : Container(),
                          ],
                        );
                      }),
                  SizedBox(
                    height: size.width * 16,
                  )
                ],
              )),
          SizedBox(
            height: size.width * 32,
          ),
          // 隐患整改提醒
          Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 32),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 20))),
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 32,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 32),
                    child: Row(
                      children: [
                        Container(
                          color: Color(0xff3074FF),
                          height: size.width * 28,
                          width: size.width * 8,
                        ),
                        SizedBox(
                          width: size.width * 16,
                        ),
                        Text(
                          "隐患整改提醒",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 100,
                          padding: EdgeInsets.only(bottom: size.width * 24),
                          alignment: Alignment.center,
                          child: Text(
                            '序号',
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: size.width * 250,
                          padding: EdgeInsets.only(bottom: size.width * 24),
                          alignment: Alignment.center,
                          child: Text(
                            '隐患排查任务',
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: size.width * 250,
                          padding: EdgeInsets.only(bottom: size.width * 24),
                          alignment: Alignment.center,
                          child: Text(
                            '隐患治理期限',
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: size.width * 2,
                    color: Color(0xffF2F2F2),
                  ),
                  ListView.builder(
                      itemCount: hiddenReminder.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, hiddenReminderIndex) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * 100,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.width * 24),
                                    child: Text(
                                      (hiddenReminderIndex + 1).toString(),
                                      style: TextStyle(
                                          color: Color(0xff7F8A9C),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 250,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.width * 24),
                                    child: Text(
                                      hiddenReminder[hiddenReminderIndex]['troubleshootContent'],
                                      style: TextStyle(
                                          color: Color(0xff7F8A9C),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 250,
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.width * 24),
                                    alignment: Alignment.center,
                                    child: Text(
                                     DateTime.fromMillisecondsSinceEpoch(hiddenReminder[hiddenReminderIndex]['dangerManageDeadline']).toString().substring(0, 16),
                                      style: TextStyle(
                                          color: Color(0xff7F8A9C),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hiddenReminderIndex != unitOperationEffect.length - 1
                                ? Container(
                                    width: double.infinity,
                                    height: size.width * 2,
                                    color: Color(0xffF2F2F2),
                                  )
                                : Container(),
                          ],
                        );
                      }),
                  SizedBox(
                    height: size.width * 16,
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class DoubleControlPaint extends CustomPainter {
  Paint _paint = Paint()
    ..color = Color(0xff3074FF).withOpacity(0.15)
    ..strokeWidth = 1
    ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    Path _path = Path();
    _path.moveTo(size.width / 3 * 2 + 7.5, 0);
    _path.lineTo(size.width, size.height / 2);
    _path.lineTo(size.width / 3 * 2 + 7.5, size.height);
    _path.close();
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
