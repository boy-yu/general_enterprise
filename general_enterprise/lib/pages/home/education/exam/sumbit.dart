import 'package:enterprise/common/clickImage.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/checkLisk/____examList.dart';
import 'package:enterprise/pages/home/education/exam/db_examCache.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class ExamSumbit extends StatefulWidget {
  final List<ExamCacheType> data;
  final bool formalExam;
  final int id, stage, type, isPicList;
  final Map submitStudyRecords;
  const ExamSumbit(this.data,
      {Key key,
      this.formalExam = false,
      @required this.id,
      this.submitStudyRecords,
      this.stage,
      this.type, this.isPicList})
      : super(key: key);
  @override
  _ExamSumbitState createState() => _ExamSumbitState();
}

class _ExamSumbitState extends State<ExamSumbit> {
  double topImage = 0;
  bool show = false;
  String hint = "";
  int grade = 0;
  int passLine = 0;
  @override
  void initState() {
    super.initState();
    if (widget.formalExam) {
      _generateGrade();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          topImage = 60;
        });
        Future.delayed(Duration(seconds: 1), () {
          grade = 80;
          _judgeText();
          setState(() {
            show = true;
          });
        });
      });
    }
  }

  List answerVoList = [];
  _generateGrade() {
    List<Map> _list = [];
    widget.data.forEach((element) {
      if (element.type == TopicTye.judge) {
        if (element.sumbit.isNotEmpty) {
          if (element.sumbit[0] == 'A') {
            element.sumbit[0] = '正确';
          } else {
            element.sumbit[0] = '错误';
          }
        }
      }
      _list.add({
        "answers": element.sumbit.isEmpty ? [''] : element.sumbit,
        "id": element.id
      });
    });
    answerVoList = _list;
    myDio.request(type: 'post', url: Interface.postScoring, data: {
      "examinationId": widget.id,
      "answerVoList": _list,
      "stage": widget.stage,
      'type': widget.type
    }).then((value) {
      if (value is Map) {
        grade = value['score'] ?? 0;
        passLine = value['passLine'] ?? 0;
        for (var i = 0; i < value['answerResult'].length; i++) {
          widget.data[i].isRight = value['answerResult'][i] == 0 ? false : true;
        }
        topImage = 60;
        show = true;
        _judgeText();
        setState(() {});
      }
    });
  }

  _judgeText() {
    if (grade < 60) {
      hint = "亲爱的工友，您差一点就及格了~";
    } else if (grade >= 60 && grade <= 80) {
      hint = "再接再厉,取得更好成绩";
    } else {
      hint = "恭喜你,取得优异成绩";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff3174FF),
              Color(0xff1C3AEA),
            ])),
            child: Stack(
              children: [
                AnimatedPositioned(
                    top: topImage - 120,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/bg_paper_result.png",
                    ),
                    duration: Duration(seconds: 1)),
                Positioned(
                    top: topImage + 85,
                    left: MediaQuery.of(context).size.width * 0.05,
                    height: size.width * 800,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Container(
                      height: size.width * 800,
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Transtion(
                        Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          widget.formalExam ? '$passLine': '80',
                                          style: TextStyle(
                                            color: Color(0xff2BC152),
                                            fontSize: size.width * 40,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          widget.formalExam ? '及格分数线': '教材完成分数线',
                                          style: TextStyle(
                                            color: Color(0xff404040),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: size.width * 60,
                                      width: size.width * 2,
                                      color: Color(0xffE6E6E6),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          widget.formalExam 
                                            ? grade < passLine 
                                              ? '不及格'
                                              : '合格'
                                            : grade < 80 
                                              ? '不及格'
                                              : '合格',
                                          style: TextStyle(
                                            color: widget.formalExam 
                                              ? grade < passLine 
                                                ? Color(0xffFF6666)
                                                : Color(0xff2BC152)
                                              : grade < 80 
                                                ? Color(0xffFF6666)
                                                : Color(0xff2BC152),
                                            fontSize: size.width * 30,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.width * 5,
                                        ),
                                        Text(
                                          '本次表现',
                                          style: TextStyle(
                                            color: Color(0xff404040),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.width * 20,
                                ),
                                ModelBox(
                                    formalExam: widget.formalExam,
                                    data: widget.data,
                                    grade: grade,
                                    callback: (e, index) {
                                      Navigator.pop(context);
                                      Navigator.pop(context,
                                          {"index": index, "grade": grade});
                                    },
                                    getGrade: (grades) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        setState(() {
                                          grade = grades;
                                        });
                                      });
                                    },
                                    submitStudyRecords:
                                        widget.submitStudyRecords),
                              ],
                            ),
                          ),
                        ),
                        show,
                        addtion: Padding(
                          padding: EdgeInsets.only(top: 36),
                          child: Text("正在计算您的成绩，请稍后"),
                        ),
                      ),
                    )),
                // headImg
                AnimatedPositioned(
                  top: topImage + 40,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: ClipOval(
                          child: ClickImage(
                            myprefs.getString("photoUrl"),
                            width: size.width * 160,
                            height: size.width * 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 10,
                      ),
                      Text(
                        myprefs.getString("username") ?? '',
                        style: TextStyle(
                          color: Color(0xff404040),
                          fontSize: size.width * 28,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  duration: Duration(seconds: 1), 
                ),
                AnimatedPositioned(
                    bottom: topImage - 42,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        !widget.formalExam
                            ? ElevatedButton(
                                onPressed: () {
                                  // Navigator.pop(context);
                                  // Navigator.pop(context, false);
                                  if(widget.isPicList == 2){
                                    Navigator.pop(context, {"index": 0, "grade": grade});
                                  }else{
                                    Navigator.pop(context);
                                    Navigator.pop(context, {"index": 0, "grade": grade});
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: Container(
                                  width: 200,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "查看解析",
                                    style: TextStyle(color: Color(0xff0059FF)),
                                  ),
                                ))
                            : ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                  // Navigator.pop(context);
                                  Future.delayed(Duration(seconds: 1), () {
                                    examListthrowFunc?.run();
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: Container(
                                  width: 200,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "考试完成",
                                    style: TextStyle(color: Color(0xff0059FF)),
                                  ),
                                )),
                        SizedBox(height: 40),
                        Text(
                          "你重视,我参与,安全生产一起抓\n  努力,共谋生,生产安全靠大家",
                          style: TextStyle(color: Colors.white, fontSize: size.width * 24),
                        )
                      ],
                    ),
                    duration: Duration(seconds: 1)),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context, false);
          return false;
        });
  }
}

