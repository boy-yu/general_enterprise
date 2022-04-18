import 'package:enterprise/common/Refre.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RiskFour extends StatefulWidget {
  RiskFour({this.title, this.id, this.leftBar, this.qrMessage});
  final String title;
  final int id;
  final List<HiddenDangerInterface> leftBar;
  final String qrMessage;
  @override
  _RiskFourState createState() => _RiskFourState();
}

class _RiskFourState extends State<RiskFour> {
  String title;
  List<HiddenDangerInterface> leftBarList = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    title = widget.title;
    leftBarList = widget.leftBar ?? [];
    for (var i = 0; i < leftBarList.length; i++) {
      if (leftBarList[i].title == title) {
        leftBarList[i].color = Colors.white;
      } else {
        leftBarList[i].color = Colors.transparent;
      }
    }
    if (widget.id is int) {
      _getRiskFourList();
    } else if (widget.qrMessage is String) {
      _getRiskFourList();
    } else {
      Fluttertoast.showToast(msg: "id不能为空，请联系开发人员");
    }
  }

  Future _getRiskFourList({int id, String classification}) async {
    var value;

    if (widget.qrMessage is String) {
      value = await myDio.request(
          type: 'get',
          url: Interface.getSpotFourList,
          queryParameters: {
            "current": 1,
            "size": 1000,
            "QRCode": widget.qrMessage
          });
    } else {
      value = await myDio.request(
          type: 'get',
          url: Interface.getSpotFourList,
          queryParameters: {
            "current": 1,
            "size": 1000,
            "threeId": id ?? widget.id,
            "classification": classification ?? widget.title,
          });
    }

    if (value != null) {
      riskFourList = value['records'];
      total = value['total'];
      if (mounted) {
        setState(() {});
      }
    }
    return Future.value();
  }

  int total = 0;
  int fourId = -1;
  List riskFourList = [
    {
      "controlMeasures": "",
      "keyParameterIndex": "",
      "controlOperable": 0,
      "id": 11208,
      "controlType": "",
      "controlMeans": "",
      "status": 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: Text(
        title.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 36,
            color: Colors.white),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 50),
            width: widghtSize.width - 50,
            height: widghtSize.height,
            child: Refre(
                child: (child, state, end, updata) => Column(
                      children: [
                        child,
                        Expanded(
                            child: ListView(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.width * 20,
                              ),
                              child: Card(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(size.width * 25),
                                      child: Image.asset(
                                        "assets/images/icon_prodect_notice.png",
                                        width: size.width * 28,
                                        height: size.width * 28,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 1,
                                      height: size.width * 43,
                                      color: Color(0xffDBDBDB),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(size.width * 20),
                                      decoration: BoxDecoration(
                                          color: Color(0xff3073FE),
                                          shape: BoxShape.circle),
                                      width: size.width * 12,
                                      height: size.width * 12,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '此风险下包含',
                                          style: TextStyle(
                                              color: Color(0xff656565),
                                              fontSize: size.width * 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: size.width * 5,
                                        ),
                                        Text(total.toString(),
                                            style: TextStyle(
                                                color: Color(0xff3073FE),
                                                fontSize: size.width * 30,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: size.width * 5,
                                        ),
                                        Text(
                                          '个管控措施',
                                          style: TextStyle(
                                              color: Color(0xff656565),
                                              fontSize: size.width * 30,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ListView.builder(
                                itemCount: riskFourList.length,
                                shrinkWrap: true, //解决无限高度问题
                                physics:
                                    NeverScrollableScrollPhysics(), //禁用滑动事件
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.all(size.width * 20),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: size.width * 96,
                                                height: size.width * 34,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff3073FE),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4.0)),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  riskFourList[index]
                                                      ['controlType'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 20,
                                              ),
                                              Text(
                                                riskFourList[index]
                                                    ['keyParameterIndex'],
                                                style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: size.width * 26,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            padding:
                                                EdgeInsets.all(size.width * 20),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: size.width * 400,
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text: '管控措施：',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff3073FE),
                                                                fontSize:
                                                                    size.width *
                                                                        20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            children: [
                                                              TextSpan(
                                                                  text: riskFourList[
                                                                          index]
                                                                      [
                                                                      'controlMeasures'],
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff666666)))
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
                                                              color: Color(
                                                                  0xff3073FE),
                                                              fontSize:
                                                                  size.width *
                                                                      20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          riskFourList[index]
                                                              ['controlMeans'],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff333333),
                                                              fontSize:
                                                                  size.width *
                                                                      20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    fourId = riskFourList[index]['id'];
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
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                      border: Border.all(
                                                          width: size.width * 1,
                                                          color: Color(
                                                              0xff3073FE)),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '台账',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff367AFF),
                                                          fontSize:
                                                              size.width * 22),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ))
                      ],
                    ),
                onRefresh: _getRiskFourList),
          ),
          // left
          LeftBar(
            iconList: leftBarList,
            callback: (int index) {
              _getRiskFourList(
                  id: leftBarList[index].id,
                  classification: leftBarList[index].title);
              title = leftBarList[index].title;
              context.read<Counter>().refreshFun(true);
            },
          )
        ],
      ),
    );
  }
}
