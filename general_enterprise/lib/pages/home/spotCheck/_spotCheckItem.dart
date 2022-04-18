import 'package:enterprise/pages/home/spotCheck/_spotCheckCircle.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

/*
 *  巡检点检风险单元/巡检点检风险项 列表
 *  type ： 'unit' = 巡检点检风险单元
 *          'item' = 巡检点检风险项
 */
// ignore: must_be_immutable
class SpotCheckItems extends StatelessWidget {
  final double width;
  final Map spotCheckData;
  final int index;
  final String type;
  SpotCheckItems(
      {Key key, this.width, this.spotCheckData, this.index, this.type})
      : super(key: key);

  String _getText() {
    String text;
    if (spotCheckData["twoId"] != null) {
      text = spotCheckData["riskUnit"].toString().length > 2 ? spotCheckData["riskUnit"].toString().substring(0, 2) : spotCheckData["riskUnit"].toString();
    } else if (spotCheckData["threeId"] != null) {
      text = spotCheckData["riskItem"].toString().length > 2 ? spotCheckData["riskItem"].toString().substring(0, 2) : spotCheckData["riskItem"].toString();
    } else {
      text = spotCheckData["riskPoint"].toString().length > 2 ? spotCheckData["riskPoint"].toString().substring(0, 2) : spotCheckData["riskPoint"].toString();
    }
    return text;
  }

  String layer;

  getValue() {
    int value;
    if (spotCheckData['totalNum'] == 0 ||
        spotCheckData['totalNum'] == null ||
        spotCheckData['uncontrolledNum'] == null) {
      value = 10;
    } else {
      value = 10 -
          (((spotCheckData['totalNum'] -
                      spotCheckData['uncontrolledNum']) /
                  spotCheckData['totalNum'] *
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
                  SpotCheckCircle(
                    width: size.width * 50,
                    radius: 18,
                    fontsize: size.width * 20,
                    text: _getText(),
                    level: spotCheckData['riskLevel'],
                    initialSpotCheckLevel: spotCheckData
                        ['initialRiskLevel'],
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
                              ? '${spotCheckData['riskUnit']}'
                              : '${spotCheckData['riskItem']}',
                          style: TextStyle(
                              color: Color(0xff343434),
                              fontSize: size.width * 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      type == "unit"
                          ? Container()
                          : spotCheckData['controlOperable'] == 1
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
                          if(spotCheckData['twoId'] != null){
                            Navigator.pushNamed(context, '/home/myLedger', arguments: {
                              'twoId': spotCheckData['twoId'],
                              'controlType': 2,
                            });
                          }else if(spotCheckData['threeId'] != null){
                            Navigator.pushNamed(context, '/home/myLedger', arguments: {
                              'threeId': spotCheckData['threeId'],
                              'controlType': 2,
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
                                    spotCheckData['totalNum'].toString(),
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: size.width * 22),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  '点检条目',
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
                                    (spotCheckData['totalNum'] -
                                            spotCheckData
                                                ['uncontrolledNum'])
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
                                    spotCheckData['uncontrolledNum']
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
                            "${spotCheckData['riskDescription']}",
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
