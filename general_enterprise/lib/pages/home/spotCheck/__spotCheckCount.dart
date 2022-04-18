import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/spotCheck/_spotCheckCircle.dart';
import 'package:enterprise/pages/home/spotCheck/_spotCheckDrewar.dart';
import 'package:enterprise/pages/home/spotCheck/_spotCheckItem.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

//  "riskLevel":
//  1	重大风险 红色
//  2 较大 橙色
//  3 一般 黄色
//  4 低风险 蓝色
/*
 *  巡检点检风险项页面
 *  spotCheckUnitList : 上一级 巡检点检风险单元列表数据
 *  index ： 巡检点检风险单元列表索引
 */
class SpotCheckCounts extends StatefulWidget {
  final int index;
  final List spotCheckUnitList;
  const SpotCheckCounts({Key key, this.index, this.spotCheckUnitList})
      : super(key: key);
  @override
  _SpotCheckCountsState createState() => _SpotCheckCountsState();
}

class _SpotCheckCountsState extends State<SpotCheckCounts> {
  @override
  void initState() {
    super.initState();
    _getSpotCheckList(widget.index);
    _getTitle(widget.index);
  }

  List dropList = [];
  _getSpotCheckList(int index) {
    myDio.request(
        type: 'get',
        url: Interface.getriskControlItemList,
        queryParameters: {
          "current": 1,
          "size": 1000,
          "twoId": widget.spotCheckUnitList[index]['twoId'],
          "controlType": 2
        }).then((value) {
      if (value != null) {
        dropList = value["records"];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  String title = '';

  _getTitle(int index) {
    title = widget.spotCheckUnitList[index]['riskUnit'].toString();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          title,
        ),
        elevation: 0,
        child: dropList.length > 0
            ? Container(
                color: Color(0xffffffff),
                child: KJHasd(
                  spotCheckUnitList: widget.spotCheckUnitList,
                  dropList: dropList,
                  select: widget.index,
                  getTitle: _getTitle,
                ))
            : Container());
  }
}

/*
 *  spotCheckUnitList : 巡检点检风险单元 列表数据
 *  dropList : 巡检点检风险项 列表数据
 */
class KJHasd extends StatefulWidget {
  final List spotCheckUnitList, dropList;
  final int select;
  KJHasd({
    @required this.spotCheckUnitList,
    @required this.dropList,
    this.select,
    this.getTitle,
  });
  final Function getTitle;
  @override
  _KJHasdState createState() => _KJHasdState();
}

class _KJHasdState extends State<KJHasd> {
  int select;
  List spotCheckCountList = [];
  List<TogglePicType> titleBar = [
    TogglePicType(
        title: '当前点检控制情况',
        data: [
          XAxisSturct(names: '受控项', color: Color(0xff31CB72), nums: 0),
          XAxisSturct(names: '不受控项', color: Color(0xffFE7A92), nums: 0),
        ],
        totalNum: 0),
    TogglePicType(
        title: '点检异常处置情况',
        data: [
          XAxisSturct(names: '待确认', color: Color(0xffFB681E), nums: 0),
          XAxisSturct(names: '待整改', color: Color(0xffFBAC51), nums: 0),
          XAxisSturct(names: '待审批', color: Color(0xffFCD073), nums: 0),
        ],
        totalNum: 0),
  ];
  int choosed = 0;
  ThrowFunc _throwFunc = ThrowFunc();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    spotCheckCountList = widget.dropList;
    select = widget.select;
    // widget.getTitle(select);
  }

  //  今日点检落实进度
  Future<TogglePicTypedata> _getImplementationStatistics(int index) async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[0].data);
    final value = await myDio.request(
        type: 'get',
        url: Interface.getImplementationStatistics,
        queryParameters: {
          "controlType": 2,
          "twoId": widget.spotCheckUnitList[index]['twoId'],
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
          "twoId": widget.spotCheckUnitList[index]['twoId'],
        });
    if (value is Map) {
      _data.data[0].nums = value['confirmedNum'] * 1.0;
      _data.data[1].nums = value['rectificatioNum'] * 1.0;
      _data.data[2].nums = value['approveNum'] * 1.0;
      value.forEach((key, value) {
        _data.totalNum += value;
      });
    }
    return _data;
  }

  getValue(int index) {
    int value;
    if (widget.spotCheckUnitList[index]['totalNum'] == 0 ||
        widget.spotCheckUnitList[index]['totalNum'] == null ||
        widget.spotCheckUnitList[index]['uncontrolledNum'] == null) {
      value = 10;
    } else {
      value = 10 -
          (((widget.spotCheckUnitList[index]['totalNum'] -
                      widget.spotCheckUnitList[index]['uncontrolledNum']) /
                  widget.spotCheckUnitList[index]['totalNum'] *
                  10)
              .toInt()
              .abs());
    }
    return value;
  }

  _getText(int index) {
    String text;
    if (widget.spotCheckUnitList[index]["twoId"] != null) {
      text = widget.spotCheckUnitList[index]["riskUnit"].toString().length > 2
          ? widget.spotCheckUnitList[index]["riskUnit"]
              .toString()
              .substring(0, 2)
          : widget.spotCheckUnitList[index]["riskUnit"].toString();
    } else if (widget.spotCheckUnitList[index]["threeId"] != null) {
      text = widget.spotCheckUnitList[index]["riskItem"].toString().length > 2
          ? widget.spotCheckUnitList[index]["riskItem"]
              .toString()
              .substring(0, 2)
          : widget.spotCheckUnitList[index]["riskItem"].toString();
    } else {
      text = widget.spotCheckUnitList[index]["riskPoint"].toString().length > 2
          ? widget.spotCheckUnitList[index]["riskPoint"]
              .toString()
              .substring(0, 2)
          : widget.spotCheckUnitList[index]["riskPoint"].toString();
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
          child: SpotCheckDrewar(
            select: select,
            width: size.width,
            spotCheckUnitList: widget.spotCheckUnitList,
            type: 'spotCheckItem',
            callback: (int index) {
              select = index;
              // _getSpotCheckList(index);
              widget.getTitle(select);
              // _getImplementationStatistics(select);
              // _getDisposalDiddenDangersStatistics(select);

              _throwFunc.run(argument: {
                      "current": 1,
                      "size": 30,
                      "twoId": widget.spotCheckUnitList[select]['twoId'],
                      "controlType": 2
                    });
                    setState(() {});
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
                      itemCount: widget.spotCheckUnitList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              select = index;
                              widget.getTitle(index);
                              _throwFunc.run(argument: {
                                "current": 1,
                                "size": 30,
                                "twoId": widget.spotCheckUnitList[select]
                                    ['twoId'],
                                "controlType": 2
                              });
                              // setState(() {});
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
                                  SpotCheckCircle(
                                    width: size.width * 40,
                                    radius: 15,
                                    text: _getText(index),
                                    level: widget.spotCheckUnitList[index]
                                        ['riskLevel'],
                                    initialSpotCheckLevel:
                                        widget.spotCheckUnitList[index]
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
          Expanded(
              child: Column(
            children: [
              Card(
                  child: CustomEchart().togglePic(
                      centerChild: '控制总数',
                      data: titleBar,
                      onpress: (index) async {
                        if (index == 0){
                          return await _getImplementationStatistics(select);
                        }else{
                          return await _getDisposalDiddenDangersStatistics(select);
                        }
                      })),
              Expanded(
                child: MyRefres(
                    child: (index, list) {
                      return InkWell(
                        onTap: () {
                          List<HiddenDangerInterface> _iconList = [];
                          _iconList = _iconList.changeHiddenDangerInterfaceType(
                              list,
                              title: 'riskItem',
                              id: "threeId",
                              icon: null,
                              iconWidget: null,
                              type: 0);
                          Navigator.pushNamed(
                              context, '/home/spotCheck/spotCheckFour',
                              arguments: {
                                'title': list[index]['riskItem'].toString(),
                                "leftBar": _iconList,
                                "id": list[index]['threeId']
                              });
                        },
                        child: SpotCheckItems(
                          width: size.width,
                          type: 'item',
                          spotCheckData: list[index],
                          index: index,
                        ),
                      );
                      // if (index == 0) {
                      //   return Column(children: [
                      //     Card(
                      //         child: CustomEchart().togglePic(
                      //             centerChild: '受控项',
                      //             data: titleBar,
                      //             onpress: (index) async {
                      //               if (index == 0)
                      //                 return await _getImplementationStatistics(
                      //                     select);
                      //               else
                      //                 return await _getDisposalDiddenDangersStatistics(
                      //                     select);
                      //             })),
                      //     InkWell(
                      //       onTap: () {
                      //         List<HiddenDangerInterface> _iconList = [];
                      //         _iconList = _iconList.changeHiddenDangerInterfaceType(
                      //             spotCheckCountList,
                      //             title: 'riskItem',
                      //             id: "threeId",
                      //             icon: null,
                      //             iconWidget: null,
                      //             type: 0);
                      //         Navigator.pushNamed(
                      //             context, '/home/spotCheck/spotCheckFour',
                      //             arguments: {
                      //               'title': spotCheckCountList[index]['riskItem']
                      //                   .toString(),
                      //               "leftBar": _iconList,
                      //               "id": spotCheckCountList[index]['threeId']
                      //             });
                      //       },
                      //       child: SpotCheckItems(
                      //         width: size.width,
                      //         type: 'item',
                      //         spotCheckData: spotCheckCountList[index],
                      //         index: index,
                      //       ),
                      //     )
                      //   ]);
                      // } else {
                      //   return InkWell(
                      //     onTap: () {
                      //       List<HiddenDangerInterface> _iconList = [];
                      //       _iconList = _iconList.changeHiddenDangerInterfaceType(
                      //           spotCheckCountList,
                      //           title: 'riskItem',
                      //           id: "threeId",
                      //           icon: null,
                      //           iconWidget: null,
                      //           type: 0);
                      //       Navigator.pushNamed(
                      //           context, '/home/spotCheck/spotCheckFour',
                      //           arguments: {
                      //             'title': spotCheckCountList[index]['riskItem']
                      //                 .toString(),
                      //             "leftBar": _iconList,
                      //             "id": spotCheckCountList[index]['threeId']
                      //           });
                      //     },
                      //     child: SpotCheckItems(
                      //       width: size.width,
                      //       type: 'item',
                      //       spotCheckData: list[index-1],
                      //       index: index,
                      //     ),
                      //   );
                      // }
                    },
                    url: Interface.getriskControlItemList,
                    throwFunc: _throwFunc,
                    listParam: 'records',
                    page: true,
                    queryParameters: {
                      "current": 1,
                      "size": 30,
                      "twoId": widget.spotCheckUnitList[select]['twoId'],
                      "controlType": 2
                    },
                    method: 'get'),
              )
            ],
          ))
        ],
      ),
    );
  }
}