class ModelBox extends StatefulWidget {
  final List<ExamCacheType> data;
  final Function(ExamCacheType, int) callback;
  final Function(int grade) getGrade;
  final bool formalExam;
  final int grade;
  final Map submitStudyRecords;
  const ModelBox(
      {Key key,
      this.data,
      @required this.callback,
      this.getGrade,
      this.formalExam = false,
      this.grade = 0,
      this.submitStudyRecords})
      : super(key: key);
  @override
  _ModelBoxState createState() => _ModelBoxState();
}

class _ModelBoxState extends State<ModelBox> {
  @override
  void initState() {
    super.initState();
    if (!widget.formalExam) {
      _init();
    } else {
      grade = widget.grade;
    }
    print(widget.grade);
  }

  int grade = 0;
  _init() {
    widget.data.forEach((element) {
      if (element.type == TopicTye.mutiple) {
        int _correct = 0;
        for (var i = 0; i < element.sumbit.length; i++) {
          if (!element.anwser.contains(element.sumbit[i])) {
            _correct = 0;
            break;
          } else
            _correct++;
        }
        element.getGrade = _correct * (element.grade / element.anwser.length);
        //(element.grade / element.anwser.length);
        if (element.grade != element.getGrade) {
          element.getGrade = element.grade / 2;
          element.isRight = false;
        } else {
          element.isRight = true;
        }
        if (_correct == 0) element.getGrade = 0;
        grade += element.getGrade.toInt();
      } else if (element.type == TopicTye.input) {
        int _correct = 0;
        for (var i = 0; i < element.sumbit.length; i++) {
          if (!element.anwser.contains(element.sumbit[i])) {
            _correct = 0;
            break;
          } else
            _correct++;
        }
        element.getGrade = _correct * (element.grade / element.anwser.length);
        if (element.grade != element.getGrade) {
          element.getGrade = element.grade / 2;
          element.isRight = false;
        } else {
          element.isRight = true;
        }
        if (_correct == 0) element.getGrade = 0;
        grade += element.getGrade.toInt();
      } else if (element.type == TopicTye.singe ||
          element.type == TopicTye.judge) {
        if (element.sumbit.isEmpty) {
          element.isRight = false;
        } else {
          if (element.anwser[0] == element.sumbit[0]) {
            element.getGrade = element.grade;
            element.isRight = true;
          } else {
            element.isRight = false;
          }
        }
        grade += element.getGrade.toInt();
      } else if (element.type == TopicTye.FAQs) {
        grade += element.grade.toInt();
      }
    });
    if (widget.getGrade is Function) {
      widget.getGrade(grade);
    }
    if (widget.submitStudyRecords != null && grade > 80) {
      widget.submitStudyRecords['score'] = grade;
      myDio
          .request(
              type: "post",
              url: Interface.postSubmitStudyRecords,
              data: widget.submitStudyRecords)
          .then((value) {});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
        border: Border.all(
          width: size.width * 2, 
          color: Color(0xffF2F2F2)
        )
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.width * 25),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/icon_paper_result_medal.png",
                  width: size.width * 21,
                  height: size.width * 26,
                ),
                SizedBox(width: size.width * 20),
                Text(
                  "本次分数",
                  style: TextStyle(
                      fontSize: size.width * 24,
                      color: Color(0xff404040),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: grade.toString(),
                        style: TextStyle(
                            color: Color(0xff3074FF),
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 40)),
                    TextSpan(
                      text: '分',
                      style: TextStyle(
                          fontSize: size.width * 24, color: Color(0xff404040)),
                    ),
                  ]),
                )
              ],
            ),
          ),
          Container(
            color: Color(0xffF2F2F2),
            height: size.width * 2,
            width: double.infinity,
          ),
          Wrap(
            children: widget.data
                .asMap()
                .keys
                .map((i) => InkWell(
                      onTap: () {
                        if (widget.formalExam) {
                          widget.callback(widget.data[i], i);
                        }
                      },
                      child: Container(
                        width: size.width * 80,
                        height: size.width * 80,
                        margin: EdgeInsets.all(size.width * 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.data[i].isRight
                                ? Color(0xff5CCC84).withOpacity(0.1)
                                : Color(0xffFF3E3E).withOpacity(0.1)),
                        alignment: Alignment.center,
                        child: Text(
                          (i + 1).toString(),
                          style: TextStyle(
                              fontSize: size.width * 32,
                              color: widget.data[i].isRight
                                  ? Color(0xff5CCC84)
                                  : Color(0xffFF3E3E)),
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
