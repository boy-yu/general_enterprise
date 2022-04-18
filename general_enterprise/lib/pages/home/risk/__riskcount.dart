import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/Refre.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/risk/_riskItem.dart';
import 'package:enterprise/pages/home/risk/_riskCircle.dart';
import 'package:enterprise/pages/home/risk/_riskDrewar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//  "riskLevel":
//  1	重大风险 红色
//  2 较大 橙色
//  3 一般 黄色
//  4 低风险 蓝色
/*
 *  风险项页面
 *  riskunitList : 上一级 风险单元列表数据
 *  index ： 风险单元列表索引
 */
class RiskCounts extends StatefulWidget {
  final int index;
  final List riskunitList;
  const RiskCounts({Key key, this.index, this.riskunitList}) : super(key: key);
  @override
  _RiskCountsState createState() => _RiskCountsState();
}

class _RiskCountsState extends State<RiskCounts> {
  @override
  void initState() {
    super.initState();
    _getTitle(widget.index);
  }

  String title = '';

  _getTitle(int index) {
    title = widget.riskunitList[index]['riskUnit'].toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          title,
        ),
        child: Container(
            color: Color(0xffffffff),
            child: KJHasd(
              riskunitList: widget.riskunitList,
              select: widget.index,
              getTitle: _getTitle,
            )));
  }
}

/*
 *  riskunitList : 风险单元 列表数据
 *  dropList : 风险项 列表数据
 */
class KJHasd extends StatefulWidget {
  final List riskunitList;
  final int select;
  KJHasd({
    @required this.riskunitList,
    this.select,
    this.getTitle,
  });
  final Function getTitle;
  @override
  _KJHasdState createState() => _KJHasdState();
}

