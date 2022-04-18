import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

GlobalKey<_WorkListCommonPageState> workListglobalKey = GlobalKey();

class WorkListCommonPage extends StatefulWidget {
  WorkListCommonPage({this.title, this.id, this.throwFunc});
  final String title;
  final int id;
  final ThrowFunc throwFunc;
  @override
  _WorkListCommonPageState createState() => _WorkListCommonPageState();
}

class _WorkListCommonPageState extends State<WorkListCommonPage> {
  String title;
  List<HiddenDangerInterface> leftBarList = [];
  @override
  void initState() {
    super.initState();
    widget.throwFunc.detailInit(_getData);
  }

  _getData({dynamic argument}) {
    widget.throwFunc.run(argument: {'threeId': argument['id']});
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
        child: (index, riskFourList) => Card(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            riskFourList[index]['controlType'],
                            style: TextStyle(
                                color: Colors.white, fontSize: size.width * 20),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 20,
                        ),
                        Text(
                          riskFourList[index]['keyParameterIndex'],
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
                                      text: '管控措施：',
                                      style: TextStyle(
                                          color: Color(0xff3073FE),
                                          fontSize: size.width * 20,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: riskFourList[index]
                                                ['controlMeasures'],
                                            style: TextStyle(
                                                color: Color(0xff666666)))
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '管控手段：',
                                    style: TextStyle(
                                        color: Color(0xff3073FE),
                                        fontSize: size.width * 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    riskFourList[index]['controlMeans'],
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
                              fourId = riskFourList[index]['fourId'];
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                border: Border.all(
                                    width: size.width * 1,
                                    color: Color(0xff3073FE)),
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
        url: Interface.getListDayWorkFour,
        listParam: "records",
        throwFunc: widget.throwFunc,
        queryParameters: {'threeId': widget.id},
        method: "get");
  }
}
