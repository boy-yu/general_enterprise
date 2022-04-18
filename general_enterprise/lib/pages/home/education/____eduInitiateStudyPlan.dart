import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interActiveType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EduInitiateStudyPlan extends StatefulWidget {
  final int researchId;
  final List educationTrainingResources;
  EduInitiateStudyPlan({this.researchId, this.educationTrainingResources});
  @override
  _EduInitiateStudyPlanState createState() => _EduInitiateStudyPlanState();
}

class _EduInitiateStudyPlanState extends State<EduInitiateStudyPlan> {

  List<InterActiveType> data = [
    InterActiveType(lable: "学习计划名称"),
    InterActiveType(lable: "学习计划主要内容"),
    InterActiveType(lable: "参训部门", type: InputType.chooseDep),
    InterActiveType(lable: "必修教材", type: InputType.chooseTextBook),
    InterActiveType(lable: "制定考试", type: InputType.chooseExam),
    InterActiveType(lable: "计划截止时间", type: InputType.time),
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('发起学习计划'),
      child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: data
                      .map((e) => e.widgets(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          educationTrainingResources: widget.educationTrainingResources,
                      )
                    ).toList(),
                ),
              )),
              GestureDetector(
                onTap: () { 
                  if(data[0].value == null || data[0].value.toString() == ''){
                    Fluttertoast.showToast(msg: '请填写学习计划名称');
                  }else if(data[1].value == null || data[1].value.toString() == ''){
                    Fluttertoast.showToast(msg: '请填写学习计划主要内容');
                  }else if(data[2].value == null || data[2].value == []){
                    Fluttertoast.showToast(msg: '请选择参训部门');
                  }else if(data[3].value == null || data[3].value == []){
                    Fluttertoast.showToast(msg: '请选择必修教材');
                  }else if(data[4].value == null || data[4].value == []){
                    Fluttertoast.showToast(msg: '请制定考试');
                  }else if(data[5].value == null){
                    Fluttertoast.showToast(msg: '请选择计划截止时间');
                  }else{
                    DateTime dateTime= DateTime.now();
                    int currentTime = dateTime.millisecondsSinceEpoch;
                    int endTime = DateTime.parse(data[5].value.toString()).millisecondsSinceEpoch;
                    /**
                     * 截止日期必须大于当前日期
                     * 有效期必须大于截止日期
                     */
                    if(endTime < currentTime){
                      Fluttertoast.showToast(msg: '计划截止日期必须大于当前日期');
                    }else{
                      Map issueData = {
                        "departmentIds": data[2].value,    // 部门集合
                        "educationTrainingPlanExaminationVoList": data[4].value,   // 考核集合
                        "isParticipateAll": 0,
                        "name": data[0].value.toString(),   //  培训名称
                        "numberExams": data[4].value.length,    //考试阶段次数
                        "researchId": widget.researchId,
                        "resourcesIds": data[3].value,  // 教材集合
                        "studyDeadline": data[5].value.toString().substring(0, 10),
                        "theme": data[1].value,   // 培训主题
                      };
                      myDio.request(
                        type: 'post',
                        url: Interface.postAddEducationTrainingPlan,
                        data: issueData
                      ).then((value) {
                        Fluttertoast.showToast(msg: '发布学习计划成功');
                        Navigator.pop(myContext);
                      });
                    }
                  }
                }, 
                child: Container(
                  height: size.width * 60,
                  width: size.width * 240,
                  margin: EdgeInsets.only(bottom: size.width * 50),
                  decoration: BoxDecoration(
                    color: Color(0xff0059FF),
                    borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '发布学习计划',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 32,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              )
            ],
          ),
        )
    );
  }
}