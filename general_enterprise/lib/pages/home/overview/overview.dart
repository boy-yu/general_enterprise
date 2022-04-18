import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  List<String> menuList;

  @override
  void initState() {
    super.initState();
    menuList = myprefs.getStringList('appFunctionMenu');
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('总览'),
      child: ListView(
        children: [
          ChartTitle(title: '安全生产清单'),
          menuList.contains('企业清单') ? SafetyProductListUi() : Container(
            width: double.infinity,
            height: size.width * 300,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text('暂未购买该模块'),
          ),
          ChartTitle(title: '安全作业'),
          menuList.contains('安全作业') ? IndexWorkUi() : Container(
            width: double.infinity,
            height: size.width * 300,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text('暂未购买该模块'),
          ),
          ChartTitle(title: '风险管控'),
          menuList.contains('风险管控') ? IndexRiskUi() : Container(
            width: double.infinity,
            height: size.width * 300,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text('暂未购买该模块'),
          ),
        ],
      ),
    );
  }
}