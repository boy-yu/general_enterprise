import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PieSturct> initialPie = [];
  List<PieSturct> residuePie = [];

  @override
  void initState() {
    super.initState();
    initialPie.add(PieSturct(
        color: Color(0xffDF0000),
        nums: 5,
        title: '重大风险'));
    initialPie.add(PieSturct(
        color: Color(0xffFF781A),
        nums: 5,
        title: '较大风险'));
    initialPie.add(PieSturct(
        color: Color(0xffFFD500),
        nums: 10,
        title: '一般风险'));
    initialPie.add(PieSturct(
        color: Color(0xff01A8F4),
        nums: 3,
        title: '低风险'));
    residuePie.add(PieSturct(
        color: Color(0xffDF0000), nums: 12, title: '重大风险'));
    residuePie.add(PieSturct(
        color: Color(0xffFF781A), nums: 2, title: '较大风险'));
    residuePie.add(PieSturct(
        color: Color(0xffFFD500),
        nums: 5,
        title: '一般风险'));
    residuePie.add(PieSturct(
        color: Color(0xff01A8F4), nums: 3, title: '低风险'));
  }

  List data = [
    {
      'name': '工程技术',
      'num': 123
    },
    {
      'name': '维护保养',
      'num': 123
    },
    {
      'name': '操作行为',
      'num': 123
    },
    {
      'name': '异常措施',
      'num': 123
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text("总览"),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(size.width * 10))
            ),
            child: // 双控运行状况 饼状图
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomEchart().pie(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '初始风险',
                            style: TextStyle(
                                color: Color(0xff466CC7), fontSize: size.width * 16),
                          ),
                          Text(
                            '10',
                            style: TextStyle(
                                color: Color(0xff466CC7), fontSize: size.width * 20),
                          )
                        ],
                      ),
                      width: 100,
                      radius: 30,
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
                              margin: EdgeInsets.only(right: size.width * 60),
                              width: size.width * 120,
                              child: ListView.builder(
                                  itemCount: data.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: size.width * 20,
                                          width: size.width * 120,
                                          decoration:
                                              BoxDecoration(color: Color(0xffDAE2F4)),
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
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color: Color(0xff466CC7),
                                                    fontSize: size.width * 12),
                                              )),
                                              Text(
                                                data[index]
                                                        ['num']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color(0xff466CC7),
                                                    fontSize: size.width * 12),
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
                            '剩余风险',
                            style: TextStyle(
                                color: Color(0xff466CC7), fontSize: size.width * 16),
                          ),
                          Text(
                            '20',
                            style: TextStyle(
                                color: Color(0xff466CC7), fontSize: size.width * 20),
                          )
                        ],
                      ),
                      width: 100,
                      radius: 30,
                      state: false,
                      strokeWidth: 10,
                      data: residuePie),
                ],
              ),
          )
        ],
      )
    );
  }
}

class DoubleControlPaint extends CustomPainter {
  Paint _paint = Paint()
    ..color = Color(0xffC7D3EE)
    ..strokeWidth = 1
    ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    Path _path = Path();
    _path.moveTo(size.width / 3 * 2, 0);
    _path.lineTo(size.width, size.height / 2);
    _path.lineTo(size.width / 3 * 2, size.height);
    _path.close();
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}