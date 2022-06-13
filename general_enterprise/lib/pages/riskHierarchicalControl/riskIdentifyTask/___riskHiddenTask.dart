import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class RiskHiddenTask extends StatefulWidget {
  RiskHiddenTask({this.leftBarList, this.index});
  final List leftBarList;
  final int index;
  @override
  State<RiskHiddenTask> createState() => _RiskHiddenTaskState();
}

class _RiskHiddenTaskState extends State<RiskHiddenTask> {
  ThrowFunc _throwFunc = new ThrowFunc();
  Map _queryParameters;

  int leftBarIndex = 0;

  @override
  void initState() {
    super.initState();
    leftBarIndex = widget.index;
    _queryParameters = {
      'riskMeasureId': widget.leftBarList[leftBarIndex]['id']
    };
  }

  String _getCheckMeans(String checkMeans) {
    switch (checkMeans) {
      case '0':
        return '现场确认';
        break;
      case '1':
        return '拍照';
        break;
      case '2':
        return '热成像';
        break;
      case '3':
        return '震动';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_queryParameters);
    return MyAppbar(
      title: Text(
        "隐患排查内容",
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
                    _queryParameters = {
                      'riskMeasureId': widget.leftBarList[leftBarIndex]['id']
                    };
                    _throwFunc.run(argument: _queryParameters);
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
                          child: Text(
                              widget.leftBarList[index]['riskMeasureDesc']
                                  .toString(),
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
              onTap: () {},
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
                              Color(0xff2276FC).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.width * 16))),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 20,
                          vertical: size.width * 16),
                      child: Text(
                        list[index]['troubleshootContent'].toString(),
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
                                        text: '巡检周期：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text:
                                            '${list[index]['checkCycle']}/${list[index]['checkCycleUnit']}',
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w400),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: '管控手段：',
                                            style: TextStyle(
                                                color: Color(0xff333333))),
                                        TextSpan(
                                            text: _getCheckMeans(
                                                list[index]['checkMeans']),
                                            style: TextStyle(
                                                color: Color(0xff7F8A9C))),
                                      ]),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        '/riskIdentifyTask/addHiddenTask',
                                        arguments: {
                                          'eventMap': list[index],
                                          'type': '修改'
                                        }).then((value) => {_throwFunc.run()});
                                  },
                                  child: Container(
                                    width: size.width * 40,
                                    height: size.width * 40,
                                    padding: EdgeInsets.all(size.width * 8),
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xff3074FF).withOpacity(0.15),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Image.asset(
                                      'assets/images/doubleRiskProjeck/icon_risk_put.png',
                                      width: size.width * 24,
                                      height: size.width * 24,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            url: Interface.getRiskTemplateFiveWarehouseAll,
            queryParameters: _queryParameters,
            method: 'get',
            throwFunc: _throwFunc,
          ),
        ))
      ]),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/riskIdentifyTask/addHiddenTask',
                arguments: {
                  'riskMeasureId': widget.leftBarList[leftBarIndex]['id']
                }).then((value) => {_throwFunc.run()});
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xff1E62EB),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 40))),
            padding: EdgeInsets.symmetric(horizontal: size.width * 20),
            margin: EdgeInsets.only(
                top: size.width * 30,
                bottom: size.width * 10,
                right: size.width * 30),
            alignment: Alignment.center,
            child: Text(
              "+ 新增",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 28,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}
