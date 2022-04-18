import 'package:enterprise/common/MychooseTime.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustom.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/common/myInput.dart';
import 'package:enterprise/common/myMutipleChoose.dart';
import 'package:enterprise/common/myMutipletSIgnClose.dart';
import 'package:enterprise/common/myText.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/MychooseTime.dart';
import '../../../common/myAppbar.dart';
import '../../../common/myCustomColor.dart';
import '../../../common/myDrop.dart';
import '../../../common/myInput.dart';
import '../../../tool/interface.dart';
import 'dart:convert' as convert;

class ApplyDetail extends StatefulWidget {
  ApplyDetail({this.arguments});
  final arguments;
  @override
  _ApplyDetailState createState() =>
      _ApplyDetailState(arguments: arguments, contents: arguments['contexts']);
}

class _ApplyDetailState extends State<ApplyDetail> {
  SharedPreferences prefs;
  _ApplyDetailState({this.arguments, this.contents});
  final arguments;
  final Counter contents;
  final List applyMsg = [
    {
      'title': '作业名称', //title
      'type': 'input', //类型 一般输入框是 Input
      "value": "", //值
      "placeHolder": "请输入作业名称", //没有值得时候提示什么，这个你不用管，我可以自己赋值
    },
    {
      'title': '作业单位',
      'type': 'choose',
      "data": [
        {
          "name": "承包商作业",
          "addtion": {
            'title': '请选择承包商作业',
            'type': 'input',
          }
        },
        {
          "name": "内部作业",
          "addtion": {
            'title': '内部作业',
            'type': 'choose',
            "data": [],
            "dataUrl": 'generalUrl/internal'
          }
        },
      ]
    },
    {'title': '作业区域', 'type': 'choose', "data": [], "dataUrl": "areaUrl"},
    {
      'title': '作业地点',
      'type': 'input',
      "value": "",
      "placeHolder": "请输入作业地点名称",
    },
    {
      'title': '作业内容',
      'type': 'input',
      'line': 4,
      "value": "",
      "placeHolder": "请输入文本内容",
    },
    {
      'title': '涉及作业',
      'type': 'checkbox',
      "data": [],
      "dataUrl": "workTypeList"
    },
  ];

  List msgList = [
    {
      "name": "申请",
      "isChoose": true,
      "isClick": true,
      "icon": Icons.perm_contact_calendar
    },
    {
      "name": "措施确认",
      "isChoose": false,
      "isClick": false,
      "icon": Icons.perm_identity
    },
    {"name": "安全交底", "isChoose": false, "isClick": false, "icon": Icons.people},
    {"name": "审批", "isChoose": false, "isClick": false, 'icon': Icons.person},
    {"name": "关闭", "isChoose": false, "isClick": false, 'icon': Icons.close},
  ];

  List signArr = [];

