import 'dart:async';

import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/pages/home.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radar_chart/radar_chart.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';

class CheckListOverflow extends StatefulWidget {
  const CheckListOverflow({
    Key key,
  }) : super(key: key);
  @override
  _CheckListOverflowState createState() => _CheckListOverflowState();
}

class _CheckListOverflowState extends State<CheckListOverflow>
    with WidgetsBindingObserver {
  GlobalKey _myKey = new GlobalKey();
  ScrollController _controller;
  int index = 0;
  Timer _timer;
  @override
  void initState() {
    //来监听 节点是否build完成
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(new Duration(seconds: 5), (timer) {
        if(_myKey.currentContext != null){
            index += _myKey.currentContext.size.height.toInt();
        _controller.animateTo((index).toDouble(),
            duration: new Duration(seconds: 2), curve: Curves.easeOutSine);
        //滚动到底部从头开始
        if ((index - _myKey.currentContext.size.height.toInt()).toDouble() >
            _controller.position.maxScrollExtent) {
          _controller.jumpTo(_controller.position.minScrollExtent);
          index = 0;
        }
        }
      });
    });

    _controller = new ScrollController(initialScrollOffset: 0);
    super.initState();
    _getPerformDuties();
    _getMainStatistics();
    _getListWarningInformation();
    _getResponsibilityList();
    _getJobResponsibilitiesNum();
    _getCheckHiddenWorkStatistics();
    _getMajorRiskControlRing();
    _getDailySafetyControllableDegreeTotal();
    _getMajorRiskControlControllableDegree();
    _getDailySafetyControllableDegree();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // 主体责任清单饼状图数据
  int implemented = -1;
  int notImplemented = -1;
  int total = -1;
  List warningInformation = [];
  List responsibility = [];
  
  String days = '';

  _getPerformDuties(){
    myDio.request(
      type: 'get',
      url: Interface.getPerformDuties,
    ).then((value) {
      if (value is Map) {
        days = value['days'].toString();
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getMainStatistics() {
    myDio
        .request(
      type: 'get',
      url: Interface.getMainStatistics,
    )
        .then((value) {
      if (value is Map) {
        total = value['totalNum'];
        implemented = value['completedNum'];
        notImplemented = value['totalNum'] - value['completedNum'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getListWarningInformation() {
    myDio
        .request(
      type: 'get',
      url: Interface.getListWarningInformation,
    )
        .then((value) {
      if (value is List) {
        warningInformation = value;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getResponsibilityList() {
    myDio
        .request(
      type: 'get',
      url: Interface.getResponsibilityList,
    )
        .then((value) {
      if (value is List) {
        responsibility = value;
        for (int i = 0; i < responsibility.length; i++) {
          double maximum = 100.0;
          values.clear();
          values.add(
              responsibility[i]['listMajorRiskProportion'] * 1.0 / maximum); //主体责任清单
          values.add(
              responsibility[i]['listDailyRiskProportion'] * 1.0 / maximum); // 重大风险管控清单
          values.add(
              responsibility[i]['listJobRolesDutyProportion'] * 1.0 / maximum); // 岗位责任清单
          values.add(responsibility[i]['listMainProportion'] * 1.0 / maximum); // 消防管理清单
          radarTiledata.add(RadarTile(
            values: values,
            borderStroke: size.width * 2,
            borderColor: Color(0xfffcb968),
          ));
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getJobResponsibilitiesNum() {
    myDio
        .request(
      type: 'get',
      url: Interface.getJobResponsibilitiesNum,
    )
        .then((value) {
      if (value is Map) {
        if (value['totalNum'] == 0) {
          jobResponPro = 0.0;
          strJobResponPro = '0.0';
        } else {
          jobResponPro = (value['completedNum'] / value['totalNum']) * 1.0;
          if (((value['completedNum'] / value['totalNum']) * 100.0)
                  .toString()
                  .length >
              4) {
            strJobResponPro =
                ((value['completedNum'] / value['totalNum']) * 100.0)
                    .toString()
                    .substring(0, 4);
          } else {
            strJobResponPro =
                ((value['completedNum'] / value['totalNum']) * 100.0)
                    .toString();
          }
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getCheckHiddenWorkStatistics() {
    myDio
        .request(
      type: 'get',
      url: Interface.getCheckHiddenWorkStatistics,
    )
        .then((value) {
      if (value is Map) {
        hiddenNum = value['hiddenNum'];
        workNum = value['workNum'];
        checkNum = value['checkNum'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  int dailySafetyImplemented = -1;
  int dailySafetyNotImplemented = -1;
  int dailySafetyTotal = -1;

  _getDailySafetyControllableDegreeTotal() {
    myDio.request(
      type: 'get',
      url: Interface.getDailySafetyControllableDegreeTotal,
    ).then((value) {
      if (value is Map) {
        dailySafetyTotal = value['totalNum'];
        dailySafetyImplemented = value['controllableNum'];
        dailySafetyNotImplemented = value['totalNum'] - value['controllableNum'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  List<RadarTile> radarTiledata = [];

  List<double> values = [];

  double jobResponPro = 0.0;
  String strJobResponPro = '0.0';

  int hiddenNum = 0;
  int workNum = 0;
  int checkNum = 0;

  List titleBar1 = [
    {
      "title": "重大风险管控清单",
    },
    {
      "title": "实时可控进度",
    },
  ];
  List titleBar2 = [
    {
      "title": "日常安全工作清单",
    },
    {
      "title": "实时可控进度",
    },
  ];
  int choosed1 = 0;
  int choosed2 = 0;
  dynamic titleBarQueryParameters1;
  dynamic titleBarQueryParameters2;
  Counter _counter1 = Provider.of(myContext);
  Counter _counter2 = Provider.of(myContext);
  double majorRiskControlTotalNum = 0.0;
  List majorRiskControlClassification = [];
  List<PieSturct> majorRiskControlResiduePie = [];

  _getMajorRiskControlRing() {
    myDio
        .request(
      type: 'get',
      url: Interface.getMajorRiskControlRing,
    )
        .then((value) {
      if (value is Map) {
        majorRiskControlTotalNum = value['totalNum'] * 1.0;
        majorRiskControlClassification = value['classification'];
        majorRiskControlOneNum = value['oneNum'] * 1.0;
        majorRiskControlTwoNum = value['twoNum'] * 1.0;
        majorRiskControlThreeNum = value['threeNum'] * 1.0;
        majorRiskControlFourNum = value['fourNum'] * 1.0;
        majorRiskControlResiduePie.clear();
        majorRiskControlResiduePie.add(PieSturct(
            color: Color(0xffDF0000),
            nums: majorRiskControlOneNum,
            title: '重大风险'));
        majorRiskControlResiduePie.add(PieSturct(
            color: Color(0xffFF781A),
            nums: majorRiskControlTwoNum,
            title: '较大风险'));
        majorRiskControlResiduePie.add(PieSturct(
            color: Color(0xffFFD500),
            nums: majorRiskControlThreeNum,
            title: '一般风险'));
        majorRiskControlResiduePie.add(PieSturct(
            color: Color(0xff01A8F4),
            nums: majorRiskControlFourNum,
            title: '低风险'));
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  double majorRiskControlOneNum = 0;
  double majorRiskControlTwoNum = 0;
  double majorRiskControlThreeNum = 0;
  double majorRiskControlFourNum = 0;

  List<MutipleXAxisSturct> xAxisListMajorRiskControlControllableDegree = [];
  double yAxisListMajorRiskControlControllableDegree = 0.0;

  _getMajorRiskControlControllableDegree(){
    myDio.request(
      type: 'get',
      url: Interface.getMajorRiskControlControllableDegree,
    ).then((value) {
      if (value is List) {
        for(int i = 0; i < value.length; i ++){
          if(yAxisListMajorRiskControlControllableDegree < value[i]['totalNum']){
            yAxisListMajorRiskControlControllableDegree = value[i]['totalNum'] * 1.0;
          }
          double controllableNum = value[i]['totalNum'] * 1.0 - value[i]['controllableNum'] * 1.0;
          xAxisListMajorRiskControlControllableDegree.add(MutipleXAxisSturct(names: value[i]['riskPoint'], nums: [controllableNum, value[i]['controllableNum'] * 1.0], color: [Color(0xff668EFF), Color(0xff8565FF)]));
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  List<MutipleXAxisSturct> xAxisListDailySafetyControllableDegree = [];
  double yAxisDailySafetyControllableDegree = 0.0;

  _getDailySafetyControllableDegree(){
    myDio.request(
      type: 'get',
      url: Interface.getDailySafetyControllableDegree,
    ).then((value) {
      if (value is List) {
        for(int i = 0; i < value.length; i ++){
          if(yAxisDailySafetyControllableDegree < value[i]['totalNum']){
            yAxisDailySafetyControllableDegree = value[i]['totalNum'] * 1.0;
          }
          double controllableDegreeNum = value[i]['totalNum'] * 1.0 - value[i]['controllableNum'] * 1.0;
          xAxisListDailySafetyControllableDegree.add(MutipleXAxisSturct(names: value[i]['name'], nums: [controllableDegreeNum, value[i]['controllableNum'] * 1.0], color: [Color(0xff668EFF), Color(0xff8565FF)]));
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: size.width * 20,
              left: size.width * 20,
              right: size.width * 20),
          child: Card(
              child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 25),
                    child: Image.asset(
                      "assets/images/icon_prodect_notice.png",
                      width: size.width * 28,
                      height: size.width * 28,
                    ),
                  ),
                  Container(
                    width: size.width * 1,
                    height: size.width * 43,
                    color: Color(0xffDBDBDB),
                  ),
                  Container(
                    margin: EdgeInsets.all(size.width * 20),
                    decoration: BoxDecoration(
                        color: Color(0xff47D900), shape: BoxShape.circle),
                    width: size.width * 10,
                    height: size.width * 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '清单已履职',
                        style: TextStyle(
                            color: Color(0xff656565),
                            fontSize: size.width * 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width * 5,
                      ),
                      Text(days,
                          style: TextStyle(
                              color: Color(0xff47D900),
                              fontSize: size.width * 30,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: size.width * 5,
                      ),
                      Text(
                        '天',
                        style: TextStyle(
                            color: Color(0xff656565),
                            fontSize: size.width * 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                width: size.width * 550,
                height: size.width * 195.0,
                child: warningInformation.isNotEmpty
                    ? ListView.builder(
                        key: _myKey,
                        //禁止手动滑动
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: warningInformation.length,
                        //item固定高度
                        // itemExtent: size.width * 55,
                        scrollDirection: Axis.vertical,
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Color(0xffF5F8FF),
                            margin: EdgeInsets.only(bottom: size.width * 15),
                            padding: EdgeInsets.all(size.width * 10),
                            // height: size.width * 50,
                            // width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${warningInformation[index]['title']}: ${warningInformation[index]['content']}',
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 16),
                            ),
                          );
                        })
                    : Container(),
              ),
            ],
          )),
        ),
        // 责任清单制
        Padding(
          padding: EdgeInsets.only(
              top: size.width * 20,
              left: size.width * 20,
              right: size.width * 20),
          child: Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 15,
                    top: size.width * 20,
                    bottom: size.width * 20),
                child: Text(
                  '责任清单制',
                  style: TextStyle(
                      color: Color(0xff272F3D),
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 28),
                ),
              ),
              Container(
                height: size.width * 2,
                width: double.infinity,
                color: Color(0xffF7F7F7),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Color(0xffEBF1FF),
                    margin: EdgeInsets.symmetric(vertical: size.width * 10),
                    child: Text(
                      '主体责任清单',
                      style: TextStyle(
                          fontSize: size.width * 14, color: Color(0xff65708D)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Color(0xffEBF1FF),
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 10),
                        child: Text(
                          '岗位责任清单',
                          style: TextStyle(
                              fontSize: size.width * 14,
                              color: Color(0xff65708D)),
                        ),
                      ),
                      radarTiledata.isNotEmpty
                          ? RadarChart(
                              length: 4,
                              radius: 50,
                              initialAngle: 0,
                              backgroundColor: Colors.white,
                              borderStroke: size.width * 2,
                              borderColor: Color(0xffE7F2FF),
                              radialStroke: size.width * 2,
                              radialColor: Color(0xffE7F2FF),
                              radars: radarTiledata,
                            )
                          : Container(),
                      Container(
                        color: Color(0xffEBF1FF),
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 10),
                        child: Text(
                          '重大风险管控清单',
                          style: TextStyle(
                              fontSize: size.width * 14,
                              color: Color(0xff65708D)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Color(0xffEBF1FF),
                    margin: EdgeInsets.symmetric(vertical: size.width * 10),
                    child: Text(
                      '日常安全工作清单',
                      style: TextStyle(
                          fontSize: size.width * 14, color: Color(0xff65708D)),
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
        // 主体责任清单饼状图
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width * 10, horizontal: size.width * 20),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 15,
                        top: size.width * 20,
                        bottom: size.width * 20),
                    child: Text(
                      '主体责任清单',
                      style: TextStyle(
                          color: Color(0xff272F3D),
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 28),
                    ),
                  ),
                  Container(
                    height: size.width * 2,
                    width: double.infinity,
                    color: Color(0xffF7F7F7),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 200,
                        height: size.width * 200,
                        margin: EdgeInsets.only(
                            left: size.width * 30,
                            right: size.width * 20,
                            top: size.width * 20,
                            bottom: size.width * 20),
                        child: Stack(
                          children: [
                            PieChartSample2(
                              roundUi: [
                                XAxisSturct(
                                    color: Color(0xff817FFF),
                                    nums: implemented * 1.0),
                                XAxisSturct(
                                    color: Color(0xff3585FF),
                                    nums: notImplemented * 1.0),
                              ],
                            ),
                            Positioned(
                                child: Center(
                                    child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  total.toString(),
                                  style: TextStyle(
                                      color: Color(0xff696C74),
                                      fontSize: size.width * 30,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '清单总数',
                                  style: TextStyle(
                                      color: Color(0xff959BA7),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 50,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: size.width * 14,
                                  height: size.width * 14,
                                  color: Color(0xff817FFF),
                                ),
                                SizedBox(
                                  width: size.width * 20,
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: '已落实       ',
                                      style: TextStyle(
                                          color: Color(0xffA7ADB7),
                                          fontSize: size.width * 26,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: implemented.toString(),
                                      style: TextStyle(
                                          color: Color(0xff494F5B),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 14,
                                  height: size.width * 14,
                                  color: Color(0xff3585FF),
                                ),
                                SizedBox(
                                  width: size.width * 20,
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: '未落实       ',
                                      style: TextStyle(
                                          color: Color(0xffA7ADB7),
                                          fontSize: size.width * 26,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: notImplemented.toString(),
                                      style: TextStyle(
                                          color: Color(0xff494F5B),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
        // 岗位责任清单
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.width * 10, horizontal: size.width * 20),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 15,
                      top: size.width * 20,
                      bottom: size.width * 20),
                  child: Text(
                    '岗位责任清单',
                    style: TextStyle(
                        color: Color(0xff272F3D),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 28),
                  ),
                ),
                Container(
                  height: size.width * 2,
                  width: double.infinity,
                  color: Color(0xffF7F7F7),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: CustomEchart().round(
                      proportion: jobResponPro,
                      proColor: Color(0xff3883c5),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: strJobResponPro,
                                      style: TextStyle(
                                        color: Color(0xff3883C5),
                                        fontSize: size.width * 73,
                                      )),
                                  TextSpan(
                                      text: '%',
                                      style: TextStyle(
                                          color: Color(0xff3883C5),
                                          fontSize: size.width * 25)),
                                ]),
                          ),
                          Text(
                            '落实进度',
                            style: TextStyle(
                                color: Color(0xff6A737B),
                                fontSize: size.width * 24),
                          )
                        ],
                      ))),
                )
              ],
            ),
          ),
        ),
        // 重大风险管控清单 | 实时可控进度
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width * 10, horizontal: size.width * 20),
            child: Card(
                child: Column(
              children: [
                Row(
                    children: titleBar1
                        .asMap()
                        .keys
                        .map((index) => Expanded(
                            child: CustomPaint(
                                painter: SliverStyle(
                                    choosed1, index, titleBar1.length),
                                child: InkWell(
                                    onTap: () {
                                      titleBarQueryParameters1 = null;
                                      _counter1.changeDateStyle(false);
                                      choosed1 = index;
                                      if (mounted) {
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: size.width * 20,
                                            bottom: size.width * 20),
                                        child: Text(
                                            titleBar1[index]['title']
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: size.width * 28,
                                                color: index == choosed1
                                                    ? Color(0xff306CFD)
                                                    : placeHolder,
                                                fontWeight:
                                                    FontWeight.bold)))))))
                        .toList()),
                choosed1 == 1
                    ? Container(
                        height: size.width * 320,
                        child: Column(
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                height: size.width * 14,
                                width: size.width * 14,
                                color: Color(0xff668EFF),
                              ),
                              SizedBox(
                                width: size.width * 10,
                              ),
                              Text(
                                '不可控',
                                style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 18
                                ),
                              ),
                              SizedBox(
                                width: size.width * 50,
                              ),
                              Container(
                                height: size.width * 14,
                                width: size.width * 14,
                                color: Color(0xff8565FF),
                              ),
                              SizedBox(
                                width: size.width * 10,
                              ),
                              Text(
                                '可控',
                                style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 18
                                ),
                              ),
                              SizedBox(
                                width: size.width * 50,
                              ),
                            ],
                          ),
                          xAxisListMajorRiskControlControllableDegree.isNotEmpty ? homeBar(
                            width: size.width * 10,
                            height: size.width * 250,
                            yAxis: yAxisListMajorRiskControlControllableDegree + yAxisListMajorRiskControlControllableDegree / 2,
                            xAxisList: xAxisListMajorRiskControlControllableDegree,
                          ) : Container(
                            width: size.width * 10,
                            height: size.width * 250,
                          ),
                        ],
                      ),
                    )
                    : majorRiskControlResiduePie.isNotEmpty
                        ? Container(
                          height: size.width * 320,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomEchart().pie(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '清单总数',
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: size.width * 18),
                                        ),
                                        Text(
                                          majorRiskControlTotalNum.truncate().toString(),
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: size.width * 26),
                                        )
                                      ],
                                    ),
                                    width: 90,
                                    radius: 35,
                                    strokeWidth: 8,
                                    state: false,
                                    data: [
                                      PieSturct(
                                          color: Color(0xffDF0000),
                                          nums: majorRiskControlTotalNum,
                                          title: '重大风险')
                                    ]),
                                majorRiskControlClassification.isNotEmpty
                                    ? CustomPaint(
                                        painter: DoubleControlPaint(),
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right: size.width * 50),
                                            width: size.width * 110,
                                            child: ListView.builder(
                                                itemCount:
                                                    majorRiskControlClassification
                                                        .length,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        height: size.width * 20,
                                                        width: size.width * 100,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffDAE2F4)),
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.width *
                                                                        5),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child: Text(
                                                              majorRiskControlClassification[
                                                                          index][
                                                                      'classification']
                                                                  .toString(),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff466CC7),
                                                                  fontSize:
                                                                      size.width *
                                                                          12),
                                                            )),
                                                            Text(
                                                              majorRiskControlClassification[
                                                                          index]
                                                                      ['num']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff466CC7),
                                                                  fontSize:
                                                                      size.width *
                                                                          12),
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
                                CustomEchart().pie(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '清单总数',
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: size.width * 18),
                                        ),
                                        Text(
                                          majorRiskControlTotalNum.toString(),
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: size.width * 26),
                                        )
                                      ],
                                    ),
                                    width: 90,
                                    radius: 35,
                                    state: false,
                                    strokeWidth: 8,
                                    data: majorRiskControlResiduePie),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: size.width * 120,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: size.width * 13,
                                        width: size.width * 13,
                                        color: Color(0xffDF0000),
                                      ),
                                      SizedBox(
                                        width: size.width * 5,
                                      ),
                                      Text(
                                        '重大风险',
                                        style: TextStyle(
                                            fontSize: size.width * 16,
                                            color: Color(0xff666666)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width * 120,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: size.width * 13,
                                        width: size.width * 13,
                                        color: Color(0xffFF781A),
                                      ),
                                      SizedBox(
                                        width: size.width * 5,
                                      ),
                                      Text(
                                        '较大风险',
                                        style: TextStyle(
                                            fontSize: size.width * 16,
                                            color: Color(0xff666666)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width * 120,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: size.width * 13,
                                        width: size.width * 13,
                                        color: Color(0xffFFD500),
                                      ),
                                      SizedBox(
                                        width: size.width * 5,
                                      ),
                                      Text(
                                        '一般风险',
                                        style: TextStyle(
                                            fontSize: size.width * 16,
                                            color: Color(0xff666666)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width * 120,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: size.width * 13,
                                        width: size.width * 13,
                                        color: Color(0xff01A8F4),
                                      ),
                                      SizedBox(
                                        width: size.width * 5,
                                      ),
                                      Text(
                                        '低风险',
                                        style: TextStyle(
                                            fontSize: size.width * 16,
                                            color: Color(0xff666666)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        )
                        : Container(
                          height: size.width * 320,
                        ),
                ],
            ))),
        // 日常安全工作清单 | 实时可控进度
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width * 10, horizontal: size.width * 20),
            child: Card(
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
                                          titleBar2[index]['title'].toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: size.width * 28,
                                              color: index == choosed2
                                                  ? Color(0xff306CFD)
                                                  : placeHolder,
                                              fontWeight: FontWeight.bold)))))))
                      .toList()),
                      choosed2 == 1
                    ? Container(
                      height: size.width * 320,
                      child: Column(
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Container(
                              height: size.width * 14,
                              width: size.width * 14,
                              color: Color(0xff668EFF),
                            ),
                            SizedBox(
                              width: size.width * 10,
                            ),
                            Text(
                              '不可控',
                              style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: size.width * 18
                              ),
                            ),
                            SizedBox(
                              width: size.width * 50,
                            ),
                            Container(
                              height: size.width * 14,
                              width: size.width * 14,
                              color: Color(0xff8565FF),
                            ),
                            SizedBox(
                              width: size.width * 10,
                            ),
                            Text(
                              '可控',
                              style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: size.width * 18
                              ),
                            ),
                            SizedBox(
                              width: size.width * 50,
                            ),
                          ],
                        ),
                        xAxisListDailySafetyControllableDegree.isNotEmpty ? homeBar(
                          width: size.width * 10,
                          height: size.width * 250,
                          yAxis: yAxisDailySafetyControllableDegree + yAxisDailySafetyControllableDegree / 2,
                          xAxisList: xAxisListDailySafetyControllableDegree,
                        ) : Container(
                          width: size.width * 10,
                          height: size.width * 250,
                        ),
                      ],
                    ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 200,
                          height: size.width * 200,
                          margin: EdgeInsets.only(
                              left: size.width * 30,
                              right: size.width * 20,
                              top: size.width * 20,
                              bottom: size.width * 20),
                          child: Stack(
                            children: [
                              PieChartSample2(
                                roundUi: [
                                  XAxisSturct(
                                      color: Color(0xff817FFF),
                                      nums: dailySafetyImplemented * 1.0),
                                  XAxisSturct(
                                      color: Color(0xff3585FF),
                                      nums: dailySafetyNotImplemented * 1.0),
                                ],
                              ),
                              Positioned(
                                  child: Center(
                                      child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dailySafetyTotal.toString(),
                                    style: TextStyle(
                                        color: Color(0xff696C74),
                                        fontSize: size.width * 30,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '清单总数',
                                    style: TextStyle(
                                        color: Color(0xff959BA7),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ))),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 50,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 14,
                                    height: size.width * 14,
                                    color: Color(0xff817FFF),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '已落实       ',
                                        style: TextStyle(
                                            color: Color(0xffA7ADB7),
                                            fontSize: size.width * 26,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: dailySafetyImplemented.toString(),
                                        style: TextStyle(
                                            color: Color(0xff494F5B),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 14,
                                    height: size.width * 14,
                                    color: Color(0xff3585FF),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '未落实       ',
                                        style: TextStyle(
                                            color: Color(0xffA7ADB7),
                                            fontSize: size.width * 26,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: dailySafetyNotImplemented.toString(),
                                        style: TextStyle(
                                            color: Color(0xff494F5B),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )
            ]))),
        // 今日管控措施实时统计
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width * 10, horizontal: size.width * 20),
            child: Card(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 15,
                      top: size.width * 20,
                      bottom: size.width * 20),
                  child: Text(
                    '今日管控措施实时统计',
                    style: TextStyle(
                        color: Color(0xff272F3D),
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 28),
                  ),
                ),
                Container(
                  height: size.width * 2,
                  width: double.infinity,
                  color: Color(0xffF7F7F7),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 20, horizontal: size.width * 50),
                  child: Row(
                    children: [
                      Container(
                        height: size.width * 70,
                        width: size.width * 70,
                        decoration: BoxDecoration(
                            color: Color(0xff6DE2FF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/xunjiandianjian@2x@2x.png",
                          height: size.width * 37,
                          width: size.width * 40,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 70,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            checkNum.toString() + '    条',
                            style: TextStyle(
                                color: Color(0xff6DE2FF),
                                fontSize: size.width * 33),
                          ),
                          Text(
                            '巡检点检',
                            style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: size.width * 27,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 20, horizontal: size.width * 50),
                  child: Row(
                    children: [
                      Container(
                        height: size.width * 70,
                        width: size.width * 70,
                        decoration: BoxDecoration(
                            color: Color(0xff8565FF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/yinhuanpaicha@2x@2x.png",
                          height: size.width * 32,
                          width: size.width * 30,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 70,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hiddenNum.toString() + '    条',
                            style: TextStyle(
                                color: Color(0xff8565FF),
                                fontSize: size.width * 33),
                          ),
                          Text(
                            '隐患排查',
                            style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: size.width * 27,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 15, horizontal: size.width * 50),
                  child: Row(
                    children: [
                      Container(
                        height: size.width * 70,
                        width: size.width * 70,
                        decoration: BoxDecoration(
                            color: Color(0xff6D9FFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/anquanzuoye@2x@2x.png",
                          height: size.width * 30,
                          width: size.width * 28,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 70,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workNum.toString() + '    条',
                            style: TextStyle(
                                color: Color(0xff6D9FFF),
                                fontSize: size.width * 33),
                          ),
                          Text(
                            '作业安全措施',
                            style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: size.width * 27,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ))),
      ],
    );
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

class DoubleControlPaint extends CustomPainter {
  Paint _paint = Paint()
    ..color = Color(0xffC7D3EE)
    ..strokeWidth = 1
    ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    Path _path = Path();
    _path.moveTo(size.width / 3 * 2, 0);
    _path.lineTo(size.width, size.height / 2);
    _path.lineTo(size.width / 3 * 2, size.height);
    _path.close();
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
