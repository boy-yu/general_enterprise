import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueFirmFile extends StatefulWidget {
  @override
  _EmergencyRescueFirmFileState createState() =>
      _EmergencyRescueFirmFileState();
}

class _EmergencyRescueFirmFileState extends State<EmergencyRescueFirmFile> {
  Map data = {};

  @override
  void initState() {
    super.initState();
    _getPlanFileData();
  }

  _getPlanFileData() {
    myDio
        .request(
      type: 'get',
      url: Interface.getPlanFile,
      // queryParameters: {"type": 2}
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

  _getStatus(int status) {
    if (status == 0) {
      return '待备案';
    } else if (status == 1) {
      return '备案进行中';
    } else if (status == 2) {
      return '已备案';
    } else {
      return '';
    }
  }

  _getUrl(String attachment, String title) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(attachment), 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _getUrl(data['riskEvaluationSheetUrl'], '事故风险辨识评估结论');
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 25, vertical: size.width * 20),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 5.0,
                      spreadRadius: 2.0)
                ]),
            child: Row(
              children: [
                Text(
                  '事故风险辨识评估结论',
                  style: TextStyle(
                      color: Color(0xff7487A4),
                      fontSize: size.width * 24,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                  width: size.width * 1.2,
                  height: size.width * 60,
                  color: Color(0xff9CB4D9),
                  margin: EdgeInsets.symmetric(horizontal: size.width * 10),
                ),
                Container(
                  width: size.width * 110,
                  alignment: Alignment.center,
                  child: Text(
                    _getStatus(data['riskEvaluationSheetStatus']),
                    style: TextStyle(
                        color: Color(0xff306DFF),
                        fontSize: size.width * 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _getUrl(data['equipmentFacilitiesListUrl'], '应急资源调查');
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 25, vertical: size.width * 20),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 5.0,
                      spreadRadius: 2.0)
                ]),
            child: Row(
              children: [
                Text(
                  '应急资源调查',
                  style: TextStyle(
                      color: Color(0xff7487A4),
                      fontSize: size.width * 24,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                  width: size.width * 1.2,
                  height: size.width * 60,
                  color: Color(0xff9CB4D9),
                  margin: EdgeInsets.symmetric(horizontal: size.width * 10),
                ),
                Container(
                  width: size.width * 110,
                  alignment: Alignment.center,
                  child: Text(
                    _getStatus(data['equipmentFacilitiesListStatus']),
                    style: TextStyle(
                        color: Color(0xff306DFF),
                        fontSize: size.width * 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _getUrl(data['evaluationSheetUrl'], '应急预案评估纪要');
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 25, vertical: size.width * 20),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 5.0,
                      spreadRadius: 2.0)
                ]),
            child: Row(
              children: [
                Text(
                  '应急预案评估纪要',
                  style: TextStyle(
                      color: Color(0xff7487A4),
                      fontSize: size.width * 24,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                  width: size.width * 1.2,
                  height: size.width * 60,
                  color: Color(0xff9CB4D9),
                  margin: EdgeInsets.symmetric(horizontal: size.width * 10),
                ),
                Container(
                  width: size.width * 110,
                  alignment: Alignment.center,
                  child: Text(
                    _getStatus(data['evaluationSheetStatus']),
                    style: TextStyle(
                        color: Color(0xff306DFF),
                        fontSize: size.width * 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _getUrl(data['recordTableUrl'], '应急预案备案表');
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 25, vertical: size.width * 20),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 5.0,
                      spreadRadius: 2.0)
                ]),
            child: Row(
              children: [
                Text(
                  '应急预案备案表',
                  style: TextStyle(
                      color: Color(0xff7487A4),
                      fontSize: size.width * 24,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                  width: size.width * 1.2,
                  height: size.width * 60,
                  color: Color(0xff9CB4D9),
                  margin: EdgeInsets.symmetric(horizontal: size.width * 10),
                ),
                Container(
                  width: size.width * 110,
                  alignment: Alignment.center,
                  child: Text(
                    // _getStatus(data['equipmentFacilitiesListStatus']),
                    data['recordTableStatus'] == 0 ? '有效' : '无效',
                    style: TextStyle(
                        color: Color(0xff7772FF),
                        fontSize: size.width * 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
