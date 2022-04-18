import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/pages/home/spotCheck/spotCheckHomeItem.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

/*
 *  巡检点检首页 风险点 
 */
class SpotCheck extends StatefulWidget {
  @override
  _SpotCheckState createState() => _SpotCheckState();
}

class _SpotCheckState extends State<SpotCheck> {
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

  List dropList = [];
  void initState() {
    super.initState();
    // _getSpotCheckList();
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

  // ignore: missing_return
  Future _getSpotCheckList() async {
    final value = await myDio.request(
        type: 'get',
        url: Interface.getRiskUnitList,
        queryParameters: {"current": 1, "size": 1000, "controlType": 2});
    if (value is Map) {
      dropList = value["records"];
      if (mounted) {
        setState(() {});
      }
    }
    return Future.value(0);
  }

  Widget _changeTitle(width, item) {
    Widget _widget;

    if (item['title'] == '总览')
      _widget = Pictrue();
    else if (item['title'] == '列表')
      _widget = ListTable(dropList: dropList, refresh: _getSpotCheckList);
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

class ListTable extends StatelessWidget {
  final List dropList;
  final Function refresh;
  ListTable({this.dropList, this.refresh});
  
  /*
    final value = await myDio.request(
        type: 'get',
        url: Interface.getRiskUnitList,
        queryParameters: {"current": 1, "size": 1000, "controlType": 2});
    if (value is Map) {
      dropList = value["records"];
      if (mounted) {
        setState(() {});
      }
    }
    return Future.value(0);
  */
  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => GestureDetector(
              child: SpotCheckHomeItem(
                spotCheckData: list,
                index: index,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home/spotCheck/spotCheckControl",
                    arguments: {'dropList': list, 'index': index});
              },
            ),
        queryParameters: {"controlType": 2},
        page: true,
        listParam: "records",
        url: Interface.getRiskUnitList,
        method: 'get');
  }
}

class ListTableImplate extends StatelessWidget {
  ListTableImplate(this.child, this.dropList);
  final Widget child;
  final List dropList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child ?? Container(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                child: SpotCheckHomeItem(
                  spotCheckData: dropList,
                  index: index,
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, "/home/spotCheck/spotCheckControl",
                      arguments: {'dropList': dropList, 'index': index});
                },
              );
            },
            itemCount: dropList.length,
          ),
        )
      ],
    );
  }
}

class Pictrue extends StatefulWidget {
  @override
  _PictrueState createState() => _PictrueState();
}

class _PictrueState extends State<Pictrue> {
  int investigatedNum = 0;
  int overdueNum = 0;
  int completedNum = 0;
  int rectificatioNum = 0;
  int confirmedNum = 0;
  int approveNum = 0;
  int noNum = 0;
  int oneNum = 0;
  int twoNum = 0;

  @override
  void initState() {
    super.initState();
    _getImplementationStatistics();
    _getDisposalDiddenDangersStatistics();
    _getRealTimeHiddenDangerStatistics();
  }

