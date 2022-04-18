import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduCheckExamLedgerDetails extends StatefulWidget {
  EduCheckExamLedgerDetails(
      {this.userId, this.planId, this.stage, this.year});
  // final int examinationId;
  final int userId, planId, stage;
  final String year;
  @override
  _EduCheckExamLedgerDetailsState createState() =>
      _EduCheckExamLedgerDetailsState();
}

class _EduCheckExamLedgerDetailsState extends State<EduCheckExamLedgerDetails> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: choosed);
    _controller.addListener(() {
      if (oldPage != _controller.page.toInt()) {
        choosed = _controller.page.toInt();
        oldPage = choosed;
        if (mounted) {
          setState(() {});
        }
      }
    });
    _init();
  }

  Map examinationData = {
    "score": 0,
    // 单选
    "singleChoice": [],
    // 填空
    "fillBlank": [
      {
        "cOption": "",
        "answerList": [],
        "result": 0,
        "score": 0,
        "questionMain": "",
        "bOption": "",
        "dOption": "",
        "correctAnswer": "",
        "parsing": "",
        "questionType": 3,
        "aOption": ""
      },
    ],
    // 判断
    "judgment": [
      {
        "cOption": "",
        "result": 0,
        "answerList": [],
        "score": 0,
        "questionMain": "",
        "bOption": "",
        "dOption": "",
        "correctAnswer": "",
        "parsing": "",
        "questionType": 4,
        "aOption": ""
      },
    ],
    "totalnum": 0,
    "errorNum": 0,
    // 问答
    "questionsAnswers": [
      {
        "cOption": "",
        "result": 0,
        "answerList": [],
        "score": 0,
        "questionMain": "",
        "bOption": "",
        "dOption": "",
        "correctAnswer": "",
        "parsing": "",
        "questionType": 5,
        "aOption": ""
      },
    ],
    // 多选
    "multipleChoice": [
      {
        "cOption": "",
        "result": 0,
        "answerList": [],
        "score": 0,
        "questionMain": "",
        "bOption": "",
        "dOption": "",
        "correctAnswer": "",
        "parsing": "",
        "questionType": 2,
        "aOption": ""
      },
    ]
  };

  List singleChoice = [];
  List multipleChoice = [];
  List judgment = [];
  List fillBlank = [];
  List questionsAnswers = [];

  String absent = '';

  _init() {
    // if (widget.examinationId == null) {
      if (widget.year == 'year') {
        myDio.request(
            type: "get",
            url: Interface.getYearExaminationPaper + widget.planId.toString(),
            queryParameters: {
              'userId': widget.userId,
              'stage': widget.stage
            }).then((value) {
          if (value is Map) {
            data = value;
            if (value['examinationData'] is Map) {
              examinationData = value['examinationData'];

              singleChoice = examinationData['singleChoice'];
              multipleChoice = examinationData['multipleChoice'];
              judgment = examinationData['judgment'];
              fillBlank = examinationData['fillBlank'];
              questionsAnswers = examinationData['questionsAnswers'];

              workData[0]['num'] = singleChoice.length;
              workData[1]['num'] = multipleChoice.length;
              workData[2]['num'] = judgment.length;
              workData[3]['num'] = fillBlank.length;
              workData[4]['num'] = questionsAnswers.length;
            } else {
              absent = '缺考';
            }
          }
          setState(() {
            show = true;
          });
        });
      } else {
        myDio.request(
            type: "get",
            url: Interface.getExaminationPaper + widget.planId.toString(),
            queryParameters: {
              'userId': widget.userId,
              'stage': widget.stage
            }).then((value) {
          if (value is Map) {
            data = value;
            if (value['examinationData'] is Map) {
              examinationData = value['examinationData'];
              if(examinationData == null){
                absent = '缺考';
              }else{
                singleChoice = examinationData['singleChoice'];
                multipleChoice = examinationData['multipleChoice'];
                judgment = examinationData['judgment'];
                fillBlank = examinationData['fillBlank'];
                questionsAnswers = examinationData['questionsAnswers'];

                workData[0]['num'] = singleChoice.length;
                workData[1]['num'] = multipleChoice.length;
                workData[2]['num'] = judgment.length;
                workData[3]['num'] = fillBlank.length;
                workData[4]['num'] = questionsAnswers.length;
              }
            } else {
              absent = '缺考';
            }
          }
          setState(() {
            show = true;
          });
        });
      }
    // } else {
    //   myDio.request(
    //       type: "get",
    //       url: Interface.getMyExaminationById,
    //       queryParameters: {
    //         'examinationId': widget.examinationId
    //       }).then((value) {
    //     if (value is Map) {
    //       data = value;
    //       if (value['examinationData'] is Map) {
    //         examinationData = value['examinationData'];

    //         singleChoice = examinationData['singleChoice'];
    //         multipleChoice = examinationData['multipleChoice'];
    //         judgment = examinationData['judgment'];
    //         fillBlank = examinationData['fillBlank'];
    //         questionsAnswers = examinationData['questionsAnswers'];

    //         workData[0]['num'] = singleChoice.length;
    //         workData[1]['num'] = multipleChoice.length;
    //         workData[2]['num'] = judgment.length;
    //         workData[3]['num'] = fillBlank.length;
    //         workData[4]['num'] = questionsAnswers.length;
    //       } else {
    //         absent = '缺考';
    //       }
    //       setState(() {
    //         show = true;
    //       });
    //     }
    //   });
    // }
  }

  Map data = {};

  PageController _controller;

  List workData = [
    {
      "index": 0,
      "title": "单选题",
      'num': 0,
    },
    {
      "index": 1,
      "title": "多选题",
      'num': 0,
    },
    {
      "index": 2,
      "title": "判断题",
      'num': 0,
    },
    {
      "index": 3,
      "title": "填空题",
      'num': 0,
    },
    {
      "index": 4,
      "title": "问答题",
      'num': 0,
    },
  ];

  int choosed = 0;
  int oldPage = 0;

  Widget _changeTitle(width, item) {
    Widget _widget;
    switch (item['title']) {
      case '单选题':
        _widget = ChoiceTopic(data: singleChoice);
        break;
      case '多选题':
        _widget = ChoiceTopic(data: multipleChoice, type: 'multiple');
        break;
      case '判断题':
        _widget = Judgment(data: judgment);
        break;
      case '填空题':
        _widget = FillBlank(data: fillBlank);
        break;
      case '问答题':
        _widget = QuestionsAnswers(data: questionsAnswers);
        break;
      default:
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('考试详情'),
        elevation: 0,
        child: Transtion(
            data.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 30,
                            vertical: size.width * 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(size.width * 30),
                                  child: Text(
                                    data['name'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff222222),
                                        fontSize: size.width * 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: size.width * 48,
                                  width: size.width * 112,
                                  decoration: BoxDecoration(
                                    color: data['score'] >= data['passLine'] ? Color(0xffECF2FF) : Color(0xffFFF2EC),
                                    borderRadius: BorderRadius.horizontal(left: Radius.circular(size.width * 24)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    data['score'] >= data['passLine']
                                        ? '合格'
                                        : '不合格',
                                        style: TextStyle(
                                          color: data['score'] >= data['passLine'] ? Color(0xff3071FD) : Color(0xffFD7830),
                                          fontSize: size.width * 24
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        data['score'] >= data['passLine'] ? 'assets/images/hg-rq@2x.png' : 'assets/images/bhg-rq@2x.png',
                                        height: size.width * 30,
                                        width: size.width * 30,
                                      ),
                                      SizedBox(
                                        width: size.width * 10,
                                      ),
                                      Text(
                                        '考核日期：${DateTime.fromMillisecondsSinceEpoch(data['modifyDate']).toString().substring(0, 11)}',
                                        style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 26
                                        ),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        data['score'] >= data['passLine'] ? 'assets/images/hg-fsx@2x.png' : 'assets/images/bhg-hgfsx@2x.png',
                                        height: size.width * 30,
                                        width: size.width * 30,
                                      ),
                                      SizedBox(
                                        width: size.width * 10,
                                      ),
                                      Text(
                                        '合格分数线：${data['passLine']}分',
                                        style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 26
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 15,
                                  ),
                                  Text(
                                    '答题人姓名：${data['nickname']}',
                                    style: TextStyle(
                                      color: Color(0xff666666),
                                      fontSize: size.width * 26,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.width * 15,
                                  ),
                                  Text(
                                    '人员类别：${data['typeName']}',
                                    style: TextStyle(
                                      color: Color(0xff666666),
                                      fontSize: size.width * 26,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.width * 20,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: size.width * 50,
                              decoration: BoxDecoration(
                                color: data['score'] >= data['passLine'] ? Color(0xffECF2FF) : Color(0xffFFF2EC),
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(size.width * 10)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                data['examinationData'] == null ?  absent.toString() : '本次考试错题：${data['examinationData']['errorNum']}道      得分：${data['score']}分',
                                style: TextStyle(
                                  color: data['score'] >= data['passLine'] ? Color(0xff3071FD) : Color(0xffFD7830),
                                  fontSize: size.width * 24,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 30),
                        padding: EdgeInsets.only(top: size.width * 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: workData.map<Widget>((ele) {
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ele['num'].toString(),
                                      style: TextStyle(
                                          fontSize: size.width * 44,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff222222)),
                                    ),
                                    Text(
                                      ele['title'],
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontSize: size.width * 22),
                                    ),
                                    SizedBox(
                                      height: size.width * 20,
                                    ),
                                    Container(
                                      height: size.width * 7,
                                      width: size.width * 33,
                                      decoration: BoxDecoration(
                                          color: choosed == ele['index']
                                              ? Color(0xff0782FE)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  size.width * 3.5))),
                                    )
                                  ],
                                ));
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        child: PageView.builder(
                          controller: _controller,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.all(size.width * 30),
                            child: _changeTitle(size.width, workData[index]),
                          ),
                          itemCount: workData.length,
                        ),
                      )
                    ],
                  )
                : Container(),
            show)
    );
  }
}