  int clickName = 0;
  bool isPlan = false;
  List secondMsg = [];
  List allDate = [];
  Map workLicense = {};
  List tempWorks = [];
  bool require = true;
  int execution = 0;
  @override
  void initState() {
    super.initState();
    _initShared();
    _getPlanDate();
    execution = widget.arguments['execution'];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (arguments['type'] != 0) {
        // go apply page
        _getAllDate();
      }
    });

    for (var i = 0; i < msgList.length; i++) {
      if (i <= execution) {
        msgList[i]['isChoose'] = true;
      }
    }
  }

  _initShared() async {
    prefs = await SharedPreferences.getInstance();
  }

  Color _backColor(data) {
    Color _color = placeHolder;

    if (msgList[data]['isChoose']) {
      _color = yellowBg;
    }
    if (msgList[data]['isClick']) {
      msgList.forEach((element) {
        element['isClick'] = false;
      });
      msgList[data]['isClick'] = true;
      _color = themeColor;
      setState(() {});
    }
    return _color;
  }

  // index submit -> object
  // names submit -> name
  void onPress(String index, names, _context) {
    List data = _context.submitDates[index];

    data.forEach((element) {
      if (element['name'] == '涉及作业') {
        List<String> typeList = element['value'][0].split(' ');
        myDio
            .request(
          type: 'get',
          url: Interface.workTemplateListUrl,
        )
            .then((value) {
          secondMsg = [];
          tempWorks = element['value'];
          if (clickName == 0) {
            allDate = [];
            // setting  reder  element Array
            value.forEach((ele) {
              String tempName =
                  convert.jsonDecode(ele['data'])['name'].toString();
              if (typeList.indexOf(tempName.substring(0, tempName.length - 3)) >
                  -1) {
                allDate.add(convert.jsonDecode(ele['data']));
              }
              _context.assginSmallTicket(allDate);
            });
          }
          setState(() {});
        }).catchError((onError) {
          Interface().error(onError, context);
        });
        return;
      }
    });
  }

  _setPlaceHolder(String title, _context, names) {
    var data;
    switch (title) {
      case '申请人':
        data = prefs.getString('username');
        break;
      default:
    }

    _context.submitDates[names]?.forEach((element) {
      if (element['title'] == title) {
        data = element['value'].toString();
        return;
      }
    });
    // if(_context.submitDates['_apply']['name'] == 'title') {
    //   // data = _context.submitDates['_apply']['value'].toString();
    // }
    if (data == 'null') {
      data = null;
    }
    return data;
  }

  _recursionSumbit(data, String judge) {
    if (data is List) {
      data.forEach((element) {
        if (element is List) {
          _recursionSumbit(element, judge);
        } else if (element is Map) {
          element.forEach((key, _element) {
            if (key != judge) {
              _recursionSumbit(_element, judge);
              // print(element[judge]);
            } else {
              if (int.parse(element['editLevel']) == execution) {
                if (int.parse(element['isRequisite']) == 1) {
                  String temp = element['value'];
                  String valus = temp.substring(temp.indexOf('-') + 1);

                  if (valus == '' && element['isshow'] != false) {
                    require = false;
                    // print(temp + element['isRequisite']);
                    Interface().error(
                        {"message": '请对' + element['name'].toString() + '签字'},
                        context);
                  }
                }
              }
            }
          });
        }
      });
    } else if (data is Map) {
      data.forEach((key, _element) {
        if (key != judge) {
          _recursionSumbit(_element, judge);
          // print(element[judge]);
        } else {
          if (int.parse(data['editLevel']) == execution) {
            if (int.parse(data['isRequisite']) == 1) {
              String temp = data['value'];
              String valus = temp.substring(temp.indexOf('-') + 1);
              if (valus == '') {
                require = false;
                // print(temp + require.toString());
                Interface().error(
                    {"message": '请对' + data['name'].toString() + '签字'},
                    context);
              }
            }
          }
        }
      });
    }
  }

  _sumbitApplyDetail(Counter _context, context, {state}) {
    List tempDataAll = _context.smallTickets;
    // signArr
    require = true;
    final data = _context.submitDates;
    if (state != null) {
      if (state == '数据录入') {
        Map data = {
          "Authorization": '',
          "opinion": '',
          "dismissed": 0,
          "appData": convert.jsonEncode(tempDataAll)
        };
        myDio
            .request(
                type: 'post',
                url: Interface.postInputDate + '${arguments["id"]}',
                data: data)
            .then((value) {
          Fluttertoast.showToast(msg: '成功');
          Navigator.pop(context);
        }).catchError((onError) {
          Interface().error(onError, context);
        });
      } else {
        _recursionSumbit(tempDataAll, 'isRequisite');
        if (!require) return;
        Map data = {
          "Authorization": '',
          "opinion": '测试意见',
          "dismissed": 0,
          "appData": convert.jsonEncode(tempDataAll)
        };
        if (state == '驳回') {
          data['dismissed'] = 1;
        }
        myDio
            .request(
                type: 'post',
                url: Interface.generalOperUrl + '${arguments["id"]}',
                data: data)
            .then((value) {
          Fluttertoast.showToast(msg: '成功');
          Navigator.pop(context);
        }).catchError((onError) {
          Interface().error(onError, context);
        });
      }
    } else if (state == null) {
      Map post = {
        "guardianId": '' == _assginValue(data, '监护人', '作业申请', field: "id") ||
                null == _assginValue(data, '监护人', '作业申请', field: "id")
            ? 0
            : int.parse(_assginValue(data, '监护人', '作业申请', field: "id")),
        "appData": convert.jsonEncode(tempDataAll),
        "Authorization": '',
      };
      myDio
          .request(
              type: 'post',
              url: Interface.submitApplyUrl + '?id=${arguments["id"]}&type=1',
              data: post)
          .then((value) {
        Fluttertoast.showToast(msg: '成功');
        Navigator.pop(context);
      }).catchError((onError) {
        Interface().error(onError, context);
      });
    }
  }

  String _assginValue(data, name, title, {int index, String field}) {
    String value = '';
    data[title].forEach((element) {
      if (element['title'] == name) {
        if (element['value'] is String) {
          if (field != null) {
            value = element[field].toString();
          } else {
            value = element['value'];
          }
        } else if (element['value'] is List) {
          if (field != null) {
            value = element['value'][index][field];
          } else {
            value = element['value'][index];
          }
        }
      }
    });
    return value;
  }

  _getPlanDate() {
    myDio.request(
        type: 'get',
        url: Interface.getWorkPlan + arguments['id'].toString(),
        queryParameters: {"Authorization": ""}).then((value) {
      if (null != value) {
        contents.changeSubmitDates(
            '作业申请', {"title": '作业单位', "value": value['workUnit']});
        contents.changeSubmitDates(
            '作业申请', {"title": '作业内容', "value": value['description']});
        contents.changeSubmitDates(
            '作业申请', {"title": '作业地点', "value": value['location']});
        contents.changeSubmitDates(
            '作业申请', {"title": '作业名称', "value": value['workName']});
        contents.changeSubmitDates(
            '作业申请', {"title": '作业区域', "value": value['region']});
        contents.changeSubmitDates(
            '作业申请', {"title": '涉及作业', "value": value['workTypes']});
        contents.changeSubmitDates(
            '作业申请', {"title": '属地单位', "value": value['territorialUnit']});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  // _recursionAuth(data) {
  //   if (data is List) {
  //     for (var i = 0; i < data.length; i++) {
  //       _recursionAuth(data[i]);
  //     }
  //   } else if (data is Map) {
  //     data['isshow'] = true;
  //     data.forEach((key, value) {
  //       if (key == 'matchField') {
  //         bool isAdd = true;
  //         signArr.forEach((_element) {
  //           if (_element['matchField'] == value) {
  //             data['isshow'] = false;
  //             isAdd = false;
  //           }
  //         });
  //         if (isAdd) {
  //           signArr.add({'matchField': value, 'value': data['value']});
  //         }
  //       } else if (data[key] is List || data[key] is Map) {
  //         _recursionAuth(value);
  //       }
  //     });
  //   }
  // }

  _getAllDate() {
    String url = '';
    if (arguments['title'] == '作业申请') {
      url = Interface.getWorkDetailUrl;
    } else {
      url = Interface.getWorkTypeDetailUrl;
    }
    // print(arguments['id']);
    if (url != '') {
      myDio
          .request(
        type: 'get',
        url: url + arguments['id'].toString(),
      )
          .then((value) {
        if (value != null) {
          signArr = [];
          // tempAlldate = value;
          allDate = value;
          // deep copy data
          // String jsonValue = convert.jsonEncode(value);
          // allDate = convert.jsonDecode(jsonValue);
          // _recursionAuth(allDate);
          List repeatSign = [];
          allDate.asMap().keys.forEach((m) {
            allDate[m]['workList'].asMap().keys.forEach((n) {
              if (allDate[m]['workList'][n]['valueType'] == 'sign') {
                allDate[m]['workList'][n]['dataList'].asMap().keys.forEach((i) {
                  for (var o = allDate[m]['workList'][n]['dataList'][i]
                                  ['signList']
                              .length -
                          1;
                      o >= 0;
                      o--) {
                    String names = allDate[m]['workList'][n]['dataList'][i]
                            ['signList'][o]['matchField']
                        .toString();
                    if (repeatSign.indexOf(names) > -1 && names != '') {
                      allDate[m]['workList'][n]['dataList'][i]['signList'][o]
                          ['isshow'] = false;
                    } else {
                      repeatSign.add(names);
                    }
                  }
                });
                signArr.add({
                  "name": allDate[m]['name'],
                  "index": [m, 'workList', n, 'dataList'],
                  "value": allDate[m]['workList'][n]
                });
              }
            });
          });

          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            // tempAllDate is completeData
            arguments['contexts'].assginSmallTicket(allDate);
          });
          _toggleSpan(execution);
          setState(() {});
        }
      }).catchError((onError) {
        Interface().error(onError, context);
      });
    }
  }

  _toggleSpan(ele) {
    msgList[ele]['isClick'] = true;
    clickName = ele;
    _backColor(ele);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    final _context = Provider.of<Counter>(context);

    return MyAppbar(
      title: Text(arguments['title']),
      // backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          arguments['title'] != '作业申请'
              ? Container(
                  height: width * 140,
                  // flex: 2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: msgList.asMap().keys.map((ele) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          _toggleSpan(ele);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: width * 26),
                          height: width * 120,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                  msgList[ele]["icon"],
                                  color: _backColor(ele),
                                ),
                              ),
                              Text(
                                msgList[ele]['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: _backColor(ele),
                                    fontSize: width * 30),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ))
              : Container(),
          Expanded(
              flex: 8,
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                ApplyFill(
                    arguments: arguments,
                    applyMsg: applyMsg,
                    setPlaceHolder: _setPlaceHolder),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home/work/riskIdentify',
                        arguments: {"id": arguments['id']});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: width * 10),
                    padding: EdgeInsets.only(right: width * 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 30, vertical: width * 20),
                          child: Text('风险辨识详情',
                              style: TextStyle(
                                  color: titleColor, fontSize: width * 40)),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: themeColor,
                        )
                      ],
                    ),
                    color: Colors.white,
                  ),
                ),
                WorkType(allDate, _setPlaceHolder, onPress, signArr, clickName,
                    execution, allDate)
              ]))),
          arguments['type'] != false && clickName == execution
              ? Row(
                  children: <Widget>[
                    clickName != 0 &&
                            clickName != 1 &&
                            clickName != 4 &&
                            arguments['title'] != '数据录入'
                        ? Expanded(
                            child: GestureDetector(
                            onTap: () {
                              _sumbitApplyDetail(_context, context,
                                  state: '驳回');
                            },
                            child: Container(
                                margin: EdgeInsets.all(width * 40),
                                padding:
                                    EdgeInsets.symmetric(vertical: width * 30),
                                decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: lineGradRed),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    '驳回',
                                    style: TextStyle(
                                        fontSize: width * 30,
                                        color: Colors.white),
                                  ),
                                )),
                          ))
                        : Container(),
                    arguments['title'] != '数据录入'
                        ? Expanded(
                            child: GestureDetector(
                            onTap: () {
                              if (arguments['type'] == 0) {
                                Fluttertoast.showToast(msg: '临时作业开发中');
                              } else {
                                _sumbitApplyDetail(_context, context,
                                    state: arguments['title'] != '作业申请'
                                        ? '通过'
                                        : null);
                              }
                            },
                            child: Container(
                                margin: EdgeInsets.all(width * 40),
                                padding:
                                    EdgeInsets.symmetric(vertical: width * 30),
                                decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: lineGradBlue),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    '提交保存',
                                    style: TextStyle(
                                        fontSize: width * 30,
                                        color: Colors.white),
                                  ),
                                )),
                          ))
                        : Expanded(
                            child: GestureDetector(
                            onTap: () {
                              if (arguments['type'] == 0) {
                                Fluttertoast.showToast(msg: '临时作业开发中');
                              } else {
                                _sumbitApplyDetail(_context, context,
                                    state: '数据录入');
                              }
                            },
                            child: Container(
                                margin: EdgeInsets.all(width * 40),
                                padding:
                                    EdgeInsets.symmetric(vertical: width * 30),
                                decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: lineGradBlue),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    '数据录入',
                                    style: TextStyle(
                                        fontSize: width * 30,
                                        color: Colors.white),
                                  ),
                                )),
                          ))
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class ApplyFill extends StatefulWidget {
  ApplyFill({this.arguments, this.applyMsg, this.setPlaceHolder});
  final arguments, setPlaceHolder;
  final List applyMsg;
  @override
  _ApplyFillState createState() => _ApplyFillState(arguments, setPlaceHolder);
}

