import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    _getAreaDistribution();
    _getAbnormalData();
    _getCurrentPieData();
  }

  // 获取风险管控统计数据
  _getRiskData() {
    initialPie.add(PieSturct(color: Color(0xffF56271), nums: 5, title: '重大风险'));
    initialPie.add(PieSturct(color: Color(0xffFF9900), nums: 5, title: '较大风险'));
    initialPie
        .add(PieSturct(color: Color(0xffFFCA0E), nums: 10, title: '一般风险'));
    initialPie.add(PieSturct(color: Color(0xff2276FC), nums: 3, title: '低风险'));
    residuePie
        .add(PieSturct(color: Color(0xffF56271), nums: 12, title: '重大风险'));
    residuePie.add(PieSturct(color: Color(0xffFF9900), nums: 2, title: '较大风险'));
    residuePie.add(PieSturct(color: Color(0xffFFCA0E), nums: 5, title: '一般风险'));
    residuePie.add(PieSturct(color: Color(0xff2276FC), nums: 3, title: '低风险'));
  }

  // 获取区域分布统计数据
  _getAreaDistribution() {
    xAxisList = [
      MutipleXAxisSturct(names: "LNG厂区", nums: [41.0, 30.0, 50.0, 24.0]),
      MutipleXAxisSturct(names: "循环水站", nums: [41.0, 30.0, 50.0, 20.0]),
      MutipleXAxisSturct(names: "天然气预处理区", nums: [41.0, 30.0, 50.0, 20.0]),
      MutipleXAxisSturct(names: "液化工序", nums: [41.0, 30.0, 100.0, 24.0]),
    ];
    maxYAxis = 100.0 + 20.0;
  }

  // 获取排查、巡检异常处置情况
  _getAbnormalData(){
    abnormalPie.add(PieSturct(color: Color(0xff2276FC), nums: 123, title: '待确认'));
    abnormalPie.add(PieSturct(color: Color(0xffF56271), nums: 30, title: '待整改'));
    abnormalPie.add(PieSturct(color: Color(0xffFFCA0E), nums: 49, title: '待审批'));
  }

  // 排查、巡检结果实时统计
  _getCurrentPieData(){
    currentPie.add(PieSturct(color: Color(0xffF56271), nums: 130, title: '重大隐患'));
    currentPie.add(PieSturct(color: Color(0xffFFCA0E), nums: 49, title: '一般隐患'));
    currentPie.add(PieSturct(color: Color(0xff5FD5EC), nums: 123, title: '无隐患'));
  }

  // 管控分类数据数组
  List data = [
    {'name': '工程技术', 'num': 123},
    {'name': '维护保养', 'num': 123},
    {'name': '操作行为', 'num': 123},
    {'name': '异常措施', 'num': 123},
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          "总览",
          style: TextStyle(fontSize: size.width * 32),
        ),
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
                                  '10',
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
                        data.isNotEmpty
                            ? CustomPaint(
                                painter: DoubleControlPaint(),
                                child: Container(
                                    margin:
                                        EdgeInsets.only(right: size.width * 60),
                                    width: size.width * 160,
                                    child: ListView.builder(
                                        itemCount: data.length,
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
                                                      data[index]['name']
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff3074FF),
                                                          fontSize:
                                                              size.width * 20),
                                                    )),
                                                    Text(
                                                      data[index]['num']
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
                                  '20',
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
            // 区域分布
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
                        "区域分布",
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
                  CustomEchart().mutipleBar(
                      xAxisList: xAxisList,
                      yAxis: maxYAxis,
                      color: [
                        Color(0xffF56271),
                        Color(0xffFF9900),
                        Color(0xffFFCA0E),
                        Color(0xff2276FC),
                      ]),
                  SizedBox(
                    height: size.width * 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 50,
                      ),
                      Container(
                        width: size.width * 300,
                        child: Row(
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
                              "重大风险总计(12)",
                              style: TextStyle(
                                  color: Color(0xff7F8A9C),
                                  fontSize: size.width * 24),
                            ),
                          ],
                        ),
                      ),
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
                        "较大风险总计(31)",
                        style: TextStyle(
                            color: Color(0xff7F8A9C),
                            fontSize: size.width * 24),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 50,
                      ),
                      Container(
                        width: size.width * 300,
                        child: Row(
                          children: [
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
                                  "一般风险总计(47)",
                                  style: TextStyle(
                                      color: Color(0xff7F8A9C),
                                      fontSize: size.width * 24),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                        "低风险总计(129)",
                        style: TextStyle(
                            color: Color(0xff7F8A9C),
                            fontSize: size.width * 24),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.width * 32,
            ),
            // 排查、巡检异常处置情况
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 32),
              padding: EdgeInsets.all(size.width * 32),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 20))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          "排查、巡检异常处置情况",
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
                                  "待确认   123",
                                  style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w400
                                  ),
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
                                  "待整改   3",
                                  style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w400
                                  ),
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
                                  "待审批   49",
                                  style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w400
                                  ),
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
            // 排查、巡检结果实时统计
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 32),
              padding: EdgeInsets.all(size.width * 32),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 20))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          "排查、巡检结果实时统计",
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
                                  "重大隐患   130",
                                  style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w400
                                  ),
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
                                  "一般隐患   49",
                                  style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w400
                                  ),
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
                                      color: Color(0xff5FD5EC),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 4))),
                                ),
                                SizedBox(
                                  width: size.width * 20,
                                ),
                                Text(
                                  "无隐患   123",
                                  style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w400
                                  ),
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
        ));
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