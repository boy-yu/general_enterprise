import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

import '../../../../common/refreshList.dart';

class RiskCommonPage extends StatefulWidget {
  RiskCommonPage({this.title, this.id, this.throwFunc});
  final String title;
  final int id;
  final ThrowFunc throwFunc;
  @override
  _RiskCommonPageState createState() => _RiskCommonPageState();
}

class _RiskCommonPageState extends State<RiskCommonPage> {
  String title;
  List<HiddenDangerInterface> leftBarList = [];
  @override
  void initState() {
    super.initState();
    widget.throwFunc.init([_getData]);
  }

  _getData({dynamic argument}) {
    myDio.request(
        type: 'get',
        url: Interface.getListMajorFireEmergencyFour,
        queryParameters: {
          'threeId': argument['id'],
        }).then((value) {
      riskFourList = value['records'];
      if (mounted) {
        setState(() {});
      }
    });
  }

  List riskFourList = [
    {
      "fourId": -1,
      "controlMeasures": "",
      "keyParameterIndex": "",
      "controlType": "",
      "controlMeans": ""
    },
  ];

  int fourId = -1;

  @override
  Widget build(BuildContext context) {
    return MyRefres(
      child: (index, list) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 20),
              child: Row(
                children: [
                  Container(
                    width: size.width * 96,
                    height: size.width * 34,
                    decoration: BoxDecoration(
                      color: Color(0xff3073FE),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      list[index]['controlType'],
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 20),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 20,
                  ),
                  Text(
                    list[index]['keyParameterIndex'],
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 26,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              height: size.width * 1,
              width: double.infinity,
              color: Color(0xffEFEFEF),
            ),
            Padding(
                padding: EdgeInsets.all(size.width * 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 400,
                          child: RichText(
                            text: TextSpan(
                                text: list[index]['controlType'] == '巡检点检'
                                    ? '点检措施：'
                                    : '排查措施',
                                style: TextStyle(
                                    color: Color(0xff3073FE),
                                    fontSize: size.width * 20,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: list[index]['controlMeasures'],
                                      style:
                                          TextStyle(color: Color(0xff666666)))
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 20,
                        ),
                        Row(
                          children: [
                            Text(
                              list[index]['controlType'] == '巡检点检'
                                  ? '点检手段：'
                                  : '排查手段',
                              style: TextStyle(
                                  color: Color(0xff3073FE),
                                  fontSize: size.width * 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              list[index]['controlMeans'],
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        fourId = list[index]['fourId'];
                        Navigator.pushNamed(context, '/home/myLedger', arguments: {
                          'fourId': fourId,
                          'controlType': 0,
                        });
                      },
                      child: Container(
                        width: size.width * 70,
                        height: size.width * 34,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: Border.all(
                              width: size.width * 1, color: Color(0xff3073FE)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '台账',
                          style: TextStyle(
                              color: Color(0xff367AFF),
                              fontSize: size.width * 22),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
      url: Interface.getListMajorFireEmergencyFour,
      method: "get",
      throwFunc: widget.throwFunc,
      listParam: "records",
      queryParameters: {
        'threeId': widget.id,
        'type': 1,
      },
    );
  }
}
