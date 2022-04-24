import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class SafetyRiskListEvent extends StatefulWidget {
  SafetyRiskListEvent({this.riskUnitName});
  final String riskUnitName;
  @override
  State<SafetyRiskListEvent> createState() => _SafetyRiskListEventState();
}

class _SafetyRiskListEventState extends State<SafetyRiskListEvent> {
  List data = [
    {
      'riskEventName': '事件名称事件名称事件名称11111111',
      'riskDescription': '风险描述风险描述风险描述风险描述风险描述风险描述风险描述',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskEventName': '事件名称事件名称事件名称',
      'riskDescription': '风险描述风险描述风险描述风险描述风险描述风险描述风险描述',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskEventName': '事件名称事件名称事件名称',
      'riskDescription': '风险描述风险描述风险描述风险描述风险描述风险描述风险描述',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskEventName': '事件名称事件名称事件名称',
      'riskDescription': '风险描述风险描述风险描述风险描述风险描述风险描述风险描述',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskEventName': '事件名称事件名称事件名称',
      'riskDescription': '风险描述风险描述风险描述风险描述风险描述风险描述风险描述',
      'overdueNum': 5,
      'completedNum': 2
    },
    {
      'riskEventName': '事件名称事件名称事件名称',
      'riskDescription': '风险描述风险描述风险描述风险描述风险描述风险描述风险描述',
      'overdueNum': 5,
      'completedNum': 2
    },
  ];

  List<TogglePicType> titleBar = [
    TogglePicType(
        title: '初始风险',
        data: [
          XAxisSturct(names: '重大风险', color: Color(0xffF56271), nums: 12),
          XAxisSturct(names: '较大风险', color: Color(0xffFF9900), nums: 12),
          XAxisSturct(names: '一般风险', color: Color(0xffFFCA0E), nums: 12),
          XAxisSturct(names: '低风险', color: Color(0xff2276FC), nums: 12),
        ],
        totalNum: 48),
    TogglePicType(
        title: '剩余风险',
        data: [
          XAxisSturct(names: '重大风险', color: Color(0xffF56271), nums: 10),
          XAxisSturct(names: '较大风险', color: Color(0xffFF9900), nums: 4),
          XAxisSturct(names: '一般风险', color: Color(0xffFFCA0E), nums: 23),
          XAxisSturct(names: '低风险', color: Color(0xff2276FC), nums: 13),
        ],
        totalNum: 43),
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(
        "风险事件",
        style: TextStyle(fontSize: size.width * 32),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: size.width * 32, top: size.width * 32),
              child: Text(
                '当前风险分析单元：${widget.riskUnitName}',
                style: TextStyle(
                    color: Color(0xff7F8A9C),
                    fontSize: size.width * 24,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: size.width * 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5.0)]),
              child: Column(children: [
                CustomEchart().togglePic(
                    centerChild: '总数',
                    data: titleBar,
                    onpress: (index) async {
                      // if (index == 0) {
                      //   return await _getWorkState();
                      // } else {
                      //   return await _getWorkPercen();
                      // }
                    }),
                SizedBox(height: size.width * 20)
              ])),
            Expanded(
                child: MyRefres(
              child: (index, list) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/safetyRiskList/safetyRiskListMeasure',
                        arguments: {'riskEventName': list[index]['riskEventName']});
                  },
                  child: Container(
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
                                '风险事件：${list[index]['riskEventName']}',
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 32,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Text(
                                '风险描述：${list[index]['riskDescription']}',
                                style: TextStyle(
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),),
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