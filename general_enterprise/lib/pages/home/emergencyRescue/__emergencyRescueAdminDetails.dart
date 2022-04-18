import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueAdminDetails extends StatefulWidget {
  EmergencyRescueAdminDetails({this.id});
  final int id;
  @override
  _EmergencyRescueAdminDetailsState createState() =>
      _EmergencyRescueAdminDetailsState();
}

class _EmergencyRescueAdminDetailsState
    extends State<EmergencyRescueAdminDetails> {
  @override
  void initState() {
    super.initState();
    _getAdminDetails();
  }

  Map data = {};

  _getAdminDetails() {
    myDio
        .request(
      type: 'get',
      url: Interface.getERAccidentById + widget.id.toString(),
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
      title: Text('事故管理详情'),
      child: data.isNotEmpty
          ? ListView(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            '事故调查报告基础信息',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
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
                                    '事故名称：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['accidentName'],
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
                                    '所在区域：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['area'],
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
                                    '其他经办人：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['otherOperationPeople'].toString(),
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
                                    '经办人：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['operationPeople'].toString(),
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
                                    '是否结案：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['isEnd'] == 0 ? '否' : '是',
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
                                    '经办科室：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data['operationDepartment'].toString(),
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
                                    '是否公布：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['isPublic'] == 0 ? '不公示' : '公示',
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
                                    '记录编号：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data['code'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 26),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                            '事故发生经过和事故救援情况',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
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
                                    '事故时间：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['accidentTime'] ?? '',
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
                                    '事故坐标：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['longitude'] != null &&
                                          data['latitude'] != null
                                      ? data['longitude'].toString() +
                                          "'E,  " +
                                          data['latitude'].toString() +
                                          "'N"
                                      : '',
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
                                    '事故地点：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['accidentAddress'].toString(),
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
                                    '处理时间:',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['disposalTime'] ?? '',
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
                            '事故造成的人员伤亡和直接经济损失',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
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
                                    '事故级别：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['accidentLevel'],
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
                                    '受伤人数：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['injuredNum'].toString(),
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
                                    '死亡人数：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['deathNum'].toString(),
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
                                    '经济损失（万元）:',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['economicLosses'].toString(),
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
                                    '损失情况:',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['damageDetails'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 15,
                            ),
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
                            '事故发生的原因和事故性质',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
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
                                    '事故类别：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['accidentType'],
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
                                    '原因分析：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['causeAnalysis'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 15,
                            ),
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
                            '事故责任的认定以及对事故责任者的处理建议',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
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
                                    '负责人员：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['head'],
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
                                    '处罚金额（万元）：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['punishmentMo'].toString(),
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
                                    '处罚情况：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['punishmentDetails'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 15,
                            ),
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
                            '事故防范和整改措施',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
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
                                    '处理情况：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['disposalDetails'],
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 15,
                            ),
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
                            '事故赔偿',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        color: Color(0xffE9E9E9),
                        height: size.width * 2,
                        width: double.infinity,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 30),
                        margin: EdgeInsets.only(bottom: size.width * 20),
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
                                    '赔偿金额（万元）：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['compensationMo'].toString(),
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
                                    '事故赔偿情况：',
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: size.width * 26),
                                  ),
                                ),
                                Text(
                                  data['compensationDetails'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
