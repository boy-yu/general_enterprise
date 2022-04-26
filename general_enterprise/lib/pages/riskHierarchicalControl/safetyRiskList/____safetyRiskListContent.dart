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
      'implement': 2 // 1已执行 2未执行
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容',
      'checkCycle': '10/天',
      'checkMeans': '拍照',
      'implement': 2 // 1已执行 2未执行
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容22222222',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'implement': 1 // 1已执行 2未执行
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容1111111111',
      'checkCycle': '10/天',
      'checkMeans': '拍照',
      'implement': 1 // 1已执行 2未执行
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'implement': 2 // 1已执行 2未执行
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容1111111111',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'implement': 1 // 1已执行 2未执行
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容1111111111',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'implement': 2 // 1已执行 2未执行
    },
    {
      'troubleshootContent': '隐患排查内容隐患排查内容隐患排查内容1111111111',
      'checkCycle': '10/天',
      'checkMeans': '现场确认',
      'implement': 1 // 1已执行 2未执行
    },
  ];


  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(
        "隐患排查内容",
        style: TextStyle(fontSize: size.width * 32),
      ),
      child: Container(
        color: Color(0xffF8FAFF),
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
              child: (index, list) => Container(
                          margin: EdgeInsets.only(left: size.width * 32, right: size.width * 32, top: size.width * 32),
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
                              Row(
                                children: [
                                  Text(
                                    '管控手段：${list[index]['checkMeans']}',
                                    style: TextStyle(
                                        color: Color(0xff7F8A9C),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: size.width * 56,
                                    width: size.width * 140,
                                    decoration: BoxDecoration(
                                      color: list[index]['implement'] == 1 ? Color(0xff5FD5EC) : Color(0xffF56271),
                                      borderRadius: BorderRadius.all(Radius.circular(size.width * 36))
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      list[index]['implement'] == 1 ? "已执行" : "未执行",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
        ),
      )
    );
  }
}