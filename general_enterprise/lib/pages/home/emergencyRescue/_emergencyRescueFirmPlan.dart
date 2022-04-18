import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmergencyRescueFirmPlan extends StatefulWidget {
  @override
  _EmergencyRescueFirmPlanState createState() =>
      _EmergencyRescueFirmPlanState();
}

class _EmergencyRescueFirmPlanState extends State<EmergencyRescueFirmPlan> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getDataList();
  }

  _getDataList() {
    myDio
        .request(
      type: 'get',
      url: Interface.getPlanFirm,
      // queryParameters: {"type": 2}
    )
        .then((value) {
      if (value is List) {
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
    return data.isNotEmpty
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (data[index]['attachment'] != '') {
                    _getUrl(data[index]['attachment'], data[index]['planName']);
                  } else {
                    Fluttertoast.showToast(msg: '暂无文件');
                  }
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
                        data[index]['planName'],
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
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 10),
                      ),
                      Container(
                        width: size.width * 110,
                        alignment: Alignment.center,
                        child: Text(
                          _getStatus(data[index]['status']),
                          style: TextStyle(
                              color: Color(0xff306DFF),
                              fontSize: size.width * 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
        : Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: size.width * 300),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/empty@2x.png",
                  height: size.width * 288,
                  width: size.width * 374,
                ),
                Text('暂无预案')
              ],
            ));
  }
}
