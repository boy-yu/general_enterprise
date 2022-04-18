import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interActiveType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EduMyAddNeedQuestionnaire extends StatefulWidget {
  @override
  _EduMyAddNeedQuestionnaireState createState() => _EduMyAddNeedQuestionnaireState();
}

class _EduMyAddNeedQuestionnaireState extends State<EduMyAddNeedQuestionnaire> {
  List<InterActiveType> data = [
    InterActiveType(lable: "需求问卷名称"),
    InterActiveType(lable: "需求问卷主题"),
    InterActiveType(lable: "相关教材", type: InputType.chooseTextBook),
    InterActiveType(lable: "调研部门", type: InputType.chooseDep),
    InterActiveType(lable: "问卷执行人", type: InputType.choosePeople),
    InterActiveType(lable: "调研截止日期", type: InputType.time),
    InterActiveType(lable: "调研问卷有效期", type: InputType.time),
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text("新增需求问卷"),
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
                          margin: EdgeInsets.symmetric(horizontal: 10)))
                      .toList(),
                ),
              )),
              GestureDetector(
                onTap: () { 
                  if(data[0].value == null || data[0].value.toString() == ''){
                    Fluttertoast.showToast(msg: '请填写问卷名称');
                  }else if(data[1].value == null || data[1].value.toString() == ''){
                    Fluttertoast.showToast(msg: '请填写问卷主题');
                  }else if(data[2].value == null || data[2].value == []){
                    Fluttertoast.showToast(msg: '请选择相关教材');
                  }else if(data[3].value == null || data[3].value == []){
                    Fluttertoast.showToast(msg: '请选择调研部门');
                  }else if(data[4].value == null || data[4].value == []){
                    Fluttertoast.showToast(msg: '请选择问卷执行人');
                  }else if(data[5].value == null){
                    Fluttertoast.showToast(msg: '请选择截止日期');
                  }else if(data[6].value == null){
                    Fluttertoast.showToast(msg: '请选择有效期');
                  }else{
                    DateTime dateTime= DateTime.now();
                    int currentTime = dateTime.millisecondsSinceEpoch;
                    int endTime = DateTime.parse(data[5].value.toString()).millisecondsSinceEpoch;
                    int validTime = DateTime.parse(data[6].value.toString()).millisecondsSinceEpoch;
                    /**
                     * 截止日期必须大于当前日期
                     * 有效期必须大于截止日期
                     */
                    if(endTime < currentTime){
                      Fluttertoast.showToast(msg: '截止日期必须大于当前日期');
                    }else if(validTime < endTime){
                      Fluttertoast.showToast(msg: '有效期必须大于截止日期');
                    }else{
                      Map issueData = {
                        "departmentIds": data[3].value,  // 部门集合 int id
                        "educationTrainingResearch": {
                          "companyId": 0,
                          "createDate": "",
                          "endTime": data[5].value.toString().substring(0, 10),  // 调研截止时间
                          "id": 0,
                          "isParticipateAll": 0,  // 是否全厂参与 0:false, 1:true
                          "modifyDate": "",
                          "name": data[0].value.toString(),// 需求问卷名称
                          "sponsorName": "string",
                          "sponsorUserId": 0,
                          "theme": data[1].value.toString(),  // 需求问卷主题
                          "validTime": data[6].value.toString().substring(0, 10), // 调研问卷有效期
                        },
                        "principalIds": data[4].value, // 负责人集合 int id
                        "resourcesIds": data[2].value  // 教材集合 int id
                      };
                      myDio.request(
                        type: 'post',
                        url: Interface.postAddEducationTrainingResearch,
                        data: issueData
                      ).then((value) {
                        Fluttertoast.showToast(msg: '新增需求问卷成功');
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
                    '发布',
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