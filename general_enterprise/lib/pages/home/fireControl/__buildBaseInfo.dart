import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueTeamList.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BuildBaseInfo extends StatefulWidget {
  @override
  _BuildBaseInfoState createState() => _BuildBaseInfoState();
}

class _BuildBaseInfoState extends State<BuildBaseInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('建筑物基础信息'),
        child: MyRefres(
            padding: EdgeInsets.all(10),
            child: (index, list) => ShaIcon(
                  onTap: () {
                    List<HiddenDangerInterface> _iconList = [];
                    _iconList = _iconList.changeHiddenDangerInterfaceType(
                      list,
                      title: 'riskPoint',
                      id: "id",
                      icon: null,
                      iconWidget: null,
                    );
                    if (_iconList.isNotEmpty) {
                      _iconList[0].color = Colors.white;
                      Navigator.pushNamed(
                          context, '/fireControl/buildBaseInfoDetail',
                          arguments: {
                            "iconList": _iconList,
                            "title": list[index]['riskPoint']
                          });
                    } else {
                      Fluttertoast.showToast(msg: '未有数据');
                    }
                  },
                  name: list[index]['riskPoint'].toString(),
                  nums: 0,
                  icons: Icon(Icons.keyboard_arrow_right),
                ),
            url: Interface.getRiskListBuildBaseInfo,
            method: 'get'));
  }
}
