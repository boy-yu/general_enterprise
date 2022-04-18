import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EduFormulateExamQuestions extends StatefulWidget {
  final List educationTrainingResources;
  EduFormulateExamQuestions({this.educationTrainingResources});
  @override
  _EduFormulateExamQuestionsState createState() =>
      _EduFormulateExamQuestionsState();
}

class _EduFormulateExamQuestionsState extends State<EduFormulateExamQuestions> {
  List compulsoryList = [];
  List resourcesIds = [];
  List compulsoryQuestionsIds = [];

  @override
  void initState() {
    super.initState();
    compulsoryList = widget.educationTrainingResources;
    for (int i = 0; i < compulsoryList.length; i++) {
      resourcesIds.add(compulsoryList[i]['id']);
    }
    systemDistributableGrade = 100 - grade;
    _getAssignableLibraryNum();
  }

  Map quesNum = {
    'fillBlankNum': 0, 
    'judgmentNum': 0, 
    'singleChoiceNum': 0, 
    'multipleChoiceNum': 0, 
    'questionsAnswersNum': 0
  };

  _getAssignableLibraryNum(){
    myDio.request(
                        type: 'post',
                        url: Interface.postAssignableLibraryNum,
                        data: {
                          'compulsoryQuestionsIds': compulsoryQuestionsIds,
                          'resourcesIds': resourcesIds
                        }
                      ).then((value) {
                        if(value is Map){
                          quesNum = value;
                        }
                        setState(() {});
                      });
  }

  int quNumber = 0;
  int grade = 0;

  int systemDistributableGrade = 0;

  int assignedSingleChoiceScore  = 0;
  int assignedMultipleChoiceScore  = 0;
  int assignedFillBlankScore  = 0;
  int assignedJudgmentScore  = 0;
  int assignedQuestionsAnswersScore  = 0;

