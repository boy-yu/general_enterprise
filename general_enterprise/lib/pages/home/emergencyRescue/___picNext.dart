import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class PicNext extends StatefulWidget {
  @override
  _PicNextState createState() => _PicNextState();
}

class _PicNextState extends State<PicNext> {
  List<TogglePicType> titleBar = [
    TogglePicType(
        title: '作业状态实时统计',
        data: [
          XAxisSturct(names: '未进行', color: Color(0xff596BFF), nums: 0),
          XAxisSturct(names: '已完成', color: Color(0xff24ABFD), nums: 0),
          XAxisSturct(names: '进行中', color: Color(0xff40E8FE), nums: 0),
        ],
        totalNum: 0),
  ];
  int choosed = 0;
  Widget title(String title) {
    Widget _widget;
    _widget = Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: size.width * 20),
            width: size.width * 6,
            height: size.width * 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: LinearGradient(colors: [
                  Color(0xff2AC79B),
                  Color(0xff3174FF),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.width * 30),
          )
        ],
      ),
    );
    return _widget;
  }

  Widget common({Widget child}) {
    return Container(
      child: child,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          vertical: size.width * 30, horizontal: size.width * 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('应急救援队'),
      child: SingleChildScrollView(
        child: Column(
          children: [
            common(
              child: Column(
                children: [
                  Row(
                    children: [
                      title('企业预案'),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 20),
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 7,
                            horizontal: size.width * 10),
                        decoration: BoxDecoration(
                            color: Color(0xffE7F2E7),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          '已评审',
                          style: TextStyle(
                              color: Color(0xff67C23A),
                              fontSize: size.width * 22),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 20),
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 7,
                            horizontal: size.width * 10),
                        decoration: BoxDecoration(
                            color: Color(0xffE7F2E7),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          '已备案',
                          style: TextStyle(
                              color: Color(0xff67C23A),
                              fontSize: size.width * 22),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 13,
                            horizontal: size.width * 30),
                        decoration: BoxDecoration(
                          color: Color(0xffF4F8FF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '综合应急预案',
                            ),
                            Text.rich(TextSpan(children: [
                              TextSpan(text: '有效期: '),
                              TextSpan(
                                text: DateTime.now().toString().split(' ')[0],
                                style: TextStyle(color: Color(0xff858888)),
                              ),
                            ])),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: size.width * 20),
            common(
                child: Column(
              children: [
                title('应急演练'),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('公司级化学品泄漏应急救援演练'),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: size.width * 7, horizontal: size.width * 9),
                      decoration: BoxDecoration(
                          color: Color(0xffE7F2E7),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        '待发起',
                        style: TextStyle(
                            fontSize: size.width * 22,
                            color: Color(0xff67C23A)),
                      ),
                    )
                  ],
                ),
                CustomEchart().togglePic(
                    data: titleBar,
                    onpress: (index) async {
                      return TogglePicTypedata(data: []);
                    })
                // Row(
                //   children: [
                //     Container(
                //       width: size.width * 300,
                //       child: PieChartSample2(
                //         roundUi: titleBar[choosed].data,
                //       ),
                //     ),
                //     Expanded(
                //         child: Column(
                //       children: titleBar[choosed].data
                //           .map<Widget>((ele) => Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Container(
                //                     width: size.width * 18,
                //                     height: size.width * 18,
                //                     decoration: BoxDecoration(
                //                       color: ele['color'],
                //                       borderRadius: BorderRadius.all(
                //                           Radius.circular(1.0)),
                //                     ),
                //                   ),
                //                   Text(ele['name'].toString(),
                //                       style: TextStyle(
                //                           color: Color(0xff656565),
                //                           fontSize: size.width * 22)),
                //                   SizedBox(
                //                     width: size.width * 100,
                //                     child: Text(
                //                       ele['value'].toString(),
                //                       style: TextStyle(
                //                           color: placeHolder,
                //                           fontSize: size.width * 22),
                //                     ),
                //                   )
                //                 ],
                //               ))
                //           .toList(),
                //     ))
                //   ],
                // ),
              ],
            )),
            SizedBox(height: size.width * 20),
            common(
                child: Column(
              children: [
                title('应急值守记录'),
                Divider(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(minHeight: size.width * 337),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/emergencyRescue_next_record.png'),
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.width * 10,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/emergencyRescue_duty@2x.png.png',
                          width: size.width * 62,
                          height: size.width * 67,
                        ),
                      ),
                      Center(
                        child: Text(
                          '值班人员：何益',
                          style: TextStyle(
                              color: Colors.white, fontSize: size.width * 24),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '值班时间：2020-12-15',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 24),
                            ),
                            Text(
                              '离岗次数：1',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 24),
                            ),
                            Text(
                              '值班负责人：马科武',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 24),
                            ),
                            Text(
                              '值班电话：19823455698',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 24),
                            ),
                            Text(
                              '交接班情况：正常',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 24),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Text('本月值守人员统计'),
                CustomEchart().togglePic(
                    data: titleBar,
                    onpress: (index) async {
                      return TogglePicTypedata(data: []);
                    })
                // Row(
                //   children: [
                //     Container(
                //       width: size.width * 300,
                //       child: PieChartSample2(

                //         roundUi: titleBar[choosed]['data'],
                //       ),
                //     ),
                //     Expanded(
                //         child: Column(
                //       children: titleBar[choosed]['data']
                //           .map<Widget>((ele) => Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Container(
                //                     width: size.width * 18,
                //                     height: size.width * 18,
                //                     decoration: BoxDecoration(
                //                       color: ele['color'],
                //                       borderRadius: BorderRadius.all(
                //                           Radius.circular(1.0)),
                //                     ),
                //                   ),
                //                   Text(ele['name'].toString(),
                //                       style: TextStyle(
                //                           color: Color(0xff656565),
                //                           fontSize: size.width * 22)),
                //                   SizedBox(
                //                     width: size.width * 100,
                //                     child: Text(
                //                       ele['value'].toString(),
                //                       style: TextStyle(
                //                           color: placeHolder,
                //                           fontSize: size.width * 22),
                //                     ),
                //                   )
                //                 ],
                //               ))
                //           .toList(),
                //     ))
                //   ],
                // ),
              ],
            )),
            SizedBox(height: size.width * 20),
            common(
                child: Column(
              children: [
                title('应急救援指挥'),
                Divider(),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 40, right: size.width * 14),
                      width: size.width * 13,
                      height: size.width * 13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff2CD151),
                      ),
                    ),
                    Text(
                      '受控',
                      style: TextStyle(
                          fontSize: size.width * 20, color: Color(0xffA0A0A0)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 40, right: size.width * 14),
                      width: size.width * 13,
                      height: size.width * 13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF0F0F0),
                      ),
                    ),
                    Text(
                      '不受控',
                      style: TextStyle(
                          fontSize: size.width * 20, color: Color(0xffA0A0A0)),
                    ),
                  ],
                ),
                CustomEchart().horizontal(yAxis: 600.0, xAxisList: [
                  XAxisSturct(names: '循环水中段', nums: 120.0, otherNum: 220.0)
                ])
              ],
            )),
            SizedBox(height: size.width * 20),
            common(
                child: Column(
              children: [
                title('持卡人数'),
                Divider(),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 40, right: size.width * 14),
                      width: size.width * 13,
                      height: size.width * 13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff2CD151),
                      ),
                    ),
                    Text(
                      '持卡人数',
                      style: TextStyle(
                          fontSize: size.width * 20, color: Color(0xffA0A0A0)),
                    ),
                  ],
                ),
                CustomEchart().horizontal(
                  height: 150,
                  yAxis: 600.0,
                  xAxisList: [
                    XAxisSturct(names: '循环水中段', nums: 120.0, otherNum: 220.0),
                    XAxisSturct(names: '循环水中段', nums: 120.0, otherNum: 220.0),
                    XAxisSturct(names: '循环水中段', nums: 120.0, otherNum: 220.0),
                  ],
                )
              ],
            )),
            SizedBox(height: size.width * 20),
            common(
                child: Column(
              children: [
                title('事故统计'),
                Divider(),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 40, right: size.width * 14),
                      width: size.width * 13,
                      height: size.width * 13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff2CD151),
                      ),
                    ),
                    Text(
                      '经济损失',
                      style: TextStyle(
                          fontSize: size.width * 20, color: Color(0xffA0A0A0)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 40, right: size.width * 14),
                      width: size.width * 13,
                      height: size.width * 13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffA0A0A0),
                      ),
                    ),
                    Text(
                      '事故起数',
                      style: TextStyle(
                          fontSize: size.width * 20, color: Color(0xffA0A0A0)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 40, right: size.width * 14),
                      width: size.width * 13,
                      height: size.width * 13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFA6E86),
                      ),
                    ),
                    Text(
                      '事故率',
                      style: TextStyle(
                          fontSize: size.width * 20, color: Color(0xffA0A0A0)),
                    ),
                  ],
                ),
                CustomEchart().mutipleBar(
                    yAxis: 300,
                    xAxisList: [
                      MutipleXAxisSturct(names: '一月', nums: [
                        30,
                        40
                      ], color: [
                        Color(0xff19D4AE),
                        Color(0xff5AB1EF),
                      ]),
                    ],
                    yWidth: 10.0)
              ],
            )),
          ],
        ),
      ),
    );
  }
}
