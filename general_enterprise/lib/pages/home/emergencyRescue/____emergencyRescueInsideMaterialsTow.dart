import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueInsideMaterialsTow extends StatefulWidget {
  EmergencyRescueInsideMaterialsTow({this.title, this.id});
  final String title;
  final int id;
  @override
  _EmergencyRescueInsideMaterialsTowState createState() =>
      _EmergencyRescueInsideMaterialsTowState();
}

class _EmergencyRescueInsideMaterialsTowState
    extends State<EmergencyRescueInsideMaterialsTow> {
  List data = [];
  
  @override
  void initState() {
    super.initState();
    _getInsideMaterialsTow();
  }

  _getInsideMaterialsTow(){
    myDio.request(
      type: 'get',
      url: Interface.getErEquipmentMaterialLibraryList,
      queryParameters: {"id": widget.id}
    ).then((value) {
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
      title: Text(widget.title),
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                          blurRadius: 5.0, //阴影模糊程度
                          spreadRadius: 3.0 //阴影扩散程度
                          )
                    ]),
                padding: EdgeInsets.symmetric(
                    vertical: size.width * 20, horizontal: size.width * 20),
                margin: EdgeInsets.symmetric(
                    vertical: size.width * 20, horizontal: size.width * 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      data[index]['equipmentName'].toString(),
                      style: TextStyle(
                          fontSize: size.width * 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7487A4)),
                    ),
                    Spacer(),
                    Container(
                      color: Color(0xff9CB4D9),
                      height: size.width * 60,
                      width: size.width * 1.2,
                      margin: EdgeInsets.only(
                          left: size.width * 20, right: size.width * 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context, 
                          '/emergencyRescue/_____emergencyRescueInsideMaterialsDetails',
                          arguments: {
                            'title': data[index]['equipmentName'],
                            'id': data[index]['id']
                          }
                        );
                      },
                      child: Container(
                        height: size.width * 40,
                        width: size.width * 120,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff2D6DFF),
                                Color(0xff7A73FF),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 20))),
                        alignment: Alignment.center,
                        child: Text(
                          '查看',
                          style: TextStyle(
                              fontSize: size.width * 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
            );
          }
        ),
    );
  }
}
