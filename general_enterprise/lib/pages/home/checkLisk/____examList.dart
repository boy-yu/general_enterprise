import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

ThrowFunc examListthrowFunc = ThrowFunc();

class ExamList extends StatefulWidget {
  ExamList({this.type});
  final int type;
  @override
  _ExamListState createState() => _ExamListState();
}

class _ExamListState extends State<ExamList> {
  bool isHave;
  @override
  void initState() {
    super.initState();
    _getFaceData();
  }

  _getFaceData() {
    myDio.request(type: 'get', url: Interface.getFaceData).then((value) {
      isHave = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('考试'),
      child: Container(
        color: Colors.white,
        child: MyRefres(
            child: (index, list) => InkWell(
                  onTap: () {
                    // 人脸识别
                    // Navigator.pushNamed(context, "/checkList/examFaceVerify",
                    //     arguments: {
                    //       "id": list[index]['examinationId'],
                    //       'title': list[index]['name'],
                    //       'duration': list[index]['duration'],
                    //       'stage': list[index]['stage'],
                    //       'type': widget.type,
                    //       'isHave': isHave,
                    //       'passLine': list[index]['passLine']
                    //     }).then((value) {
                    //   examListthrowFunc.run();
                    //   // 返回值
                    // });
                    Navigator.pushNamed(context, "/home/education/mokExam",
                        arguments: {
                          "id": list[index]['examinationId'],
                          "formalExam": true,
                          'title': list[index]['name'],
                          'duration': list[index]['duration'],
                          'stage': list[index]['stage'],
                          'type': widget.type,
                          'passLine': list[index]['passLine']
                        }).then((value) {
                          examListthrowFunc.run();
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 30, vertical: size.width * 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 8)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1.0,
                              blurRadius: 1.0)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: size.width * 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width * 350,
                                        child: Text(
                                          list[index]['name'].toString(),
                                          style: TextStyle(
                                              color: Color(0xff404040),
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        height: size.width * 40,
                                        width: size.width * 119,
                                        decoration: BoxDecoration(
                                          color: Color(0xff3869FC),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(size.width * 4)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '开始考试',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: size.width * 1,
                                  color: Color(0xffE8E8E8),
                                  margin: EdgeInsets.symmetric(
                                      vertical: size.width * 12),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontSize: size.width * 20,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '第${list[index]['stage']}阶段考核： ',
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: '请在截至日期内完成考核',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff404040))),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontSize: size.width * 20,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '考试时长：',
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: '${list[index]['duration']}分钟',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff404040))),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontSize: size.width * 20,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '合格分数线：',
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: '${list[index]['passLine']}分',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff404040))),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: size.width * 5,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontSize: size.width * 20,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '截止时间：',
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: DateTime.fromMillisecondsSinceEpoch(list[index]['endTime']).toString().split(" ")[0],
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff404040))),
                                            ]),
                                      ),
                                    ])),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
            throwFunc: examListthrowFunc,
            url: Interface.getExamList,
            queryParameters: {'isYear': widget.type},
            method: 'get'),
      ),
    );
  }
}
