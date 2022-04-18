import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class EmergencyRescueHome extends StatefulWidget {
  @override
  _EmergencyRescueHomeState createState() => _EmergencyRescueHomeState();
}

class _EmergencyRescueHomeState extends State<EmergencyRescueHome> {
  List emergencyRescueList = [
    {
      "name": "应急救援一张图",
      "icon": 'assets/images/icon_emergency_rescue_home_picture.png'
    },

    {
      "name": "企业预案",
      "icon": 'assets/images/icon_emergency_rescue_home_firm.png'
    },

    {
      "name": "应急处置卡",
      "icon": 'assets/images/icon_emergency_rescue_home_card.png'
    },

    {
      "name": "应急指挥",
      "icon": 'assets/images/icon_emergency_rescue_home_conduct.png'
    },

    {
      "name": "应急值守",
      "icon": 'assets/images/icon_emergency_rescue_home_system.png'
    },

    // {"name": "应急值守记录", "icon": 'assets/images/icon_emergency_rescue_home_record.png'},

    {
      "name": "应急疏散图",
      "icon": 'assets/images/icon_emergency_rescue_home_evacuate.png'
    },

    {
      "name": "应急救援物资",
      "icon": 'assets/images/icon_emergency_rescue_home_materials.png'
    },

    // {"name": "应急演练", "icon": 'assets/images/icon_emergency_rescue_home_drill.png'},

    {
      "name": "事故管理",
      "icon": 'assets/images/icon_emergency_rescue_home_admin.png'
    },

    {
      "name": "应急响应",
      "icon": 'assets/images/icon_emergency_rescue_home_response.png'
    },
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MyAppbar(
      title: Text(
        '应急救援',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 37,
            color: Colors.white),
      ),
      child: Container(
        color: Colors.white,
        height: height,
        child: ListView.builder(
          itemCount: emergencyRescueList.length,
          shrinkWrap: true,
          itemBuilder: (builder, index) {
            return Padding(
              padding: EdgeInsets.only(
                  right: size.width * 31,
                  left: size.width * 33,
                  top: size.width * 35.0),
              // InkWell 添加 Material触摸水波效果
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/emergencyRescue/_emergencyRescueLeftList',
                        arguments: {
                          'index': index,
                        });
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            emergencyRescueList[index]['icon'],
                            height: size.width * 42,
                            width: size.width * 42,
                          ),
                          SizedBox(
                            width: size.width * 34,
                          ),
                          Text(
                            emergencyRescueList[index]['name'],
                            style: TextStyle(
                                color: Color(0xff3C3C3C),
                                fontSize: size.width * 26),
                          ),
                          Spacer(),
                          Container(
                            height: size.width * 31,
                            width: size.width * 90,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: Color(0xff2E6CFD),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '查看',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 20),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.width * 35,
                      ),
                      index != emergencyRescueList.length - 1
                          ? Container(
                              color: Color(0xffEFEFEF),
                              height: size.width * 1,
                              width: double.infinity,
                            )
                          : Container(),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
