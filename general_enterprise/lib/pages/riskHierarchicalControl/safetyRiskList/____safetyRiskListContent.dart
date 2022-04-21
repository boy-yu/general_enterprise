import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class SafetyRiskListContent extends StatefulWidget {
  SafetyRiskListContent({this.riskMeasureDesc});
  final String riskMeasureDesc;
  @override
  State<SafetyRiskListContent> createState() => _SafetyRiskListContentState();
}

class _SafetyRiskListContentState extends State<SafetyRiskListContent> {
  List data = [
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容1111111111',
      'checkCycle': '10/天',
      'checkMeans': '拍照',
      'isControlled': 1
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容',
      'checkCycle': '10/天',
      'checkMeans': '拍照',
      'isControlled': 1
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容22222222',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'isControlled': 2
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容1111111111',
      'checkCycle': '10/天',
      'checkMeans': '拍照',
      'isControlled': 2
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'isControlled': 2
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容1111111111',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'isControlled': 1
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容1111111111',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'isControlled': 1
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容1111111111',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'isControlled': 1
    },
  ];


  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(
        "隐患排查内容",
        style: TextStyle(fontSize: size.width * 32),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: size.width * 32, top: size.width * 32),
              child: Text(
                '当前管控措施：${widget.riskMeasureDesc}',
                style: TextStyle(
                    color: Color(0xff7F8A9C),
                    fontSize: size.width * 24,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
                child: MyRefres(
              child: (index, list) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/safetyRiskList/safetyRiskListMeasure',
                        arguments: {'riskEventName': list[index]['riskEventName']});
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.width * 32, left: size.width * 64),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 20,
                                  vertical: size.width * 10),
                              decoration: BoxDecoration(
                                  color: list[index]['isControlled'] == 1 ? Color(0xff3074FF).withOpacity(0.1) : Color(0xffF56271).withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(size.width * 20),
                                      topRight:
                                          Radius.circular(size.width * 20))),
                              child: Text(
                                list[index]['isControlled'] == 1 ? '受控' : '不受控',
                                style: TextStyle(
                                    color: list[index]['isControlled'] == 1 ? Color(0xff3074FF) : Color(0xffF56271),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: size.width * 32),
                          padding: EdgeInsets.all(size.width * 32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '隐患排查内容：${list[index]['troubleshootContent']}',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 32,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Text(
                                '巡检周期：${list[index]['checkCycle']}',
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Text(
                                '管控手段：${list[index]['checkMeans']}',
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ],
                  )),
              // page: true,
              // url: Interface.getHistoricalSubscribe,
              // listParam: "records",
              // queryParameters: {
              //   'type': 2,
              // },
              // method: 'get'
              data: data,
            ))
          ],
        )
    );
  }
}