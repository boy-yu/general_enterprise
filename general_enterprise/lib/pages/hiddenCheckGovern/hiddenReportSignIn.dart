import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class HiddenReportSignIn extends StatefulWidget {
  @override
  State<HiddenReportSignIn> createState() => _HiddenReportSignInState();
}

class _HiddenReportSignInState extends State<HiddenReportSignIn> {
  List<PieSturct> statisticsPie = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < data.length; i++) {
      data[i]['select'] = false;
    }
    _getStatisticsData();
  }

  _getStatisticsData() {
    statisticsPie
        .add(PieSturct(color: Color(0xff2276FC), nums: 123, title: '已完成'));
    statisticsPie
        .add(PieSturct(color: Color(0xffFF9900), nums: 30, title: '逾期'));
    statisticsPie
        .add(PieSturct(color: Color(0xffFFCA0E), nums: 49, title: '待确认'));
    statisticsPie
        .add(PieSturct(color: Color(0xffF56271), nums: 123, title: '待整改'));
    statisticsPie
        .add(PieSturct(color: Color(0xff5FD5EC), nums: 30, title: '待审批'));
  }

  List data = [
    // type 1已完成 2逾期 3待确认 4待整改 5待审批
    {
      'riskObjectName': '分析对象分析对象分析对象',
      'riskUnitName': '分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元',
      'riskEventName': '事件事件事件事件事件事件事件事件事件事件',
      'riskMeasureDesc': '措施措施措施措施措施措施措施措施措施措施措施措施措施',
      'troubleshootContent': '排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容',
      'id': 1
    },
    {
      'riskObjectName': '分析对象分析对象分析对象',
      'riskUnitName': '分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元',
      'riskEventName': '事件事件事件事件事件事件事件事件事件事件',
      'riskMeasureDesc': '措施措施措施措施措施措施措施措施措施措施措施措施措施',
      'troubleshootContent': '排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容',
      'id': 2
    },
    {
      'riskObjectName': '分析对象分析对象分析对象',
      'riskUnitName': '分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元',
      'riskEventName': '事件事件事件事件事件事件事件事件事件事件',
      'riskMeasureDesc': '措施措施措施措施措施措施措施措施措施措施措施措施措施',
      'troubleshootContent': '排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容',
      'id': 3
    },
    {
      'riskObjectName': '分析对象分析对象分析对象',
      'riskUnitName': '分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元',
      'riskEventName': '事件事件事件事件事件事件事件事件事件事件',
      'riskMeasureDesc': '措施措施措施措施措施措施措施措施措施措施措施措施措施',
      'troubleshootContent': '排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容',
      'id': 4
    },
    {
      'riskObjectName': '分析对象分析对象分析对象',
      'riskUnitName': '分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元分析单元',
      'riskEventName': '事件事件事件事件事件事件事件事件事件事件',
      'riskMeasureDesc': '措施措施措施措施措施措施措施措施措施措施措施措施措施',
      'troubleshootContent': '排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容排查内容',
      'id': 15
    },
  ];

  // 总的复选框控制开关
  bool _checkValue = false;
  // 要删除的id数组
  List<int> deleteIds = [];  

  _selectAll(value){
    this.deleteIds = []; // 重置
    data.forEach((element) {
      element['select'] = value;
      if(value == true){
        this.deleteIds.add(element['id']);
      }
    });
    setState(() {
     _checkValue = value;
     data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          "报表签收",
          style: TextStyle(fontSize: size.width * 32),
        ),
        elevation: 0,
        child: Container(
          color: Color(0xffF8FAFF),
          child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _checkValue, 
                      onChanged: (value){
                        _selectAll(value);
                      }
                    ),
                    Text(
                      "全选",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 28
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.only(top: size.width * 32),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: data[index]['select'], 
                              onChanged: (value){
                                if(value == false){
                                  this.deleteIds.remove(data[index]['id']);
                                }else{
                                  this.deleteIds.add(data[index]['id']);
                                }
                                setState(() {
                                  data[index]['select'] = value;
                                });
                              }
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(size.width * 20), bottomLeft: Radius.circular(size.width * 20), bottomRight: Radius.circular(size.width * 20)),
                                border: data[index]['select'] ? Border.all(color: Color(0xFF3074FF), width: size.width * 2) : null,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: size.width * 24, vertical: size.width * 16),
                                    child: Text(
                                          '风险分析对象：${data[index]['riskObjectName']}',
                                          style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 28,
                                            fontWeight: FontWeight.w500
                                          ),
                                        )
                                  ),
                                  Container(
                                    width: size.width * 630,
                                    padding: EdgeInsets.symmetric(horizontal: size.width * 24, vertical: size.width * 16),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff2276FC).withOpacity(0.12),
                                          Colors.transparent,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(size.width * 20), bottomRight: Radius.circular(size.width * 20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(fontSize: size.width * 24, fontWeight: FontWeight.w400),
                                              children: <InlineSpan>[
                                                TextSpan(text: '风险分析单元：', style: TextStyle(color: Color(0xff333333))),
                                                TextSpan(text: data[index]['riskUnitName'], style: TextStyle(color: Color(0xff7F8A9C))),
                                              ]),
                                        ),
                                        SizedBox(
                                          height: size.width * 16,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(fontSize: size.width * 24, fontWeight: FontWeight.w400),
                                              children: <InlineSpan>[
                                                TextSpan(text: '风险事件：', style: TextStyle(color: Color(0xff333333))),
                                                TextSpan(text: data[index]['riskEventName'], style: TextStyle(color: Color(0xff7F8A9C))),
                                              ]),
                                        ),
                                        SizedBox(
                                          height: size.width * 16,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(fontSize: size.width * 24, fontWeight: FontWeight.w400),
                                              children: <InlineSpan>[
                                                TextSpan(text: '管控措施：', style: TextStyle(color: Color(0xff333333))),
                                                TextSpan(text: data[index]['riskMeasureDesc'], style: TextStyle(color: Color(0xff7F8A9C))),
                                              ]),
                                        ),
                                        SizedBox(
                                          height: size.width * 16,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(fontSize: size.width * 24, fontWeight: FontWeight.w400),
                                              children: <InlineSpan>[
                                                TextSpan(text: '隐患排查内容：', style: TextStyle(color: Color(0xff333333))),
                                                TextSpan(text: data[index]['troubleshootContent'], style: TextStyle(color: Color(0xff7F8A9C))),
                                              ]),
                                        ),
                                        SizedBox(
                                          height: size.width * 16,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  )
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          print(deleteIds);
                        },
                        child: Container(
                          height: size.width * 80,
                          width: size.width * 680,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xff3074FF),
                            borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                          ),
                          child: Text(
                            "确认签字",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
        ),
      );
  }
}
