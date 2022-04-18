import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/checkLisk/__hiddenSpecificItem.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenDangerGovernLedger.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class RiskUncontrollable extends StatefulWidget {
  @override
  _RiskUncontrollableState createState() => _RiskUncontrollableState();
}

class _RiskUncontrollableState extends State<RiskUncontrollable> {
  ThrowFunc _throwFunc = ThrowFunc();

  List territoryDropList = [
    {'title': '属地单位', 'data': [], 'value': '', 'saveTitle': '属地单位'},
  ];

  List riskObjectDropList = [
    {'title': '风险分析对象', 'data': [], 'value': '', 'saveTitle': '风险分析对象'},
  ];

  int territorialUnitId;
  int oneId;

  Map queryParameters;

  @override
  void initState() {
    super.initState();
    _getTerritorialUnitAll();
    _getRiskOneListAllByterritorialUnit();
  }

  _getTerritorialUnitAll() {
    myDio
        .request(
      type: 'get',
      url: Interface.getTerritorialUnitAll,
    )
        .then((value) {
      if (value is List) {
        territoryDropList[0]['data'] = value;
        setState(() {});
      }
    });
  }

  _getRiskOneListAllByterritorialUnit() {
    myDio.request(
        type: 'get',
        url: Interface.getRiskOneListAllByterritorialUnit,
        queryParameters: {
          'territorialUnitId': territorialUnitId
        }).then((value) {
      if (value is List) {
        riskObjectDropList[0]['data'] = value;
        setState(() {});
      }
    });
  }

  _getData(){
    queryParameters = {
      'oneId': oneId, //  风险分析对象
      'territorialUnitId': territorialUnitId, //  属地单位
    };
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('风险不受控数据'),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropDown(
                      territoryDropList,
                      0,
                      callbacks: (val) {
                        territorialUnitId = val['id'];
                        riskObjectDropList[0]['data'] = [];
                        riskObjectDropList[0]['title'] =
                            riskObjectDropList[0]['saveTitle'];
                        _getRiskOneListAllByterritorialUnit();
                        _getData();
                        _throwFunc.run(argument: queryParameters);
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: DropDown(
                      riskObjectDropList,
                      0,
                      callbacks: (val) {
                        oneId = val['id'];
                        _getData();
                        _throwFunc.run(argument: queryParameters);
                        setState(() {});
                      },
                    ),
                  )
                ]),
            Container(
              height: size.width * 15,
              width: double.infinity,
              color: Color(0xffEAEDF2),
              margin: EdgeInsets.symmetric(vertical: size.width * 10),
            ),
            Expanded(
              child: MyRefres(
                child: (index, list) => Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 40, vertical: size.width * 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipPath(
                        clipper: MyCustomClipper(),
                        child: Container(
                            color: themeColor,
                            padding: EdgeInsets.only(
                                left: size.width * 20, right: size.width * 40),
                            child: Text(
                              list[index]['name'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 32,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12, //阴影颜色
                                  offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                                  blurRadius: 5.0, //阴影大小
                                  spreadRadius: 0.0 //阴影扩散程度
                                  ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '风险分析对象：${list[index]['riskPoint'].toString()}',
                                style: TextStyle(
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '风险分析单元：${list[index]['riskUnit'].toString()}',
                                style: TextStyle(
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '风险事件：${list[index]['riskItem'].toString()}',
                                style: TextStyle(
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: '负责部门：',
                                    style: TextStyle(
                                        color: Color(0xff3073FE),
                                        fontSize: size.width * 20,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: list[index]['departmentName'] == null ? "— —" : list[index]['departmentName'].toString(),
                                    style: TextStyle(fontSize: size.width * 20))
                              ])),
                              SizedBox(
                                height: size.width * 20,
                              ),
                              Row(
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: '管控方式：',
                                        style: TextStyle(
                                            color: Color(0xff3073FE),
                                            fontSize: size.width * 20,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: list[index]['controlMeans'].toString(),
                                        style: TextStyle(fontSize: size.width * 20))
                                  ])),
                                  Spacer(),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: '管控周期：',
                                        style: TextStyle(
                                            color: Color(0xff3073FE),
                                            fontSize: size.width * 20,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: list[index]['cycle'].toString(),
                                        style: TextStyle(fontSize: size.width * 20))
                                  ])),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // data: data,
                type: '风险不受控',
                listParam: "records",
                throwFunc: _throwFunc,
                page: true,
                url: Interface.getUncontrolledFourList,
                queryParameters: queryParameters,
                method: 'get'
              ),
            )
          ],
        ));
  }
}
