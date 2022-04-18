import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class RiskDetails extends StatefulWidget {
  RiskDetails(
      {this.accDataMap,
      this.strStartDateTime,
      this.endDates,
      this.investigationResults,
      this.status,
      this.sign,
      this.qrMessage});
  final Map accDataMap;
  final String strStartDateTime;
  final String endDates;
  final int investigationResults;
  final int status;
  final String sign;
  final String qrMessage;
  @override
  _RiskDetailsState createState() => _RiskDetailsState();
}

class _RiskDetailsState extends State<RiskDetails> {
  String title;
  int controlType;
  List detailsList = [];

  @override
  void initState() {
    super.initState();
    if (widget.qrMessage == null) {
      if (widget.accDataMap['oneId'] != null) {
        title = widget.accDataMap['riskPoint'];
      } else if (widget.accDataMap['twoId'] != null) {
        title = widget.accDataMap['riskUnit'];
      } else {
        title = widget.accDataMap['riskItem'];
      }
      if (widget.sign == 'risk') {
        controlType = null;
      } else {
        controlType = 2;
      }
    } else {
      title = '风险历史';
    }

    _getList();
  }

  _getList() {
    myDio
        .request(
            type: 'get',
            url: Interface.getRiskItemHistory,
            queryParameters: widget.qrMessage == null
                ? {
                    "current": 1,
                    "size": 1000,
                    "oneId": widget.accDataMap['oneId'] != null
                        ? widget.accDataMap['oneId']
                        : '',
                    "twoId": widget.accDataMap['twoId'] != null
                        ? widget.accDataMap['twoId']
                        : '',
                    "threeId": widget.accDataMap['threeId'] != null
                        ? widget.accDataMap['threeId']
                        : '',
                    "startDate": widget.strStartDateTime,
                    "endDate": widget.endDates,
                    "status": widget.status != -1
                        ? widget.status
                        : widget.investigationResults == 0
                            ? 4
                            : null,
                    "investigationResults": widget.investigationResults != -1
                        ? widget.investigationResults
                        : '',
                    "controlType": controlType,
                  }
                : {"current": 1, "size": 1000, "QRCode": widget.qrMessage})
        .then((value) {
      if (value != null) {
        detailsList = value['records'];
        setState(() {});
      }
    });
  }

  _getColor(int index) {
    switch (detailsList[index]['investigationResults']) {
      case 0:
        if (detailsList[index]['status'] == '逾期') {
          return Colors.transparent;
        } else {
          return Color(0xffCBCBCB);
        }
        break;
      case 1:
        if (detailsList[index]['status'] == '逾期') {
          return Colors.transparent;
        } else {
          return Color(0xffFBAB00);
        }
        break;
      case 2:
        if (detailsList[index]['status'] == '逾期') {
          return Colors.transparent;
        } else {
          return Color(0xffEB1111);
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MyAppbar(
      title: Text(
        title.toString(),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 36,
            color: Colors.white),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.width * 20),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 20),
                  color: Color(0xffCBCBCB),
                  width: size.width * 14,
                  height: size.width * 14,
                ),
                Text('无隐患'),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 20),
                  color: Color(0xffFBAB00),
                  width: size.width * 14,
                  height: size.width * 14,
                ),
                Text('一般隐患'),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 20),
                  color: Color(0xffEB1111),
                  width: size.width * 14,
                  height: size.width * 14,
                ),
                Text('重大隐患'),
              ],
            ),
          ),
          Container(
            color: Color(0xffECECEC),
            width: double.infinity,
            height: size.width * 42,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '点检人',
                  style: TextStyle(
                      color: Color(0xff424242), fontSize: size.width * 24),
                ),
                Text(
                  '所在工位',
                  style: TextStyle(
                      color: Color(0xff424242), fontSize: size.width * 24),
                ),
                Text(
                  '点检时间',
                  style: TextStyle(
                      color: Color(0xff424242), fontSize: size.width * 24),
                ),
                Text(
                  '点检项',
                  style: TextStyle(
                      color: Color(0xff424242), fontSize: size.width * 24),
                ),
                Text(
                  '点检状态',
                  style: TextStyle(
                      color: Color(0xff424242), fontSize: size.width * 24),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: detailsList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                          width: width / 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: _getColor(index),
                                    shape: BoxShape.circle),
                                width: size.width * 12,
                                height: size.width * 12,
                                margin: EdgeInsets.only(right: size.width * 5),
                              ),
                              Text(
                                detailsList[index]['reportingUser'],
                                style: TextStyle(
                                    color: Color(0xff424242),
                                    fontSize: size.width * 24),
                              ),
                            ],
                          )),
                      Container(
                        width: width / 5,
                        alignment: Alignment.center,
                        child: Text(
                          detailsList[index]['reportingDepartment'],
                          style: TextStyle(
                              color: Color(0xff424242),
                              fontSize: size.width * 24),
                        ),
                      ),
                      Container(
                        width: width / 5,
                        alignment: Alignment.center,
                        child: Text(
                          detailsList[index]['reportingTime'],
                          style: TextStyle(
                              color: Color(0xff424242),
                              fontSize: size.width * 24),
                        ),
                      ),
                      Container(
                        width: width / 5,
                        alignment: Alignment.center,
                        child: Text(
                          detailsList[index]['keyParameterIndex'],
                          style: TextStyle(
                              color: Color(0xff424242),
                              fontSize: size.width * 24),
                        ),
                      ),
                      Container(
                        width: width / 5,
                        alignment: Alignment.center,
                        child: Text(
                          detailsList[index]['status'],
                          style: TextStyle(
                              color: Color(0xff424242),
                              fontSize: size.width * 24),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
