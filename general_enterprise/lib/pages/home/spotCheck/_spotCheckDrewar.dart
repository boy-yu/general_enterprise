import 'package:enterprise/pages/home/spotCheck/_spotCheckCircle.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class SpotCheckDrewar extends StatefulWidget {
  final double width;
  final List spotCheckUnitList;
  final int select;
  const SpotCheckDrewar(
      {Key key, this.width, this.spotCheckUnitList, this.type, this.callback, this.select})
      : super(key: key);
  final String type;
  final Function callback;
  @override
  _SpotCheckDrewarState createState() => _SpotCheckDrewarState();
}

class _SpotCheckDrewarState extends State<SpotCheckDrewar> {
  _getText(int index) {
    String text;
    if (widget.spotCheckUnitList[index]["twoId"] != null) {
      text = widget.spotCheckUnitList[index]["riskUnit"].toString().substring(0, 2);
    } else if (widget.spotCheckUnitList[index]["threeId"] != null) {
      text = widget.spotCheckUnitList[index]["riskItem"].toString().substring(0, 2);
    } else {
      text = widget.spotCheckUnitList[index]["riskPoint"].toString().substring(0, 2);
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
                widget.type == 'spotCheckItem' ? 
                Text(
                  '巡检风险事件选择',
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: size.width * 26,
                    fontWeight: FontWeight.bold
                  ),
                )
                : Text(
                  '巡检风险分析单元选择',
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: size.width * 26,
                    fontWeight: FontWeight.bold
                  ),
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
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.spotCheckUnitList.length, 
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      widget.callback(index);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: size.width * 20, bottom: size.width * 30, top: size.width * 30),
                      color: widget.select == index ? Colors.white : Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                            child: SpotCheckCircle(
                              width: size.width * 40,
                              radius: 15,
                              fontsize: 8,
                              text: _getText(index),
                              value: widget.spotCheckUnitList[index]['totalNum'] == 0
                                  ? 10
                                  : 10 -
                                      ((widget.spotCheckUnitList[index]['totalNum'] -
                                                  widget.spotCheckUnitList[index]
                                                      ['uncontrolledNum']) /
                                              widget.spotCheckUnitList[index]
                                                  ['totalNum'] *
                                              10)
                                          .toInt(),
                              level: widget.spotCheckUnitList[index]['riskLevel'],
                              initialSpotCheckLevel: widget.spotCheckUnitList[index]
                                  ['initialRiskLevel'],
                            ),
                          ),
                          Text(
                            widget.type == 'spotCheckItem'
                                ? "${widget.spotCheckUnitList[index]['riskUnit']}"
                                : "${widget.spotCheckUnitList[index]['riskPoint']}",
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