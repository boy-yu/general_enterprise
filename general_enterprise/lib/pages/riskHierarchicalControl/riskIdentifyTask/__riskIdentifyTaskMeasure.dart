import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';

class RiskIdentifyTaskMeasure extends StatefulWidget {
  RiskIdentifyTaskMeasure({this.leftBarList, this.index});
  final List leftBarList;
  final int index;
  @override
  State<RiskIdentifyTaskMeasure> createState() => _RiskIdentifyTaskMeasureState();
}

class _RiskIdentifyTaskMeasureState extends State<RiskIdentifyTaskMeasure> {
  ThrowFunc _throwFunc = new ThrowFunc();

  int leftBarIndex = 0;

  @override
  void initState() {
    super.initState();
    leftBarIndex = widget.index;
  }

  List data = [
    {
      "riskMeasure": "这是措施1",
      "controlMode": "隐患排查",
      "controlClassify1": "维护保养",
      "controlClassify2": "XXXXXX",
      "controlClassify3": "XXXXXXXXXXXX",
      "troubleshootContent": '隐患排查内容隐患排查内容隐患排查内容隐患排查内容'
    },
    {
      "riskMeasure": "这是XXXXXXXXX措施2",
      "controlMode": "隐患排查",
      "controlClassify1": "维护保养",
      "controlClassify2": "XXXXXX",
      "controlClassify3": "XXXXXXXXXXXX",
      "troubleshootContent": '隐患排查内容隐患排查内容隐患排查内容隐患排查内容'
    },
    {
      "riskMeasure": "这是XXXXXXXXX措施3",
      "controlMode": "隐患排查",
      "controlClassify1": "维护保养",
      "controlClassify2": "XXXXXX",
      "controlClassify3": "XXXXXXXXXXXX",
      "troubleshootContent": '隐患排查内容隐患排查内容隐患排查内容隐患排查内容'
    },
    {
      "riskMeasure": "这是XXXXXXXXX措施4",
      "controlMode": "隐患排查",
      "controlClassify1": "维护保养",
      "controlClassify2": "XXXXXX",
      "controlClassify3": "XXXXXXXXXXXX",
      "troubleshootContent": '隐患排查内容隐患排查内容隐患排查内容隐患排查内容'
    },
    {
      "riskMeasure": "这是XXXXXXXXX措施5",
      "controlMode": "隐患排查",
      "controlClassify1": "维护保养",
      "controlClassify2": "XXXXXX",
      "controlClassify3": "XXXXXXXXXXXX",
      "troubleshootContent": '隐患排查内容隐患排查内容隐患排查内容隐患排查内容'
    },
    {
      "riskMeasure": "这是XXXXXXXXX措施6",
      "controlMode": "隐患排查",
      "controlClassify1": "维护保养",
      "controlClassify2": "XXXXXX",
      "controlClassify3": "XXXXXXXXXXXX",
      "troubleshootContent": '隐患排查内容隐患排查内容隐患排查内容隐患排查内容'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(
        "风险管控措施",
        style: TextStyle(fontSize: size.width * 32),
      ),
      child: Row(children: [
        Container(
          color: Colors.white,
          width: size.width * 240,
          child: ListView.builder(
              itemCount: widget.leftBarList.length,
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
                          child: Text(widget.leftBarList[index]['riskIncident'],
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
              onTap: () {
                Navigator.pushNamed(
                    context, 
                    '/riskIdentifyTask/riskHiddenTask',
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
                          offset: Offset(1.0, 2.0),
                          color: Color(0xff7F8A9C).withOpacity(0.05),
                          spreadRadius: 1.0,
                          blurRadius: 1.0)
                    ]),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff5FD5EC).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 16))),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 20,
                          vertical: size.width * 16),
                      child: Text(
                        list[index]['riskMeasure'],
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            right: size.width * 20,
                            left: size.width * 20,
                            top: size.width * 16,
                            bottom: size.width * 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '管控方式：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['controlMode'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
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
                                        text: '管控措施分类1：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['controlClassify1'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
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
                                        text: '管控措施分类2：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['controlClassify2'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
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
                                        text: '管控措施分类3：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['controlClassify3'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
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
                                        text: '隐患排查内容：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['troubleshootContent'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                          ],
                        ))
                  ],
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
            throwFunc: _throwFunc,
            data: data,
          ),
        ))
      ]),
      actions: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(
              context, 
              '/riskIdentifyTask/addControlMeasure'
            ).then((value) => {
              _throwFunc.run()
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff1E62EB),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 40))
            ),
            padding: EdgeInsets.symmetric(horizontal: size.width * 20),
            margin: EdgeInsets.only(top: size.width * 30, bottom: size.width * 10, right: size.width * 30),
            alignment: Alignment.center,
            child: Text(
              "+ 新增",
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        )
      ],
    );
  }
}