class _ApplyFillState extends State<ApplyFill> {
  _ApplyFillState(this.arguments, this.setPlaceHolder);
  final arguments, setPlaceHolder;
  bool isPlan = false;

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    Counter _context = Provider.of<Counter>(context);
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            isPlan = !isPlan;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '计划详情',
                  style: TextStyle(color: titleColor, fontSize: width * 40),
                ),
                Icon(
                  !isPlan
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_down,
                  color: themeColor,
                )
              ],
            ),
            padding: EdgeInsets.symmetric(
                horizontal: width * 30, vertical: width * 20),
          ),
        ),
        !isPlan
            ? Container()
            : Column(
                children: widget.applyMsg.map<Widget>((e) {
                String _place = setPlaceHolder(e['title'], _context, '作业申请');
                return MyText(
                  title: e['title'],
                  value: _place,
                );
                // switch (e['type']) {
                //   case 'choose':
                //     name = MyText(
                //       title: e['title'],
                //       value: _place,
                //     );
                //     break;
                //   case 'checkbox':
                //     name = MyText(
                //       title: e['title'],
                //       value: _place,
                //     );
                //     break;
                //   case 'input':
                //     name = MyText(
                //       title: e['title'],
                //       value: _place,

                //       // index: e['index'],
                //     );
                //     break;
                //   case 'chooseTime':
                //     name = MyText(
                //       title: e['title'],
                //       value: _place,
                //     );
                //     break;
                //   default:
                //     name = Container();
                // }
                // return name;
              }).toList()),
      ],
    );
  }
}

