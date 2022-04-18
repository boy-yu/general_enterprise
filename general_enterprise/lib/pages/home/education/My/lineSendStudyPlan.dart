import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/tool/interActiveType.dart';
import 'package:flutter/material.dart';

class LineSendStudyPlan extends StatefulWidget {
  @override
  _LineSendStudyPlanState createState() => _LineSendStudyPlanState();
}

class _LineSendStudyPlanState extends State<LineSendStudyPlan> {
  List<InterActiveType> data = [
    InterActiveType(lable: "计划名称"),
    InterActiveType(lable: "学习计划主要内容"),
    InterActiveType(lable: "培训类型", type: InputType.choose),
    InterActiveType(lable: "培训对象", type: InputType.choosePeople),
    InterActiveType(lable: "培训地点", type: InputType.choose),
    InterActiveType(lable: "培训开始时间", type: InputType.choose),
    InterActiveType(lable: "培训结束时间", type: InputType.choose),
    InterActiveType(lable: "请选择考核次数", type: InputType.addtion),
  ];
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text("发起现场学习计划"),
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
              ElevatedButton(onPressed: () {}, child: Text("确定"))
            ],
          ),
        ));
  }
}
