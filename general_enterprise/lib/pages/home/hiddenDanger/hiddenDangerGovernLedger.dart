import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myDateSelect.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiddenDangerGovernLedger extends StatefulWidget {
  @override
  _HiddenDangerGovernLedgerState createState() =>
      _HiddenDangerGovernLedgerState();
}

class _HiddenDangerGovernLedgerState extends State<HiddenDangerGovernLedger> {
  String startDate;
  String endDate;
  ThrowFunc _throwFunc = ThrowFunc();
  Map queryParameters;

  List territoryDropList = [
    {
      'title': '属地单位',
      'data': [],
      'value': '',
      'saveTitle': '属地单位'
    },
  ];

  List riskObjectDropList = [
    {
      'title': '风险分析对象',
      'data': [],
      'value': '',
      'saveTitle': '风险分析对象'
    },
  ];

  List stateDropList = [
    {
      'title': '整改状态',
      'data': [
        {'name': '待确认'},
        {'name': '待整改'},
        {'name': '待审批'},
        {'name': '已完成'},
        {'name': '查看全部'},
      ],
      'value': '',
      'saveTitle': '整改状态'
    },
  ];

  List hiddenClassifyDropList = [
    {
      'title': '隐患分类',
      'data': [
        {'name': '无隐患'},
        {'name': '一般隐患'},
        {'name': '重大隐患'},
        {'name': '查看全部'},
      ],
      'value': '',
      'saveTitle': '隐患分类'
    },
  ];

  List data = [
    {
      'grade': 1,
      'executor': '张三',
      'location': '精馏一班',
      'time': '2020.10.22    11:11:11',
      'indicator': '安全净空高度',
      'state': '待整改'
    },
    {
      'grade': null,
      'executor': '张三',
      'location': '精馏一班',
      'time': '2020.10.22    11:11:11',
      'indicator': '安全净空高度',
      'state': '待整改'
    },
    {
      'grade': 2,
      'executor': '张三',
      'location': '精馏一班',
      'time': '2020.10.22    11:11:11',
      'indicator': '安全净空高度',
      'state': '待整改'
    },
    {
      'grade': 2,
      'executor': '张三',
      'location': '精馏一班',
      'time': '2020.10.22    11:11:11',
      'indicator': '安全净空高度',
      'state': '待整改'
    },
  ];

  int oneId;
  int hiddenLevel;
  int hiddenStatus;
  int territorialUnitId;

  @override
  void initState() {
    super.initState();
    _init();
    DateTime dateTime = DateTime.now();
    startDate = dateTime.toString().substring(0, 10);
    endDate = dateTime.toString().substring(0, 10);
    _getData();
    _getTerritorialUnitAll();
    _getRiskOneListAllByterritorialUnit();
  }

  _getTerritorialUnitAll(){
    myDio.request(
      type: 'get', 
      url: Interface.getTerritorialUnitAll, 
    ).then((value) {
      if (value is List) {
        territoryDropList[0]['data'] = value;
        setState(() {});
      }
    });
  }

  _getRiskOneListAllByterritorialUnit(){
    myDio.request(
      type: 'get', 
      url: Interface.getRiskOneListAllByterritorialUnit, 
      queryParameters: {
        'territorialUnitId': territorialUnitId
      }
    ).then((value) {
      if (value is List) {
        riskObjectDropList[0]['data'] = value;
        setState(() {});
      }
    });
  }

  _getData(){
    queryParameters = {
      'oneId': oneId, //  风险分析对象
      'hiddenLevel': hiddenLevel, //  隐患分类
      'hiddenStatus': hiddenStatus, //  整改状态
      'territorialUnitId': territorialUnitId, //  属地单位
      'startDate': startDate, 
      'endDate': endDate, 
    };
  }

  int _getHiddenStatus(String hiddenStatus){
    switch (hiddenStatus) {
      case '待确认':
        return 1;
        break;
      case '待整改':
        return 2;
        break;
      case '待审批':
        return 3;
        break;
      case '已完成':
        return 4;
        break;
      default:
        return null;
    }
  }

