import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class ControlSituation extends StatefulWidget {
  ControlSituation({this.id});
  final String id;
  @override
  State<ControlSituation> createState() => _ControlSituationState();
}

class _ControlSituationState extends State<ControlSituation> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map data = {
    "riskControlDataList": [],
    "riskObjectName": "",
    "riskMeasureDesc": "",
    "riskEventName": "",
    "riskUnitName": ""
  };

  _getData() {
    myDio.request(
        type: 'get',
        url: Interface.getRiskTemplateFourImplementationById,
        queryParameters: {'id': widget.id}).then((value) {
      if (value is Map) {
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
        title: Text(
          '管控情况',
          style: TextStyle(fontSize: size.width * 32),
        ),
        child: Container(
          color: Color(0xffF8FAFF),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 32, vertical: size.width * 30),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff5E92FB),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * 20),
                        bottomLeft: Radius.circular(size.width * 20),
                        bottomRight: Radius.circular(size.width * 20)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff7F8A9C).withOpacity(0.05),
                          spreadRadius: size.width * 2,
                          blurRadius: size.width * 8)
                    ]),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 32, vertical: size.width * 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [],
                    ),
                    Text(
                      '风险分析对象：${data['riskObjectName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 32,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '风险分析单元：${data['riskUnitName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 24,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '风险事件：${data['riskEventName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 24,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                    Text(
                      '管控措施：${data['riskMeasureDesc']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 24,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: size.width * 16,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * 32),
                child: Row(
                  children: [
                    Container(
                      height: size.width * 48,
                      width: size.width * 12,
                      decoration: BoxDecoration(
                        color: Color(0xffFF943D),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(size.width * 24),
                            bottomRight: Radius.circular(size.width * 24)),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 24,
                    ),
                    Text(
                      '未管控任务列表',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 32,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: data['riskControlDataList'].length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(size.width * 20),
                                    bottomLeft:
                                        Radius.circular(size.width * 20),
                                    bottomRight:
                                        Radius.circular(size.width * 20)),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Color(0xff7F8A9C).withOpacity(0.05),
                                      spreadRadius: size.width * 2,
                                      blurRadius: size.width * 8)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 32,
                                      vertical: size.width * 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                            Radius.circular(size.width * 20)),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff2276FC).withOpacity(0.12),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    '隐患排查任务：${data['riskControlDataList'][index]['troubleshootContent']}',
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 32,
                                      vertical: size.width * 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                fontSize: size.width * 24,
                                                fontWeight: FontWeight.w400),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                  text: '开始时间：',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff333333))),
                                              TextSpan(
                                                  text: DateTime.fromMillisecondsSinceEpoch(
                                                          data['riskControlDataList']
                                                                  [index][
                                                              'checkStartDate'])
                                                      .toString()
                                                      .substring(0, 19),
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff7F8A9C))),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: size.width * 16,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                fontSize: size.width * 24,
                                                fontWeight: FontWeight.w400),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                  text: '结束时间：',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff333333))),
                                              TextSpan(
                                                  text: DateTime.fromMillisecondsSinceEpoch(
                                                          data['riskControlDataList']
                                                                  [index]
                                                              ['checkEndDate'])
                                                      .toString()
                                                      .substring(0, 19),
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff7F8A9C))),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: size.width * 16,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                fontSize: size.width * 24,
                                                fontWeight: FontWeight.w400),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                  text: '管控手段：',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff333333))),
                                              TextSpan(
                                                  text: data['riskControlDataList']
                                                                  [index]
                                                              ['checkMeans'] ==
                                                          0
                                                      ? '现场确认'
                                                      : '拍照',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff7F8A9C))),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: size.width * 16,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ));
                      }))
            ],
          ),
        ));
  }
}
