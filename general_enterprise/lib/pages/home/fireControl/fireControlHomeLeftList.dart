import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencySystem.dart';
import 'package:enterprise/pages/home/fireControl/_fireMap.dart';
import 'package:enterprise/pages/home/fireControl/_fireOverview.dart';
import 'package:enterprise/pages/home/productList/_riskList.dart';
import 'package:enterprise/pages/home/productList/productList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class FireControlHomeLeftList extends StatefulWidget {
  @override
  _FireControlHomeLeftListState createState() =>
      _FireControlHomeLeftListState();
}

class _FireControlHomeLeftListState extends State<FireControlHomeLeftList> {
  List leftBar = [
    {
      "name": "消防总览",
      'title': '消防总览',
      'icon': "assets/images/fire/overrall@2x.png",
      'unIcon': 'assets/images/fire/overrall2@2x.png',
      "widget": FireMap()
    },
    {
      "name": "巡检台账",
      'title': '巡检台账',
      'icon': "assets/images/fire/bill@2x.png",
      'unIcon': 'assets/images/fire/bill2@2x.png',
      "widget": CheckRiskList()
    },
    {
      "name": "消防值守",
      'title': '消防值守',
      'icon': "assets/images/fire/duty@2x.png",
      'unIcon': 'assets/images/fire/duty2@2x.png',
      "widget": EmergencySystem()
    },
    {
      "name": "基础信息",
      'title': '基础信息',
      'icon': "assets/images/fire/base@2x.png",
      'unIcon': 'assets/images/fire/base2@2x.png',
      "widget": FireOverview()
    },
  ];
  int choosed = 0;
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(leftBar[choosed]['title']),
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(left: size.width * 110),
            height: MediaQuery.of(context).size.height,
            color: Color(0xffF6F9FF),
            child: leftBar[choosed]['widget'],
          ),
          ProductListHomeLeftBar(
              leftBar: leftBar,
              callback: (int index) {
                choosed = index;
                if (mounted) {
                  setState(() {});
                }
              },
              choosed: choosed)
        ]));
  }
}
