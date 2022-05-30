import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class RiskIdentifyTaskMeasure extends StatefulWidget {
  RiskIdentifyTaskMeasure({this.leftBarList, this.index});
  final List leftBarList;
  final int index;
  @override
  State<RiskIdentifyTaskMeasure> createState() =>
      _RiskIdentifyTaskMeasureState();
}

class _RiskIdentifyTaskMeasureState extends State<RiskIdentifyTaskMeasure> {
  ThrowFunc _throwFunc = new ThrowFunc();
  Map _queryParameters;

  int leftBarIndex = 0;

  @override
  void initState() {
    super.initState();
    leftBarIndex = widget.index;
    _queryParameters = {'riskEventId': widget.leftBarList[leftBarIndex]['id']};
  }

  String _getClassify1(String classify1) {
    // 工程技术：1；维护保养：2；操作行为：3；应急措施：4
    switch (classify1) {
      case '1':
        return '工程技术';
        break;
      case '2':
        return '维护保养';
        break;
      case '3':
        return '操作行为';
        break;
      case '4':
        return '应急措施';
        break;
      default:
        return '';
    }
  }

  String _getClassify2(String classify2) {
    // 工艺控制:1-1；关键设备/部件：1-2；安全附件：1-3；安全仪表：1-4；其它：1-5；
    // 动设备：2-1；静设备：2-2；其它：2-3；
    // 人员资质：3-1；操作记录：3-2；交接班：3-3；其他：3-4；
    // 应急设施:4-1；个体防护：4-2；消防设施：4-3；应急预案：4-4；其它：4-5；
    switch (classify2) {
      case '1-1':
        return '工艺控制';
        break;
      case '1-2':
        return '关键设备/部件';
        break;
      case '1-3':
        return '安全附件';
        break;
      case '1-4':
        return '安全仪表';
        break;
      case '1-5':
        return '其它';
        break;
      case '2-1':
        return '动设备';
        break;
      case '2-2':
        return '静设备';
        break;
      case '2-3':
        return '其它';
        break;
      case '3-1':
        return '人员资质';
        break;
      case '3-2':
        return '操作记录';
        break;
      case '3-3':
        return '交接班';
        break;
      case '3-4':
        return '其他';
        break;
      case '4-1':
        return '应急设施';
        break;
      case '4-2':
        return '个体防护';
        break;
      case '4-3':
        return '消防设施';
        break;
      case '4-4':
        return '应急预案';
        break;
      case '4-5':
        return '其它';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(
        "风险管控措施",
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
                      'riskEventId': widget.leftBarList[leftBarIndex]['id']
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
                              widget.leftBarList[index]['riskEventName'],
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
              onTap: () {
                Navigator.pushNamed(context, '/riskIdentifyTask/riskHiddenTask',
                    arguments: {'index': index, 'data': list});
              },
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
                        list[index]['riskMeasureDesc'],
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
                                        text: '管控方式：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['dataSrc'] == "2"
                                            ? '隐患排查'
                                            : '自动化监控',
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '管控措施分类1：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text:  _getClassify1(list[index]['classify1']),
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '管控措施分类2：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: _getClassify2(list[index]['classify2']),
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '管控措施分类3：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]['classify3'] == ''
                                            ? '无'
                                            : list[index]['classify3'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 16,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.w400),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: '隐患排查内容：',
                                        style: TextStyle(
                                            color: Color(0xff333333))),
                                    TextSpan(
                                        text: list[index]
                                            ['troubleshootContent'],
                                        style: TextStyle(
                                            color: Color(0xff7F8A9C))),
                                  ]),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            url: Interface.getRiskTemplateFourWarehouseAll,
            queryParameters: _queryParameters,
            method: 'get',
            throwFunc: _throwFunc,
          ),
        ))
      ]),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/riskIdentifyTask/addControlMeasure',
                arguments: {
                  'riskEventId': widget.leftBarList[leftBarIndex]['id']
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
