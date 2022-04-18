import 'package:enterprise/common/MychooseTime.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myDrop.dart';
import 'package:enterprise/common/myInput.dart';
// import 'package:enterprise/common/myMutipleChoose.dart';
import 'package:enterprise/common/mySearchPeople.dart';
import 'package:enterprise/common/myText.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkPlan extends StatefulWidget {
  WorkPlan({
    this.sumbitWidget,
    this.circuit,
    this.id,
    this.executionMemo = '',
  });

  final Widget sumbitWidget;
  final int circuit, id;
  final String executionMemo;
  // 0 - fill in
  // 1 - approve
  @override
  _WorkPlanState createState() => _WorkPlanState();
}

class _WorkPlanState extends State<WorkPlan> {
  Counter _context = Provider.of<Counter>(myContext);

  @override
  void dispose() {
    cacheData.saved(
        id: 0,
        workStep: 0,
        context: _context.submitDates['作业计划'],
        router: "WorkPlan");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _context.emptySubmitDates(key: "作业计划");
    });
    if (widget.circuit > 1 || widget.executionMemo != '' || widget.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _getData();
      });
    } else {
      cacheAssgin();
    }
  }

  cacheAssgin() {
    cacheData.queryTable(id: 0, router: "WorkPlan").then((value) {
      _context.submitDates['作业计划'] = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  _getData() {
    myDio
        .request(
            type: 'get', url: Interface.getWorkDetail + widget.id.toString())
        .then((value) {
      if (value is Map) {
        data.forEach((element) {
          String tempField = element['field'];
          if (tempField == 'planApprovalUserIds') {
            _context.changeSubmitDates('作业计划', {
              "title": element['title'],
              "value": value[tempField],
              'id': value['planApprovalUserIds']
            });
          } else if (tempField == 'riskIdentifierUserIds') {
            _context.changeSubmitDates('作业计划', {
              "title": element['title'],
              "value": value[tempField],
              'id': value['riskIdentifierIds']
            });
          } else if (tempField == 'region') {
            _context.changeSubmitDates('作业计划', {
              "title": element['title'],
              "value": value[tempField],
              'id': value['regionId']
            });
          } else if (tempField == 'territorialUnit') {
            _context.changeSubmitDates('作业计划', {
              "title": element['title'],
              "value": value[tempField],
              'id': value['territorialUnitId']
            });
          } else {
            _context.changeSubmitDates(
                '作业计划', {"title": element['title'], "value": value[tempField]});
          }

          element['value'] = value[tempField];
        });

        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  List data = [
    {'title': '作业名称', 'type': 'input', 'space': '作业基本信息', 'field': 'workName'},
    {
      'title': '作业区域',
      'type': 'choose',
      "data": [],
      "dataUrl": Interface.areaUrl,
      "field": "region"
    },
    {
      'title': '作业内容',
      'type': 'input', //单选框,
      "field": "description"
    },
    {
      'title': '属地单位', //title
      'type': 'text', //类型 一般输入框是 Input
      'value': '',
      'space': '相关单位',
      "field": "territorialUnit"
    },
    {
      'title': '作业风险辨识人',
      'type': 'checkbox',
      "data": [],
      'space': '',
      "field": "riskIdentifierUserIds"
    },
    {
      'title': '作业时间',
      'type': 'chooseTime',
      'value': '',
      'space': '',
      "field": "planDate"
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            children: data.map<Widget>((ele) {
              Widget _widget;
              var value;
              if (ele['value'] != '' && ele['value'] != null) {
                value = ele['value'];
              } else {
                if (_context.submitDates['作业计划'] != null) {
                  _context.submitDates['作业计划'].forEach((sumbit) {
                    if (sumbit['title'] == ele['title']) {
                      value = sumbit['value'];
                    }
                  });
                }
              }
              switch (ele['type']) {
                case 'text':
                  _widget = Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: underColor)),
                      color: Colors.white,
                    ),
                    // width: windowSize.width,
                    padding: EdgeInsets.all(size.width * 20),
                    child: MyText(
                      title: ele['title'],
                      value: value,
                    ),
                  );
                  break;
                case 'input':
                  _widget = Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: underColor)),
                      color: Colors.white,
                    ),
                    // width: windowSize.width - size.width * 140,
                    padding: EdgeInsets.all(size.width * 20),
                    child: widget.circuit > 1
                        ? MyText(
                            title: ele['title'],
                            value: value,
                          )
                        : MyInput(
                            placeHolder: value,
                            title: ele['title'],
                            purview: '作业计划',
                          ),
                  );
                  break;
                case 'choose':
                  _widget = Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: underColor)),
                      color: Colors.white,
                    ),
                    width: windowSize.width,
                    padding: EdgeInsets.all(size.width * 20),
                    child: widget.circuit > 1
                        ? MyText(
                            title: ele['title'],
                            value: value,
                          )
                        : MyDrop(
                            title: ele['title'],
                            purview: '作业计划',
                            data: ele['data'],
                            dataUrl: ele['dataUrl'],
                            placeHolder: value,
                            callSetstate: () {
                              if (mounted) {
                                setState(() {});
                              }
                            }),
                  );
                  break;
                case 'chooseTime':
                  _widget = widget.circuit > 1
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 20),
                          child: MyText(
                            title: ele['title'],
                            value: value,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: underColor)),
                            color: Colors.white,
                          ),
                          width: windowSize.width,
                          padding: EdgeInsets.all(size.width * 20),
                          child: MychooseTime(
                            title: ele['title'],
                            purview: '作业计划',
                            placeholder: value,
                          ),
                        );
                  break;
                case 'checkbox':
                  if (value is String) value = null;
                  // print('value----------------------------------' + value.toString());
                  _widget = (Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: underColor)),
                      color: Colors.white,
                    ),
                    width: windowSize.width,
                    padding: EdgeInsets.all(size.width * 20),
                    child: SourchMutiplePeople(
                      title: ele['title'],
                      purview: '作业计划',
                      // userId: value == null ? myprefs.getInt('userId') : -1,
                      userId: value != null ? value[0] is Map ? value[0]['id'] : value[0] : -1,
                    ),
                  ));
                  break;
                default:
                  _widget = Text(ele['title'].toString() + '暂未开发');
              }
              if (ele['space'] != null) {
                Widget __widget;
                __widget = _widget;
                _widget = Column(
                  children: [
                    Align(
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 20),
                          child: Text(
                            ele['space'].toString(),
                            style: TextStyle(color: placeHolder),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        alignment: Alignment.centerRight),
                    __widget
                  ],
                );
              }
              return _widget;
            }).toList(),
          ),
          widget.sumbitWidget != null ? widget.sumbitWidget : Container(),
          SizedBox(
            height: size.width * 50,
          )
        ],
      )),
    );
  }
}
