import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
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
    _getMeasureStatisticsData();
    _getTaskCompletionData();
    _getHiddenDangerTreatmentSituation();
  }

  int riskTotal = 0;

  // 获取风险管控统计数据
  _getRiskData() {
    myDio
        .request(
      type: 'get',
      url: Interface.getRiskStatistics,
    )
        .then((value) {
      if (value is Map) {
        initialPie.add(PieSturct(
            color: Color(0xffF56271),
            nums: value['initialRiskOne'] * 1.0,
            title: '重大风险'));
        initialPie.add(PieSturct(
            color: Color(0xffFF9900),
            nums: value['initialRiskTwo'] * 1.0,
            title: '较大风险'));
        initialPie.add(PieSturct(
            color: Color(0xffFFCA0E),
            nums: value['initialRiskThree'] * 1.0,
            title: '一般风险'));
        initialPie.add(PieSturct(
            color: Color(0xff2276FC),
            nums: value['initialRiskFour'] * 1.0,
            title: '低风险'));

        residuePie.add(PieSturct(
            color: Color(0xffF56271),
            nums: value['riskOne'] * 1.0,
            title: '重大风险'));
        residuePie.add(PieSturct(
            color: Color(0xffFF9900),
            nums: value['riskTwo'] * 1.0,
            title: '较大风险'));
        residuePie.add(PieSturct(
            color: Color(0xffFFCA0E),
            nums: value['riskThree'] * 1.0,
            title: '一般风险'));
        residuePie.add(PieSturct(
            color: Color(0xff2276FC),
            nums: value['riskFour'] * 1.0,
            title: '低风险'));

        riskTotal = value['total'];
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  // 隐患情况
  _getHiddenDangerTreatmentSituation(){
    myDio.request(
      type: 'get',
      url: Interface.getHiddenDangerTreatmentSituation,
    ).then((value) {
      if (value is Map) {
        abnormalPie
        .add(PieSturct(color: Color(0xff2276FC), nums: value['confirmed'] * 1.0, title: '待确认'));
        abnormalPie
            .add(PieSturct(color: Color(0xffF56271), nums: value['rectification'] * 1.0, title: '整改中'));
        abnormalPie
            .add(PieSturct(color: Color(0xffFFCA0E), nums: value['acceptance'] * 1.0, title: '待验收'));

        currentPie
        .add(PieSturct(color: Color(0xffF56271), nums: value['major'] * 1.0, title: '重大隐患'));
        currentPie
            .add(PieSturct(color: Color(0xffFFCA0E), nums: value['commonly'] * 1.0, title: '一般隐患'));

        hiddenDangerTreatmentSituationData = value;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  Map hiddenDangerTreatmentSituationData = {
    "acceptance": 0,
    "commonly": 0,
    "major": 0,
    "rectification": 0,
    "confirmed": 0
  };

  // 管控措施统计
  _getMeasureStatisticsData() {
    myDio
        .request(
      type: 'get',
      url: Interface.getMeasureStatistics,
    )
        .then((value) {
      if (value is Map) {
        measureStatisticsData[0]['num'] = value['engineeringTechnology'];
        measureStatisticsData[1]['num'] = value['maintenance'];
        measureStatisticsData[2]['num'] = value['operationBehavior'];
        measureStatisticsData[3]['num'] = value['emergencyMeasure'];
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  // 管控分类数据数组
  List measureStatisticsData = [
    {'name': '工程技术', 'num': 0},
    {'name': '维护保养', 'num': 0},
    {'name': '操作行为', 'num': 0},
    {'name': '异常措施', 'num': 0},
  ];

  // 任务完成情况
  _getTaskCompletionData() {
    myDio
        .request(
      type: 'get',
      url: Interface.getTaskCompletion,
    )
        .then((value) {
      if (value is Map) {
        taskCompletionData = value;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  // 任务完成情况
  Map taskCompletionData = {
    "waitCheck": 0,
    "total": 0,
    "beOverdue": 0,
    "checked": 0
  };

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
                                riskTotal.toString(),
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
                      measureStatisticsData.isNotEmpty
                          ? CustomPaint(
                              painter: DoubleControlPaint(),
                              child: Container(
                                  margin:
                                      EdgeInsets.only(right: size.width * 60),
                                  width: size.width * 160,
                                  child: ListView.builder(
                                      itemCount: measureStatisticsData.length,
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
                                                    measureStatisticsData[index]
                                                            ['name']
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
                                                    measureStatisticsData[index]
                                                            ['num']
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
                                riskTotal.toString(),
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
          // 任务完成情况
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
                      "任务完成情况",
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
                      height: size.width * 144,
                      width: size.width * 296,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 24),
                      decoration: BoxDecoration(
                          color: Color(0xffFF9900).withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 16))),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '应排查任务',
                                style: TextStyle(
                                    color: Color(0xffFF9900),
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 28),
                              ),
                              SizedBox(
                                height: size.width * 12,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Color(0xffFF9900)),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: taskCompletionData['total']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 40,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '条',
                                          style: TextStyle(
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w400)),
                                    ]),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: size.width * 64,
                            width: size.width * 64,
                            decoration: BoxDecoration(
                                color: Color(0xffFF9900),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_home_pie.png',
                              height: size.width * 35,
                              width: size.width * 35,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: size.width * 144,
                      width: size.width * 296,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 24),
                      decoration: BoxDecoration(
                          color: Color(0xff5FD5EC).withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 16))),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '已排查任务',
                                style: TextStyle(
                                    color: Color(0xff5FD5EC),
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 28),
                              ),
                              SizedBox(
                                height: size.width * 12,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Color(0xff5FD5EC)),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: taskCompletionData['checked']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 40,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '条',
                                          style: TextStyle(
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w400)),
                                    ]),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: size.width * 64,
                            width: size.width * 64,
                            decoration: BoxDecoration(
                                color: Color(0xff5FD5EC),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_home_pie.png',
                              height: size.width * 35,
                              width: size.width * 35,
                            ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: size.width * 144,
                      width: size.width * 296,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 24),
                      decoration: BoxDecoration(
                          color: Color(0xff3074FF).withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 16))),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '待排查任务',
                                style: TextStyle(
                                    color: Color(0xff3074FF),
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 28),
                              ),
                              SizedBox(
                                height: size.width * 12,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Color(0xff3074FF)),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: taskCompletionData['waitCheck']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 40,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '条',
                                          style: TextStyle(
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w400)),
                                    ]),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: size.width * 64,
                            width: size.width * 64,
                            decoration: BoxDecoration(
                                color: Color(0xff3074FF),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_home_pie.png',
                              height: size.width * 35,
                              width: size.width * 35,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: size.width * 144,
                      width: size.width * 296,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 24),
                      decoration: BoxDecoration(
                          color: Color(0xffF56271).withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 16))),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '逾期任务',
                                style: TextStyle(
                                    color: Color(0xffF56271),
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 28),
                              ),
                              SizedBox(
                                height: size.width * 12,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Color(0xffF56271)),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: taskCompletionData['beOverdue']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 40,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '条',
                                          style: TextStyle(
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w400)),
                                    ]),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: size.width * 64,
                            width: size.width * 64,
                            decoration: BoxDecoration(
                                color: Color(0xffF56271),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_home_pie.png',
                              height: size.width * 35,
                              width: size.width * 35,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 30,
                ),
                Container(
                  height: size.width * 174,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff3074FF),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 16))),
                  padding: EdgeInsets.all(size.width * 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '排查完成率',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: size.width * 30,
                      ),
                      Row(
                        children: [
                          ProgressComp(
                            value: taskCompletionData['total'] == 0
                                ? 0
                                : taskCompletionData['checked'] /
                                    taskCompletionData['total'],
                            width: size.width * 450,
                            height: size.width * 32,
                            frColor: Colors.white,
                            bgColor: Color(0xff5F93FF)),
                          Spacer(),
                          Text(
                            taskCompletionData['total'] == 0
                                ? '0%'
                                : (taskCompletionData['checked'] / taskCompletionData['total'] * 100).toStringAsFixed(1).toString() + '%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 32
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // CustomEchart()
                //     .mutipleBar(xAxisList: xAxisList, yAxis: maxYAxis, color: [
                //   Color(0xffF56271),
                //   Color(0xffFF9900),
                //   Color(0xffFFCA0E),
                //   Color(0xff2276FC),
                // ]),
                // SizedBox(
                //   height: size.width * 30,
                // ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: size.width * 50,
                //     ),
                //     Container(
                //       width: size.width * 300,
                //       child: Row(
                //         children: [
                //           Container(
                //             height: size.width * 20,
                //             width: size.width * 20,
                //             decoration: BoxDecoration(
                //                 color: Color(0xffF56271),
                //                 borderRadius: BorderRadius.all(
                //                     Radius.circular(size.width * 4))),
                //           ),
                //           SizedBox(
                //             width: size.width * 8,
                //           ),
                //           Text(
                //             "重大风险总计(12)",
                //             style: TextStyle(
                //                 color: Color(0xff7F8A9C),
                //                 fontSize: size.width * 24),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       height: size.width * 20,
                //       width: size.width * 20,
                //       decoration: BoxDecoration(
                //           color: Color(0xffFF9900),
                //           borderRadius: BorderRadius.all(
                //               Radius.circular(size.width * 4))),
                //     ),
                //     SizedBox(
                //       width: size.width * 8,
                //     ),
                //     Text(
                //       "较大风险总计(31)",
                //       style: TextStyle(
                //           color: Color(0xff7F8A9C), fontSize: size.width * 24),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: size.width * 20,
                // ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: size.width * 50,
                //     ),
                //     Container(
                //       width: size.width * 300,
                //       child: Row(
                //         children: [
                //           Row(
                //             children: [
                //               Container(
                //                 height: size.width * 20,
                //                 width: size.width * 20,
                //                 decoration: BoxDecoration(
                //                     color: Color(0xffFFCA0E),
                //                     borderRadius: BorderRadius.all(
                //                         Radius.circular(size.width * 4))),
                //               ),
                //               SizedBox(
                //                 width: size.width * 8,
                //               ),
                //               Text(
                //                 "一般风险总计(47)",
                //                 style: TextStyle(
                //                     color: Color(0xff7F8A9C),
                //                     fontSize: size.width * 24),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       height: size.width * 20,
                //       width: size.width * 20,
                //       decoration: BoxDecoration(
                //           color: Color(0xff2276FC),
                //           borderRadius: BorderRadius.all(
                //               Radius.circular(size.width * 4))),
                //     ),
                //     SizedBox(
                //       width: size.width * 8,
                //     ),
                //     Text(
                //       "低风险总计(129)",
                //       style: TextStyle(
                //           color: Color(0xff7F8A9C), fontSize: size.width * 24),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: size.width * 30,
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 32,
          ),
          // 隐患治理情况
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
                    "隐患治理情况",
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
                            "待确认   ${hiddenDangerTreatmentSituationData['confirmed']}",
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
                            "整改中   ${hiddenDangerTreatmentSituationData['rectification']}",
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
                            "待验收   ${hiddenDangerTreatmentSituationData['acceptance']}",
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
          // 历史隐患统计
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
                    "历史隐患统计",
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
                            "重大隐患   ${hiddenDangerTreatmentSituationData['major']}",
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
                            "一般隐患   ${hiddenDangerTreatmentSituationData['commonly']}",
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
  ];

  // 异常处置数据数组
  List<PieSturct> hisControlhiddenPie = [];

  @override
  void initState() {
    super.initState();
    _getHisControlhiddenData();
  }

  // 获取排查、巡检异常处置情况
  _getHisControlhiddenData() {
    hisControlhiddenPie
        .add(PieSturct(color: Color(0xff2276FC), nums: 123, title: '待确认'));
    hisControlhiddenPie
        .add(PieSturct(color: Color(0xffF56271), nums: 30, title: '待整改'));
    hisControlhiddenPie
        .add(PieSturct(color: Color(0xffFFCA0E), nums: 49, title: '待审批'));
  }

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

  List hiddenCheckReminder = [
    {
      'troubleshootContent': '隐患排查任务',
      'startTime': 1652169600,
      'endTime': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'startTime': 1652169600,
      'endTime': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'startTime': 1652169600,
      'endTime': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'startTime': 1652169600,
      'endTime': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'startTime': 1652169600,
      'endTime': 1652169600
    },
    {
      'troubleshootContent': '隐患排查任务',
      'startTime': 1652169600,
      'endTime': 1652169600
    },
  ];

  int isHiddenRemind = 1;

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
          // 历史隐患治理情况
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
                    "历史隐患治理情况",
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
                      data: hisControlhiddenPie),
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
                            "已确认   123",
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
                            "已整改   3",
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
                            "已验收   49",
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
          // 隐患排查提醒/隐患治理提醒
          Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 32),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 20))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          isHiddenRemind = 1;
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(top: size.width * 32),
                          child: Column(
                            children: [
                              Text(
                                '隐患排查提醒',
                                style: TextStyle(
                                    color: isHiddenRemind == 1
                                        ? Color(0xff3074FF)
                                        : Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: size.width * 12,
                              ),
                              isHiddenRemind == 1
                                  ? Container(
                                      height: size.width * 8,
                                      width: size.width * 56,
                                      decoration: BoxDecoration(
                                          color: Color(0xff3074FF),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(size.width * 8))),
                                    )
                                  : Container(
                                      height: size.width * 8,
                                      width: size.width * 56,
                                    )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isHiddenRemind = 2;
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(top: size.width * 32),
                          child: Column(
                            children: [
                              Text(
                                '隐患治理提醒',
                                style: TextStyle(
                                    color: isHiddenRemind == 2
                                        ? Color(0xff3074FF)
                                        : Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: size.width * 12,
                              ),
                              isHiddenRemind == 2
                                  ? Container(
                                      height: size.width * 8,
                                      width: size.width * 56,
                                      decoration: BoxDecoration(
                                          color: Color(0xff3074FF),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(size.width * 8))),
                                    )
                                  : Container(
                                      height: size.width * 8,
                                      width: size.width * 56,
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
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
                          width: size.width * 300,
                          padding: EdgeInsets.only(bottom: size.width * 24),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '隐患排查任务',
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: size.width * 150,
                          padding: EdgeInsets.only(bottom: size.width * 24),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '开始时间',
                            style: TextStyle(
                                color: Color(0xff7F8A9C),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: size.width * 150,
                          padding: EdgeInsets.only(bottom: size.width * 24),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '结束时间',
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
                  Container(
                    height: size.width * 310,
                    child: ListView.builder(
                        itemCount: hiddenCheckReminder.length,
                        itemBuilder: (context, hiddenCheckReminderIndex) {
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
                                      width: size.width * 300,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.width * 24),
                                      child: Text(
                                        hiddenCheckReminder[
                                                hiddenCheckReminderIndex]
                                            ['troubleshootContent'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 150,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.width * 24),
                                      child: Text(
                                        DateTime.fromMillisecondsSinceEpoch(
                                                hiddenCheckReminder[
                                                        hiddenCheckReminderIndex]
                                                    ['startTime'])
                                            .toString()
                                            .substring(0, 16),
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
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        DateTime.fromMillisecondsSinceEpoch(
                                                hiddenCheckReminder[
                                                        hiddenCheckReminderIndex]
                                                    ['endTime'])
                                            .toString()
                                            .substring(0, 16),
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              hiddenCheckReminderIndex !=
                                      unitOperationEffect.length - 1
                                  ? Container(
                                      width: double.infinity,
                                      height: size.width * 2,
                                      color: Color(0xffF2F2F2),
                                    )
                                  : Container(),
                            ],
                          );
                        }),
                  ),
                  SizedBox(
                    height: size.width * 30,
                  )
                ],
              )),
          SizedBox(
            height: size.width * 32,
          ),
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