  //  当前点检控制情况
  Future _getImplementationStatistics() async {
    myDio.request(
        type: 'get',
        url: Interface.getImplementationStatistics,
        queryParameters: {"controlType": 2}).then((value) {
      if (value != null) {
        investigatedNum = value['totalNum'];
        overdueNum = value['uncontrolledNum'];
        completedNum = value['controlledNum'];
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  // 点检异常处置情况
  Future _getDisposalDiddenDangersStatistics() async {
    myDio.request(
        type: 'get',
        url: Interface.getDisposalDiddenDangersStatistics,
        queryParameters: {"controlType": 2}).then((value) {
      if (value != null) {
        rectificatioNum = value['rectificatioNum'];
        confirmedNum = value['confirmedNum'];
        approveNum = value['approveNum'];
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  // 点检结果实时统计
  Future _getRealTimeHiddenDangerStatistics() async {
    myDio.request(
        type: 'get',
        url: Interface.getRealTimeHiddenDangerStatistics,
        queryParameters: {"controlType": 2}).then((value) {
      if (value != null) {
        noNum = value['notHiddenNum'];
        oneNum = value['oneNum'];
        twoNum = value['twoNum'];
      }
      if (mounted) {
        setState(() {});
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
            // 今日点检落实进度
            Container(
              margin: EdgeInsets.all(size.width * 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                        blurRadius: 5.0, //阴影模糊程度
                        spreadRadius: 1.0 //阴影扩散程度
                        )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(title: '当前点检控制情况'),
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
                                  color: Color(0xff7885EC),
                                  nums: investigatedNum * 1.0),
                              XAxisSturct(
                                  color: Color(0xff31CB72),
                                  nums: completedNum * 1.0),
                              XAxisSturct(
                                  color: Color(0xffFE7A92),
                                  nums: overdueNum * 1.0),
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
                                    height: size.width * 14,
                                    width: size.width * 14,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.0)),
                                      border: Border.all(
                                          width: 1, color: Color(0xff666666)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '点检项         ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: investigatedNum.toString(),
                                        style: TextStyle(
                                            color: Color(0xff666666),
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
                                        color: Color(0xff7885EC),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0))),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '受控项         ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: completedNum.toString(),
                                        style: TextStyle(
                                            color: Color(0xff7885EC),
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
                                        color: Color(0xffFE7A92),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0))),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '不受控项     ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: overdueNum.toString(),
                                        style: TextStyle(
                                            color: Color(0xffFE7A92),
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
            // 点检异常处置情况
            Container(
              margin: EdgeInsets.all(size.width * 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                        blurRadius: 5.0, //阴影模糊程度
                        spreadRadius: 1.0 //阴影扩散程度
                        )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(title: '点检异常处置情况'),
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
                                  color: Color(0xffFB681E),
                                  nums: confirmedNum * 1.0),
                              XAxisSturct(
                                  color: Color(0xffFBAC51),
                                  nums: rectificatioNum * 1.0),
                              XAxisSturct(
                                  color: Color(0xffFCD073),
                                  nums: approveNum * 1.0),
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
                                    height: size.width * 14,
                                    width: size.width * 14,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFB681E),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0))),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '待确认         ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: confirmedNum.toString(),
                                        style: TextStyle(
                                            color: Color(0xffFB681E),
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
                                        color: Color(0xffFBAC51),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0))),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '待整改         ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: rectificatioNum.toString(),
                                        style: TextStyle(
                                            color: Color(0xffFBAC51),
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
                                        color: Color(0xffFCD073),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0))),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '待审批         ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: approveNum.toString(),
                                        style: TextStyle(
                                            color: Color(0xffFCD073),
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
            // 点检结果实时统计
            Container(
              margin: EdgeInsets.all(size.width * 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                        blurRadius: 5.0, //阴影模糊程度
                        spreadRadius: 1.0 //阴影扩散程度
                        )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(title: '点检结果实时统计'),
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
                            // roundUi: [
                            //   {'value': twoNum},
                            //   {'value': oneNum},
                            //   {'value': noNum},
                            // ],
                            // color: [
                            //   Color(0xffF7454A),
                            //   Color(0xffF4D341),
                            //   Color(0xffBEBEBE),
                            // ],
                            roundUi: [
                              XAxisSturct(
                                  nums: twoNum * 1.0, color: Color(0xffF7454A)),
                              XAxisSturct(
                                  nums: oneNum * 1.0, color: Color(0xffF4D341)),
                              XAxisSturct(
                                  nums: noNum * 1.0, color: Color(0xffBEBEBE)),
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
                                        text: '重大隐患         ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: twoNum.toString(),
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
                                        text: '一般隐患         ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: oneNum.toString(),
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
                                        color: Color(0xffBEBEBE),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0))),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: '无隐患             ',
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: noNum.toString(),
                                        style: TextStyle(
                                            color: Color(0xffBEBEBE),
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
          ],
        ),
      ),
    );
  }

  Widget title({String title = '标题'}) {
    Widget _widget;
    _widget = Container(
      margin: EdgeInsets.only(
          top: size.width * 15, bottom: size.width * 15, left: size.width * 20),
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
