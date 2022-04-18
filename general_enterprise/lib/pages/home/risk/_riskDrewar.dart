import 'package:enterprise/pages/home/risk/_riskCircle.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class RiskDrewar extends StatefulWidget {
  final double width;
  final List riskunitList;
  final int select;
  const RiskDrewar(
      {Key key, this.width, this.riskunitList, this.type, this.callback, this.select})
      : super(key: key);
  // const RiskDrewar({Key key, this.width}) : super(key: key);
  final String type;
  final Function callback;
  @override
  _RiskDrewarState createState() => _RiskDrewarState();
}

class _RiskDrewarState extends State<RiskDrewar> {
  _getText(int index) {
    String text;
    if (widget.riskunitList[index]["twoId"] != null) {
      text = widget.riskunitList[index]["riskUnit"].toString().substring(0, 2);
    } else if (widget.riskunitList[index]["threeId"] != null) {
      text = widget.riskunitList[index]["riskItem"].toString().substring(0, 2);
    } else {
      text = widget.riskunitList[index]["riskPoint"].toString().substring(0, 2);
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.width * 20, left: size.width * 20, right: size.width * 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.type == 'riskItem'
                    ? Text(
                        '风险事件选择',
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 26,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        '风险分析单元选择',
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 26,
                            fontWeight: FontWeight.bold),
                      ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: size.width * 90,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/images/hidden_close.png',
                                width: size.width * 26, height: size.width * 26),
                            Text(
                              "收起",
                              style: TextStyle(fontSize: size.width * 16),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.riskunitList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      widget.callback(index);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: size.width * 20, bottom: size.width * 30, top: size.width * 30),
                      color: widget.select == index ? Colors.white : Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                            child: RiskCircle(
                              width: size.width * 40,
                              radius: 15,
                              fontsize: 8,
                              text: _getText(index),
                              value: widget.riskunitList[index]['totalNum'] == 0
                                  ? 10
                                  : 10 -
                                      ((widget.riskunitList[index]['totalNum'] -
                                                  widget.riskunitList[index]
                                                      ['uncontrolledNum']) /
                                              widget.riskunitList[index]
                                                  ['totalNum'] *
                                              10)
                                          .toInt(),
                              level: widget.riskunitList[index]['riskLevel'],
                              initialRiskLevel: widget.riskunitList[index]
                                  ['initialRiskLevel'],
                            ),
                          ),
                          Text(
                            widget.type == 'riskItem'
                                ? "${widget.riskunitList[index]['riskUnit']}"
                                : "${widget.riskunitList[index]['riskPoint']}",
                            style: TextStyle(
                                fontSize: size.width * 20,
                                color: Color(0xff343434)),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
