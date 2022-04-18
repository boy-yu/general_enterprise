import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueTeamList.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireOverviewList extends StatefulWidget {
  @override
  _FireOverviewListState createState() => _FireOverviewListState();
}

class _FireOverviewListState extends State<FireOverviewList> {
  List data = [
    {
      "title": '个体防护',
      // 'num': 10,
      // 'descript': '包含10类个人防护装备',
      'icon': 'assets/images/fire/kuangs@2x.png'
    },
    {
      "title": '消防器材',
      // 'num': 10,
      // 'descript': '包含10类消防设施',
      'icon': 'assets/images/fire/weihuap@2x.png'
    },
    {
      "title": '防雷防静电',
      // 'num': 10,
      // 'descript': '包含10类防雷防静电设施',
      'icon': 'assets/images/fire/qita@2x.png'
    },
  ];
  List _list = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    myDio.request(type: 'get', url: Interface.getFireFightRisk).then((value) {
      if (value is List) {
        _list = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('设备设施清单'),
      backgroundColor: Colors.white,
      child: Column(
        children: data
            .map((e) => ShaIcon(
                onTap: () {
                  List<HiddenDangerInterface> _iconList = [];
                  _iconList = _iconList.changeHiddenDangerInterfaceType(
                    _list,
                    title: 'riskPoint',
                    id: "id",
                    icon: null,
                    iconWidget: null,
                  );
                  if (_iconList.isNotEmpty) {
                    _iconList[0].color = Colors.white;
                    Navigator.pushNamed(context, '/fireControl/fireOLLIst',
                        arguments: {
                          "iconList": _iconList,
                          "title": e['title']
                        });
                  } else {
                    Fluttertoast.showToast(msg: '未有数据');
                  }
                },
                descrpit: e['descript'],
                name: e['title'],
                nums: e['num'],
                icon: e['icon']))
            .toList(),
      ),
    );
  }
}
