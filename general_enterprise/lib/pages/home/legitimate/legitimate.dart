import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class Legitimate extends StatefulWidget {
  @override
  _Legitimate createState() => _Legitimate();
}

class _Legitimate extends State<Legitimate> {
  List legitimateList = [
      {"name": "企业基本信息", "router": "/legitimate/_legitimateLeftList", "icon": 'assets/images/icon_legitimate_home_basic.png'},
      {"name": "安全管理机构", "router": "/legitimate/_legitimateLeftList", "icon": 'assets/images/icon_legitimate_home_management.png'},
      {"name": "企业证照", "router": "/legitimate/_legitimateLeftList", "icon": 'assets/images/icon_legitimate_home_firm_license.png'},
      {"name": "人员证照", "router": "/legitimate/_legitimateLeftList", "icon": 'assets/images/icon_legitimate_home_crew_license.png'},
      {"name": "设备证照", "router": "/legitimate/_legitimateLeftList", "icon": 'assets/images/icon_legitimate_home_equipment_license.png'},
      {"name": "项目合规", "router": "/legitimate/_legitimateLeftList", "icon": 'assets/images/icon_legitimate_home_project_compliance.png'},
      {"name": "管理制度和操作规程", "router": "/legitimate/_legitimateLeftList", "icon": 'assets/images/icon_legitimate_home_system.png'},
      {"name": "生产设施及工艺安全", "router": "/legitimate/_legitimateLeftList", "icon": 'assets/images/icon_legitimate_home_craft.png'},
      {"name": "法律法规", "router": "/legitimate/_legitimateLeftList", "icon": 'assets/images/icon_legitimate_home_legislation.png'},
    ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MyAppbar(
      title: Text(
        '企业合规性',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size.width * 37,
          color: Colors.white
        ),
      ),
      child: Container(
        color: Colors.white,
        height: height,
        child: ListView.builder(
          itemCount: legitimateList.length,
          shrinkWrap: true,
          itemBuilder: (builder, index) {
            return Padding(
              padding: EdgeInsets.only(right: size.width * 31, left: size.width * 33, top: size.width * 35.0),
              // InkWell 添加 Material触摸水波效果
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    legitimateList[index]['router'],
                    arguments: {
                      'index': index,
                    }
                  );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          legitimateList[index]['icon'],
                          height: size.width * 42,
                          width: size.width * 42,
                        ),
                        SizedBox(
                          width: size.width * 34,
                        ),
                        Text(
                          legitimateList[index]['name'],
                          style: TextStyle(
                            color: Color(0xff3C3C3C),
                            fontSize: size.width * 26
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: size.width * 31,
                          width: size.width * 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Color(0xff2E6CFD),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '查看',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 20
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 35,
                    ),
                    index != legitimateList.length - 1 ? Container(
                      color: Color(0xffEFEFEF),
                      height: size.width * 1,
                      width: double.infinity,
                    ) : Container(),
                  ],
                )
              ),
            );
          },
        ),
      ),
    );
  }
}
