import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class FireOverview extends StatefulWidget {
  @override
  _FireOverviewState createState() => _FireOverviewState();
}

class _FireOverviewState extends State<FireOverview> {
  List data = [
    {
      'title': '设备设施清单',
      'bgImage': 'assets/images/fire/fireList@2x.png',
      'icon': 'assets/images/fire/fireListIcon@2x.png'
    },
    {
      'title': '建筑物基础信息',
      'bgImage': 'assets/images/fire/fireBase@2x.png',
      'icon': 'assets/images/fire/fireBaseIcon@2x.png'
    },
    {
      'title': '消防档案',
      'bgImage': 'assets/images/fire/fileFIles@2x.png',
      'icon': 'assets/images/fire/fireFileIcon@2x.png'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: data
          .map((e) => InkWell(
                onTap: () {
                  if (e['title'] == '消防档案') {
                    Navigator.pushNamed(context, '/fireControl/FireBaseFile');
                  } else if (e['title'] == '建筑物基础信息') {
                    Navigator.pushNamed(context, '/fireControl/buildBaseInfo');
                  } else {
                    Navigator.pushNamed(
                        context, '/fireControl/fireOverviewList');
                  }
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      size.width * 30, size.width * 30, size.width * 30, 0),
                  height: size.width * 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(e['bgImage']),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: size.width * 35, bottom: size.width * 30),
                        child: Text(
                          e['title'],
                          style: TextStyle(
                              color: Colors.white, fontSize: size.width * 32),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: size.width * 40),
                        child: Image.asset(e['icon'],
                            width: size.width * 50, height: size.width * 51),
                      )
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
