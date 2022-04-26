import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class RiskIdentifyTask extends StatefulWidget {
  @override
  State<RiskIdentifyTask> createState() => _RiskIdentifyTaskState();
}

class _RiskIdentifyTaskState extends State<RiskIdentifyTask> {
  int leftBarIndex = 0;

  List leftBarList = [
    {"riskObject": "风险分析对象1风险分析对象1风险分析对象1风险分析对象1"},
    {"riskObject": "风险分析对象2"},
    {"riskObject": "风险分析对象3"},
    {"riskObject": "风险分析对象4"},
    {"riskObject": "风险分析对象5"},
    {"riskObject": "风险分析对象6"},
    {"riskObject": "风险分析对象7"},
    {"riskObject": "风险分析对象8"},
  ];

  List data = [
    {
      "riskUnit": "风险单元1风险单元1风险单元1风险单元1风险单元1",
      "type": "其他伤害其他伤害其他伤害其他伤害其他伤害"
    },
    {"riskUnit": "风险单元2", "type": "其他伤害"},
    {"riskUnit": "风险单元3", "type": "其他伤害"},
    {"riskUnit": "风险单元4", "type": "其他伤害"},
    {"riskUnit": "风险单元5", "type": "其他伤害"},
    {"riskUnit": "风险单元6", "type": "其他伤害"},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.white,
          width: size.width * 240,
          child: ListView.builder(
              itemCount: leftBarList.length,
              padding: EdgeInsets.only(top: size.width * 20),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    leftBarIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    height: size.width * 88,
                    width: size.width * 240,
                    alignment: Alignment.centerLeft,
                    color: index == leftBarIndex
                        ? Color(0xffF8FAFF)
                        : Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: size.width * 48,
                          width: size.width * 12,
                          decoration: BoxDecoration(
                            color: index == leftBarIndex
                                ? Color(0xffFF943D)
                                : Colors.transparent,
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(size.width * 24)),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 20,
                        ),
                        Container(
                          width: size.width * 200,
                          child: Text(leftBarList[index]['riskObject'],
                              style: TextStyle(
                                  color: index == leftBarIndex
                                      ? Color(0xff333333)
                                      : Color(0xff7F8A9C),
                                  fontSize: size.width * 28,
                                  fontWeight: index == leftBarIndex
                                      ? FontWeight.w500
                                      : FontWeight.w400),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
        Expanded(
            child: Container(
          color: Color(0xffF8FAFF),
          child: MyRefres(
            child: (index, list) => GestureDetector(
                onTap: (){
                  Navigator.pushNamed(
                    context, 
                    '/riskIdentifyTask/riskIdentifyTaskIncident',
                    arguments: {
                      'index': index,
                      'data': list
                    }
                  );
                },
                child: Container(
                margin: EdgeInsets.only(
                    left: size.width * 16,
                    right: size.width * 20,
                    top: size.width * 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * 16),
                        bottomLeft: Radius.circular(size.width * 16),
                        bottomRight: Radius.circular(size.width * 16)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff7F8A9C).withOpacity(0.05),
                          spreadRadius: size.width * 2,
                          blurRadius: size.width * 8)
                    ]
                    ),
                alignment: Alignment.centerLeft,
                child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xffFFCA0E).withOpacity(0.12),
                            Colors.transparent,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size.width * 16),
                        bottomLeft: Radius.circular(size.width * 16),
                        bottomRight: Radius.circular(size.width * 16)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 16),
                      child: Text(
                        list[index]['riskUnit'],
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
              ),
            ),
            // page: true,
            // url: Interface.getHistoricalSubscribe,
            // listParam: "records",
            // queryParameters: {
            //   'type': 2,
            // },
            // method: 'get'
            data: data,
          ),
        ))
        // Container(
        //   color: Color(0xffF8FAFF),
        //   child:
        // )
      ],
    );
  }
}
