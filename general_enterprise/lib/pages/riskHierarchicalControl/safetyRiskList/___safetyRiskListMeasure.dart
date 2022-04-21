import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class SafetyRiskListMeasure extends StatefulWidget {
  SafetyRiskListMeasure({this.riskEventName});
  final String riskEventName;
  @override
  State<SafetyRiskListMeasure> createState() => _SafetyRiskListMeasureState();
}

class _SafetyRiskListMeasureState extends State<SafetyRiskListMeasure> {
  List data = [
    {
      'riskMeasureDesc': '管控措施管控措施管控措施管控措施管控措施11111111',
      'classify1': '分类1',
      'classify2': '分类2',
      'classify3': '分类3',
      'dataSrc': '隐患排查',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskMeasureDesc': '管控措施管控措施管控措施管控措施管控措施',
      'classify1': '分类1',
      'classify2': '分类2',
      'classify3': '分类3',
      'dataSrc': '隐患排查',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskMeasureDesc': '管控措施管控措施管控措施管控措施管控措施',
      'classify1': '分类1',
      'classify2': '分类2',
      'classify3': '分类3',
      'dataSrc': '隐患排查',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskMeasureDesc': '管控措施管控措施管控措施管控措施管控措施',
      'classify1': '分类1',
      'classify2': '分类2',
      'classify3': '分类3',
      'dataSrc': '隐患排查',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskMeasureDesc': '管控措施管控措施管控措施管控措施管控措施',
      'classify1': '分类1',
      'classify2': '分类2',
      'classify3': '分类3',
      'dataSrc': '隐患排查',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskMeasureDesc': '管控措施管控措施管控措施管控措施管控措施',
      'classify1': '分类1',
      'classify2': '分类2',
      'classify3': '分类3',
      'dataSrc': '隐患排查',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskMeasureDesc': '管控措施管控措施管控措施管控措施管控措施',
      'classify1': '分类1',
      'classify2': '分类2',
      'classify3': '分类3',
      'dataSrc': '隐患排查',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskMeasureDesc': '管控措施管控措施管控措施管控措施管控措施',
      'classify1': '分类1',
      'classify2': '分类2',
      'classify3': '分类3',
      'dataSrc': '隐患排查',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskMeasureDesc': '管控措施管控措施管控措施管控措施管控措施',
      'classify1': '分类1',
      'classify2': '分类2',
      'classify3': '分类3',
      'dataSrc': '隐患排查',
      'overdueNum': 5,
      'completedNum': 2
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(
        "管控措施",
        style: TextStyle(fontSize: size.width * 32),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: size.width * 32, top: size.width * 32),
              child: Text(
                '当前风险事件：${widget.riskEventName}',
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
                        context, '/safetyRiskList/safetyRiskListContent',
                        arguments: {'riskMeasureDesc': list[index]['riskMeasureDesc']});
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
                                  color: Color(0xffFF9900).withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(size.width * 20),
                                      topRight:
                                          Radius.circular(size.width * 20))),
                              child: Text(
                                '逾期 ${list[index]['overdueNum']}',
                                style: TextStyle(
                                    color: Color(0xffFF9900),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 16,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 20,
                                  vertical: size.width * 10),
                              decoration: BoxDecoration(
                                  color: Color(0xff3074FF).withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(size.width * 20),
                                      topRight:
                                          Radius.circular(size.width * 20))),
                              child: Text(
                                '已完成 ${list[index]['completedNum']}',
                                style: TextStyle(
                                    color: Color(0xff3074FF),
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
                                '管控措施：${list[index]['riskMeasureDesc']}',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 32,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Text(
                                '管控分类：${list[index]['classify1']}-${list[index]['classify2']}-${list[index]['classify3']}',
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
                                    '管控方式：${list[index]['dataSrc']}',
                                    style: TextStyle(
                                        color: Color(0xff7F8A9C),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: size.width * 56,
                                    width: size.width * 112,
                                    decoration: BoxDecoration(
                                      color: Color(0xff3074FF),
                                      borderRadius: BorderRadius.all(Radius.circular(size.width * 36))
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "详情",
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