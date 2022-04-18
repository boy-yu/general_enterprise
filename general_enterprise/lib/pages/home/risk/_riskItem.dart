import 'package:enterprise/pages/home/risk/_riskCircle.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

/*
 *  风险单元/风险项 列表
 *  type ： 'unit' = 风险单元
 *          'item' = 风险项
 */
// ignore: must_be_immutable
class RiskItems extends StatelessWidget {
  final double width;
  final List riskData;
  final int index;
  final String type;
  RiskItems({Key key, this.width, this.riskData, this.index, this.type})
      : super(key: key);

  String _getText() {
    String text;
    if (riskData[index]["twoId"] != null) {
      text = riskData[index]["riskUnit"].toString().substring(0, 2);
    } else if (riskData[index]["threeId"] != null) {
      text = riskData[index]["riskItem"].toString().substring(0, 2);
    } else {
      text = riskData[index]["riskPoint"].toString().substring(0, 2);
    }
    return text;
  }

  String layer;

  getValue() {
    int value;
    if (riskData[index]['totalNum'] == 0 ||
        riskData[index]['totalNum'] == null ||
        riskData[index]['uncontrolledNum'] == null) {
      value = 10;
    } else {
      value = 10 -
          (((riskData[index]['totalNum'] - riskData[index]['uncontrolledNum']) /
                  riskData[index]['totalNum'] *
                  10)
              .toInt()
              .abs());
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    if (type == 'unit') {
      layer = 'unit';
    } else {
      layer = 'item';
    }
    return Card(
      child: Container(
          margin: EdgeInsets.only(
              top: width * 20,
              left: width * 50,
              bottom: size.width * 20,
              right: size.width * 20),
          child: Column(
            children: [
              Row(
                children: [
                  RiskCircle(
                    width: size.width * 50,
                    radius: 18,
                    fontsize: size.width * 20,
                    text: _getText(),
                    level: riskData[index]['riskLevel'],
                    initialRiskLevel: riskData[index]['initialRiskLevel'],
                    value: getValue(),
                  ),
                  SizedBox(
                    width: size.width * 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 380 - width * 90,
                        child: Text(
                          type == "unit"
                              ? '${riskData[index]['riskUnit']}'
                              : '${riskData[index]['riskItem']}',
                          style: TextStyle(
                              color: Color(0xff343434),
                              fontSize: size.width * 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      type == "unit"
                          ? Container()
                          : riskData[index]['controlOperable'] == 1
                              ? Container(
                                  margin: EdgeInsets.only(top: size.width * 25),
                                  child: Text(
                                    '待管控',
                                    style: TextStyle(
                                        color: Color(0xff367AFF),
                                        fontSize: size.width * 22),
                                  ),
                                )
                              : Container(),
                    ],
                  ),
                  Spacer(),
                  PopupMenuButton(
                      onSelected: (String value) {
                        if (value == '台账') {
                          if(riskData[index]['twoId'] != null){
                            Navigator.pushNamed(context, '/home/myLedger', arguments: {
                              'twoId': riskData[index]['twoId'],
                              'controlType': 0,
                            });
                          }else if(riskData[index]['threeId'] != null){
                            Navigator.pushNamed(context, '/home/myLedger', arguments: {
                              'threeId': riskData[index]['threeId'],
                              'controlType': 0,
                            });
                          }
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuItem<String>>[
                            PopupMenuItem(
                                value: "编辑",
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/icon_risk_item_edit.png",
                                      width: size.width * 24,
                                      height: size.width * 24,
                                    ),
                                    SizedBox(
                                      width: size.width * 20,
                                    ),
                                    Text(
                                      '编辑',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 22),
                                    )
                                  ],
                                )),
                            PopupMenuItem(
                                value: "删除",
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/icon_risk_item_del.png",
                                      width: size.width * 24,
                                      height: size.width * 24,
                                    ),
                                    SizedBox(
                                      width: size.width * 20,
                                    ),
                                    Text(
                                      '删除',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 22),
                                    )
                                  ],
                                )),
                            PopupMenuItem(
                                value: "台账",
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/icon_risk_account.png",
                                      width: size.width * 24,
                                      height: size.width * 24,
                                    ),
                                    SizedBox(
                                      width: size.width * 20,
                                    ),
                                    Text(
                                      '台账',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 22),
                                    )
                                  ],
                                ))
                          ]),
                ],
              ),
              type == "unit"
                  ? Container()
                  : Divider(
                      color: Color(0xffEFEFEF),
                    ),
              type == "unit"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: size.width * 34,
                                  minHeight: size.width * 34,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 2),
                                decoration: BoxDecoration(
                                  color: Color(0xffFF4040),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    riskData[index]['totalNum'].toString(),
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: size.width * 22),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  '管控项',
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontSize: size.width * 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: size.width * 34,
                                  minHeight: size.width * 34,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 2),
                                decoration: BoxDecoration(
                                  color: Color(0xff00C621),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    (riskData[index]['totalNum'] -
                                            riskData[index]['uncontrolledNum'])
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: size.width * 22),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  '受控项',
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontSize: size.width * 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: size.width * 34,
                                  minHeight: size.width * 34,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 2),
                                decoration: BoxDecoration(
                                  color: Color(0xffFAD400),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    riskData[index]['uncontrolledNum']
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: size.width * 22),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  '不受控',
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontSize: size.width * 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "风险描述：",
                          style: TextStyle(
                              color: Color(0xff656565), fontSize: width * 22),
                        ),
                        Container(
                          width: width * 440 - width * 60,
                          child: Text(
                            "${riskData[index]['riskDescription']}",
                            style: TextStyle(
                                color: Color(0xff656565), fontSize: width * 22),
                          ),
                        ),
                      ],
                    ))
            ],
          )),
    );
  }
}
