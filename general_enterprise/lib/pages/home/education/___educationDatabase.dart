import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EducationDatabase extends StatefulWidget {
  EducationDatabase({this.name, this.kBIndex});
  final String name;
  final int kBIndex;
  @override
  _EducationDatabasetate createState() => _EducationDatabasetate();
}

class _EducationDatabasetate extends State<EducationDatabase> {
  Map data = {
    "id": -1,
    "processName": "",
    "reactionType": "",
    "keyMonitoringUnit": "",
    "processIntroduction": "",
    "processHazardCharacteristics": "",
    "typicalProcess": "",
    "focusProcessParameters": "",
    "basicRequirementsControl": "",
    "suitableControlMethod": "",
    "createDate": "",
    "modifyDate": ""
  };
  @override
  void initState() {
    super.initState();
    _getKnowledgeBaseDetails();
  }

  _getKnowledgeBaseDetails() {
    myDio.request(
        type: 'get',
        url: Interface.getKnowledgeBaseDetails,
        queryParameters: {
          "kBIndex": widget.kBIndex,
          "name": widget.name,
        }).then((value) {
      if (value != null) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.name.toString()),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 20),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Color(0xFFDFDFDF), width: size.width * 2),
                borderRadius: BorderRadius.circular(size.width * 20.0)),
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 20, horizontal: size.width * 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '反应类型',
                        style: TextStyle(
                            color: Color(0xff292929),
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['reactionType'].toString(),
                        style: TextStyle(
                            color: Color(0xff292929),
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: Text(
                          '反应类型',
                          style: TextStyle(
                              color: Color(0x00000000),
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: size.width * 2,
                  color: Color(0xffDFDFDF),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 20),
                  child: Text(
                    '重点监控单元',
                    style: TextStyle(
                        color: Color(0xff292929),
                        fontSize: size.width * 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 20, horizontal: size.width * 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data['keyMonitoringUnit'].toString(),
                          style: TextStyle(
                              color: Color(0xff292929),
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            height: size.width * 69,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff3174FF),
                  Color(0xff1C3AEA),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '工艺简介',
              style: TextStyle(
                  fontSize: size.width * 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 20),
            child: Text(
              data['processIntroduction'],
              style: TextStyle(
                color: Color(0xff666666),
                fontSize: size.width * 28,
              ),
            ),
          ),
          Container(
            height: size.width * 69,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff3174FF),
                  Color(0xff1C3AEA),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '工艺危险特点',
              style: TextStyle(
                  fontSize: size.width * 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 20),
            child: Text(
              data['processHazardCharacteristics'],
              style: TextStyle(
                color: Color(0xff666666),
                fontSize: size.width * 28,
              ),
            ),
          ),
          Container(
            height: size.width * 69,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff3174FF),
                  Color(0xff1C3AEA),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '典型工艺',
              style: TextStyle(
                  fontSize: size.width * 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 10),
            child: Text(
              data['typicalProcess'],
              style: TextStyle(
                color: Color(0xff666666),
                fontSize: size.width * 28,
              ),
            ),
          ),
          Container(
            height: size.width * 69,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff3174FF),
                  Color(0xff1C3AEA),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '重点监控工艺参数',
              style: TextStyle(
                  fontSize: size.width * 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 20),
            child: Text(
              data['focusProcessParameters'],
              style: TextStyle(
                color: Color(0xff666666),
                fontSize: size.width * 28,
              ),
            ),
          ),
          Container(
            height: size.width * 69,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff3174FF),
                  Color(0xff1C3AEA),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '安全控制的基本要求',
              style: TextStyle(
                  fontSize: size.width * 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 20),
            child: Text(
              data['basicRequirementsControl'],
              style: TextStyle(
                color: Color(0xff666666),
                fontSize: size.width * 28,
              ),
            ),
          ),
          Container(
            height: size.width * 69,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff3174FF),
                  Color(0xff1C3AEA),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '宜采用的控制方式',
              style: TextStyle(
                  fontSize: size.width * 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 30, vertical: size.width * 20),
            child: Text(
              data['suitableControlMethod'],
              style: TextStyle(
                color: Color(0xff666666),
                fontSize: size.width * 28,
              ),
            ),
          ),
          SizedBox(
            height: size.width * 20,
          )
          // ListView.builder(
          //   itemCount: 1,
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context,index){
          //     return Column(
          //       children: [

          //       ],
          //     );
          //   }
          // ),
        ],
      ),
    );
  }
}
