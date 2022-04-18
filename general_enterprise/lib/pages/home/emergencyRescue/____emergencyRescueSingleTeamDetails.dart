import 'package:enterprise/common/empty.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueSingleTeamDetails extends StatefulWidget {
  EmergencyRescueSingleTeamDetails({this.id});
  final int id;
  @override
  _EmergencyRescueSingleTeamDetailsState createState() =>
      _EmergencyRescueSingleTeamDetailsState();
}

class _EmergencyRescueSingleTeamDetailsState
    extends State<EmergencyRescueSingleTeamDetails> {
  Map data = {
    "id": -1,
    "rescueTeamName": "",
    "rescueTeamType": "",
    "qualificationLevel": "",
    "mainDepartment": "",
    "serviceArea": "",
    "mainHead": "",
    "officePhone": "",
    "onDutyPhone": "",
    "totalPeopleNum": 0,
    "fullTimePeopleNum": 0,
    "partTimePeopleNum": 0,
    "squadronNum": 0,
    "teamNum": 0,
    "setUpTime": "",
    "asOfTime": "",
    "getCertificateTime": "",
    "longitude": "0",
    "latitude": "0",
    "rescueTeamAddress": "",
    "mainEquipment": "",
    "professionalDescription": "",
    "qualityStandardLevel": "",
    "licenseIssuingAgencies": "",
    "createDate": "",
    "modifyDate": "",
    "companyId": -1,
    "isGovernmentCreate": 1,
    "qualification": "",
    "agreement": "",
    "members": ""
  };

  @override
  void initState() {
    super.initState();
    _getTeamDetails();
  }

  _getTeamDetails() {
    myDio
        .request(
      type: 'get',
      url: Interface.getERRescueTeamDetails + widget.id.toString(),
    )
        .then((value) {
      if (value is Map) {
        data = value;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('详情'),
      child: data.isNotEmpty
          ? ListView(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                        child: Text(
                          '救援队伍信息',
                          style: TextStyle(
                              fontSize: size.width * 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Color(0xffE9E9E9),
                        height: size.width * 2,
                        width: double.infinity,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.width * 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '队伍名称：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
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
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '救援类型：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
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
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '中队个数：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['squadronNum'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '小队个数：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['teamNum'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '救援队伍地址：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['rescueTeamAddress'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '主要装备描述：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data['mainEquipment'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 26),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '服务区域：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['serviceArea'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                        child: Text(
                          '成立信息',
                          style: TextStyle(
                              fontSize: size.width * 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Color(0xffE9E9E9),
                        height: size.width * 2,
                        width: double.infinity,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.width * 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '成立时间：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['setUpTime'].toString().length > 10
                                      ? data['setUpTime']
                                          .toString()
                                          .substring(0, 10)
                                      : data['setUpTime'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '截至时间：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['asOfTime'].toString().length > 10
                                      ? data['asOfTime']
                                          .toString()
                                          .substring(0, 10)
                                      : data['asOfTime'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '发证日期：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['getCertificateTime'].toString().length >
                                          10
                                      ? data['getCertificateTime']
                                          .toString()
                                          .substring(0, 10)
                                      : data['getCertificateTime'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '发证机关：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['licenseIssuingAgencies'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                        child: Text(
                          '人员与联络电话',
                          style: TextStyle(
                              fontSize: size.width * 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Color(0xffE9E9E9),
                        height: size.width * 2,
                        width: double.infinity,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.width * 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '主要部门：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['mainDepartment'],
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '主要负责人：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
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
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '办公室电话：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['officePhone'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '值班电话：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['onDutyPhone'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '总人数（人）：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
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
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '专职人数（人）：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data['fullTimePeopleNum'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 26),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '兼职人数（人）：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['partTimePeopleNum'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '成员：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data['members'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 26),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '专业描述:',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data['professionalDescription'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                        child: Text(
                          '其他信息',
                          style: TextStyle(
                              fontSize: size.width * 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Color(0xffE9E9E9),
                        height: size.width * 2,
                        width: double.infinity,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.width * 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '资质等级：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['qualificationLevel'],
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '质量标准化等级：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['qualityStandardLevel'],
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Container(
                  color: Colors.white,
                  height: size.width * 50,
                  width: double.infinity,
                )
              ],
            )
          : Empty()
    );
  }
}
