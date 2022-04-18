import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/spotCheck/_spotCheckCircle.dart';
import 'package:enterprise/pages/home/spotCheck/_spotCheckDrewar.dart';
import 'package:enterprise/pages/home/spotCheck/_spotCheckItem.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

/*
 *  巡检点检风险单元页面 
 *  dropList ： 上一级 巡检点检风险点列表数据
 *  index ： 巡检点检风险点列表索引
 */
class SpotCheckControl extends StatefulWidget {
  final int index;
  final List dropList;
  SpotCheckControl({Key key, this.dropList, this.index}) : super(key: key);
  @override
  _SpotCheckControlState createState() => _SpotCheckControlState();
}

class _SpotCheckControlState extends State<SpotCheckControl> {
  int select = 0;
  ThrowFunc _throwFunc = ThrowFunc();
  List spotCheckUnitList = [];
  int totalSpotCheckStatistics;
  int totalInitialSpotCheckStatistics;
  List<TogglePicType> titleBar = [
    TogglePicType(
      title: "当前点检控制情况",
      data: [
        XAxisSturct(names: '受控项', color: Color(0xff31CB72), nums: 0.0),
        XAxisSturct(names: '不受控项', color: Color(0xffFE7A92), nums: 0.0),
      ],
      totalNum: 0,
    ),
    TogglePicType(
      title: "点检异常处置情况",
      data: [
        XAxisSturct(names: '待确认', color: Color(0xffFB681E), nums: 0.0),
        XAxisSturct(names: '待整改', color: Color(0xffFBAC51), nums: 0.0),
        XAxisSturct(names: '待审批', color: Color(0xffFCD073), nums: 0.0),
      ],
      totalNum: 0,
    ),
  ];
  int choosed = 0;
  void initState() {
    super.initState();
    select = widget.index;
    _getTitle(select);
  }

  //  今日点检落实进度
  Future<TogglePicTypedata> _getImplementationStatistics(int index) async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[0].data);
    final value = await myDio.request(
        type: 'get',
        url: Interface.getImplementationStatistics,
        queryParameters: {
          "controlType": 2,
          "oneId": widget.dropList[index]['oneId'],
        });

    if (value is Map) {
      _data.data[0].nums = value['controlledNum'] * 1.0;
      _data.data[1].nums = value['uncontrolledNum'] * 1.0;
      _data.totalNum = value['totalNum'];
    }
    return _data;
  }

  // 点检异常处置情况
  Future<TogglePicTypedata> _getDisposalDiddenDangersStatistics(
      int index) async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[1].data);
    final value = await myDio.request(
        type: 'get',
        url: Interface.getDisposalDiddenDangersStatistics,
        queryParameters: {
          "controlType": 2,
          "oneId": widget.dropList[index]['oneId'],
        });

    if (value is Map) {
      _data.data[0].nums = value['confirmedNum'] * 1.0;
      _data.data[1].nums = value['rectificatioNum'] * 1.0;
      _data.data[2].nums = value['approveNum'] * 1.0;
      _data.totalNum = value['confirmedNum'] +
          value['rectificatioNum'] +
          value['approveNum'];
    }

    return _data;
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
    return Scaffold(
        key: _globalKey,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: lineGradBlue,
              ),
            ),
          ),
          title: Text(
            title,
          ),
          leading: BackButton(),
        ),
        drawer: Container(
            color: Color(0xffF4F6FA),
            width: width * 450,
            child: SpotCheckDrewar(
              select: select,
              width: width,
              spotCheckUnitList: widget.dropList,
              callback: (int index) {
                select = index;
                _throwFunc.run(argument: {
                  "current": 1,
                  "size": 30,
                  "oneId": widget.dropList[select]['oneId'],
                  "controlType": 2
                });
                _getTitle(index);
                setState(() {});
              },
            )),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            _getTitle(index);
                            _throwFunc.run(argument: {
                              "current": 1,
                              "size": 30,
                              "oneId": widget.dropList[select]['oneId'],
                              "controlType": 2
                            });
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
                                    child: SpotCheckCircle(
                                      width: width * 40,
                                      radius: 15,
                                      text: _getText(index),
                                      level: widget.dropList[index]
                                          ['riskLevel'],
                                      initialSpotCheckLevel: widget
                                          .dropList[index]['initialRiskLevel'],
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
                child: MyRefres(
                    child: (index, list) {
                      if (index == 0) {
                        return Column(
                          children: [
                            Card(
                                child: Column(children: [
                              CustomEchart().togglePic(
                                  centerChild: '受控项',
                                  data: titleBar,
                                  onpress: (index) async {
                                    if (index == 0) {
                                      return _getImplementationStatistics(
                                          select);
                                    } else {
                                      return _getDisposalDiddenDangersStatistics(
                                          select);
                                    }
                                  }),
                            ])),
                            GestureDetector(
                              child: SpotCheckItems(
                                width: width,
                                spotCheckData: list[index],
                                index: index,
                                type: "unit",
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/home/spotCheck/spotCheckCounts',
                                    arguments: {
                                      "index": index,
                                      'spotCheckUnitList': list
                                    });
                              },
                            )
                          ],
                        );
                      } else {
                        return GestureDetector(
                          child: SpotCheckItems(
                            width: width,
                            spotCheckData: list[index],
                            index: index,
                            type: "unit",
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/home/spotCheck/spotCheckCounts',
                                arguments: {
                                  "index": index,
                                  'spotCheckUnitList': list
                                });
                          },
                        );
                      }
                    },
                    url: Interface.getriskControlUnitList,
                    method: 'get',
                    listParam: 'records',
                    throwFunc: _throwFunc,
                    queryParameters: {
                  "current": 1,
                  "size": 30,
                  "oneId": widget.dropList[select]['oneId'],
                  "controlType": 2
                }))
          ],
        ));
  }
}
