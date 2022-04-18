import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/education/_eduMy.dart';
import 'package:flutter/material.dart';

class StudyPlanList extends StatefulWidget {
  @override
  _StudyPlanListState createState() => _StudyPlanListState();
}

class _StudyPlanListState extends State<StudyPlanList> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text("在线学习计划"),
        child: Transtion(
            Column(
              children: [EduMyStylePlan()],
            ),
            show));
  }
}
