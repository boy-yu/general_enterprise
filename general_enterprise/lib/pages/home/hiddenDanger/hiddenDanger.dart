import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenDangerHome.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';

class HiddenDanger extends StatefulWidget {
  @override
  _HiddenDangerState createState() => _HiddenDangerState();
}

class _HiddenDangerState extends State<HiddenDanger>
    with AutomaticKeepAliveClientMixin {
  PageController _controller;
  List hiddenData = [
    {
      "index": 0,
      "title": "总览",
      "descript": "选择需要使用的",
      "img": "assets/images/look.png",
      "isClick": false,
    },
    {
      "index": 1,
      "title": "列表",
      "descript": "选择需要使用的",
      "img": "assets/images/apply.png",
      "isClick": true,
    },
  ];

  int choosed = 1;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: choosed);
    _controller.addListener(() {
      if (_controller.page.toString().length <= 3) {
        if (_controller.page.toString().substring(2, 3) == '0') {
          choosed = _controller.page.toInt();
          if (mounted) {
            setState(() {});
          }
        }
      }
    });
  }

  int investigatedNum = 0;
  int overdueNum = 0;
  int completedNum = 0;
  int rectificatioNum = 0;
  int confirmedNum = 0;
  int approveNum = 0;
  int notHiddenNum = 0;
  int oneNum = 0;
  int twoNum = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MyAppbar(
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(.2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(28))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: hiddenData.map<Widget>((ele) {
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
                      fontSize: size.width * 35),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 40, vertical: size.width * 10),
              ),
            );
          }).toList(),
        ),
      ),
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (context, index) => Column(
          children: [index == 0 ? Pictrue() : HiddenDangerHome()],
        ),
        itemCount: hiddenData.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Pictrue extends StatefulWidget {
  @override
  _PictrueState createState() => _PictrueState();
}

class _PictrueState extends State<Pictrue> {
  int investigatedNum = 0; // 待排查
  int overdueNum = 0; //  逾期
  int completedNum = 0; //   已完成

  int rectificatioNum = 0; //  待整改
  int confirmedNum = 0; //  待确认
  int approveNum = 0; //  待审批

  int notHiddenNum = 0; //  无隐患
  int oneNum = 0; //  一般隐患
  int twoNum = 0; //  重大隐患
  @override
  void initState() {
    super.initState();
    _getImplementationStatistics();
    _getDisposalDiddenDangersStatistics();
    _getRealTimeHiddenDangerStatistics();
  }

  //  今日排查落实进度
  _getImplementationStatistics() {
    myDio.request(
        type: 'get',
        url: Interface.getImplementationStatistics,
        queryParameters: {"controlType": 1}).then((value) {
      if (value != null) {
        investigatedNum = value['totalNum'];
        overdueNum = value['uncontrolledNum'];
        completedNum = value['controlledNum'];
      }
    });
  }

  // 排查异常处置情况
  _getDisposalDiddenDangersStatistics() {
    myDio.request(
        type: 'get',
        url: Interface.getDisposalDiddenDangersStatistics,
        queryParameters: {"controlType": 1}).then((value) {
      if (value != null) {
        rectificatioNum = value['rectificatioNum'];
        confirmedNum = value['confirmedNum'];
        approveNum = value['approveNum'];
      }
    });
  }

  // 排查结果实时统计
  _getRealTimeHiddenDangerStatistics() {
    myDio.request(
        type: 'get',
        url: Interface.getRealTimeHiddenDangerStatistics,
        queryParameters: {"controlType": 1}).then((value) {
      if (value != null) {
        notHiddenNum = value['notHiddenNum'];
        oneNum = value['oneNum'];
        twoNum = value['twoNum'];
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
            // 今排查落实进度
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
                  title(title: '当前隐患控制情况'),
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
                                  nums: completedNum * 1.0,
                                  color: Color(0xff7885EC)),
                              XAxisSturct(
                                  nums: overdueNum * 1.0,
                                  color: Color(0xffFE7A92)),
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
                                        text: '排查项         ',
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

            // 排查异常处置情况
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
                  title(title: '排查异常处置情况'),
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
                                nums: confirmedNum * 1.0,
                                color: Color(0xffFB681E),
                              ),
                              XAxisSturct(
                                nums: rectificatioNum * 1.0,
                                color: Color(0xffFBAC51),
                              ),
                              XAxisSturct(
                                nums: approveNum * 1.0,
                                color: Color(0xffFCD073),
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
            //排查结果实时统计
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
                  title(title: '排查结果实时统计'),
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
                                nums: twoNum * 1.0,
                                color: Color(0xffF7454A),
                              ),
                              XAxisSturct(
                                nums: oneNum * 1.0,
                                color: Color(0xffF4D341),
                              ),
                              XAxisSturct(
                                nums: notHiddenNum * 1.0,
                                color: Color(0xffBEBEBE),
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
                                        text: notHiddenNum.toString(),
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
