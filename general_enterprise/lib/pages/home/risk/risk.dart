import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../tool/funcType.dart';

/*
 *  风险首页 风险点 
 */
class Risk extends StatefulWidget {
  @override
  _RiskState createState() => _RiskState();
}

class _RiskState extends State<Risk> {
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
      "title": "列表",
      "descript": "选择需要使用的",
      "img": "assets/images/apply.png",
      "isClick": true
    },
  ];

  int choosed = 1;
  int oldPage = 1;

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

  Map riskStatistics = {};
  //  风险统计

  int inspectionNum;
  int hiddenInvestigationNum;

  Widget _changeTitle(width, item) {
    Widget _widget;

    if (item['title'] == '总览') {
      _widget = Pictrue();
    } else if (item['title'] == '列表') _widget = MenuList();
    // ListTable(
    //   getriskList: _getriskList,
    //   dropList: dropList,
    // );
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return MyAppbar(
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
                      fontSize: width * 35),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 40, vertical: width * 10),
              ),
            );
          }).toList(),
        ),
      ),
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (context, index) => _changeTitle(width, workData[index]),
        itemCount: workData.length,
      ),
    );
  }
}

class MenuList extends StatefulWidget {
  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  List data = [
    {
      'title': '风险管控',
      'content': '包含初始风险和剩余风险统计、风险管控分类、区域分布、风险管控台账',
      'icon': 'assets/images/fxgk@2x.png',
      'route': '/home/risk/riskHome',
    },
    {
      'title': '控制指标历史数据',
      'content': '风险管控温度、压力、液位、流速等的历史数据记录',
      'icon': 'assets/images/kz@2x.png',
      'route': '/home/risk/controlIndex',
    },
    {
      'title': '风险不受控数据',
      'content': '全厂共0项不受控风险',
      'icon': 'assets/images/fx@2x.png',
      'route': '/home/risk/riskUncontrollable',
    },
  ];

  int num = 0;

  @override
  void initState() {
    super.initState();
    _getNum();
  }

