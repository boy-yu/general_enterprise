import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueInsideMaterialsDetails extends StatefulWidget {
  EmergencyRescueInsideMaterialsDetails({this.id});
  final int id;
  @override
  _EmergencyRescueInsideMaterialsDetailsState createState() => _EmergencyRescueInsideMaterialsDetailsState();
}

class _EmergencyRescueInsideMaterialsDetailsState extends State<EmergencyRescueInsideMaterialsDetails> {
  Map data = {
    "id": -1,
    "equipmentName": "",
    "unit": "",
    "number": 0,
    "location": "",
    "memo": "",
    "equipmentId": -1,
    "createDate": "",
    "modifyDate": ""
  };
  
  @override
  void initState() {
    super.initState();
    _getInsideMaterialsDetails();
  }

  _getInsideMaterialsDetails(){
    myDio.request(
      type: 'get',
      url: Interface.getShowErEquipmentMaterialLibrary + widget.id.toString(),
      // queryParameters: {"id": widget.id}
    ).then((value) {
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
                      '装备物资',
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
                            width: size.width * 150,
                            child: Text(
                              '装备名称：',
                              style: TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: size.width * 26),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['equipmentName'],
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
                            width: size.width * 150,
                            child: Text(
                              '单位：',
                              style: TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: size.width * 26),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['unit'],
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
                            width: size.width * 150,
                            child: Text(
                              '数量：',
                              style: TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: size.width * 26),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['number'].toString(),
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
                            width: size.width * 150,
                            child: Text(
                              '存放地点：',
                              style: TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: size.width * 26),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['location'].toString(),
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
                            width: size.width * 150,
                            child: Text(
                              '备注：',
                              style: TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: size.width * 26),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['memo'].toString(),
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
                            width: size.width * 150,
                            child: Text(
                              '创建时间：',
                              style: TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: size.width * 26),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 50,
                          ),
                          Text(
                            data['createDate'],
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
                            width: size.width * 150,
                            child: Text(
                              '修改时间：',
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
                              data['modifyDate'],
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
        ],
      ),
    );
  }
}