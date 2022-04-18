import 'package:enterprise/pages/home/risk/_riskCircle.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

/*
 *  风险分析对象列表 
 */
class RiskHomeItem extends StatelessWidget {
  final List riskData;
  final int index;
  const RiskHomeItem({Key key, this.riskData, this.index}) : super(key: key);

  _getText(int index) {
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
    return Card(
      margin: EdgeInsets.fromLTRB(
          size.width * 30, size.width * 30, size.width * 30, 0),
      child: Padding(
        padding: EdgeInsets.all(size.width * 20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '风险分析对象：',
                  style: TextStyle(
                      color: Color(0xff343434),
                      fontSize: size.width * 26,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  riskData[index]['riskPoint'],
                  style: TextStyle(
                      color: Color(0xff343434),
                      fontSize: size.width * 26,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    print(riskData[index]['oneId']);
                    Navigator.pushNamed(context, '/home/myLedger', arguments: {
                      'oneId': riskData[index]['oneId'],
                      'controlType': 0,
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.width * 46,
                    width: size.width * 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(width: 1, color: Color(0xff2A60F7)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icon_risk_account.png",
                          width: size.width * 26,
                          height: size.width * 26,
                        ),
                        SizedBox(
                          width: size.width * 10,
                        ),
                        Text(
                          '台账',
                          style: TextStyle(
                              color: Color(0xff2A60F7),
                              fontSize: size.width * 22),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: size.width * 20, bottom: size.width * 10),
              width: double.infinity,
              height: size.width * 1,
              color: Color(0xffEFEFEF),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 20,
                      top: size.width * 20,
                      right: size.width * 40,
                      bottom: size.width * 20),
                  child: RiskCircle(
                    width: size.width * 60,
                    radius: 20,
                    fontsize: size.width * 20,
                    text: _getText(index),
                    value: getValue(),
                    level: riskData[index]['riskLevel'],
                    initialRiskLevel: riskData[index]['initialRiskLevel'],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '责任部门：',
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 24,
                          ),
                        ),
                        Text(
                          riskData[index]['responsibleDepartment'],
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '责任人：',
                          style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: size.width * 24),
                        ),
                        Text(
                          riskData[index]['personLiable'],
                          style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: size.width * 24),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                // 注释编辑删除功能 以后需要用
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/icon_risk_item_edit.png",
                            width: size.width * 24,
                            height: size.width * 24,
                          ),
                          SizedBox(
                            width: size.width * 5,
                          ),
                          Text(
                            '编辑',
                            style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: size.width * 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.width * 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/icon_risk_item_del.png",
                            width: size.width * 24,
                            height: size.width * 24,
                          ),
                          SizedBox(
                            width: size.width * 5,
                          ),
                          Text(
                            '删除',
                            style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: size.width * 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
