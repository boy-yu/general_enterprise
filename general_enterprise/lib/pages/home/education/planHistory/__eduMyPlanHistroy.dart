import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/education/_eduMy.dart';
import 'package:flutter/material.dart';

class EduMyPlanHistoryList extends StatefulWidget {
  @override
  _EduMyPlanHistoryListState createState() => _EduMyPlanHistoryListState();
}

class _EduMyPlanHistoryListState extends State<EduMyPlanHistoryList> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        child: Column(
      children: [EduPlayItem()],
    ));
  }
}
