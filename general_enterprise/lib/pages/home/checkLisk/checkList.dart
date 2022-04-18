import 'dart:convert';

import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class CheckList extends StatefulWidget {
  CheckList({this.way, this.qrMessage});
  final int way;
  final String qrMessage;
  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  List<HiddenDangerInterface> leftBar = [];
  List data = [
    {
      "index": 0,
      "title": "我的当日工作清单",
      "descript": "选择需要使用的",
      "img": "assets/images/todayback@2x.png",
      "isClick": false,
    },
    {
      "index": 1,
      "title": "我的岗位责任清单",
      "descript": "选择需要使用的",
      "img": "assets/images/workback@2x.png",
      "isClick": true,
    },
  ];

  List<Map> nextLeftBar = [
    {
      "title": '安全作业',
      "name": '作业',
      "contexts": ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
      "image": 'assets/images/bg_site_management.png',
      "icon": 'assets/images/myCheckListWork.png',
      "color": Colors.white
    },
    {
      "title": '隐患排查',
      "name": '隐患',
      "contexts": ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
      "image": 'assets/images/bg_site_management.png',
      "icon": 'assets/images/myCheckListHidden@2x.png',
      "color": Color(0xffEAEDF2)
    },
    {
      'title': '巡检点检',
      "name": '巡检',
      'contexts': ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
      'image': 'assets/images/bg_basic_management.png',
      'icon': 'assets/images/icon_hidden_base.png',
      'color': Color(0xffEAEDF2)
    },
    {
      'title': '安全教育培训',
      "name": '教育',
      'contexts': ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
      'image': 'assets/images/bg_basic_management.png',
      'icon': 'assets/images/myCheckListSafe@2x.png',
      'color': Color(0xffEAEDF2)
    },
    {
      'title': '岗位职责',
      "name": '岗责',
      'contexts': ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
      'image': 'assets/images/bg_basic_management.png',
      'icon': 'assets/images/myCheckListEmergency@2x.png',
      'color': Color(0xffEAEDF2)
    },
    {
      'title': '离线提交数据',
      "name": '离线',
      'contexts': ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
      'image': 'assets/images/bg_basic_management.png',
      'icon': 'assets/images/lx@2x.png',
      'color': Color(0xffEAEDF2)
    },
    // {
    //   'title': '企业合规性',
    //   "name": '合规',
    //   'contexts': ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
    //   'image': 'assets/images/bg_basic_management.png',
    //   'icon': 'assets/images/myCheckListCompliance@2x.png',
    //   'color': Color(0xffEAEDF2)
    // },
    // {
    //   'title': '消防管理',
    //   "name": '消防',
    //   'contexts': ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
    //   'image': 'assets/images/bg_basic_management.png',
    //   'icon': 'assets/images/myCheckListFire@2x.png',
    //   'color': Color(0xffEAEDF2)
    // },
    // {
    //   'title': '应急救援',
    //   "name": '应急',
    //   'contexts': ['作业场所', '设施设备', '防护、保险、信号等装置装备'],
    //   'image': 'assets/images/bg_basic_management.png',
    //   'icon': 'assets/images/myCheckListEmergency@2x.png',
    //   'color': Color(0xffEAEDF2)
    // },
  ];

  int choosed = 1;

  @override
  void initState() {
    super.initState();
    _init();

    if (widget.way is int) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _click(index: widget.way);
      });
    }
    if (widget.qrMessage != null) {
      // qrcode
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        List<int> bytes = base64Decode(widget.qrMessage);
        String qrMessage = utf8.decode(bytes);
        Map _map = jsonDecode(qrMessage);
        _click(index: 0, qrMsg: _map, nextIndex: 2);
      });
    }
  }

  List<String> menuList;

  _init() {
    leftBar = [];
    menuList = myprefs.getStringList('appFunctionMenu');
    nextLeftBar.forEach((element) {
      if(element['title'] == '安全作业' && menuList.contains('安全作业')){
        leftBar.add(HiddenDangerInterface(
          title: element['title'],
          contexts: element['contexts'],
          image: element['image'],
          icon: element['icon'],
          color: element['color'],
          name: element['name'],
        ));
      }else if(element['title'] == '安全教育培训' && menuList.contains('教育培训')){
        leftBar.add(HiddenDangerInterface(
            title: element['title'],
            contexts: element['contexts'],
            image: element['image'],
            icon: element['icon'],
            color: element['color'],
            name: element['name'],
          ));
      }else if(element['title'] == '岗位职责'){
        leftBar.add(HiddenDangerInterface(
            title: element['title'],
            contexts: element['contexts'],
            image: element['image'],
            icon: element['icon'],
            color: element['color'],
            name: element['name'],
          ));
      }else if(menuList.contains('风险管控')){
        if(element['title'] == '隐患排查' || element['title'] == '巡检点检' || element['title'] == '离线提交数据'){
          leftBar.add(HiddenDangerInterface(
            title: element['title'],
            contexts: element['contexts'],
            image: element['image'],
            icon: element['icon'],
            color: element['color'],
            name: element['name'],
          ));
        }
      }
    });
  }

  _click({int index = 0, Map qrMsg, int nextIndex = 0}) {
    if (index == 0) {
      leftBar.forEach((element) {
        element.color = Color(0xffEAEDF2);
      });
      leftBar[nextIndex].color = Colors.white;
      Navigator.pushNamed(context, '/index/checkList/today', arguments: {
        "leftBar": leftBar,
        "title": leftBar[nextIndex].title,
        "qrMessage": qrMsg,
        "choosed": nextIndex
      });
    } else if (index == 1) {
      Navigator.pushNamed(context, '/index/checkList/postWork');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/index/checkList/unplanned');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('我的清单'),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              _click(index: index);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.width * 30, horizontal: size.width * 40),
              margin: EdgeInsets.only(
                  left: size.width * 30,
                  right: size.width * 30,
                  top: size.width * 40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, //阴影颜色
                        offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                        blurRadius: 5.0, //阴影大小
                        spreadRadius: 0.0 //阴影扩散程度
                        ),
                  ]),
              height: size.width * 280,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        data[index]['title'],
                        style: TextStyle(
                            color: Color(0xff393B3D),
                            fontSize: size.width * 34,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Image.asset(
                        data[index]['img'],
                        height: size.width * 209,
                        width: size.width * 300,
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}