  int assignedSingleChoiceNum = 0;
  int assignedMultipleChoiceNum = 0;
  int assignedFillBlankNum = 0;
  int assignedJudgmentNum = 0;
  int assignedQuestionsAnswersNum = 0;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('制定考题'),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(size.width * 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '系统分配考题',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 28,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.width * 5,
                        ),
                        RichText(
                          text: TextSpan(children: <InlineSpan>[
                            TextSpan(
                                text: '本试卷还剩余',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 22)),
                            TextSpan(
                                text: systemDistributableGrade.toString(),
                                style: TextStyle(
                                    color: Color(0xff3074FF),
                                    fontSize: size.width * 24)),
                            TextSpan(
                                text: '分可以让系统给员工分配不同的考题进行考核',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 22)),
                          ]),
                        ),
                        SizedBox(
                          height: size.width * 5,
                        ),
                        Text(
                          '单选题：2分/题    多选题：4分/题    判断题：2分/题',
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 20,
                          ),
                        ),
                        Text(
                          '填空题：4分/题    问答题：8分/题',
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 20,
                          ),
                        ),
                        SizedBox(
                          height: size.width * 5,
                        ),
                        Text(
                          '*以下为每种题型最多的分配次数',
                          style: TextStyle(
                            color: Color(0xff3074FF),
                            fontSize: size.width * 20,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: size.width * 10),
                          padding: EdgeInsets.symmetric(vertical: size.width * 10, horizontal: size.width * 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(size.width * 10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1.0,
                                    blurRadius: 5.0)
                              ]),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '单选题：',
                                    style: TextStyle(
                                      color: Color(0xff262626),
                                      fontSize: size.width * 24,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Container(
                                    width: size.width * 200,
                                    height: size.width * 60,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: '请输入分配题数',
                                        hintStyle: TextStyle(
                                            color: Color(0xffA6A6A6),
                                            fontSize: size.width * 22),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (String str) {
                                        quesNum['isChoiceNum'] = null;
                                        if(str != ''){
                                          if(int.parse(str) > quesNum['singleChoiceNum']){
                                            quesNum['isChoiceNum'] = 1;
                                            Fluttertoast.showToast(msg: '超过可分配题数');
                                          }else{
                                            assignedSingleChoiceNum = int.parse(str);
                                            assignedSingleChoiceScore = int.parse(str) * 2;
                                            systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                            if(systemDistributableGrade < 0){
                                              Fluttertoast.showToast(msg: '本套试卷已超过100分，请重新分配');
                                            }
                                          }
                                        }else{
                                          assignedSingleChoiceNum = 0;
                                          assignedSingleChoiceScore = 0 * 2;
                                          systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                        }
                                        setState(() {});
                                      },
                                      autofocus: false,
                                      style: TextStyle(
                                          color: quesNum['isChoiceNum'] == 1 ? Colors.red :Color(0xff0059FF),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                          text: '题',
                                          style: TextStyle(
                                              color: Color(0xff0059FF),
                                              fontSize: size.width * 22,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '  |  ',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                      TextSpan(
                                          text: quesNum['singleChoiceNum'] * 2 > systemDistributableGrade ? (systemDistributableGrade / 2) > (quesNum['singleChoiceNum'] - assignedSingleChoiceNum) ? '可分配${(quesNum['singleChoiceNum'] - assignedSingleChoiceNum)}题' : '可分配${(systemDistributableGrade / 2).floor()}题' : '可分配${quesNum['singleChoiceNum']}题',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                    ]),
                                  ),
                                ],
                              ),
                              Container(
                                color: Color(0xffE0E0E0),
                                height: size.width * 1,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(vertical: size.width * 10),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '多选题：',
                                    style: TextStyle(
                                      color: Color(0xff262626),
                                      fontSize: size.width * 24,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Container(
                                    width: size.width * 200,
                                    height: size.width * 60,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: '请输入分配题数',
                                        hintStyle: TextStyle(
                                            color: Color(0xffA6A6A6),
                                            fontSize: size.width * 22),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (String str) {
                                        quesNum['ismMultipleNum'] = null;
                                        if(str != ''){
                                          if(int.parse(str) > quesNum['multipleChoiceNum']){
                                            Fluttertoast.showToast(msg: '超过可分配题数');
                                            quesNum['ismMultipleNum'] = 1;
                                          }else{
                                            assignedMultipleChoiceNum = int.parse(str);
                                            assignedMultipleChoiceScore = int.parse(str) * 4;
                                            systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                            if(systemDistributableGrade < 0){
                                              Fluttertoast.showToast(msg: '本套试卷已超过100分，请重新分配');
                                            }
                                          }
                                        }else{
                                          assignedMultipleChoiceNum = 0;
                                          assignedMultipleChoiceScore = 0 * 2;
                                          systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                        }
                                        setState(() {});
                                      },
                                      autofocus: false,
                                      style: TextStyle(
                                          color: quesNum['ismMultipleNum'] == 1 ? Colors.red : Color(0xff0059FF),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                          text: '题',
                                          style: TextStyle(
                                              color: Color(0xff0059FF),
                                              fontSize: size.width * 22,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '  |  ',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                      TextSpan(
                                          text: quesNum['multipleChoiceNum'] * 4 > systemDistributableGrade ? (systemDistributableGrade / 4) > (quesNum['multipleChoiceNum'] - assignedMultipleChoiceNum) ? '可分配${(quesNum['multipleChoiceNum'] - assignedMultipleChoiceNum)}题' : '可分配${(systemDistributableGrade / 4).floor()}题' : '可分配${quesNum['multipleChoiceNum']}题',
                                          // text: quesNum['multipleChoiceNum'] * 4 > systemDistributableGrade ? '可分配${(systemDistributableGrade / 4).floor()}题' : '可分配${quesNum['multipleChoiceNum']}题',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                    ]),
                                  ),
                                ],
                              ),
                              Container(
                                color: Color(0xffE0E0E0),
                                height: size.width * 1,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(vertical: size.width * 10),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '判断题：',
                                    style: TextStyle(
                                      color: Color(0xff262626),
                                      fontSize: size.width * 24,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Container(
                                    width: size.width * 200,
                                    height: size.width * 60,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: '请输入分配题数',
                                        hintStyle: TextStyle(
                                            color: Color(0xffA6A6A6),
                                            fontSize: size.width * 22),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (String str) {
                                        quesNum['isJudgmentNum'] = null; 
                                        if(str != ''){
                                          if(int.parse(str) > quesNum['judgmentNum']){
                                            Fluttertoast.showToast(msg: '超过可分配题数');
                                            quesNum['isJudgmentNum'] = 1;
                                          }else{
                                            assignedJudgmentNum = int.parse(str);
                                            assignedJudgmentScore = int.parse(str) * 2;
                                            systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                            if(systemDistributableGrade < 0){
                                              Fluttertoast.showToast(msg: '本套试卷已超过100分，请重新分配');
                                            }
                                          }
                                        }else{
                                          assignedJudgmentNum = 0;
                                          assignedJudgmentScore = 0 * 2;
                                          systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                        }
                                        setState(() {});
                                      },
                                      autofocus: false,
                                      style: TextStyle(
                                          color: quesNum['isJudgmentNum'] == 1 ? Colors.red : Color(0xff0059FF),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                          text: '题',
                                          style: TextStyle(
                                              color: Color(0xff0059FF),
                                              fontSize: size.width * 22,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '  |  ',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                      TextSpan(
                                          text: quesNum['judgmentNum'] * 2 > systemDistributableGrade ? (systemDistributableGrade / 2) > (quesNum['judgmentNum'] - assignedJudgmentNum) ? '可分配${(quesNum['judgmentNum'] - assignedJudgmentNum)}题' : '可分配${(systemDistributableGrade / 2).floor()}题' : '可分配${quesNum['judgmentNum']}题',
                                          // text: quesNum['judgmentNum'] * 2 > systemDistributableGrade ? '可分配${(systemDistributableGrade / 2).floor()}题' : '可分配${quesNum['judgmentNum']}题',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                    ]),
                                  ),
                                ],
                              ),
                              Container(
                                color: Color(0xffE0E0E0),
                                height: size.width * 1,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(vertical: size.width * 10),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '填空题：',
                                    style: TextStyle(
                                      color: Color(0xff262626),
                                      fontSize: size.width * 24,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Container(
                                    width: size.width * 200,
                                    height: size.width * 60,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: '请输入分配题数',
                                        hintStyle: TextStyle(
                                            color: Color(0xffA6A6A6),
                                            fontSize: size.width * 22),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (String str) {
                                        quesNum['isFillBlankNum'] = null;
                                        if(str != ''){
                                          if(int.parse(str) > quesNum['fillBlankNum']){
                                            Fluttertoast.showToast(msg: '超过可分配题数');
                                            quesNum['isFillBlankNum'] = 1;
                                          }else{
                                            assignedFillBlankNum = int.parse(str);
                                            assignedFillBlankScore = int.parse(str) * 4;
                                            systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                            if(systemDistributableGrade < 0){
                                              Fluttertoast.showToast(msg: '本套试卷已超过100分，请重新分配');
                                            }
                                          }
                                        }else{
                                          assignedFillBlankNum = 0;
                                          assignedFillBlankScore = 0 * 2;
                                          systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                        }
                                        setState(() {});
                                      },
                                      autofocus: false,
                                      style: TextStyle(
                                          color: quesNum['isFillBlankNum'] == 1 ? Colors.red : Color(0xff0059FF),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                          text: '题',
                                          style: TextStyle(
                                              color: Color(0xff0059FF),
                                              fontSize: size.width * 22,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '  |  ',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                      TextSpan(
                                          text: quesNum['fillBlankNum'] * 4 > systemDistributableGrade ? (systemDistributableGrade / 4) > (quesNum['fillBlankNum'] - assignedFillBlankNum) ? '可分配${(quesNum['fillBlankNum'] - assignedFillBlankNum)}题' : '可分配${(systemDistributableGrade / 4).floor()}题' : '可分配${quesNum['fillBlankNum']}题',
                                          // text: quesNum['fillBlankNum'] * 4 > systemDistributableGrade ? '可分配${(systemDistributableGrade / 4).floor()}题' : '可分配${quesNum['fillBlankNum']}题',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                    ]),
                                  ),
                                ],
                              ),
                              Container(
                                color: Color(0xffE0E0E0),
                                height: size.width * 1,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(vertical: size.width * 10),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '问答题：',
                                    style: TextStyle(
                                      color: Color(0xff262626),
                                      fontSize: size.width * 24,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Container(
                                    width: size.width * 200,
                                    height: size.width * 60,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: '请输入分配题数',
                                        hintStyle: TextStyle(
                                            color: Color(0xffA6A6A6),
                                            fontSize: size.width * 22),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (String str) {
                                        quesNum['isQuestionsAnswersNum'] = null;
                                        if(str != ''){
                                          if(int.parse(str) > quesNum['questionsAnswersNum']){
                                            Fluttertoast.showToast(msg: '超过可分配题数');
                                            quesNum['isQuestionsAnswersNum'] = 1;
                                          }else{
                                            assignedQuestionsAnswersNum = int.parse(str);
                                            assignedQuestionsAnswersScore = int.parse(str) * 8;
                                            systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                            if(systemDistributableGrade < 0){
                                              Fluttertoast.showToast(msg: '本套试卷已超过100分，请重新分配');
                                            }
                                          }
                                        }else{
                                          assignedQuestionsAnswersNum = 0;
                                          assignedQuestionsAnswersScore = 0 * 2;
                                          systemDistributableGrade = 100 - grade - assignedSingleChoiceScore - assignedMultipleChoiceScore - assignedFillBlankScore - assignedJudgmentScore - assignedQuestionsAnswersScore;
                                        }
                                        setState(() {});
                                      },
                                      autofocus: false,
                                      style: TextStyle(
                                          color: quesNum['isQuestionsAnswersNum'] == 1 ? Colors.red : Color(0xff0059FF),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                          text: '题',
                                          style: TextStyle(
                                              color: Color(0xff0059FF),
                                              fontSize: size.width * 22,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '  |  ',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                      TextSpan(
                                          text: quesNum['questionsAnswersNum'] * 8 > systemDistributableGrade ? (systemDistributableGrade / 2) > (quesNum['questionsAnswersNum'] - assignedQuestionsAnswersNum) ? '可分配${(quesNum['questionsAnswersNum'] - assignedQuestionsAnswersNum)}题' : '可分配${(systemDistributableGrade / 8).floor()}题' : '可分配${quesNum['questionsAnswersNum']}题',
                                          // text: quesNum['questionsAnswersNum'] * 8 > systemDistributableGrade ? '可分配${(systemDistributableGrade / 8).floor()}题' : '可分配${quesNum['questionsAnswersNum']}题',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 24)),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(size.width * 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '已制定必考题' + quNumber.toString() + '题共' + grade.toString() + '分',
                          style: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true, 
                          physics:NeverScrollableScrollPhysics(),
                          itemCount: compulsoryList.length,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, "/home/education/eduQuestionLibrary",
                                  arguments: {
                                    'compulsoryList': compulsoryList,
                                    'index': index
                                  }).then((value) {
                                    // 返回值
                                    if(value is List){
                                      compulsoryQuestionsIds = [];
                                      quNumber = value.length;
                                      for (int i = 0; i < value.length; i++) {
                                        grade += value[i]['score'];
                                        compulsoryQuestionsIds.add(value[i]['id']);
                                      }
                                      systemDistributableGrade = 100 - grade;
                                      _getAssignableLibraryNum();
                                      setState(() {});
                                    }
                                  });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: size.width * 10),
                                padding: EdgeInsets.symmetric(vertical: size.width * 15, horizontal: size.width * 30),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1.0,
                                      blurRadius: 5.0
                                    )
                                  ]
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          compulsoryList[index]['title'],
                                          style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 28,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.width * 10,
                                        ),
                                        Text(
                                          '共${compulsoryList[index]['classHours']}学时',
                                          style: TextStyle(
                                            color: Color(0xff16CAA2),
                                            fontSize: size.width * 18
                                          ),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      '请选择  >',
                                      style: TextStyle(
                                        fontSize: size.width * 26,
                                        color: Color(0xff4C94FD)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        )
                      ],
                    ),
                  ),
                ],
              )
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: size.width * 225, vertical: size.width * 30),
              child: GestureDetector(
                onTap:(){
                  if(systemDistributableGrade != 0){
                    Fluttertoast.showToast(msg: '本套考题不是100分，请确认分配');
                  }else{
                    String compulsoryQuestionsId = '';
                    compulsoryQuestionsIds.forEach((f){
                      if(compulsoryQuestionsId == ''){
                        compulsoryQuestionsId = "$f";
                      }else {
                        compulsoryQuestionsId = "$compulsoryQuestionsId"",""$f";
                      }
                    });

                    Map traiPlanExamData = {};
                    traiPlanExamData['compulsoryQuestionsId'] = compulsoryQuestionsId;
                    traiPlanExamData['singleChoiceNum'] = assignedSingleChoiceNum;
                    traiPlanExamData['multipleChoiceNum'] = assignedMultipleChoiceNum;
                    traiPlanExamData['fillBlankNum'] = assignedFillBlankNum;
                    traiPlanExamData['judgmentNum'] = assignedJudgmentNum;
                    traiPlanExamData['questionsAnswersNum'] = assignedQuestionsAnswersNum;
                    // 制定的考题数量
                    traiPlanExamData['enactTopicNum'] = compulsoryQuestionsIds.length + assignedSingleChoiceNum + assignedMultipleChoiceNum + assignedFillBlankNum + assignedJudgmentNum + assignedQuestionsAnswersNum;
                    
                    Navigator.pop(context, traiPlanExamData);
                  }
                },
                child: Container(
                  height: size.width * 60,
                  decoration: BoxDecoration(
                    color: Color(0xff0059FF),
                    borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '确定',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 32,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
