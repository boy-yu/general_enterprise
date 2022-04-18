import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/pages/home.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class ClosedManagementOverview extends StatefulWidget {
  @override
  State<ClosedManagementOverview> createState() =>
      _ClosedManagementOverviewState();
}

class _ClosedManagementOverviewState extends State<ClosedManagementOverview> {
  List<XAxisSturct> realTimePeople = [
    XAxisSturct(names: '内部人员', color: Color(0xff2276FC), nums: 23),
    XAxisSturct(names: '来访人员', color: Color(0xff5FD5EC), nums: 55),
  ];

  List<XAxisSturct> realTimeCar = [
    XAxisSturct(names: '内部车辆', color: Color(0xff2276FC), nums: 23),
    XAxisSturct(names: '普通车辆', color: Color(0xff5FD5EC), nums: 55),
    XAxisSturct(names: '危化品车辆', color: Color(0xffFFCF5F), nums: 15),
  ];

  List callPolice = [
    {"name": "李玉", "phone": "18109041935", "type": "未佩戴安全帽"},
    {"name": "李玉", "phone": "18109041935", "type": "未佩戴安全帽"},
    {"name": "李玉", "phone": "18109041935", "type": "未佩戴安全帽"},
    {"name": "李玉", "phone": "18109041935", "type": "未佩戴安全帽"},
    {"name": "李玉", "phone": "18109041935", "type": "未佩戴安全帽"},
    {"name": "李玉", "phone": "18109041935", "type": "未佩戴安全帽"},
    {"name": "李玉", "phone": "18109041935", "type": "未佩戴安全帽"},
    {"name": "李玉", "phone": "18109041935", "type": "未佩戴安全帽"},
    {"name": "李玉", "phone": "18109041935", "type": "未佩戴安全帽"},
  ];

  List<MutipleXAxisSturct> xAxisList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    for (int i = 0; i < 24; i++) {
      xAxisList.add(
        MutipleXAxisSturct(
            names: (i < 10 ? "0" + i.toString() : i.toString()) + ":00",
            color: [
              Color(0xff2276FC),
              Color(0xff5FD5EC),
              Color(0xffFFCF5F),
              Color(0xffEE6F7C)
            ],
            nums: [
              30 * 1.0,
              13 * 1.0,
              35 * 1.0,
              24 * 1.0
            ]),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 企业实时人数概览
        Container(
            color: Colors.white,
            padding: EdgeInsets.all(size.width * 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '企业实时人数概览',
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 30,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      width: 150,
                      child: PieChartSample2(roundUi: realTimePeople),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: realTimePeople
                            .map<Widget>((ele) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width * 18,
                                        height: size.width * 18,
                                        decoration: BoxDecoration(
                                          color: ele.color,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 20,
                                      ),
                                      Text(ele.names.toString(),
                                          style: TextStyle(
                                              color: Color(0xff7F8A9C),
                                              fontSize: size.width * 22)),
                                      SizedBox(
                                        width: size.width * 20,
                                      ),
                                      Container(
                                        width: size.width * 100,
                                        child: Text(
                                          ele.nums.toInt().toString(),
                                          style: TextStyle(
                                              color: placeHolder,
                                              fontSize: size.width * 22),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            .toList())
                  ],
                )
              ],
            )),
        SizedBox(
          height: size.width * 20,
        ),
        // 企业实时车辆概览
        Container(
            color: Colors.white,
            padding: EdgeInsets.all(size.width * 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '企业实时车辆概览',
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 30,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      width: 150,
                      child: PieChartSample2(roundUi: realTimeCar),
                    ),
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: realTimeCar
                                .map<Widget>((ele) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.width * 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: size.width * 18,
                                            height: size.width * 18,
                                            decoration: BoxDecoration(
                                              color: ele.color,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(1.0)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 20,
                                          ),
                                          Text(ele.names.toString(),
                                              style: TextStyle(
                                                  color: Color(0xff7F8A9C),
                                                  fontSize: size.width * 22)),
                                          SizedBox(
                                            width: size.width * 20,
                                          ),
                                          Container(
                                            width: size.width * 100,
                                            child: Text(
                                              ele.nums.toInt().toString(),
                                              style: TextStyle(
                                                  color: placeHolder,
                                                  fontSize: size.width * 22),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                .toList()))
                  ],
                )
              ],
            )),
        SizedBox(
          height: size.width * 20,
        ),
        // 企业出入人、车流量分析
        Container(
            color: Colors.white,
            padding: EdgeInsets.all(size.width * 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '企业出入人、车流量分析',
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.width * 30,
                ),
                histogram(
                    width: size.width * 10,
                    height: size.width * 250,
                    yAxis: 100,
                    xAxisList: xAxisList,
                    showsTitle: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                      width: size.width * 12,
                      height: size.width * 12,
                      decoration: BoxDecoration(
                        color: Color(0xff2276FC),
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 8,
                    ),
                    Text("进入人数",
                        style: TextStyle(
                            color: Color(0xff7F8A9C),
                            fontSize: size.width * 18)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                      width: size.width * 12,
                      height: size.width * 12,
                      decoration: BoxDecoration(
                        color: Color(0xff5FD5EC),
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 8,
                    ),
                    Text("离开人数",
                        style: TextStyle(
                            color: Color(0xff7F8A9C),
                            fontSize: size.width * 18)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                      width: size.width * 12,
                      height: size.width * 12,
                      decoration: BoxDecoration(
                        color: Color(0xffFFCF5F),
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 8,
                    ),
                    Text("进入车辆",
                        style: TextStyle(
                            color: Color(0xff7F8A9C),
                            fontSize: size.width * 18)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                      width: size.width * 12,
                      height: size.width * 12,
                      decoration: BoxDecoration(
                        color: Color(0xffEE6F7C),
                        borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 8,
                    ),
                    Text("离开车辆",
                        style: TextStyle(
                            color: Color(0xff7F8A9C),
                            fontSize: size.width * 18)),
                      ],
                    ),
                  ],
                )
              ],
            )),
        SizedBox(
          height: size.width * 20,
        ),
        // 门禁报警
        Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 30, top: size.width * 20),
                  child: Text(
                    '门禁报警',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 30,
                      top: size.width * 15,
                      bottom: size.width * 15),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 100,
                        child: Text(
                          "姓名",
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 28),
                        ),
                      ),
                      Container(
                        width: size.width * 180,
                        child: Text(
                          "电话",
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 28),
                        ),
                      ),
                      Container(
                        width: size.width * 300,
                        child: Text(
                          "报警类型",
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 28),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: callPolice.length,
                    shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                    physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 30,
                            vertical: size.width * 15),
                        color:
                            index % 2 == 0 ? Color(0xffF7F7F7) : Colors.white,
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 100,
                              child: Text(
                                callPolice[index]['name'],
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 24),
                              ),
                            ),
                            Container(
                              width: size.width * 180,
                              child: Text(
                                callPolice[index]['phone'],
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 24),
                              ),
                            ),
                            Container(
                              width: size.width * 300,
                              child: Text(
                                callPolice[index]['type'],
                                style: TextStyle(
                                    color: Color(0xffEE6F7C),
                                    fontSize: size.width * 24),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
              ],
            )),
      ],
    );
  }

  Widget histogram(
      {height = 250.0,
      width = 30.0,
      @required double yAxis,
      @required List<MutipleXAxisSturct> xAxisList,
      showsTitle,
      List<Color> color,
      double yWidth = 30.0}) {
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
        yAxisList: yAxisList,
        showsTitle: showsTitle);
  }
}
