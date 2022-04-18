import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmergencyRescuePicture extends StatefulWidget {
  @override
  _EmergencyRescuePictureState createState() => _EmergencyRescuePictureState();
}

class _EmergencyRescuePictureState extends State<EmergencyRescuePicture> {
  MethodChannel _channel = MethodChannel('nativeView');
  List data = [
    {
      'name': '应急救援一张图',
      'bgimg': 'assets/images/bg_one_picture.png',
      'icon': 'assets/images/icon_one_picture.png',
      'router': '/emergencyRescue/__emergencyRescuePic',
    },
    {
      'name': '应急疏散',
      'bgimg': 'assets/images/bg_evacuate.png',
      'icon': 'assets/images/icon_evacuate.png',
      'router': '/emergencyRescue/__emergencyRescueEvacuate',
    },
    {
      'name': '个人和社会可接受风险图',
      'bgimg': 'assets/images/bg_risk_pic.png',
      'icon': 'assets/images/icon_risk_pic.png',
      'router': '/emergencyRescue/__emergencyRescueRiskPic',
    },
    // {
    //   'name': '3D',
    //   'bgimg': 'assets/images/bg_3D.png',
    //   'icon': 'assets/images/icon_3D.png',
    //   'router': '',
    // },
    // {
    //   'name': '新应急救援一张图',
    //   'bgimg': 'assets/images/bg_one_picture.png',
    //   'icon': 'assets/images/icon_one_picture.png',
    //   'router': '/mapTest',
    // },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (data[index]['router'] == '') {
                if (data[index]['name'] == '3D') {
                  // three-model-map/52e1bd65-24c6-11eb-a25b-0242ac120002
                  _channel.invokeMethod('webView', {
                    "url":
                        'http://3d.models.sctshz.com/#/three-model-map/52e1bd65-24c6-11eb-a25b-0242ac120002',
                    "title": "3d地图"
                  });
                } else {
                  Fluttertoast.showToast(msg: '....');
                }
              } else {
                Navigator.pushNamed(
                  context,
                  data[index]['router'],
                );
              }
            },
            child: Container(
              height: size.width * 130,
              width: size.width * 570,
              margin: EdgeInsets.symmetric(
                  vertical: size.width * 20, horizontal: size.width * 25),
              padding: EdgeInsets.symmetric(horizontal: size.width * 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                image: DecorationImage(
                    image: AssetImage(data[index]['bgimg']), fit: BoxFit.cover),
              ),
              child: Row(
                children: [
                  Text(
                    data[index]['name'],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 32),
                  ),
                  Spacer(),
                  Image.asset(
                    data[index]['icon'],
                    width: size.width * 65,
                    height: size.width * 65,
                  )
                ],
              ),
            ),
          );
        });
  }
}
