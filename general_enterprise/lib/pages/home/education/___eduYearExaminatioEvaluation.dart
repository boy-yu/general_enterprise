import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class EduYearExaminatioEvaluation extends StatefulWidget {
  EduYearExaminatioEvaluation({this.yearExaminatioEvaluation});
  final List yearExaminatioEvaluation;
  @override
  _EduYearExaminatioEvaluationState createState() => _EduYearExaminatioEvaluationState();
}

class _EduYearExaminatioEvaluationState extends State<EduYearExaminatioEvaluation> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('考试测评情况'),
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: widget.yearExaminatioEvaluation.length,
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1.0,
                    spreadRadius: 1.0
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/cp@2x.png',
                              height: size.width * 30,
                              width: size.width * 30,
                            ),
                            SizedBox(
                              width: size.width * 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.yearExaminatioEvaluation[index]['year'].toString() + '年考试测评情况',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 24
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: size.width * 33,
                                      width: size.width * 172,
                                      color: Color(0xffE5EDFF),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '学习计划'+ widget.yearExaminatioEvaluation[index]['planNum'].toString() +'次',
                                        style: TextStyle(
                                          color: Color(0xff2758F5),
                                          fontSize: size.width * 20
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 20,
                                    ),
                                    Container(
                                      height: size.width * 33,
                                      width: size.width * 190,
                                      color: Color(0xffE5EDFF),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '阶段性考核'+ widget.yearExaminatioEvaluation[index]['examinatioNum'].toString() +'次',
                                        style: TextStyle(
                                          color: Color(0xff2758F5),
                                          fontSize: size.width * 20
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: size.width * 110,
                        width: size.width * 201,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/bg_kaoshicepingfenshu.png'),
                          )
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.yearExaminatioEvaluation[index]['avgScore'].toString(),
                              style: TextStyle(
                                fontSize: size.width * 36,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: size.width * 10,
                            ),
                            Text(
                              '考核平均分',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 24
                              ),
                            )
                          ],
                        ),
                      ),
                    ]
                  ),
                  Container(
                    height: size.width * 1,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffEEEEEE),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 25),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '考试合格',
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: size.width * 21
                            ),
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Text(
                            widget.yearExaminatioEvaluation[index]['passNum'].toString() + '次',
                            style: TextStyle(
                              color: Color(0xff50A3EF),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '考试不合格',
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: size.width * 21
                            ),
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Text(
                            widget.yearExaminatioEvaluation[index]['unqualified'].toString() + '次',
                            style: TextStyle(
                              color: Color(0xffD12926),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '缺考',
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: size.width * 21
                            ),
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Text(
                            widget.yearExaminatioEvaluation[index]['missedExamNum'].toString() + '次',
                            style: TextStyle(
                              color: Color(0xffFFAA72),
                              fontSize: size.width * 26
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  )
                ],
              ),
            );
          }
        ),
      )
    );
  }
}