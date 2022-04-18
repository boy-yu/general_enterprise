import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/bigDanger/_safeReport.dart';
import 'package:enterprise/pages/home/bigDanger/_work.dart';
// import 'package:enterprise/pages/home/education/education.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class BigDanger extends StatefulWidget {
  @override
  _BigDangerState createState() => _BigDangerState();
}

class _BigDangerState extends State<BigDanger> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('重大危险源'),
      child: BigDangerList(),
    );
  }
}

class BigDangerList extends StatefulWidget {
  @override
  _BigDangerListState createState() => _BigDangerListState();
}

class _BigDangerListState extends State<BigDangerList> {
  List data = [
    {
      "title": '重大危险源档案',
      'descript': '包含厂内重大危险源的档案信息',
      'icon': 'assets/images/dangan@2x.png',
      'router': '/index/dangerSource'
    },
    {
      "title": '安全评估或评价报告',
      'descript': '重大危险源相关评估报告',
      'icon': 'assets/images/baogao@2x.png',
      'router': '/index/dangerSource'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data
          .asMap()
          .keys
          .map((index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, data[index]['router'],
                      arguments: {
                        "index": index,
                        'leftbar': [
                          {
                            "name": "档案",
                            'title': '重大危险源档案',
                            'icon':
                                "assets/images/bigDanger/danger_word@2x.png",
                            'unIcon':
                                'assets/images/bigDanger/danger_word2@2x.png',
                            "widget": DangerWord()
                          },
                          {
                            "name": "报告",
                            'title': '安全评估或评价报告',
                            'icon':
                                "assets/images/bigDanger/danger_rebort@2x.png",
                            'unIcon':
                                'assets/images/bigDanger/danger_rebort2@2x.png',
                            "widget": SafeReport()
                          },
                        ],
                      });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 30,
                      right: size.width * 30,
                      top: size.width * 15),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 40,
                          vertical: size.width * 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index]['title'],
                                style: TextStyle(
                                    fontSize: size.width * 36,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: size.width * 30),
                              Text(
                                data[index]['descript'],
                                style: TextStyle(
                                    fontSize: size.width * 20,
                                    color: Color(0xffA0A2A3)),
                              ),
                              SizedBox(height: size.width * 110),
                              Text(
                                '查看详情 >',
                                style: TextStyle(
                                    fontSize: size.width * 22,
                                    color: Color(0xff2F6EFD)),
                              ),
                            ],
                          ),
                          Image.asset(
                            data[index]['icon'],
                            width: size.width * 194,
                            height: size.width * 194,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
