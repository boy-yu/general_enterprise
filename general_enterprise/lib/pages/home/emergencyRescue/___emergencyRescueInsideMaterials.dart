import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueInsideMaterials extends StatefulWidget {
  @override
  _EmergencyRescueInsideMaterialsState createState() =>
      _EmergencyRescueInsideMaterialsState();
}

class _EmergencyRescueInsideMaterialsState
    extends State<EmergencyRescueInsideMaterials> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getInsideMaterials();
  }

  _getInsideMaterials() {
    myDio.request(
        type: 'get',
        url: Interface.getErEquipmentMaterialList,
        queryParameters: {"current": 1, 'size': 1000}).then((value) {
      if (value is Map) {
        data = value['records'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('救援物资'),
      child: data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/emergencyRescue/____emergencyRescueInsideMaterialsTow',
                        arguments: {
                          'title': data[index]['sourcesEquipment'],
                          'id': data[index]['id']
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: size.width * 15, horizontal: size.width * 20),
                    padding: EdgeInsets.all(size.width * 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                              blurRadius: 2.0, //阴影模糊程度
                              spreadRadius: 1.0 //阴影扩散程度
                              )
                        ]),
                    child: Row(
                      children: [
                        Text(
                          data[index]['sourcesEquipment'],
                          style: TextStyle(
                              color: Color(0xff7487A4),
                              fontSize: size.width * 26,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/icon_file_list.png',
                          width: size.width * 30,
                          height: size.width * 30,
                        )
                      ],
                    ),
                  ),
                );
              })
          : Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: size.width * 300),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                  ),
                  Image.asset(
                    "assets/images/empty@2x.png",
                    height: size.width * 288,
                    width: size.width * 374,
                  ),
                  Text(
                    '暂无数据',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
    );
  }
}