class _KJHasdState extends State<KJHasd> {
  List<TogglePicType> titleBar = [
    TogglePicType(title: "初始风险统计", data: [
      XAxisSturct(names: '重大风险', color: Color(0xffF7454A), nums: 0),
      XAxisSturct(names: '较大风险', color: Color(0xffF49E41), nums: 0),
      XAxisSturct(names: '一般风险', color: Color(0xffF4D341), nums: 0),
      XAxisSturct(names: '低风险', color: Color(0xff37A9FA), nums: 0),
    ]),
    TogglePicType(title: "剩余风险统计", data: [
      XAxisSturct(names: '重大风险', color: Color(0xffF7454A), nums: 0),
      XAxisSturct(names: '较大风险', color: Color(0xffF49E41), nums: 0),
      XAxisSturct(names: '一般风险', color: Color(0xffF4D341), nums: 0),
      XAxisSturct(names: '低风险', color: Color(0xff37A9FA), nums: 0),
    ]),
    TogglePicType(title: "管控分类", data: [
      XAxisSturct(names: '隐患排查', color: Color(0xff6554C0), nums: 0),
      XAxisSturct(names: '巡检点检', color: Color(0xff5FBDB2), nums: 0),
    ]),
  ];
  int choosed = 0;
  int select;
  List riskCountList = [];
  int checked = 1;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    select = widget.select;
    // _getriskList(widget.select);
    _getriskStatistics(widget.select);
    _getControlClassificationStatistics(widget.select);
  }

  //  风险统计
  _getriskStatistics(int index) {
    myDio.request(
        type: 'get',
        url: Interface.getRiskStatistics,
        queryParameters: {
          "twoId": widget.riskunitList[index]['twoId'],
        }).then((value) {
      if (value is Map) {
        // titleBar[0]['data'][0]['value'] = value['initialOneRiskLevel'];
        // titleBar[0]['data'][1]['value'] = value['initialTwoRiskLevel'];
        // titleBar[0]['data'][2]['value'] = value['initialThreeRiskLevel'];
        // titleBar[0]['data'][3]['value'] = value['initialFourRiskLevel'];
        // titleBar[0]['totalNum'] = value['initialOneRiskLevel'] +
        //     value['initialTwoRiskLevel'] +
        //     value['initialThreeRiskLevel'] +
        //     value['initialFourRiskLevel'];
        // titleBar[1]['data'][0]['value'] = value['oneRiskLevel'];
        // titleBar[1]['data'][1]['value'] = value['twoRiskLevel'];
        // titleBar[1]['data'][2]['value'] = value['threeRiskLevel'];
        // titleBar[1]['data'][3]['value'] = value['fourRiskLevel'];
        // titleBar[1]['totalNum'] = value['oneRiskLevel'] +
        //     value['twoRiskLevel'] +
        //     value['threeRiskLevel'] +
        //     value['fourRiskLevel'];
        // setState(() {});
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  _getControlClassificationStatistics(int index) {
    myDio.request(
        type: 'get',
        url: Interface.getControlClassificationStatistics,
        queryParameters: {
          "twoId": widget.riskunitList[index]['twoId'],
        }).then((value) {
      if (value is Map) {
        // titleBar[2]['data'][0]['value'] = value['hiddenInvestigationNum'];
        // titleBar[2]['data'][1]['value'] = value['inspectionNum'];

        // titleBar[2]['totalNum'] =
        //     value['hiddenInvestigationNum'] + value['inspectionNum'];
        // if (mounted) {
        //   setState(() {});
        // }
      }
    });
  }

  Future _getriskList(int index) async {
    final value = await myDio.request(
        type: 'get',
        url: Interface.getriskControlItemList,
        queryParameters: {
          "current": 1,
          "size": 1000,
          "twoId": widget.riskunitList[index]['twoId'],
        });
    if (value != null) {
      riskCountList = value["records"];
      context.read<Counter>().refreshFun(false);
      if (mounted) {
        setState(() {});
      }
    }
  }

  getValue(int index) {
    int value;
    if (widget.riskunitList[index]['totalNum'] == 0 ||
        widget.riskunitList[index]['totalNum'] == null ||
        widget.riskunitList[index]['uncontrolledNum'] == null) {
      value = 10;
    } else {
      value = 10 -
          (((widget.riskunitList[index]['totalNum'] -
                      widget.riskunitList[index]['uncontrolledNum']) /
                  widget.riskunitList[index]['totalNum'] *
                  10)
              .toInt()
              .abs());
    }
    return value;
  }

  _getText(int index) {
    String text;
    if (widget.riskunitList[index]["twoId"] != null) {
      text = widget.riskunitList[index]["riskUnit"].toString().substring(0, 2);
    } else if (widget.riskunitList[index]["threeId"] != null) {
      text = widget.riskunitList[index]["riskItem"].toString().substring(0, 2);
    } else {
      text = widget.riskunitList[index]["riskPoint"].toString().substring(0, 2);
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: Container(
          color: Color(0xffF4F6FA),
          width: size.width * 450,
          child: RiskDrewar(
            select: select,
            width: size.width,
            riskunitList: widget.riskunitList,
            type: 'riskItem',
            callback: (int index) {
              select = index;
              context.read<Counter>().refreshFun(true);
              _getriskList(index);
              widget.getTitle(index);
              _getriskStatistics(index);
              _getControlClassificationStatistics(index);
            },
          )),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: size.width * 90,
              color: Color(0xffEAEDF2),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _globalKey.currentState.openDrawer();
                    },
                    child: Container(
                      height: size.width * 90,
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset('assets/images/hidden_open.png',
                                  width: size.width * 26,
                                  height: size.width * 26),
                              Text(
                                "展开",
                                style: TextStyle(fontSize: size.width * 16),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.riskunitList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              select = index;
                              _getriskList(index);
                              widget.getTitle(index);
                              _getriskStatistics(index);
                              _getControlClassificationStatistics(index);
                              context.read<Counter>().refreshFun(true);
                              setState(() {});
                            },
                            child: Container(
                              width: size.width * 90,
                              height: size.width * 90,
                              color: select == index
                                  ? Color(0xffffffff)
                                  : Color(0xffEAEDF2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RiskCircle(
                                    width: size.width * 40,
                                    radius: 15,
                                    text: _getText(index),
                                    level: widget.riskunitList[index]
                                        ['riskLevel'],
                                    initialRiskLevel: widget.riskunitList[index]
                                        ['initialRiskLevel'],
                                    value: getValue(index),
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
                  )
                ],
              )),
          Container(
              width: size.width * 650,
              child: Refre(
                  child: (child, state, end, updata) => Column(
                        children: [
                          child,
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: riskCountList.length ?? 0,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Column(
                                    children: [
                                      Card(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: titleBar
                                                  .asMap()
                                                  .keys
                                                  .map((index) => Expanded(
                                                          child: CustomPaint(
                                                        painter: SliverStyle(
                                                            choosed,
                                                            index,
                                                            titleBar.length),
                                                        child: InkWell(
                                                          onTap: () {
                                                            choosed = index;
                                                            // if (choosed == 0) {
                                                            //   if (titleBar[0][
                                                            //           'totalNum'] ==
                                                            //       0) {
                                                            //     _getriskStatistics(
                                                            //         select);
                                                            //   }
                                                            // } else {
                                                            //   if (titleBar[2][
                                                            //           'totalNum'] ==
                                                            //       0) {
                                                            //     _getControlClassificationStatistics(
                                                            //         index);
                                                            //   }
                                                            // }
                                                            if (mounted) {
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.only(
                                                                top:
                                                                    size.width *
                                                                        20,
                                                                bottom:
                                                                    size.width *
                                                                        20),
                                                            child: Text(
                                                              titleBar[index]
                                                                  .title
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.width *
                                                                          28,
                                                                  color: index ==
                                                                          choosed
                                                                      ? Color(
                                                                          0xff306CFD)
                                                                      : placeHolder,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      )))
                                                  .toList(),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: size.width * 300,
                                                  child: PieChartSample2(
                                                    // centerChild: Column(
                                                    //   children: [
                                                    //     Text(
                                                    //       '  总数   ',
                                                    //       style: TextStyle(
                                                    //           fontSize:
                                                    //               size.width *
                                                    //                   24),
                                                    //     ),
                                                    //     Text(
                                                    //       titleBar[choosed]
                                                    //           .totalNum
                                                    //           .toString(),
                                                    //       style: TextStyle(
                                                    //           fontSize:
                                                    //               size.width *
                                                    //                   24),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    roundUi:
                                                        titleBar[choosed].data,
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  children: titleBar[choosed]
                                                      .data
                                                      .map<Widget>((ele) => Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        18,
                                                                height:
                                                                    size.width *
                                                                        18,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      ele.color,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              1.0)),
                                                                ),
                                                              ),
                                                              Text(
                                                                  ele
                                                                      .names
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff656565),
                                                                      fontSize:
                                                                          size.width *
                                                                              22)),
                                                              SizedBox(
                                                                width:
                                                                    size.width *
                                                                        100,
                                                                child: Text(
                                                                  ele.nums
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          placeHolder,
                                                                      fontSize:
                                                                          size.width *
                                                                              22),
                                                                ),
                                                              )
                                                            ],
                                                          ))
                                                      .toList(),
                                                ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          List<HiddenDangerInterface>
                                              _iconList = [];
                                          _iconList = _iconList
                                              .changeHiddenDangerInterfaceType(
                                                  riskCountList,
                                                  title: 'riskItem',
                                                  id: "threeId",
                                                  icon: null,
                                                  iconWidget: null,
                                                  type: 0);
                                          Navigator.pushNamed(context,
                                              '/home/risk/riskFilterFour',
                                              arguments: {
                                                'title': riskCountList[index]
                                                        ['riskItem']
                                                    .toString(),
                                                "leftBar": _iconList,
                                                "id": riskCountList[index]
                                                    ['threeId']
                                              });
                                          // if (riskCountList[index]['controlOperable'] ==
                                          //     1) {
                                          //   WorkDialog.myDialog(context, () {
                                          //     _getriskList(select);
                                          //     widget.getTitle(index);
                                          //     _getriskStatistics(select);
                                          //     _getriskProgress(select);
                                          //   }, 6,
                                          //       threeId: riskCountList[index]['threeId'],
                                          //       riskItemtitle: riskCountList[index]
                                          //               ['riskItem']
                                          //           .toString(),
                                          //       operable: true);
                                          // } else {
                                          //   WorkDialog.myDialog(
                                          //     context,
                                          //     () {},
                                          //     6,
                                          //     threeId: riskCountList[index]['threeId'],
                                          //     operable: false,
                                          //   );
                                          // }
                                        },
                                        child: RiskItems(
                                          width: size.width,
                                          type: 'item',
                                          riskData: riskCountList,
                                          index: index,
                                        ),
                                      )
                                    ],
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    List<HiddenDangerInterface> _iconList = [];
                                    _iconList = _iconList
                                        .changeHiddenDangerInterfaceType(
                                            riskCountList,
                                            title: 'riskItem',
                                            id: "threeId",
                                            icon: null,
                                            iconWidget: null,
                                            type: 0);
                                    Navigator.pushNamed(
                                        context, '/home/risk/riskFilterFour',
                                        arguments: {
                                          'title': riskCountList[index]
                                                  ['riskItem']
                                              .toString(),
                                          "leftBar": _iconList,
                                          "id": riskCountList[index]['threeId']
                                        });
                                    // if (riskCountList[index]['controlOperable'] ==
                                    //     1) {
                                    //   WorkDialog.myDialog(context, () {
                                    //     _getriskList(select);
                                    //     widget.getTitle(index);
                                    //     _getriskStatistics(select);
                                    //     _getriskProgress(select);
                                    //     setState(() {});
                                    //   }, 6,
                                    //       threeId: riskCountList[index]['threeId'],
                                    //       riskItemtitle: riskCountList[index]
                                    //               ['riskItem']
                                    //           .toString(),
                                    //       operable: true);
                                    // } else {
                                    //   WorkDialog.myDialog(
                                    //     context,
                                    //     () {},
                                    //     6,
                                    //     threeId: riskCountList[index]['threeId'],
                                    //     operable: false,
                                    //   );
                                    // }
                                  },
                                  child: RiskItems(
                                    width: size.width,
                                    type: 'item',
                                    riskData: riskCountList,
                                    index: index,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                  onRefresh: () async {
                    await _getriskList(select);
                  }))
        ],
      ),
    );
  }

  Widget container({@required Widget child}) {
    Widget _widget;
    _widget = Container(
      height: size.width * 280,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 100, vertical: size.width * 60),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                offset: Offset(-1, 2),
                blurRadius: 1)
          ]),
      child: child == null ? Container() : child,
    );
    return _widget;
  }
}