  _getNum(){
    myDio.request(
      type: 'get',
      url: Interface.getUncontrolledAll,
    ).then((value) {
      if (value is Map) {
        num = value['num'];
        data[2]['content'] = '全厂共' + num.toString() + '项不受控风险';
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (data[index]['route'] != '') {
                Navigator.pushNamed(context, data[index]['route'],
                    arguments: {});
              } else {
                Fluttertoast.showToast(msg: '敬请期待');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2.0,
                        spreadRadius: 1.0),
                  ]),
              width: size.width * 690,
              height: size.width * 280,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 40, vertical: size.width * 30),
              margin: EdgeInsets.symmetric(
                  vertical: size.width * 20, horizontal: size.width * 25),
              child: Row(
                children: [
                  Container(
                    width: size.width * 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index]['title'],
                          style: TextStyle(
                              fontSize: size.width * 34,
                              color: Color(0xff393B3D),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        index == 2 
                        ? RichText(
                          text: TextSpan(style: TextStyle(fontSize: size.width * 20,), children: [
                            TextSpan(text: "全厂共", style: TextStyle(color: Color(0xffa0a2a3))),
                            TextSpan(text: num.toString() + "项", style: TextStyle(color: Color(0xffff6969))),
                            TextSpan(text: "不受控风险", style: TextStyle(color: Color(0xffa0a2a3))),
                          ]),
                          textDirection: TextDirection.ltr,
                        )
                        : Text(
                          data[index]['content'],
                          style: TextStyle(
                              fontSize: size.width * 20,
                              color: Color(0xffa0a2a3)),
                        ),
                        Spacer(),
                        Text(
                          '查看详情 >',
                          style: TextStyle(
                              fontSize: size.width * 22,
                              color: Color(0xff2f6efd)),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    data[index]['icon'],
                    width: size.width * 194,
                    height: size.width * 193,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Pictrue extends StatefulWidget {
  Pictrue();

  @override
  _PictrueState createState() => _PictrueState();
}

class _PictrueState extends State<Pictrue> {
  List gridList = [];
  int totalRiskStatistics;
  int totalOneRiskLeve;
  int totalTwoRiskLeve;
  int totalThreeRiskLeve;
  int totalFourRiskLeve;
  bool checked = true;
  List riskPointList = [];
  Map valueList = {
    "oneRiskLevel": 0,
    "twoRiskLevel": 0,
    "threeRiskLevel": 0,
    "fourRiskLevel": 0,
  };
  double hiddenInvestigationNum = 0.0;
  double inspectionNum = 0.0;
  List<MutipleXAxisSturct> xAxisList = [];
  int totalInitialRiskStatistics = 0;
  List oneRiskLevelList,
      twoRiskLevelList,
      threeRiskLevelList,
      fourRiskLevelList = [];

  double maxYAxis = 0.0;
  Map riskStatistics = {
    "oneRiskLevel": 0,
    "twoRiskLevel": 0,
    "threeRiskLevel": 0,
    "fourRiskLevel": 0,
    "initialOneRiskLevel": 0,
    "initialTwoRiskLevel": 0,
    "initialThreeRiskLevel": 0,
    "initialFourRiskLevel": 0,
  };

  @override
  void initState() {
    super.initState();
    _getriskStatistics(); //统计
    _getcontrolClassify(); //管控分类
    _getRiskPoint();
    gridList = [
      {
        "name": "重大风险",
        'value': 0,
        'color': Color(0xffF7454A),
      },
      {
        "name": "较大风险",
        'value': 0,
        'color': Color(0xffF39D41),
      },
      {
        "name": "一般风险",
        'value': 0,
        'color': Color(0xffF3D341),
      },
      {
        "name": "低风险",
        'value': 0,
        'color': Color(0xff37A9F9),
      },
    ];
  }

  // 风险管控分类统计
  _getcontrolClassify() {
    myDio
        .request(
      type: 'get',
      url: Interface.getControlClassificationStatistics,
    )
        .then((value) {
      if (value != null) {
        inspectionNum = double.parse(value['inspectionNum'].toString());
        hiddenInvestigationNum =
            double.parse(value['hiddenInvestigationNum'].toString());
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getriskStatistics() {
    myDio.request(type: 'get', url: Interface.getRiskStatistics).then((value) {
      if (value != null) {
        riskStatistics = value;
        totalRiskStatistics = riskStatistics['oneRiskLevel'] +
            riskStatistics['twoRiskLevel'] +
            riskStatistics['threeRiskLevel'] +
            riskStatistics['fourRiskLevel'];
        totalInitialRiskStatistics = riskStatistics['initialOneRiskLevel'] +
            riskStatistics['initialTwoRiskLevel'] +
            riskStatistics['initialThreeRiskLevel'] +
            riskStatistics['initialFourRiskLevel'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getRiskPoint() {
    myDio.request(type: 'get', url: Interface.getRiskPoint).then((value) {
      if (value != null) {
        riskPointList = value;
        List<MutipleXAxisSturct> mutiplexAxisList = [];
        List<int> _list = [];
        for (int i = 0; i < riskPointList.length; i++) {
          mutiplexAxisList.add(
              MutipleXAxisSturct(names: riskPointList[i]['riskPoint'], nums: [
            double.parse(riskPointList[i]['oneRiskLevel'].toString()),
            double.parse(riskPointList[i]['twoRiskLevel'].toString()),
            double.parse(riskPointList[i]['threeRiskLevel'].toString()),
            double.parse(riskPointList[i]['fourRiskLevel'].toString()),
          ]));
          gridList[0]['value'] += riskPointList[i]['oneRiskLevel'];
          gridList[1]['value'] += riskPointList[i]['twoRiskLevel'];
          gridList[2]['value'] += riskPointList[i]['threeRiskLevel'];
          gridList[3]['value'] += riskPointList[i]['fourRiskLevel'];
          _list.add(riskPointList[i]['oneRiskLevel']);
          _list.add(riskPointList[i]['twoRiskLevel']);
          _list.add(riskPointList[i]['threeRiskLevel']);
          _list.add(riskPointList[i]['fourRiskLevel']);
        }

        xAxisList = mutiplexAxisList;
        if (valueList != null) {
          maxYAxis = _list.getmax(_list) + 20.0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 10, vertical: size.width * 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 初始风险统计/剩余风险统计
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: size.width * 15, horizontal: size.width * 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0),
                  ]),
              child: Column(
                children: [
                  Container(
                    height: size.width * 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              checked = true;
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Column(
                              children: [
                                checked
                                    ? Image.asset(
                                        'assets/images/mark_cut_cartogram.png',
                                        height: size.width * 10,
                                        width: size.width * 260,
                                      )
                                    : Container(
                                        height: size.width * 10,
                                        width: size.width * 260,
                                      ),
                                SizedBox(
                                  height: size.width * 25,
                                ),
                                Text(
                                  '初始风险统计',
                                  style: TextStyle(
                                      color: checked
                                          ? Color(0xff306CFD)
                                          : Color(0xffA0A0A0),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        GestureDetector(
                            onTap: () {
                              checked = false;
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Column(
                              children: [
                                checked == false
                                    ? Image.asset(
                                        'assets/images/mark_cut_cartogram.png',
                                        height: size.width * 10,
                                        width: size.width * 260,
                                      )
                                    : Container(
                                        height: size.width * 10,
                                        width: size.width * 260,
                                      ),
                                SizedBox(
                                  height: size.width * 25,
                                ),
                                Text(
                                  '剩余风险统计',
                                  style: TextStyle(
                                      color: checked
                                          ? Color(0xffA0A0A0)
                                          : Color(0xff306CFD),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PieChartSample2(
                          roundUi: [
                            XAxisSturct(
                                color: Color(0xffF7454A),
                                nums: checked
                                    ? riskStatistics['oneRiskLevel'] * 1.0
                                    : riskStatistics['initialOneRiskLevel'] *
                                        1.0),
                            XAxisSturct(
                                color: Color(0xffF39D41),
                                nums: checked
                                    ? riskStatistics['twoRiskLevel'] * 1.0
                                    : riskStatistics['initialTwoRiskLevel'] *
                                        1.0),
                            XAxisSturct(
                                color: Color(0xffF3D341),
                                nums: checked
                                    ? riskStatistics['threeRiskLevel'] * 1.0
                                    : riskStatistics['initialThreeRiskLevel'] *
                                        1.0),
                            XAxisSturct(
                                color: Color(0xff37A9F9),
                                nums: checked
                                    ? riskStatistics['fourRiskLevel'] * 1.0
                                    : riskStatistics['initialFourRiskLevel'] *
                                        1.0),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.width * 20,
                            ),
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: '风险总数     ',
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: checked
                                      ? totalInitialRiskStatistics.toString()
                                      : totalRiskStatistics.toString(),
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: size.width * 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: size.width * 14,
                                  width: size.width * 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF7454A),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.0))),
                                ),
                                SizedBox(
                                  width: size.width * 10,
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: '重大风险     ',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: checked
                                          ? riskStatistics[
                                                  'initialOneRiskLevel']
                                              .toString()
                                          : riskStatistics['oneRiskLevel']
                                              .toString(),
                                      style: TextStyle(
                                          color: Color(0xffF7454A),
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
                                  height: size.width * 14,
                                  width: size.width * 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF49E41),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.0))),
                                ),
                                SizedBox(
                                  width: size.width * 10,
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: '较大风险     ',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: checked
                                          ? riskStatistics[
                                                  'initialTwoRiskLevel']
                                              .toString()
                                          : riskStatistics['twoRiskLevel']
                                              .toString(),
                                      style: TextStyle(
                                          color: Color(0xffF49E41),
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
                                  height: size.width * 14,
                                  width: size.width * 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF4D341),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.0))),
                                ),
                                SizedBox(
                                  width: size.width * 10,
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: '一般风险     ',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: checked
                                          ? riskStatistics[
                                                  'initialThreeRiskLevel']
                                              .toString()
                                          : riskStatistics['threeRiskLevel']
                                              .toString(),
                                      style: TextStyle(
                                          color: Color(0xffF4D341),
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
                                  height: size.width * 14,
                                  width: size.width * 14,
                                  decoration: BoxDecoration(
                                      color: Color(0xff37A9FA),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.0))),
                                ),
                                SizedBox(
                                  width: size.width * 10,
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: '低风险         ',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: checked
                                          ? riskStatistics[
                                                  'initialFourRiskLevel']
                                              .toString()
                                          : riskStatistics['fourRiskLevel']
                                              .toString(),
                                      style: TextStyle(
                                          color: Color(0xff37A9FA),
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
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            // 管控分类
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: size.width * 15, horizontal: size.width * 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(title: '管控分类'),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffF7F7F7),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: size.width * 10, bottom: size.width * 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: PieChartSample2(
                            roundUi: [
                              XAxisSturct(
                                nums: hiddenInvestigationNum * 1.0,
                                color: Color(0xff6554C0),
                              ),
                              XAxisSturct(
                                nums: inspectionNum * 1.0,
                                color: Color(0xff5FBDB2),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: size.width * 18,
                                    width: size.width * 18,
                                    decoration: BoxDecoration(
                                        color: Color(0xff6554C0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0))),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '隐患排查     ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: hiddenInvestigationNum.toString(),
                                        style: TextStyle(
                                            color: Color(0xffA4A4A4),
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
                                    height: size.width * 18,
                                    width: size.width * 18,
                                    decoration: BoxDecoration(
                                        color: Color(0xff5FBDB2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0))),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '巡检点检     ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: inspectionNum.toString(),
                                        style: TextStyle(
                                            color: Color(0xffA4A4A4),
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
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // // 区域分布
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: size.width * 15, horizontal: size.width * 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(title: '区域分布'),
                  Container(
                    height: size.width * 1,
                    width: double.infinity,
                    color: Color(0xffF7F7F7),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 20,
                        bottom: size.width * 20,
                        right: size.width * 20),
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: size.width * 16,
                                  height: size.width * 10,
                                  color: gridList[0]['color'],
                                  margin:
                                      EdgeInsets.only(right: size.width * 10),
                                ),
                                Container(
                                  child: Text(
                                    gridList[0]['name'] +
                                        ('总计(${gridList[0]["value"]})'),
                                    style: TextStyle(fontSize: size.width * 16),
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
                                  width: size.width * 16,
                                  height: size.width * 10,
                                  color: gridList[1]['color'],
                                  margin:
                                      EdgeInsets.only(right: size.width * 10),
                                ),
                                Container(
                                  child: Text(
                                    gridList[1]['name'] +
                                        ('总计(${gridList[1]["value"]})'),
                                    style: TextStyle(fontSize: size.width * 16),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: size.width * 16,
                                  height: size.width * 10,
                                  color: gridList[2]['color'],
                                  margin:
                                      EdgeInsets.only(right: size.width * 10),
                                ),
                                Container(
                                  child: Text(
                                    gridList[2]['name'] +
                                        ('总计(${gridList[2]["value"]})'),
                                    style: TextStyle(fontSize: size.width * 16),
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
                                  width: size.width * 16,
                                  height: size.width * 10,
                                  color: gridList[3]['color'],
                                  margin:
                                      EdgeInsets.only(right: size.width * 10),
                                ),
                                Container(
                                  child: Text(
                                    gridList[3]['name'] +
                                        ('总计(${gridList[3]["value"]})'),
                                    style: TextStyle(fontSize: size.width * 16),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomEchart().mutipleBar(
                      xAxisList: xAxisList,
                      yAxis: maxYAxis,
                      color: [
                        Colors.red,
                        Color(0xffF39D41),
                        Color(0xffF3D341),
                        Color(0xff37A9F9),
                      ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title({String title = '标题'}) {
    Widget _widget;
    _widget = Container(
      margin: EdgeInsets.symmetric(
          vertical: size.width * 15, horizontal: size.width * 25),
      child: Text(
        title,
        style: TextStyle(
            fontSize: size.width * 30,
            color: Color(0xff333333),
            fontWeight: FontWeight.bold),
      ),
    );
    return _widget;
  }
}
