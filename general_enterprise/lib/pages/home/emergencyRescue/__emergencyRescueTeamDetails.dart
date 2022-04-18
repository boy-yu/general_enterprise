import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueTeamDetails extends StatefulWidget {
  EmergencyRescueTeamDetails({this.id});
  final int id;
  @override
  _EmergencyRescueTeamDetailsState createState() =>
      _EmergencyRescueTeamDetailsState();
}

class _EmergencyRescueTeamDetailsState extends State<EmergencyRescueTeamDetails> {
  Map data = {
    "id": -1,
    "rescueTeamName": "",
    "rescueTeamType": "",
    "mainHead": "",
    "onDutyPhone": "",
    "totalPeopleNum": -1,
    "fullTimePeopleNum": -1,
    "setUpTime": "",
    "mainEquipment": "",
    "members": "",
    "professionalDescription": "",
    "companyId": -1
  };

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List member = [];

  _getData(){
    myDio.request(
      type: 'get',
      url: Interface.getERHeadquartersRescueTeamDetails + widget.id.toString(),
    ).then((value) {
      if (value is Map) {
        data = value['erHeadquartersRescueTeam'];
        
      }
      if(value['sysCompanyUsers'] is List){
        member =value['sysCompanyUsers'];
      }
      if (mounted) {
          setState(() {});
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('队伍详情'),
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
                      '救援队伍',
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
                            '队伍名称：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['rescueTeamName'],
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
                            '主要负责人：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['mainHead'],
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
                            '成立时间：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['setUpTime'],
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
                            '专职人数：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['fullTimePeopleNum'].toString(),
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
                            '总人数：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['totalPeopleNum'].toString(),
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
                            '救援队类型：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['rescueTeamType'],
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 180,
                            child: Text(
                            '主要装备描述：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Expanded(
                            child: Text(
                              data['mainEquipment'],
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 26),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: size.width * 1,
                        color: Color(0xffE5E5E5),
                        margin: EdgeInsets.symmetric(vertical: size.width * 20),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 180,
                            child: Text(
                            '专业描述：',
                            style: TextStyle(
                                color: Color(0xff888888),
                                fontSize: size.width * 26),
                          ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Expanded(
                            child: Text(
                              data['professionalDescription'],
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 26),
                            ),
                          )
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
              member.isNotEmpty ? ListView.builder(
                  itemCount: member.length,
                  shrinkWrap: true, //解决无限高度问题
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(size.width * 30,
                            size.width * 20, size.width * 20, size.width * 20),
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
                                    member[index]['telephone'] != '' ? member[index]['telephone'] : '暂无电话',
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 24),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ));
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
