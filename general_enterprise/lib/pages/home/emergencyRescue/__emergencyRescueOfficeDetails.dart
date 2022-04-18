import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueOfficeDetails extends StatefulWidget {
  @override
  _EmergencyRescueOfficeDetailsState createState() =>
      _EmergencyRescueOfficeDetailsState();
}

class _EmergencyRescueOfficeDetailsState
    extends State<EmergencyRescueOfficeDetails> {
  Map test;
  Map data = {
    "id": -1,
    "commanderName": "",
    "commanderPhone": "",
    "commanderPosition": "",
    "deputyCommanderName": "",
    "deputyCommanderPhone": "",
    "deputyCommanderPosition": "",
    "directorName": "",
    "directorPhone": "",
    "directorPosition": "",
    "headquartersMembers": "",
    "officeMembers": "",
    "companyId": -1,
    "createDate": "",
    "modifyDate": "",
    "phone": ""
  };

  List member = [];

  @override
  void initState() {
    super.initState();
    _getOfficeDetails();
  }

  _getOfficeDetails() {
    myDio.request(
        type: 'get',
        url: Interface.getEREmergencyHeadquarters,
        queryParameters: {"type": 2}).then((value) {
      if (value is Map) {
        if(value['erHeadquartersAndOffice'] is Map){
          test = value['erHeadquartersAndOffice'];
          if(test.isNotEmpty){
            data = value['erHeadquartersAndOffice'];
          }
        }
        if(value['sysCompanyUsers'] is List){
          member =value['sysCompanyUsers'];
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('办公室详情'),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: size.width * 29,
                      width: size.width * 7.1,
                      color: Color(0xff2D69FB),
                      margin: EdgeInsets.only(
                          top: size.width * 30,
                          bottom: size.width * 30,
                          right: size.width * 15),
                    ),
                    Text(
                      '应急办公室',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffE5E5E5),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(size.width * 30, size.width * 20,
                      size.width * 20, size.width * 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: size.width * 180,
                            child: Text(
                            '负责人：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['directorName'],
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 26),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: size.width * 1,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 180,
                            child: Text(
                            '职务：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['directorPosition'],
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 26),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: size.width * 1,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 180,
                            child: Text(
                            '电话：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['directorPhone'],
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 26),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.width * 15,
          ),
          Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      height: size.width * 29,
                      width: size.width * 7.1,
                      color: Color(0xff2D69FB),
                      margin: EdgeInsets.only(
                          top: size.width * 30,
                          bottom: size.width * 30,
                          right: size.width * 15),
                    ),
                    Text(
                      '成员',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                height: size.width * 1,
                width: double.infinity,
                color: Color(0xffE5E5E5),
              ),
              member.isNotEmpty
                        ?ListView.builder(
                  itemCount: member.length,
                  shrinkWrap: true, //解决无限高度问题
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return  Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(
                                size.width * 30,
                                size.width * 20,
                                size.width * 20,
                                size.width * 20),
                            margin: EdgeInsets.only(bottom: size.width * 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member[index]['nickname'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: size.width * 1,
                                  width: double.infinity,
                                  color: Color(0xffE5E5E5),
                                  margin: EdgeInsets.symmetric(
                                      vertical: size.width * 20),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '电话：',
                                      style: TextStyle(
                                          color: Color(0xff888888),
                                          fontSize: size.width * 24),
                                    ),
                                    Container(
                                      width: size.width * 280,
                                      child: Text(
                                        member[index]['telephone'] != ''
                                            ? member[index]['telephone']
                                            : '暂无电话',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 24),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ))
                        ;
                  }) : Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: size.width * 100),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/empty@2x.png",
                  height: size.width * 288,
                  width: size.width * 374,
                ),
                Text('暂无成员')
              ],
            )),
            ],
          ),
        ],
      ),
    );
  }
}