class ChoiceTopic extends StatefulWidget {
  ChoiceTopic({this.data, this.type});
  final List data;
  final String type;
  @override
  _ChoiceTopicState createState() => _ChoiceTopicState();
}

class _ChoiceTopicState extends State<ChoiceTopic> {
  _getIcon(String current, List answerList) {
    int find = -1;
    List anwser = List.generate(
        answerList.length, (index) => answerList[index]['answer']);
    find = anwser.indexOf(current);
    if (find > -1) {
      return Image.asset(
        'assets/images/gou@2x.png',
        height: size.width * 30,
        width: size.width * 30,
      );
    } else {
      return Container(
        height: size.width * 30,
        width: size.width * 30,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: size.width * 2, color: Color(0xff295FF7)),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        alignment: Alignment.center,
        child: Text(
          current,
          style: TextStyle(color: Color(0xff295FF7), fontSize: size.width * 20),
        ),
      );
    }
    //   }else{

    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: size.width * 25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 20, vertical: size.width * 10),
                  child: Text(
                    (index + 1).toString() +
                        (widget.type == 'multiple'
                            ? '. 多选题（4分/题 得分：${widget.data[index]['score']}）'
                            : '. 单选题（2分/题 得分：${widget.data[index]['score']}）'),
                    style: TextStyle(
                        color: Color(0xff333333), fontSize: size.width * 28),
                  ),
                ),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffEEEEEE),
                ),
                Padding(
                    padding: EdgeInsets.all(size.width * 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data[index]['questionMain'] + ' (   )',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 28),
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: size.width * 320,
                              child: Row(
                                children: [
                                  _getIcon(
                                      'A', widget.data[index]['answerList']),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.data[index]['aOption'],
                                      style: TextStyle(
                                          fontSize: size.width * 28,
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 320,
                              child: Row(
                                children: [
                                  _getIcon(
                                      'B', widget.data[index]['answerList']),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.data[index]['bOption'],
                                      style: TextStyle(
                                          fontSize: size.width * 28,
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: size.width * 320,
                              child: Row(
                                children: [
                                  _getIcon(
                                      'C', widget.data[index]['answerList']),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.data[index]['cOption'],
                                      style: TextStyle(
                                          fontSize: size.width * 28,
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 320,
                              child: Row(
                                children: [
                                  _getIcon(
                                      'D', widget.data[index]['answerList']),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.data[index]['dOption'],
                                      style: TextStyle(
                                          fontSize: size.width * 28,
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        Row(
                          children: [
                            Text(
                              '正确答案：${widget.data[index]['correctAnswer']}',
                              style: TextStyle(
                                  color: Color(0xff295FF7),
                                  fontSize: size.width * 28),
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffEEEEEE),
                ),
                widget.data[index]['isShow'] == 1
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 20,
                            vertical: size.width * 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '题目解析',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xff047EFD)),
                            ),
                            SizedBox(
                              height: size.width * 10,
                            ),
                            Text(
                              widget.data[index]['parsing'],
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 28),
                            )
                          ],
                        ),
                      )
                    : Container(),
                GestureDetector(
                  onTap: () {
                    if (widget.data[index]['isShow'] == null) {
                      widget.data[index]['isShow'] = 1;
                    } else {
                      widget.data[index]['isShow'] = null;
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.width * 10),
                    child: widget.data[index]['isShow'] == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_up,
                                color: Color(0xff047EFD),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '显示解析',
                                style: TextStyle(
                                    color: Color(0xff047EFD),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff047EFD),
                              )
                            ],
                          ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class Judgment extends StatefulWidget {
  Judgment({this.data});
  final List data;
  @override
  _JudgmentState createState() => _JudgmentState();
}

class _JudgmentState extends State<Judgment> {
  _getIcon(String current, List answerList) {
    for (int i = 0; i < answerList.length; i++) {
      if (answerList[i]['answer'] == current) {
        return Image.asset(
          'assets/images/gou@2x.png',
          height: size.width * 30,
          width: size.width * 30,
        );
      } else {
        return Container(
          height: size.width * 30,
          width: size.width * 30,
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(width: size.width * 2, color: Color(0xff295FF7)),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          alignment: Alignment.center,
          child: Text(
            current == '正确' ? 'A' : 'B',
            style:
                TextStyle(color: Color(0xff295FF7), fontSize: size.width * 20),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: size.width * 25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 20, vertical: size.width * 10),
                  child: Text(
                    (index + 1).toString() +
                        '. 判断题（2分/题）得分：${widget.data[index]['score']}',
                    style: TextStyle(
                        color: Color(0xff333333), fontSize: size.width * 28),
                  ),
                ),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffEEEEEE),
                ),
                Padding(
                    padding: EdgeInsets.all(size.width * 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data[index]['questionMain'] + ' (   )',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 28),
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: size.width * 200,
                              child: Row(
                                children: [
                                  _getIcon(
                                      '正确', widget.data[index]['answerList']),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text(
                                    '正确',
                                    style: TextStyle(
                                        fontSize: size.width * 28,
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 200,
                              child: Row(
                                children: [
                                  _getIcon(
                                      '错误', widget.data[index]['answerList']),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text(
                                    '错误',
                                    style: TextStyle(
                                        fontSize: size.width * 28,
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        Row(
                          children: [
                            Text(
                              '正确答案：${widget.data[index]['correctAnswer']}',
                              style: TextStyle(
                                  color: Color(0xff295FF7),
                                  fontSize: size.width * 28),
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffEEEEEE),
                ),
                widget.data[index]['isShow'] == 1
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 20,
                            vertical: size.width * 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '题目解析',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xff047EFD)),
                            ),
                            SizedBox(
                              height: size.width * 10,
                            ),
                            Text(
                              widget.data[index]['parsing'],
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 28),
                            )
                          ],
                        ),
                      )
                    : Container(),
                GestureDetector(
                  onTap: () {
                    if (widget.data[index]['isShow'] == null) {
                      widget.data[index]['isShow'] = 1;
                    } else {
                      widget.data[index]['isShow'] = null;
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.width * 10),
                    child: widget.data[index]['isShow'] == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_up,
                                color: Color(0xff047EFD),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '显示解析',
                                style: TextStyle(
                                    color: Color(0xff047EFD),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff047EFD),
                              )
                            ],
                          ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class FillBlank extends StatefulWidget {
  FillBlank({this.data});
  final List data;
  @override
  _FillBlankState createState() => _FillBlankState();
}

class _FillBlankState extends State<FillBlank> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: size.width * 25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 20, vertical: size.width * 10),
                  child: Text(
                    (index + 1).toString() +
                        '. 填空题（4分/空 得分：${widget.data[index]['score']}）',
                    style: TextStyle(
                        color: Color(0xff333333), fontSize: size.width * 28),
                  ),
                ),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffEEEEEE),
                ),
                Padding(
                    padding: EdgeInsets.all(size.width * 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data[index]['questionMain'],
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 28),
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        // 填空题选项rwhre
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.data[index]['answerList'].length,
                            itemBuilder: (context, _index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.width * 5),
                                child: Row(
                                  children: [
                                    Text(
                                      (_index + 1).toString() + '.',
                                      style: TextStyle(
                                          color: Color(0xff295FF7),
                                          fontSize: size.width * 34),
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Text(
                                      widget.data[index]['answerList'][_index]
                                          ['answer'],
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontSize: size.width * 28),
                                    )
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        Row(
                          children: [
                            Text(
                              '正确答案：${widget.data[index]['correctAnswer']}',
                              style: TextStyle(
                                  color: Color(0xff295FF7),
                                  fontSize: size.width * 28),
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffEEEEEE),
                ),
                widget.data[index]['isShow'] == 1
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 20,
                            vertical: size.width * 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '题目解析',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xff047EFD)),
                            ),
                            SizedBox(
                              height: size.width * 10,
                            ),
                            Text(
                              widget.data[index]['parsing'],
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 28),
                            )
                          ],
                        ),
                      )
                    : Container(),
                GestureDetector(
                  onTap: () {
                    if (widget.data[index]['isShow'] == null) {
                      widget.data[index]['isShow'] = 1;
                    } else {
                      widget.data[index]['isShow'] = null;
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.width * 10),
                    child: widget.data[index]['isShow'] == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_up,
                                color: Color(0xff047EFD),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '显示解析',
                                style: TextStyle(
                                    color: Color(0xff047EFD),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff047EFD),
                              )
                            ],
                          ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class QuestionsAnswers extends StatefulWidget {
  QuestionsAnswers({this.data});
  final List data;
  @override
  _QuestionsAnswersState createState() => _QuestionsAnswersState();
}

class _QuestionsAnswersState extends State<QuestionsAnswers> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: size.width * 25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 20, vertical: size.width * 10),
                  child: Text(
                    (index + 1).toString() +
                        '. 问答题（8分/题 得分：${widget.data[index]['score']}）',
                    style: TextStyle(
                        color: Color(0xff333333), fontSize: size.width * 28),
                  ),
                ),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffEEEEEE),
                ),
                Padding(
                    padding: EdgeInsets.all(size.width * 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data[index]['questionMain'],
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 28),
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        // 问答题选项rwhre
                        Center(
                          child: Container(
                            height: size.width * 260,
                            width: size.width * 630,
                            padding: EdgeInsets.all(size.width * 10),
                            color: Color(0xffF1F6FF),
                            child: Text(
                                widget.data[index]['answerList'][0]['answer']),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                      ],
                    )),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffEEEEEE),
                ),
                widget.data[index]['isShow'] == 1
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 20,
                            vertical: size.width * 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '题目解析',
                              style: TextStyle(
                                  fontSize: size.width * 24,
                                  color: Color(0xff047EFD)),
                            ),
                            SizedBox(
                              height: size.width * 10,
                            ),
                            Text(
                              widget.data[index]['parsing'],
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 28),
                            )
                          ],
                        ),
                      )
                    : Container(),
                GestureDetector(
                  onTap: () {
                    if (widget.data[index]['isShow'] == null) {
                      widget.data[index]['isShow'] = 1;
                    } else {
                      widget.data[index]['isShow'] = null;
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.width * 10),
                    child: widget.data[index]['isShow'] == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_up,
                                color: Color(0xff047EFD),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '显示解析',
                                style: TextStyle(
                                    color: Color(0xff047EFD),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff047EFD),
                              )
                            ],
                          ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
