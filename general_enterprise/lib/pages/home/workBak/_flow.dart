import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkFlow extends StatefulWidget {
  WorkFlow({this.arguments});
  final arguments;
  @override
  _WorkFlowState createState() =>
      _WorkFlowState(id: arguments['id'].toString());
}

class _WorkFlowState extends State<WorkFlow> {
  SharedPreferences perf;
  _WorkFlowState({this.id});
  final id;
  final Map msg = {
    '作业单位': 'xxxx单位',
    '作业区域': 'xxxx区域',
    '作业地点': 'xxxx地点',
    '作业时间段': '2018-02-16--2018-02-25',
    '作业内容': 'xxxx描述',
    '作业人': '张安',
    '涉及作业': '动火作业'
  };

  final Map data = {
    "year": "2018",
    'event': [
      {'time': '04-09', 'people': '某某申请人', 'state': '已申请'},
      {'time': '04-16', 'people': '某某申请人', 'state': '已申请'},
      {'time': '04-23', 'people': '某某申请人', 'state': '通过'},
      {'time': '04-30', 'people': '某某申请人', 'state': '驳回'},
    ]
  };

  @override
  void initState() {
    super.initState();
    _getMsg();
  }

  _getMsg() async {
    perf = await SharedPreferences.getInstance();
    // print(id);
    myDio
        .request(
            type: 'get', url: Interface.workHistoryUrl + '/' + id.toString())
        .then((value) {
      // print(value);
      msg['作业单位'] = value['workUnit'].toString();
      msg['作业区域'] = value['territorialUnit'].toString();
      msg['作业地点'] = value['location'].toString();
      msg['作业时间段'] =
          value['startDate'].toString() + ' - ' + value['endDate'].toString();
      msg['作业内容'] = value['description'].toString();
      msg['作业人'] = value['applicantName'].toString();
      msg['涉及作业'] = value['workTypes'].toString();
      data['year'] = value['startDate'].toString().split('-')[0].toString();
      data['event'] = value['applicationFlows'];
      setState(() {});
    }).catchError((onError) {
      print(onError);
    });
  }

  _generateMsg(width, height) {
    List<Widget> _widget = [];
    msg.forEach((key, value) {
      _widget.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: width * 200,
            margin: EdgeInsets.only(top: height * 10),
            child: Text(
              key + ":",
              textAlign: TextAlign.right,
              style: TextStyle(color: placeHolder, fontSize: width * 28),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: width * 30, top: height * 10),
            child: Text(value,
                // maxLines: 3,
                style: TextStyle(color: placeHolder, fontSize: width * 24)),
          ))
        ],
      ));
    });

    return _widget;
  }

  _generateDate(width, height, context) {
    List<Widget> _widget = [];
    // print(data['event']);

    String __generateName({int type = 0}) {
      if (type == null) type = 0;
      List name = ['申请人', '安全措施', '安全交底', '审批人', '关闭'];
      return name[type];
    }

    data['event'].forEach((element) {
      String min = element['executionTime'];
      if (min != null) {
        min = min.split(' ')[1];
      }
      _widget.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: height * 10),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: element['executionTime']
                          .toString()
                          .split(' ')[0]
                          .toString() +
                      '\n'),
              TextSpan(text: min)
            ])),
          ),
          SizedBox(
            width: width * 100,
          ),
          Column(
            children: <Widget>[
              Icon(Icons.adjust, color: themeColor),
              Container(
                width: 1,
                height: height * 100,
                color: themeColor,
              )
            ],
          ),
          Expanded(
              child: Container(
            color: Color.fromRGBO(244, 244, 244, 1),
            padding: EdgeInsets.only(
                left: width * 40, top: height * 29, bottom: height * 30),
            margin: EdgeInsets.only(
                left: width * 26, right: width * 26, top: width * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: __generateName(type: element['executionType']) +
                              ': \n'),
                      TextSpan(
                          text: '${element["executionName"]} ',
                          style: TextStyle())
                    ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // webview
                    // http://gp-local.cn:9005/#/app-work-record test
                    // http://yx.sccitysafety.com/#/app-work-record
                    // http://192.168.10.127:8185/#/app-work-record
                    String baseUrl = '';
                    switch (Interface.baseUrl) {
                      case 'http://gp-local.cn:32694':
                        baseUrl =
                            'http://192.168.10.127:8185/#/app-work-record';
                        break;
                      case 'http://gp-local.cn:31101':
                        baseUrl = 'http://gp-local.cn:9005/#/app-work-record';
                        break;
                      case 'http://api.yx.app.sccitysafety.com':
                        baseUrl =
                            'http://yx.sccitysafety.com/#/app-work-record';
                        break;
                      default:
                    }
                    String url = baseUrl +
                        '?token=' +
                        perf.getString('token') +
                        '&workFlowId=' +
                        element['id'].toString() +
                        '&workId=' +
                        widget.arguments['id'].toString();
                    // print(url);
                    print(element['id']);
                    Navigator.pushNamed(context, '/webview',
                        arguments: {"url": url});
                  },
                  child: Container(
                    child: Text(
                      '作业票详情',
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: yellowBg,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            bottomLeft: Radius.circular(24))),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                ),
              ],
            ),
          )),
        ],
      ));
    });

    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;

    return MyAppbar(
      title: Text('历史详情'),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: size.width * 44),
                color: Colors.white,
                child: Column(children: _generateMsg(width, size.width)),
              ),
              Container(
                margin: EdgeInsets.only(top: size.width * 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      data['year'].toString() + '         ',
                      style: TextStyle(color: themeColor, fontSize: width * 32),
                    ),
                    SizedBox(
                      width: width * 100,
                    ),
                    Icon(
                      Icons.alarm,
                      color: themeColor,
                    )
                  ],
                ),
                padding: EdgeInsets.only(left: width * 20, top: width * 30),
                color: Colors.white,
              ),
              Container(
                child: Column(
                  children: _generateDate(width, size.width, context),
                ),
                padding: EdgeInsets.only(
                    left: width * 20, top: width * 30, bottom: size.width * 40),
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