class WorkType extends StatefulWidget {
  WorkType(this.allDate, this.setPlaceHolder, this.onPress, this.signArr,
      this.clickName, this.execution, this.tempAlldate);
  final allDate,
      setPlaceHolder,
      onPress,
      signArr,
      clickName,
      execution,
      tempAlldate;
  @override
  _WorkTypeState createState() => _WorkTypeState();
}

class _WorkTypeState extends State<WorkType> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return null != widget.allDate
        ? Column(
            children: widget.allDate.asMap().keys.map<Widget>((e) {
              return Container(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.grey.withOpacity(.1),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: width * 10),
                    child: Text(
                      widget.allDate[e]['name'].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 30),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.allDate[e]['workList']
                        .asMap()
                        .keys
                        .map<Widget>((m) {
                      Widget name;
                      String memo = widget.allDate[e]['workList'][m]['memo'];
                      if (memo == null || memo == '') {
                        memo = '';
                      } else {
                        memo = '(' + memo + ')';
                      }
                      // execution = 4 only look
                      // print(widget.allDate[e]['workList'][m]['editLevel']);
                      String _editLevel =
                          widget.allDate[e]['workList'][m]['editLevel'];
                      switch (widget.allDate[e]['workList'][m]['valueType']) {
                        case 'select':
                          int next = 0;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = 1;
                            }
                            // else if (widget.execution == 4) {
                            //   next = 2;
                            // }
                          }
                          String temp =
                              widget.allDate[e]['workList'][m]['value'];
                          String value = temp.substring(temp.indexOf('-') + 1);
                          if (value == '') value = null;
                          if (next == 0) {
                            name = MyDrop(
                              title: widget.allDate[e]['workList'][m]['name'],
                              data: widget.allDate[e]['workList'][m]
                                  ['selectList'],
                              index: [e, 'workList', m],
                              name: widget.allDate[e]['name'],
                              placeHolder: value,
                              memo: memo,
                              callSetstate: () {
                                setState(() {});
                              },
                            );
                          } else if (next == 2) {
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              value: value,
                            );
                          } else {
                            name = Container();
                          }

                          break;
                        case 'checkbox':
                          int next = 0;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = 1;
                              // hide
                            }
                            // else if (widget.execution == 4) {
                            //   next = 2;
                            //   // disable amend
                            // }
                          }
                          String temp =
                              widget.allDate[e]['workList'][m]['value'];
                          String value = temp.substring(temp.indexOf('-') + 1);
                          if (value == '') value = null;
                          if (next == 0) {
                            name = MutipleDrop(
                              title: widget.allDate[e]['workList'][m]['name'],
                              data: widget.allDate[e]['workList'][m]
                                  ['selectList'],
                              index: [e, 'workList', m],
                              // name: widget.allDate[e]['name'],
                              placeHolder: value,
                              memo: memo,
                            );
                          } else if (next == 2) {
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              value: value,
                            );
                          } else {
                            name = Container();
                          }
                          break;
                        case 'sign':
                          name = MyMutipleSignClose(
                            title: widget.allDate[e]['workList'][m]['name'],
                            dataList: widget.tempAlldate[e]['workList'][m]
                                ['dataList'],
                            name: widget.allDate[e]['name'],
                            index: [e, 'workList', m, 'dataList'],
                            clickName: widget.clickName,
                            execution: widget.execution,
                            memo: memo,
                          );
                          break;
                        case 'timePart':
                          int next = 0;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = 1;
                              // hide
                            }
                            // else if (widget.execution == 4) {
                            //   next = 2;
                            //   // disable amend
                            // }
                          }

                          String temp =
                              widget.allDate[e]['workList'][m]['value'];
                          String value = temp.substring(temp.indexOf('-') + 1);
                          if (value == '') value = null;
                          if (next == 0) {
                            name = MychooseTime(
                              name: widget.allDate[e]['name'],
                              title: widget.allDate[e]['workList'][m]['name'],
                              index: [e, 'workList', m],
                              numer: 2,
                              placeholder: value,
                              memo: memo,
                            );
                          } else if (next == 2) {
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              value: value,
                            );
                          } else {
                            name = Container();
                          }
                          break;
                        case 'table':
                          int next = 0;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = 1;
                              // hide
                            }
                            // else if (widget.execution == 4) {
                            //   next = 2;
                            //   // disable amend
                            // }
                          }

                          if (next == 0) {
                            name = MyCustom(
                                name: widget.allDate[e]['name'],
                                title: widget.allDate[e]['workList'][m]['name'],
                                data: widget.allDate[e]['workList'][m],
                                index: [e, 'workList', m, 'tableTitle'],
                                memo: memo);
                          } else if (next == 2) {
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              type: 'table',
                              tableTitle: widget.allDate[e]['workList'][m]
                                  ['tableTitle'],
                            );
                          } else {
                            name = Container();
                          }

                          break;
                        case 'input':
                          int next = 0;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = 1;
                              // hide
                            }
                            // else if (widget.execution == 4) {
                            //   next = 2;
                            //   // disable amend
                            // }
                          }

                          String temp =
                              widget.allDate[e]['workList'][m]['value'];
                          String value = temp.substring(temp.indexOf('-') + 1);
                          if (value == '') value = null;

                          if (next == 0) {
                            name = MyInput(
                                name: widget.allDate[e]['name'],
                                title: widget.allDate[e]['workList'][m]['name'],
                                index: [e, 'workList', m],
                                placeHolder: value,
                                memo: memo);
                          } else if (next == 2) {
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              value: value,
                            );
                          } else {
                            name = Container();
                          }

                          break;
                        case 'images':
                          int next = 0;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = 1;
                              // hide
                            }
                            // else if (widget.execution == 4) {
                            //   next = 2;
                            //   // disable amend
                            // }
                          }

                          String temp =
                              widget.allDate[e]['workList'][m]['value'];
                          String value = temp.substring(temp.indexOf('-') + 1);
                          if (value == '') value = null;

                          if (next == 0) {
                            name = MyImageCarma(
                                title: widget.allDate[e]['workList'][m]['name'],
                                name: widget.allDate[e]['name'],
                                index: [e, 'workList', m],
                                type: 'images',
                                placeHolder: value,
                                memo: memo);
                          } else if (next == 2) {
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              value: value,
                              type: 'images',
                            );
                          } else {
                            name = Container();
                          }
                          break;
                        default:
                          name = Text(widget.allDate[e]['workList'][m]['name']
                                  .toString() +
                              '暂未开发');
                      }
                      return name;
                    }).toList(),
                  )
                ],
              ));
            }).toList(),
          )
        : Container();
  }
}

