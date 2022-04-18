import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/risk/_riskHomeItem.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class RiskHome extends StatefulWidget {
  @override
  _RiskHomeState createState() => _RiskHomeState();
}

class _RiskHomeState extends State<RiskHome> {
  List dropList = [];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('风险分析对象'),
      child: MyRefres(
        child: (index, list) => GestureDetector(
          child: RiskHomeItem(
            riskData: list,
            index: index,
          ),
          onTap: () {
            Navigator.pushNamed(context, "/home/risk/riskControl",
              arguments: {'dropList': list, 'index': index});
            },
          ),
          page: true,
          url: Interface.getRiskUnitList,
          listParam: "records",
          method: 'get'),
    );
  }
}
