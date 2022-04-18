import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckEduList extends StatefulWidget {
  @override
  _CheckEduListState createState() => _CheckEduListState();
}

class _CheckEduListState extends State<CheckEduList> {
  List data = [
    {
      'image': 'assets/images/peixunwenjuanicon.png',
      'name': '培训需求问卷',
      'router': "/checkList/researchList",
      'num': 0
    },
    {
      'image': 'assets/images/xuexi@2x.png',
      'name': '在线学习计划',
      'router': "/checkList/studyPlan",
      'num': 0
    },
    {
      'image': 'assets/images/xianmxia@2x.png',
      'name': '现场学习计划',
      'router': "/checkList/offlineStudyPlan",
      'num': 0
    },
    {
      'image': 'assets/images/kaos@2x.png',
      'name': '考试',
      'router': "/checkList/examList",
      'num': 0
    },
  ];

  List yearData = [
    {
      'image': 'assets/images/xuexi@2x.png',
      'name': '在线学习计划',
      'router': "/checkList/studyPlan",
      'num': 0
    },
    {
      'image': 'assets/images/xianmxia@2x.png',
      'name': '现场学习计划',
      'router': "/checkList/offlineStudyPlan",
      'num': 0
    },
    {
      'image': 'assets/images/kaos@2x.png',
      'name': '考试',
      'router': "/checkList/examList",
      'num': 0
    },
  ];

  @override
  void initState() {
    super.initState();
    _getMyEducationTrainingTaskStatistics();
  }

  _getMyEducationTrainingTaskStatistics() {
    myDio
        .request(
      type: "get",
      url: Interface.getMyEducationTrainingTaskStatistics,
    )
        .then((value) {
      if (value is Map) {
        data[0]['num'] = value['educationTrainingResearchProcessingNum'];
        data[1]['num'] = value['educationTrainingPlanProcessingNum'];
        data[2]['num'] = value['educationTrainingOfflinePlanNum'];
        data[3]['num'] = value['educationTrainingPlanExaminationNum'];

        yearData[0]['num'] = value['educationTrainingPlanYearProcessingNum'];
        yearData[1]['num'] = value['educationTrainingOfflinePlanYearNum'];
        yearData[2]['num'] = value['educationTrainingPlanYearExaminationNum'];
      }
      setState(() {});
    });
  }

  int choice = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    choice = 1;
                    setState(() {});
                  },
                  child: Container(
                      width: size.width * 300,
                      alignment: Alignment.center,
                      color: Colors.white,
                      // padding: EdgeInsets.symmetric(vertical: size.width * 30),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: size.width * 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '普通',
                                  style: TextStyle(
                                      color: choice == 1
                                          ? Color(0xff3074FF)
                                          : Color(0xff666666),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                data[0]['num'] != 0 ||
                                        data[1]['num'] != 0 ||
                                        data[2]['num'] != 0 ||
                                        data[3]['num'] != 0
                                    ? Column(
                                        children: [
                                          Container(
                                            height: size.width * 20,
                                            width: size.width * 20,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                          ),
                                          SizedBox(
                                            height: size.width * 20,
                                          )
                                        ],
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          choice == 1
                              ? Container(
                                  height: size.width * 4,
                                  width: size.width * 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3074FF),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 2))),
                                )
                              : Container(),
                        ],
                      )),
                ),
                Container(
                  height: size.width * 38,
                  width: size.width * 1,
                  color: Color(0xffeeeeee),
                ),
                GestureDetector(
                  onTap: () {
                    choice = 2;
                    setState(() {});
                  },
                  child: Container(
                      width: size.width * 300,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: size.width * 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '年度',
                                  style: TextStyle(
                                      color: choice == 2
                                          ? Color(0xff3074FF)
                                          : Color(0xff666666),
                                      fontSize: size.width * 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                yearData[0]['num'] != 0 ||
                                        yearData[1]['num'] != 0 ||
                                        yearData[2]['num'] != 0
                                    ? Column(
                                        children: [
                                          Container(
                                            height: size.width * 20,
                                            width: size.width * 20,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                          ),
                                          SizedBox(
                                            height: size.width * 20,
                                          )
                                        ],
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          choice == 2
                              ? Container(
                                  height: size.width * 4,
                                  width: size.width * 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3074FF),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 2))),
                                )
                              : Container(),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Container(
            height: size.width * 1,
            width: double.infinity,
            color: Color(0xffeeeeee),
          ),
          SizedBox(
            height: size.width * 20,
          ),
          Expanded(
              child: choice == 1
                  ? ListView.builder(
                      // 普通
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (data[index]['router'] != '') {
                              Navigator.of(context).pushNamed(
                                  data[index]['router'],
                                  arguments: {'type': 0}).then((value) {
                                _getMyEducationTrainingTaskStatistics();
                                // 返回值
                              });
                            } else {
                              Fluttertoast.showToast(msg: '敬请期待');
                            }
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 30,
                                    vertical: size.width * 15),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 24,
                                    vertical: size.width * 45),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.16),
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0)
                                    ]),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      data[index]['image'],
                                      height: size.width * 90,
                                      width: size.width * 90,
                                    ),
                                    SizedBox(
                                      width: size.width * 30,
                                    ),
                                    Text(
                                      data[index]['name'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: size.width * 50,
                                      width: size.width * 90,
                                      decoration: BoxDecoration(
                                        color: Color(0xff3074FF),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 6)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '详情',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.width * 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              data[index]['num'] != 0
                                  ? Positioned(
                                      right: size.width * 45,
                                      top: size.width * 65,
                                      child: Container(
                                        height: size.width * 26,
                                        width: size.width * 26,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        alignment: Alignment.center,
                                        child: Text(
                                          data[index]['num'].toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 16),
                                        ),
                                      ))
                                  : Container(),
                            ],
                          ),
                        );
                      })
                  : ListView.builder(
                      // 年度
                      itemCount: yearData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            if (yearData[index]['router'] != '') {
                                        Navigator.of(context).pushNamed(
                                            yearData[index]['router'],
                                            arguments: {
                                              'type': 1
                                            }).then((value) {
                                          _getMyEducationTrainingTaskStatistics();
                                          // 返回值
                                        });
                                      } else {
                                        Fluttertoast.showToast(msg: '敬请期待');
                                      }
                          },
                          child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 30,
                                    vertical: size.width * 15),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 24,
                                    vertical: size.width * 45),
                              decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.16),
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0)
                                    ]),
                              child: Row(
                                children: [
                                  Image.asset(
                                    yearData[index]['image'],
                                    height: size.width * 90,
                                    width: size.width * 90,
                                  ),
                                  SizedBox(
                                    width: size.width * 30,
                                  ),
                                  Text(
                                    yearData[index]['name'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: size.width * 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Container(
                                      height: size.width * 50,
                                      width: size.width * 90,
                                      decoration: BoxDecoration(
                                        color: Color(0xff3074FF),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 6)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '详情',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.width * 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            yearData[index]['num'] != 0
                                ? Positioned(
                                      right: size.width * 45,
                                      top: size.width * 65,
                                      child: Container(
                                        height: size.width * 26,
                                        width: size.width * 26,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        alignment: Alignment.center,
                                        child: Text(
                                          yearData[index]['num'].toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 16),
                                        ),
                                      ))
                                : Container(),
                          ],
                        ),
                        );
                      }))
        ],
      ),
    );
  }
}
