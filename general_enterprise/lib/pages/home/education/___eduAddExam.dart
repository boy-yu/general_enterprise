import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EduAddExam extends StatefulWidget {
  EduAddExam({this.educationTrainingResources});
  final List educationTrainingResources;
  @override
  _EduAddExamState createState() => _EduAddExamState();
}

class _EduAddExamState extends State<EduAddExam> {

  List educationTrainingPlanExaminationVoList = [
    {
      "compulsoryQuestionsId": "",
      "duration": 0,
      "endTime": "",
      "fillBlankNum": 0,
      "judgmentNum": 0,
      "multipleChoiceNum": 0,
      "passLine": 0,
      "questionsAnswersNum": 0,
      "singleChoiceNum": 0,
      "stage": 0
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('制定考试'),
      child: InkWell(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 20),
                child: Row(
                  children: [
                    Text(
                      '请选择考核次数',
                      style: TextStyle(
                        fontSize: size.width * 30,
                        color: Color(0xff262626),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: size.width * 165,
                      margin: EdgeInsets.only(top:5.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.black12)//设置所有的边框宽度为1 颜色为浅灰
                      ),
                      child: Row(
                        children: <Widget>[
                          _reduceBtn(),
                          _countArea(),
                          _addBtn()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.width * 20,
                width: MediaQuery.of(context).size.width,
                color: Color(0xffF7F7F7),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: educationTrainingPlanExaminationVoList.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.all(size.width * 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2.0,
                              blurRadius: 5.0
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            Container(
                              color: Color(0xffF7F7F7),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(size.width * 15),
                              child: Text(
                                '第' + (index + 1).toString() + '阶段考核',
                                style: TextStyle(
                                  color: Color(0xff0059FF),
                                  fontSize: size.width * 26,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(size.width * 20),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context)
                                          .pushNamed(
                                        '/home/education/eduFormulateExamQuestions',
                                        arguments: {'educationTrainingResources': widget.educationTrainingResources}
                                      ).then((value) {
                                        if(value is Map){
                                          educationTrainingPlanExaminationVoList[index]['enactTopicNum'] = value['enactTopicNum'];

                                          educationTrainingPlanExaminationVoList[index]['compulsoryQuestionsId'] = value['compulsoryQuestionsId'];
                                          educationTrainingPlanExaminationVoList[index]['singleChoiceNum'] = value['singleChoiceNum'];
                                          educationTrainingPlanExaminationVoList[index]['multipleChoiceNum'] = value['multipleChoiceNum'];
                                          educationTrainingPlanExaminationVoList[index]['fillBlankNum'] = value['fillBlankNum'];
                                          educationTrainingPlanExaminationVoList[index]['judgmentNum'] = value['judgmentNum'];
                                          educationTrainingPlanExaminationVoList[index]['questionsAnswersNum'] = value['questionsAnswersNum'];
                                        }
                                        setState(() {});
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          '制定考题',
                                          style: TextStyle(
                                            color: Color(0xff262626),
                                            fontSize: size.width * 24
                                          ),
                                        ),
                                        Spacer(),
                                        educationTrainingPlanExaminationVoList[index]['enactTopicNum'] == null ? Text(
                                          '请选择',
                                          style: TextStyle(
                                            color: Color(0xffA6A6A6),
                                            fontSize: size.width * 22
                                          ),
                                        ) : Text(
                                          educationTrainingPlanExaminationVoList[index]['enactTopicNum'].toString() + '题',
                                          style: TextStyle(
                                            color: Color(0xff0059FF),
                                            fontSize: size.width * 22,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Color(0xffA6A6A6),
                                          size: size.width * 40,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Color(0xffE0E0E0),
                                    height: size.width * 1,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(vertical: size.width * 10),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now().toLocal(),
                                        firstDate: DateTime(DateTime.now().toLocal().year - 30),
                                        lastDate: DateTime(
                                          DateTime.now().toLocal().year + 30)
                                        ).then((value) {
                                          if(value != null){
                                            educationTrainingPlanExaminationVoList[index]['endTime'] = value.toString().substring(0, 10);
                                          }
                                          setState(() {});
                                          print(value.toString().substring(0, 10));
                                        }
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          '考核截至时间',
                                          style: TextStyle(
                                            color: Color(0xff262626),
                                            fontSize: size.width * 24
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          educationTrainingPlanExaminationVoList[index]['endTime'] == '' ? '请选择' : educationTrainingPlanExaminationVoList[index]['endTime'],
                                          style: TextStyle(
                                            color: educationTrainingPlanExaminationVoList[index]['endTime'] == '' ? Color(0xffA6A6A6) : Color(0xff262626),
                                            fontSize: educationTrainingPlanExaminationVoList[index]['endTime'] == '' ? size.width * 22 : size.width * 24
                                          ),
                                        ),
                                        educationTrainingPlanExaminationVoList[index]['endTime'] == '' ? Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Color(0xffA6A6A6),
                                          size: size.width * 40,
                                        ) : Container()
                                      ],
                                    )
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
                                        '考核时长',
                                        style: TextStyle(
                                          color: Color(0xff262626),
                                          fontSize: size.width * 24
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: size.width * 120,
                                        height: size.width * 50,
                                        alignment: Alignment.bottomRight,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(3),
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: '请输入考核时长',
                                                  hintStyle: TextStyle(
                                                    color: Color(0xffA6A6A6),
                                                    fontSize: size.width * 22
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                onChanged: (String str){
                                                  if(str == ''){
                                                    educationTrainingPlanExaminationVoList[index]['duration'] = 0;
                                                  }else{
                                                    educationTrainingPlanExaminationVoList[index]['duration'] = int.parse(str);
                                                  }
                                                  setState(() {});
                                                },
                                                autofocus: false,
                                                style: TextStyle(
                                                  color: Color(0xff262626),
                                                  fontSize: size.width * 24
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '分钟',
                                              style: TextStyle(
                                                color: Color(0xff262626),
                                                fontSize: size.width * 24
                                              ),
                                            )
                                          ],
                                        ),
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
                                        '合格分数线',
                                        style: TextStyle(
                                          color: Color(0xff262626),
                                          fontSize: size.width * 24
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: size.width * 100,
                                        height: size.width * 50,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: '请输入合格分数线',
                                            hintStyle: TextStyle(
                                              color: Color(0xffA6A6A6),
                                              fontSize: size.width * 22
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (String str){
                                            if(str == ''){
                                              educationTrainingPlanExaminationVoList[index]['passLine'] = 0;
                                            }else{
                                              educationTrainingPlanExaminationVoList[index]['passLine'] = int.parse(str);
                                            } 
                                            setState(() {});
                                          },
                                          autofocus: false,
                                          style: TextStyle(
                                            color: Color(0xff262626),
                                            fontSize: size.width * 24
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                )
              ),
              GestureDetector(
                onTap: (){
                  for (int i = 0; i < educationTrainingPlanExaminationVoList.length; i++) {
                    if(educationTrainingPlanExaminationVoList[i]['enactTopicNum'] == null || educationTrainingPlanExaminationVoList[i]['enactTopicNum'] == 0){
                      Fluttertoast.showToast(msg: '请制定' + (i + 1).toString() + '阶段考题');
                      return;
                    }else if(educationTrainingPlanExaminationVoList[i]['endTime'] == ''){
                      Fluttertoast.showToast(msg: '请制定' + (i + 1).toString() + '阶段截止时间');
                      return;
                    }else if(educationTrainingPlanExaminationVoList[i]['duration'] == 0){
                      Fluttertoast.showToast(msg: '请制定' + (i + 1).toString() + '阶段考核时长');
                      return;
                    }else if(educationTrainingPlanExaminationVoList[i]['passLine'] == 0){
                      Fluttertoast.showToast(msg: '请制定' + (i + 1).toString() + '阶段合格分数线');
                      return;
                    }else{
                      educationTrainingPlanExaminationVoList[i]['stage'] = i + 1;
                      for (int i = 0; i < educationTrainingPlanExaminationVoList.length; i++) {
                        if(educationTrainingPlanExaminationVoList[i]['stage'] == 0){
                          return;
                        }else{
                          Navigator.pop(context, educationTrainingPlanExaminationVoList);
                        }
                      }
                    }
                  }
                  
                },
                child: Container(
                  height: size.width * 60,
                  width: size.width * 240,
                  margin: EdgeInsets.only(bottom: size.width * 20),
                  decoration: BoxDecoration(
                    color: Color(0xff0059FF),
                    borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '确定制定',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 32,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  //减少按钮
  Widget _reduceBtn(){
    return InkWell(
      onTap: (){
        if(educationTrainingPlanExaminationVoList.length > 1){
          // count--;//数量只有大于1才能减减
          educationTrainingPlanExaminationVoList.removeLast();
          setState(() {});
        }
      },
      child: Container(
          width: size.width * 45,//是正方形的所以宽和高都是45
          height: size.width * 45,
          alignment: Alignment.center,//上下左右都居中
          decoration: BoxDecoration(
            color: educationTrainingPlanExaminationVoList.length > 1 ? Colors.white : Colors.black12,//按钮颜色大于1是白色，小于1是灰色
            border: Border(//外层已经有边框了所以这里只设置右边的边框
              right:BorderSide(width: 1.0,color: Colors.black12)
            )
          ),
          child:educationTrainingPlanExaminationVoList.length > 1 ? Text('-') : Text(' '),//数量小于1 什么都不显示
      ),
    );
  }
  //加号
  Widget _addBtn(){
    return InkWell(
      onTap: (){
        educationTrainingPlanExaminationVoList.add(
          {
            "compulsoryQuestionsId": "",
            "duration": 0,
            "endTime": "",
            "fillBlankNum": 0,
            "judgmentNum": 0,
            "multipleChoiceNum": 0,
            "passLine": 0,
            "questionsAnswersNum": 0,
            "singleChoiceNum": 0,
            "stage": 0
          }
        );
        setState(() {});
      },
      child: Container(
          width: size.width * 45,//是正方形的所以宽和高都是45
          height: size.width * 45,
          alignment: Alignment.center,//上下左右都居中
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(//外层已经有边框了所以这里只设置右边的边框
              left:BorderSide(width: 1.0,color: Colors.black12)
            )
          ),
          child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(){
    return Container(
       width: size.width * 70,//爬两个数字的这里显示不下就宽一点70
       height: size.width * 45,//高度和加减号保持一样的高度
       alignment: Alignment.center,//上下左右居中
       color: Colors.white,//北京颜色 设置为白色
       child: Text(educationTrainingPlanExaminationVoList.length.toString()),//先默认设置为1 因为后续是动态的获取数字
    );
  }
}