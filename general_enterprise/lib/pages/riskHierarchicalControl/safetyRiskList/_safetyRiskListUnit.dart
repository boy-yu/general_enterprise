import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class SafetyRiskListUnit extends StatefulWidget {
  SafetyRiskListUnit({this.riskObjectName});
  final String riskObjectName;
  @override
  State<SafetyRiskListUnit> createState() => _SafetyRiskListUnitState();
}

class _SafetyRiskListUnitState extends State<SafetyRiskListUnit> {
  List data = [
    {
      'riskUnitName': 'XXXXXXXXXXXXXXX',
      'safetySign': 'XXXX',
      'greatNum': 32,
      'largerNum': 46,
      'commonNum': 2,
      'lowNum': 754,
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskUnitName': 'XXXXXXXXXXXXXXX',
      'safetySign': 'XXXX',
      'greatNum': 32,
      'largerNum': 46,
      'commonNum': 2,
      'lowNum': 754,
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskUnitName': 'XXXXXXXXXXXXXXX',
      'safetySign': 'XXXX',
      'greatNum': 32,
      'largerNum': 46,
      'commonNum': 2,
      'lowNum': 754,
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskUnitName': 'XXXXXXXXXXXXXXX',
      'safetySign': 'XXXX',
      'greatNum': 32,
      'largerNum': 46,
      'commonNum': 2,
      'lowNum': 754,
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskUnitName': 'XXXXXXXXXXXXXXX',
      'safetySign': 'XXXX',
      'greatNum': 32,
      'largerNum': 46,
      'commonNum': 2,
      'lowNum': 754,
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskUnitName': 'XXXXXXXXXXXXXXX',
      'safetySign': 'XXXX',
      'greatNum': 32,
      'largerNum': 46,
      'commonNum': 2,
      'lowNum': 754,
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskUnitName': 'XXXXXXXXXXXXXXX',
      'safetySign': 'XXXX',
      'greatNum': 32,
      'largerNum': 46,
      'commonNum': 2,
      'lowNum': 754,
      'overdueNum': 5,
      'completedNum': 2
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          "风险分析单元",
          style: TextStyle(fontSize: size.width * 32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: size.width * 32, top: size.width * 32),
              child: Text(
                '当前风险分析对象：${widget.riskObjectName}',
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
                        context, '/safetyRiskList/safetyRiskListEvent',
                        arguments: {'riskUnitName': list[index]['riskUnitName']});
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
                                '风险分析单元：${list[index]['riskUnitName']}',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 32,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Text(
                                '安全标志：${list[index]['safetySign']}',
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
                                    '风险等级：',
                                    style: TextStyle(
                                        color: Color(0xff7F8A9C),
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    height: size.width * 48,
                                    width: size.width * 64,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 8)),
                                      border: Border.all(
                                          width: size.width * 2,
                                          color: Color(0xffF56271)),
                                    ),
                                    child: Text(
                                      list[index]['greatNum'].toString(),
                                      style: TextStyle(
                                          color: Color(0xffF56271),
                                          fontSize: size.width * 28,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 12,
                                  ),
                                  Container(
                                    height: size.width * 48,
                                    width: size.width * 64,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 8)),
                                      border: Border.all(
                                          width: size.width * 2,
                                          color: Color(0xffFF9900)),
                                    ),
                                    child: Text(
                                      list[index]['largerNum'].toString(),
                                      style: TextStyle(
                                          color: Color(0xffFF9900),
                                          fontSize: size.width * 28,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 12,
                                  ),
                                  Container(
                                    height: size.width * 48,
                                    width: size.width * 64,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 8)),
                                      border: Border.all(
                                          width: size.width * 2,
                                          color: Color(0xffFFCA0E)),
                                    ),
                                    child: Text(
                                      list[index]['commonNum'].toString(),
                                      style: TextStyle(
                                          color: Color(0xffFFCA0E),
                                          fontSize: size.width * 28,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 12,
                                  ),
                                  Container(
                                    height: size.width * 48,
                                    width: size.width * 64,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 8)),
                                      border: Border.all(
                                          width: size.width * 2,
                                          color: Color(0xff2276FC)),
                                    ),
                                    child: Text(
                                      list[index]['lowNum'].toString(),
                                      style: TextStyle(
                                          color: Color(0xff2276FC),
                                          fontSize: size.width * 28,
                                          fontWeight: FontWeight.w400),
                                    ),
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
                              )
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
