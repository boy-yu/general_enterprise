import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HiddenCheckGovern extends StatefulWidget {
  @override
  State<HiddenCheckGovern> createState() => _HiddenCheckGovernState();
}

class _HiddenCheckGovernState extends State<HiddenCheckGovern> {
  List menuList = [
    {
      'name': '隐患排查任务',
      'image': 'assets/images/doubleRiskProjeck/image_hidden_menu_task.png',
      'router': '/hiddenCheckGovern/hiddenCheckTask'
    },
    {
      'name': '隐患治理任务',
      'image': 'assets/images/doubleRiskProjeck/image_hidden_menu_govern_task.png',
      'router': '/hiddenCheckGovern/hiddenGovernTask'
    },
    {
      'name': '隐患排查记录',
      'image': 'assets/images/doubleRiskProjeck/image_hidden_menu_check_record.png',
      'router': '/hiddenCheckGovern/hiddenCheckRecord'
    },
    {
      'name': '隐患治理台账',
      'image': 'assets/images/doubleRiskProjeck/image_hidden_menu_govern_record.png',
      'router': '/hiddenCheckGovern/hiddenGovernRecord'
    },
    // {
    //   'name': '报表签收',
    //   'image': 'assets/images/doubleRiskProjeck/image_hidden_menu_report.png',
    //   'router': '/hiddenCheckGovern/hiddenReportSignIn'
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('隐患排查治理', style: TextStyle(fontSize: size.width * 32)),
      child: Container(
        color: Color(0xffF8FAFF),
        child: ListView.builder(
          itemCount: menuList.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                if(menuList[index]['router'] == ''){
                  Fluttertoast.showToast(msg: '暂无开放该模块');
                }else{
                  Navigator.pushNamed(context, menuList[index]['router']);
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: size.width * 40, left: size.width * 32, right: size.width * 32),
                padding: EdgeInsets.symmetric(horizontal: size.width * 60, vertical: size.width * 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(size.width * 20))
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuList[index]['name'],
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(
                          height: size.width * 30,
                        ),
                        Image.asset(
                          'assets/images/doubleRiskProjeck/go@2x.png',
                          height: size.width * 40,
                          width: size.width * 56,
                        )
                      ],
                    ),
                    Spacer(),
                    Image.asset(
                          menuList[index]['image'],
                          height: size.width * 164,
                          width: size.width * 164,
                        )
                  ],
                ),
              ),
            );
          }
        ),
      )
    );
  }
}