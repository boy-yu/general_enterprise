import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myDateSelect.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLedger extends StatefulWidget {
  MyLedger({this.oneId, this.twoId, this.threeId, this.fourId, this.coDepartmentId, this.hiddenType, this.controlType});
  final int oneId;
  final int twoId;
  final int threeId;
  final int fourId; 
  final int coDepartmentId;
  final String hiddenType;
  final int controlType;

  @override
  _MyLedgerState createState() => _MyLedgerState();
}

class _MyLedgerState extends State<MyLedger> {
  int choosed = 0;
  List stateList = [
    {
      "index": 0,
      "name": "逾期",
      "isClick": false,
    },
    {
      "index": 1,
      "name": "正常",
      "isClick": true,
    }
  ];
  ThrowFunc _throwFunc = ThrowFunc();
  String startDate;
  String endDate;
  int oneId;
  int twoId;
  int threeId;
  int fourId; 
  int coDepartmentId;
  String hiddenType;
  int controlType;
  int status;
  SharedPreferences prefs;

  Widget _dropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: MyDateSelect(
            title: 'startDate',
            purview: 'startDate',
            callback: (value) {
              startDate = value;
            },
          ),
        ),
        Expanded(
          child: MyDateSelect(
            title: 'endDate',
            purview: 'endDate',
            callback: (value) {
              endDate = value;
              _getData();
              _throwFunc.run(argument: queryParameters);
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
    DateTime dateTime = DateTime.now();
    startDate = dateTime.toString().substring(0, 10);
    endDate = dateTime.toString().substring(0, 10);
    oneId = widget.oneId;
    twoId = widget.twoId;
    threeId = widget.threeId;
    fourId = widget.fourId; 
    coDepartmentId = widget.coDepartmentId;
    hiddenType = widget.hiddenType;
    controlType = widget.controlType;
    status = 5;
    _getData();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Map queryParameters;

  _getData(){
    queryParameters = {
      'oneId': oneId,
      'twoId': twoId,
      'threeId': threeId,
      'fourId': fourId,
      'coDepartmentId': coDepartmentId, // 部门id
      'hiddenType': hiddenType, //  隐患类型
      'controlType': controlType, //  1隐患排查 2巡检点检 0风险管控
      'startDate': startDate, //  开始时间
      'endDate': endDate, //  结束时间
      'status': status, //  4正常 5逾期
    };
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(.2), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(28))
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: stateList.map<Widget>((ele) {
            return GestureDetector(
              onTap: () {
                choosed = ele['index'];
                if(choosed == 1){
                  status = 4; //  正常
                }else{
                  status = 5; //  逾期
                }
                _getData();
                _throwFunc.run(argument: queryParameters);
                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: choosed == ele['index'] ? Colors.white : null,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text(
                  ele['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          choosed == ele['index'] ? themeColor : Colors.white,
                      fontSize: size.width * 35),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 40, vertical: size.width * 10),
              ),
            );
          }).toList(),
        ),
      ),
      child: Column(
        children: [
          _dropDown(),
          SizedBox(
            height: size.width * 30,
          ),
          Container(
            width: double.infinity,
            height: size.width * 42,
            color: Color(0xffD6D6D6),
            child: Row(
              children: [
                Container(
                  width: size.width * 150,
                  alignment: Alignment.center,
                  child: Text(
                    '执行人',
                    style: TextStyle(
                      fontSize: size.width * 24,
                      color: Color(0xff424242)
                    ),
                  ),
                ),
                Container(
                  width: size.width * 150,
                  alignment: Alignment.center,
                  child: Text(
                    '所在工位',
                    style: TextStyle(
                      fontSize: size.width * 24,
                      color: Color(0xff424242)
                    ),
                  ),
                ),
                Container(
                  width: size.width * 200,
                  alignment: Alignment.center,
                  child: Text(
                    '执行时间',
                    style: TextStyle(
                      fontSize: size.width * 24,
                      color: Color(0xff424242)
                    ),
                  ),
                ),
                Container(
                  width: size.width * 250,
                  alignment: Alignment.center,
                  child: Text(
                    '关键参数指标',
                    style: TextStyle(
                      fontSize: size.width * 24,
                      color: Color(0xff424242)
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MyRefres(
              child: (index, list) => GestureDetector(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 150,
                            alignment: Alignment.center,
                            child: Text(
                              list[index]['reportingUser'],
                              style: TextStyle(
                                fontSize: size.width * 20,
                                color: Color(0xff666666)
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 150,
                            alignment: Alignment.center,
                            child: Text(
                              list[index]['reportingDepartment'],
                              style: TextStyle(
                                fontSize: size.width * 20,
                                color: Color(0xff666666)
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 200,
                            alignment: Alignment.center,
                            child: Text(
                              DateTime.fromMillisecondsSinceEpoch(list[index]['reportingTime']).toString().substring(0, 19),
                              style: TextStyle(
                                fontSize: size.width * 20,
                                color: Color(0xff666666)
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 250,
                            alignment: Alignment.center,
                            child: Text(
                              list[index]['keyParameterIndex'],
                              style: TextStyle(
                                fontSize: size.width * 20,
                                color: Color(0xff666666)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: size.width * 1,
                      color: Color(0xffD6D6D6),
                      margin: EdgeInsets.symmetric(horizontal: size.width * 30),
                    ),
                  ],
                ),
                onTap: () {
                  // print(list[index]);
                  String token = prefs.getString('token');
                  String id = list[index]['uuid'];
                  Navigator.pushNamed(
                    context, '/webviews',
                    arguments: {
                      "url":
                      '$webUrl/risk-account-list?token=$token&id=$id&${DateTime.now().microsecondsSinceEpoch.toString()}'
                    });
                },
              ),
              listParam: "records",
              throwFunc: _throwFunc,
              page: true,
              url: Interface.getControlBook,
              queryParameters: queryParameters,
              method: 'get'
            ),
          ),
        ],
      )
    );
  }
}