class OnlyLook extends StatefulWidget {
  OnlyLook(this.allDate, this.setPlaceHolder, this.onPress, this.signArr,
      this.clickName, this.execution, this.tempAlldate);
  final allDate,
      setPlaceHolder,
      onPress,
      signArr,
      clickName,
      execution,
      tempAlldate;
  @override
  _OnlyLookState createState() => _OnlyLookState();
}

class _OnlyLookState extends State<OnlyLook> {
  @override
  Widget build(BuildContext context) {
    double width = size.width;

    return null != widget.allDate
        ? Column(
            children: widget.allDate.asMap().keys.map<Widget>((e) {
              return Container(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.grey.withOpacity(.1),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: width * 10),
                    child: Text(
                      widget.allDate[e]['name'].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 30),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.allDate[e]['workList']
                        .asMap()
                        .keys
                        .map<Widget>((m) {
                      Widget name;
                      String memo = widget.allDate[e]['workList'][m]['memo'];
                      if (memo == null || memo == '') {
                        memo = '';
                      } else {
                        memo = '(' + memo + ')';
                      }
                      // print(widget.allDate[e]['workList'][m]['editLevel']);
                      String _editLevel =
                          widget.allDate[e]['workList'][m]['editLevel'];
                      switch (widget.allDate[e]['workList'][m]['valueType']) {
                        case 'select':
                          bool next = true;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = false;
                            }
                          }
                          if (next) {
                            String temp =
                                widget.allDate[e]['workList'][m]['value'];
                            String value =
                                temp.substring(temp.indexOf('-') + 1);
                            if (value == '') value = null;
                            name = MyDrop(
                              title: widget.allDate[e]['workList'][m]['name'],
                              data: widget.allDate[e]['workList'][m]
                                  ['selectList'],
                              index: [e, 'workList', m],
                              name: widget.allDate[e]['name'],
                              placeHolder: value,
                              memo: memo,
                              callSetstate: () {
                                setState(() {});
                              },
                            );
                          } else {
                            name = Container();
                          }

                          break;
                        case 'checkbox':
                          bool next = true;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = false;
                            }
                          }
                          if (next) {
                            String temp =
                                widget.allDate[e]['workList'][m]['value'];
                            String value =
                                temp.substring(temp.indexOf('-') + 1);
                            if (value == '') value = null;
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              value: value,
                            );
                          } else {
                            name = Container();
                          }
                          break;
                        case 'sign':
                          name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              dataList: widget.tempAlldate[e]['workList'][m]
                                  ['dataList'],
                              type: 'sign',
                              signValue: widget.signArr);
                          break;
                        case 'timePart':
                          bool next = true;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = false;
                            }
                          }
                          name = Container();
                          if (next) {
                            String temp =
                                widget.allDate[e]['workList'][m]['value'];
                            String value =
                                temp.substring(temp.indexOf('-') + 1);
                            if (value == '') value = null;
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              value: value,
                            );
                          }
                          break;
                        case 'table':
                          bool next = true;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = false;
                            }
                          }

                          name = Container();
                          if (next) {
                            name = MyText(
                                title: widget.allDate[e]['workList'][m]['name'],
                                type: 'table',
                                tableTitle: widget.allDate[e]['workList'][m]
                                    ['tableTitle']);
                          }

                          break;
                        case 'input':
                          bool next = true;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = false;
                            }
                          }

                          name = Container();

                          if (next) {
                            String temp =
                                widget.allDate[e]['workList'][m]['value'];
                            String value =
                                temp.substring(temp.indexOf('-') + 1);
                            if (value == '') value = null;
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name'],
                              value: value,
                            );
                          }
                          break;
                        case 'images':
                          bool next = true;
                          if (_editLevel != null) {
                            if (int.parse(_editLevel) != widget.clickName) {
                              next = false;
                            }
                          }
                          name = Container();
                          if (next) {
                            String temp =
                                widget.allDate[e]['workList'][m]['value'];
                            String value =
                                temp.substring(temp.indexOf('-') + 1);
                            if (value == '') value = null;
                            name = MyText(
                              title: widget.allDate[e]['workList'][m]['name']
                                  .toString(),
                              value: value,
                              type: 'images',
                            );
                          }
                          break;
                        default:
                          name = Text(widget.allDate[e]['workList'][m]['name']
                                  .toString() +
                              '暂未开发');
                      }
                      return name;
                    }).toList(),
                  )
                ],
              ));
            }).toList(),
          )
        : Container();
  }
}
