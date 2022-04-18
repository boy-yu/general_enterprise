import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/Refre.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';

import 'package:enterprise/pages/home/risk/_riskItem.dart';
import 'package:enterprise/pages/home/risk/_riskCircle.dart';
import 'package:enterprise/pages/home/risk/_riskDrewar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
 *  风险单元页面 
 *  dropList ： 上一级 风险点列表数据
 *  index ： 风险点列表索引
 */
class RiskControl extends StatefulWidget {
  final int index;
  final List dropList;
  RiskControl({Key key, this.dropList, this.index}) : super(key: key);
  @override
  _RiskControlState createState() => _RiskControlState();
}

class _RiskControlState extends State<RiskControl> {
  int select;
  List riskunitList = [];
  List<TogglePicType> titleBar = [
    TogglePicType(title: '初始风险统计', data: [
      XAxisSturct(names: '重大风险', color: Color(0xffF7454A), nums: 0),
      XAxisSturct(names: '较大风险', color: Color(0xffF49E41), nums: 0),
      XAxisSturct(names: '一般风险', color: Color(0xffF4D341), nums: 0),
      XAxisSturct(names: '低风险', color: Color(0xff37A9FA), nums: 0),
    ]),
    TogglePicType(title: '剩余风险统计', data: [
      XAxisSturct(names: '重大风险', color: Color(0xffF7454A), nums: 0),
      XAxisSturct(names: '较大风险', color: Color(0xffF49E41), nums: 0),
      XAxisSturct(names: '一般风险', color: Color(0xffF4D341), nums: 0),
      XAxisSturct(names: '低风险', color: Color(0xff37A9FA), nums: 0),
    ]),
    TogglePicType(title: '管控分类', data: [
      XAxisSturct(names: '隐患排查', color: Color(0xff6554C0), nums: 0),
      XAxisSturct(names: '巡检点检', color: Color(0xff5FBDB2), nums: 0),
    ]),
  ];
  int choosed = 0;

  void initState() {
    super.initState();
    select = widget.index;
    // _getriskStatistics(select);
    _getControlClassificationStatistics(select);

    _getriskunitList(select);
    _getTitle(select);
  }