  int _getHiddenLevel(String hiddenLevel){
    switch (hiddenLevel) {
      case '无隐患':
        return 0;
        break;
      case '一般隐患':
        return 1;
        break;
      case '重大隐患':
        return 2;
        break;
      default:
        return null;
    }
  }

  Widget _dropDown() {
    return Column(
      children: [
        // 筛选 时间
        Row(
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
        ),
        // 筛选 属地单位 风险分析对象
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
                    riskObjectDropList[0]['title'] = riskObjectDropList[0]['saveTitle'];
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
        // 筛选 整改状态 隐患分类
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: DropDown(
                  stateDropList,
                  0,
                  callbacks: (val) {
                    hiddenStatus = _getHiddenStatus(val['status']);
                    _getData();
                    _throwFunc.run(argument: queryParameters);
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: DropDown(
                  hiddenClassifyDropList,
                  0,
                  callbacks: (val) {
                    hiddenLevel = _getHiddenLevel(val['status']);
                    _getData();
                    _throwFunc.run(argument: queryParameters);
                    setState(() {});
                  },
                ),
              )
            ]),
      ],
    );
  }

  String _getStatus(int status){
    switch (status) {
      case 1:
        return '待确认';
        break;
      case 2:
        return '待整改';
        break;
      case 3:
        return '待审批';
        break;
      case 4:
        return '已完成';
        break;
      default:
        return '';
    }
  }

  SharedPreferences prefs;

  _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  _getColor(int hiddenLevel){
    switch (hiddenLevel) {
      case 0:
        return Color(0xffCCCCCC);
        break;
      case 1:
        return Color(0xffFBAB00);
        break;
      case 2:
        return Color(0xffEC1111);
        break;
      default:
        return Color(0xffCCCCCC);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('隐患排查治理台账'),
      child: Column(
        children: [
          _dropDown(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.width * 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.width * 14,
                  width: size.width * 14,
                  color: Color(0xffCCCCCC),
                  margin: EdgeInsets.only(
                      left: size.width * 30, right: size.width * 10),
                ),
                Text(
                  '无隐患',
                  style: TextStyle(
                      color: Color(0xff666666), fontSize: size.width * 18),
                ),
                Container(
                  height: size.width * 14,
                  width: size.width * 14,
                  color: Color(0xffFBAB00),
                  margin: EdgeInsets.only(
                      left: size.width * 30, right: size.width * 10),
                ),
                Text(
                  '一般隐患',
                  style: TextStyle(
                      color: Color(0xff666666), fontSize: size.width * 18),
                ),
                Container(
                  height: size.width * 14,
                  width: size.width * 14,
                  color: Color(0xffEC1111),
                  margin: EdgeInsets.only(
                      left: size.width * 30, right: size.width * 10),
                ),
                Text(
                  '重大隐患',
                  style: TextStyle(
                      color: Color(0xff666666), fontSize: size.width * 18),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: size.width * 42,
            decoration: BoxDecoration(
              color: Color(0xffECECEC),
              border:
                  Border.all(width: size.width * 1, color: Color(0xffD6D6D6)),
            ),
            child: Row(
              children: [
                Container(
                  width: size.width * 220,
                  alignment: Alignment.center,
                  child: Text(
                    '风险分析对象',
                    style: TextStyle(
                        fontSize: size.width * 24, color: Color(0xff424242)),
                  ),
                ),
                Container(
                  width: size.width * 170,
                  alignment: Alignment.center,
                  child: Text(
                    '风险事件',
                    style: TextStyle(
                        fontSize: size.width * 24, color: Color(0xff424242)),
                  ),
                ),
                Container(
                  width: size.width * 230,
                  alignment: Alignment.center,
                  child: Text(
                    '执行时间',
                    style: TextStyle(
                        fontSize: size.width * 24, color: Color(0xff424242)),
                  ),
                ),
                Container(
                  width: size.width * 120,
                  alignment: Alignment.center,
                  child: Text(
                    '整改状态',
                    style: TextStyle(
                        fontSize: size.width * 24, color: Color(0xff424242)),
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
                            width: size.width * 220,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: size.width * 12,
                                  width: size.width * 12,
                                  decoration: BoxDecoration(
                                    color: _getColor(list[index]['hiddenLevel']),
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 5,
                                ),
                                Text(
                                  list[index]['riskPoint'],
                                  style: TextStyle(
                                      fontSize: size.width * 20,
                                      color: Color(0xff666666)),
                                ),
                              ],
                            )
                          ),
                          Container(
                            width: size.width * 170,
                            alignment: Alignment.center,
                            child: Text(
                              list[index]['riskItem'],
                              style: TextStyle(
                                  fontSize: size.width * 20,
                                  color: Color(0xff666666)),
                            ),
                          ),
                          Container(
                            width: size.width * 230,
                            alignment: Alignment.center,
                            child: Text(
                              list[index]['reportingTime'],
                              style: TextStyle(
                                  fontSize: size.width * 20,
                                  color: Color(0xff666666)),
                            ),
                          ),
                          Container(
                            width: size.width * 120,
                            alignment: Alignment.center,
                            child: Text(
                              _getStatus(list[index]['status']),
                              style: TextStyle(
                                  fontSize: size.width * 20,
                                  color: Color(0xff666666)),
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
                  String token = prefs.getString('token');
                  int id = list[index]['id'];
                  Navigator.pushNamed(
                    context, '/webviews',
                    arguments: {
                      "url":
                      '$webUrl/hidden-governbook-list?token=$token&id=$id&${DateTime.now().microsecondsSinceEpoch.toString()}'
                    });
                },
              ),
              listParam: "records",
              throwFunc: _throwFunc,
              page: true,
              url: Interface.getListHiddenHistory,
              queryParameters: queryParameters,
              method: 'get'
            ),
          ),
        ],
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown(this.list, this.index, {Key key, this.callbacks}) : super(key: key);
  final int index;
  final List list;
  final callbacks;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.list.asMap().keys.map((i) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            showBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 200,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  widget.list[i]['data'].map<Widget>((_ele) {
                                Color _juegeColor() {
                                  Color _color = widget.list[i]['value'] == '' &&
                                          _ele['name'] == '查看全部'
                                      ? themeColor
                                      : widget.list[i]['value'] == _ele['name']
                                          ? themeColor
                                          : Colors.white;
                                  return _color;
                                }

                                Color _conColors = _juegeColor();
                                return GestureDetector(
                                  onTap: () {
                                    widget.list[i]['value'] = _ele['name'];
                                    if (_ele['name'] == '查看全部') {
                                      widget.list[i]['title'] =
                                          widget.list[i]['saveTitle'];
                                    } else {
                                      widget.list[i]['title'] = _ele['name'];
                                    }
                                    widget.callbacks({
                                      'status': _ele['name'],
                                      'id': _ele['id'],
                                    });
                                    setState(() {});
                                    // widget.getDataList();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.width * 32),
                                    decoration: BoxDecoration(
                                        color: _conColors,
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: underColor))),
                                    child: Center(
                                      child: Text(
                                        _ele['name'],
                                        style: TextStyle(
                                            fontSize: size.width * 30,
                                            color: _conColors.toString() ==
                                                    'Color(0xff6ea3f9)'
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Expanded(child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ))
                      ],
                    ),
                  );
                });
          },
          child: Container(
            width: size.width * 618,
            height: size.width * 80,
            margin: EdgeInsets.only(
                top: 10.0, left: size.width * 10.0, right: size.width * 10.0),
            padding: EdgeInsets.only(
                left: size.width * 20.0, right: size.width * 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Color(0xffD2D2D2),
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.list[i]['title'].toString(),
                  style: TextStyle(
                      color: Color(0xff898989), fontSize: size.width * 32),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff898989),
                ),
              ],
            ),
          ),
        )
      );
    }).toList());
  }
}