  //  风险统计
  Future<TogglePicTypedata> _getriskStatistics(int index) async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[0].data);
    final value = await myDio.request(
        type: 'get',
        url: Interface.getRiskStatistics,
        queryParameters: {
          "oneId": widget.dropList[index]['oneId'],
        });
    if (value is Map) {
      titleBar[0].data[0].nums = value['initialOneRiskLevel'] * 1.0;
      titleBar[0].data[1].nums = value['initialTwoRiskLevel'] * 1.0;
      titleBar[0].data[2].nums = value['initialThreeRiskLevel'] * 1.0;
      titleBar[0].data[3].nums = value['initialFourRiskLevel'] * 1.0;
      titleBar[0].totalNum = value['initialOneRiskLevel'] +
          value['initialTwoRiskLevel'] +
          value['initialThreeRiskLevel'] +
          value['initialFourRiskLevel'];
      titleBar[1].data[0].nums = value['oneRiskLevel'] * 1.0;
      titleBar[1].data[1].nums = value['twoRiskLevel'] * 1.0;
      titleBar[1].data[2].nums = value['threeRiskLevel'] * 1.0;
      titleBar[1].data[3].nums = value['fourRiskLevel'] * 1.0;
      titleBar[1].totalNum = value['oneRiskLevel'] +
          value['twoRiskLevel'] +
          value['threeRiskLevel'] +
          value['fourRiskLevel'];
    }

    return _data;
  }

  // 管控分类统计图
  Future<TogglePicTypedata> _getControlClassificationStatistics(
      int index) async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[0].data);
    final value = await myDio.request(
        type: 'get',
        url: Interface.getControlClassificationStatistics,
        queryParameters: {
          "oneId": widget.dropList[index]['oneId'],
        });
    if (value is Map) {
      titleBar[2].data[0].nums = value['hiddenInvestigationNum'] * 1.0;
      titleBar[2].data[1].nums = value['inspectionNum'] * 1.0;

      titleBar[2].totalNum =
          value['hiddenInvestigationNum'] + value['inspectionNum'];
    }

    return _data;
  }

  Future _getriskunitList(int index) async {
    final value = await myDio.request(
        type: 'get',
        url: Interface.getriskControlUnitList,
        queryParameters: {
          "current": 1,
          "size": 1000,
          "oneId": widget.dropList[index]['oneId']
        });

    if (value != null) {
      riskunitList = value["records"];
      if (mounted) {
        setState(() {});
      }
    }
  }

  _getBgColor(int select, int index) {
    Color bgColor;
    if (select == index) {
      bgColor = Color(0xffffffff);
    } else {
      bgColor = Color(0xffEAEDF2);
    }
    return bgColor;
  }

  _getText(int index) {
    String text;
    if (widget.dropList[index]["twoId"] != null) {
      text = widget.dropList[index]["riskUnit"].toString().substring(0, 2);
    } else if (widget.dropList[index]["threeId"] != null) {
      text = widget.dropList[index]["riskItem"].toString().substring(0, 2);
    } else {
      text = widget.dropList[index]["riskPoint"].toString().substring(0, 2);
    }
    return text;
  }

  String title = '';

  _getTitle(int index) {
    title = widget.dropList[index]['riskPoint'].toString();
    return title;
  }

  int checked = 1;

  getValue(int index) {
    int value;
    if (widget.dropList[index]['totalNum'] == 0 ||
        widget.dropList[index]['totalNum'] == null ||
        widget.dropList[index]['uncontrolledNum'] == null) {
      value = 10;
    } else {
      value = 10 -
          (((widget.dropList[index]['totalNum'] -
                      widget.dropList[index]['uncontrolledNum']) /
                  widget.dropList[index]['totalNum'] *
                  10)
              .toInt()
              .abs());
    }
    return value;
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return MyAppbar(
        title: Text(
          title,
        ),
        elevation: 0,
        child: Scaffold(
          key: _globalKey,
          drawer: Container(
              color: Color(0xffF4F6FA),
              width: width * 450,
              child: RiskDrewar(
                select: select,
                width: width,
                riskunitList: widget.dropList,
                callback: (int index) {
                  select = index;
                  _getriskunitList(index);
                  _getTitle(index);
                  _getriskStatistics(index);
                  _getControlClassificationStatistics(index);
                },
              )),
          body: Row(
            children: [
              Container(
                width: width * 90,
                color: Color(0xffEAEDF2),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _globalKey.currentState.openDrawer();
                      },
                      child: Container(
                        height: width * 90,
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Image.asset('assets/images/hidden_open.png',
                                    width: width * 26, height: width * 26),
                                Text(
                                  "展开",
                                  style: TextStyle(fontSize: width * 16),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.dropList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              select = index;
                              _getriskunitList(index);
                              _getTitle(index);
                              _getriskStatistics(index);
                              _getControlClassificationStatistics(index);
                              context.read<Counter>().refreshFun(true);
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Container(
                                width: width * 90,
                                height: width * 90,
                                color: _getBgColor(select, index),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: RiskCircle(
                                        width: width * 40,
                                        radius: 15,
                                        text: _getText(index),
                                        level: widget.dropList[index]
                                            ['riskLevel'],
                                        initialRiskLevel: widget.dropList[index]
                                            ['initialRiskLevel'],
                                        value: getValue(index),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Refre(
                      initRefresh: false,
                      child: (child, state, end, updata) => Column(
                            children: [
                              child,
                              Expanded(
                                  child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                itemCount: riskunitList.length,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Column(
                                      children: [
                                        CustomEchart().togglePic(
                                            data: titleBar,
                                            onpress: (value) async {
                                              if (index == 2)
                                                return await _getControlClassificationStatistics(
                                                    select);
                                              else
                                                return await _getriskStatistics(
                                                    select);
                                            }),
                                        GestureDetector(
                                          child: RiskItems(
                                            width: width,
                                            riskData: riskunitList,
                                            index: index,
                                            type: "unit",
                                          ),
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                "/home/risk/RiskCounts",
                                                arguments: {
                                                  "index": index,
                                                  'riskunitList': riskunitList
                                                }).then((value) {
                                              _getriskStatistics(select);
                                              _getControlClassificationStatistics(
                                                  select);
                                              _getriskunitList(select);
                                              _getTitle(select);
                                            });
                                          },
                                        )
                                      ],
                                    );
                                  }
                                  return GestureDetector(
                                    child: RiskItems(
                                      width: width,
                                      riskData: riskunitList,
                                      index: index,
                                      type: "unit",
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/home/risk/RiskCounts",
                                          arguments: {
                                            "index": index,
                                            'riskunitList': riskunitList
                                          }).then((value) {
                                        _getriskStatistics(select);
                                        _getControlClassificationStatistics(
                                            select);
                                        _getriskunitList(select);
                                        _getTitle(select);
                                      });
                                    },
                                  );
                                },
                              ))
                            ],
                          ),
                      onRefresh: () async {
                        await _getriskunitList(select);
                      }))
            ],
          ),
        ));
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
