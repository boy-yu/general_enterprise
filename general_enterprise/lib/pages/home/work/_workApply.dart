import 'dart:convert';
import 'package:enterprise/common/loding.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/newMyDrop.dart';
import 'package:enterprise/common/newMyImageCarma.dart';
import 'package:enterprise/common/newMyInput.dart';
import 'package:enterprise/common/newMySearchPeople.dart';
import 'package:enterprise/common/newMychooseTime.dart';
import 'package:enterprise/common/pageDrop.dart' as prefiex;
import 'package:enterprise/pages/home/work/work_dilog/interruptWork.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WorkApply extends StatefulWidget {
  WorkApply(
      {this.sumbitWidget,
      this.circuit,
      this.id,
      this.bookId,
      this.executionMemo,
      this.operable = false,
      this.parentId = 0,
      this.parentReceiptInformation});
  final Widget sumbitWidget;
  final int circuit, id, bookId, parentId;
  final List parentReceiptInformation;
  final String executionMemo;
  final bool operable;
  @override
  _WorkApplyState createState() => _WorkApplyState();
}

class _WorkApplyState extends State<WorkApply> {
  int page = 1;
  bool isPop = false;
  List data = [];
  int choosed = -1;
  List applyList = [];
  List filedData = [];
  String chooseName = '';
  Counter _counter = Provider.of<Counter>(myContext);
  List<List> _secondTempData = [];
  List<List> _thirdTempData = [];
  List<Map> _foursTempData = [];
  List _workDutyCrowdList = [];

  _changeIndex({int index, String msg}) {
    choosed = index;
  }

  _addPeople(
      {@required List inner,
      @required List outer,
      @required Map guarDian,
      @required List implementPeople}) {
    if (choosed < 0) return;
    data[choosed]['inner'] = inner;
    data[choosed]['outer'] = outer;
    List<int> tempId = [];
    inner.forEach((element) {
      tempId.add(element['id']);
    });

    List tempWorkContractorsVoList = [];
    outer.forEach((element) {
      tempWorkContractorsVoList.add({
        "name": element['name'],
        "contractorsStaffVoList": element['names'],
      });
    });
    for (var i = 0; i < filedData.length; i++) {
      filedData[i].remove('peopleData');
    }

    _counter.changeSubmitDates("作业申请", {
      "title": choosed,
      "value": {
        "id": data[choosed]['id'],
        "userIds": tempId,
        "guardianId": guarDian['id'],
        "workContractorsVoList": tempWorkContractorsVoList,
        "workTypeFieldList": filedData,
        "safetyMeasuresImplementerVoList": implementPeople,
        "workDepartmentOpinionList": jsonDecode(jsonEncode(applyList)),
        "workDutyCrowdList": jsonDecode(jsonEncode(_workDutyCrowdList))
      }
    });
    applyList = [];
    _workDutyCrowdList.clear();
    if (mounted) {
      setState(() {});
    }
  }

  _changePage({int pages, String msg}) {
    page = pages;
    isPop = true;
    if (msg != null) {
      chooseName = msg;
    }
    if (mounted) {
      setState(() {});
    }
  }

  _changeFieldData(List list) {
    filedData = list;
    _secondTempData[choosed] = list;
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    myDio.request(type: "get", url: Interface.getApplyData, queryParameters: {
      "bookId": widget.bookId,
      "parentBookId": widget.parentId
    }).then((value) {
      if (value is List) {
        data = value;
        data.forEach((element) {
          _secondTempData.add([]);
          _thirdTempData.add([]);
          _foursTempData.add({});
        });
        _assignData();
      }
    });
  }

  _assignData() async {
    _counter.emptySubmitDates(key: '安全交底');
    _counter.emptySubmitDates(key: '作业申请');
    for (var i = 0; i < data.length; i++) {
      _counter.changeSubmitDates("作业申请", {"title": i, "value": {}});
      data[i]['inner'] = data[i]['thisCompany'];
      List tempId = [];
      int guarDianId = -1;
      List tempWorkContractorsVoList = [];
      if (data[i]['inner'] is List) {
        for (var _i = 0; _i < data[i]['inner'].length; _i++) {
          if (data[i]['inner'][_i]['guardian'] == 1) {
            guarDianId = data[i]['inner'][_i]['userId'];
            data[i]['inner'][_i]['guarDian'] = true;
          }
          tempId.add(data[i]['inner'][_i]['userId']);
        }

        if (data[i]['contractorsMap'] is Map) {
          data[i]['contractorsMap'].forEach((key, _value) {
            List contractorsStaffVoList = [];
            if (_value is List) {
              _value.forEach((element) {
                contractorsStaffVoList.add({
                  "name": element['name'],
                  "certificateName": element['relatedCertificate']
                      ['certificateName'],
                  "frontPicture": element['relatedCertificate']['frontPicture']
                });
              });
            }
            tempWorkContractorsVoList.add({
              "name": key,
              "contractorsStaffVoList": contractorsStaffVoList
            });
          });
        }
        _counter.changeSubmitDates("作业申请", {
          "title": i,
          "value": {
            "id": data[i]['id'],
            "userIds": tempId,
            "guardianId": guarDianId,
            "workContractorsVoList": tempWorkContractorsVoList
          }
        });
      }
      if (data[i]['contractorsMap'] is Map) {
        data[i]['outer'] = [];
        data[i]['contractorsMap'].forEach((key, values) {
          data[i]['outer']
              .add({"name": key, "type": "contractors", "names": values});
        });
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  _changeisPop(bool change) {
    isPop = change;
  }

  Widget _judgetWidget() {
    Widget _widget = Container();
    switch (page) {
      case 1:
        _widget = WorkApplyFirst(widget.operable,
            changeIndex: _changeIndex,
            sumbitWidget: widget.sumbitWidget,
            data: data,
            length: data.length,
            circuit: widget.circuit,
            getData: _getData,
            callback: _changePage);
        break;
      case 2:
        _widget = WorkApplySecond(
          parentReceiptInformation: widget.parentReceiptInformation,
          listCallback: _changeFieldData,
          callback: _changePage,
          chooseName: chooseName,
          counter: _counter,
          tempData: _secondTempData[choosed],
          workDutyCrowdList: _workDutyCrowdList,
          changeisPop: _changeisPop,
        );
        break;
      case 3:
        _widget = ApplyAdmini(
            parentReceiptInformation: widget.parentReceiptInformation,
            name: data[choosed]['name'].toString(),
            data: applyList,
            changePage: _changePage,
            tempList: _thirdTempData[choosed],
            changeisPop: _changeisPop,
            changeData: (value) {
              if (value is List) {
                _thirdTempData[choosed] = value;
                applyList = value;
                setState(() {});
              }
            });
        break;
      case 4:
        _widget = Addpeople(
            parentReceiptInformation: widget.parentReceiptInformation,
            changePage: _changePage,
            id: data[choosed]['id'],
            changeisPop: _changeisPop,
            workName: chooseName,
            addPeopel: _addPeople,
            mapData: data[choosed],
            tempData: _foursTempData[choosed]);

        break;
      default:
        _widget = Center(
          child: Text('数据异常'),
        );
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: _judgetWidget(),
        onWillPop: () async {
          if (isPop) {
            isPop = false;
            return true;
          }

          if (page != 1) {
            _changePage(
              pages: page - 1,
            );
            return false;
          }
          return true;
        });
  }
}

class ApplyAdmini extends StatefulWidget {
  final List data;
  final String name;
  final Function({int pages, String msg}) changePage;
  final Function(dynamic value) changeData;
  final Function(bool change) changeisPop;
  final List tempList;
  //renew ticket
  final List parentReceiptInformation;
  const ApplyAdmini(
      {Key key,
      this.data,
      this.name,
      this.changeData,
      this.changePage,
      this.tempList,
      this.changeisPop,
      this.parentReceiptInformation})
      : super(key: key);
  @override
  _ApplyAdminiState createState() => _ApplyAdminiState();
}

class _ApplyAdminiState extends State<ApplyAdmini> {
  _init() {
    if (widget.tempList.isEmpty || widget.parentReceiptInformation.isNotEmpty) {
      int parentReceiptId = -1;
      if (widget.parentReceiptInformation is List) {
        for (var i = 0; i < widget.parentReceiptInformation.length; i++) {
          if (widget.name == widget.parentReceiptInformation[i]['workName']) {
            parentReceiptId = widget.parentReceiptInformation[i]['receiptId'];
            break;
          }
        }
      }
      myDio.request(
          type: 'get',
          url: Interface.getWorkDepartmentList,
          queryParameters: {
            "workName": widget.name,
            "parentReceiptId": parentReceiptId > -1 ? parentReceiptId : null
          }).then((value) {
        if (value is List) {
          if (widget.parentReceiptInformation.isNotEmpty) {
            value.forEach((element) {
              element['fieldValue'] = element['user'];
            });
          }
          widget.changeData(value);
        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.changeData(widget.tempList);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size.width * 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.data.isNotEmpty
                  ? Text('${widget.data[0]['workName']}作业审批流程')
                  : Container()
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
                children: widget.data
                    .map((e) => Container(
                          child: prefiex.PageDrop(
                            ontap: () {
                              widget.changeisPop(true);
                            },
                            title: e['workRole'],
                            data: [],
                            placeHolder: e['fieldValue'] ?? '',
                            dataUrl: Interface.getWorkDepartmentUserList,
                            callSetstate: (data) {
                              e['userId'] = data['id'];
                              e['fieldValue'] = data['name'];
                            },
                            queryParameters: {"id": e['id']},
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: underColor))),
                        ))
                    .toList()),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () {
                  widget.changePage(pages: 2);
                },
                child: Text('上一步'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(themeColor)),
                onPressed: () {
                  bool next = true;
                  for (Map element in widget.data) {
                    if (element['userId'] == 0) {
                      next = false;
                      break;
                    }
                  }

                  if (next) {
                    widget.changePage(pages: 4);
                  } else {
                    Fluttertoast.showToast(msg: '数据存在未填写!');
                  }
                },
                child: Text('下一步'),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 50,
          )
        ],
      ),
    );
  }
}

class WorkApplyFirst extends StatefulWidget {
  final Widget sumbitWidget;
  final List data;
  final Function({int pages, String msg}) callback;
  final Function({int index, String msg}) changeIndex;
  final Function getData;
  final int circuit, length;
  final bool operable;
  const WorkApplyFirst(this.operable,
      {Key key,
      this.sumbitWidget,
      this.data,
      this.length,
      this.callback,
      this.changeIndex,
      this.circuit,
      this.getData})
      : super(key: key);
  @override
  _WorkApplyFirstState createState() => _WorkApplyFirstState();
}

class _WorkApplyFirstState extends State<WorkApplyFirst> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              itemCount: widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ApplyItem(widget.operable,
                    dataMap: widget.data[index],
                    index: index,
                    length: widget.length,
                    circuit: widget.circuit,
                    getData: widget.getData, callback: () {
                  widget.changeIndex(index: index);
                  widget.callback(
                      pages: 2, msg: widget.data[index]['name'].toString());
                });
              }),
        ),
        widget.sumbitWidget,
        SizedBox(
          height: size.width * 50,
        )
      ],
    );
  }
}

class ApplyItem extends StatelessWidget {
  ApplyItem(
    this.operable, {
    @required this.dataMap,
    this.index,
    this.callback,
    this.length,
    this.circuit,
    this.getData,
  });
  final Map dataMap;
  final int index, circuit, length;
  final Function callback, getData;
  final bool operable;
  final List inner = [];
  final List outer = [];

  _getImage(String workName) {
    switch (workName) {
      case '动火作业':
        return 'assets/images/icon_fire_check.png';
        break;
      case '临时用电':
        return 'assets/images/icon_electric_check.png';
        break;
      case '吊装作业':
        return 'assets/images/icon_hoisting_check.png';
        break;
      case '高处作业':
        return 'assets/images/icon_height_check.png';
        break;
      case '受限空间':
        return 'assets/images/icon_limitation_check.png';
        break;
      case '盲板抽堵':
        return 'assets/images/icon_blind_plate_wall_check.png';
        break;
      case '动土作业':
        return 'assets/images/icon_soil_check.png';
        break;
      case '断路作业':
        return 'assets/images/icon_turnoff_check.png';
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        if (!operable) return;
        if (length < 2) {
          InterruptWork.detailInterrup(details, context, dataMap['id'], getData,
              type: InterruptWorkType.onlyChange);
          return;
        }
        InterruptWork.detailInterrup(
          details,
          context,
          dataMap['id'],
          getData,
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: size.width * 20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), spreadRadius: 1.0)
        ]),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    width: size.width * 75,
                    height: size.width * 86,
                    image: AssetImage(_getImage(dataMap['name'])),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          dataMap['name'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 34,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.width * 10,
                        ),
                        circuit == 5
                            ? Container(
                                width: size.width * 140,
                                height: size.width * 44,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              side: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xff6D9FFD))),
                                  onPressed: callback,
                                  child: Text(
                                    '编辑',
                                    style: TextStyle(
                                        fontSize: size.width * 22,
                                        color: Colors.white),
                                  ),

                                  ///圆角
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: '危害识别：',
                            style: TextStyle(
                                color: Color(0xff6D9FFD),
                                fontSize: size.width * 24),
                          ),
                          TextSpan(
                            text: dataMap['hazardNum'].toString(),
                            style: TextStyle(
                                color: Color(0xffff5555),
                                fontSize: size.width * 24),
                          ),
                          TextSpan(
                            text: '条',
                            style: TextStyle(
                                color: Color(0xffff5555),
                                fontSize: size.width * 24),
                          ),
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: '安全措施：',
                            style: TextStyle(
                                color: Color(0xff6D9FFD),
                                fontSize: size.width * 24),
                          ),
                          TextSpan(
                            text: dataMap['measuresNum'].toString(),
                            style: TextStyle(
                                color: Color(0xff09ba07),
                                fontSize: size.width * 24),
                          ),
                          TextSpan(
                            text: '条',
                            style: TextStyle(
                                color: Color(0xff09ba07),
                                fontSize: size.width * 24),
                          ),
                        ])),
                      ],
                    ),
                  ],
                ))
              ],
            ),
            Row(
              children: <Widget>[
                dataMap['inner'] != null
                    ? Container(
                        width: size.width * 350,
                        height: size.width * 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    alignment:
                                        const FractionalOffset(1.2, -0.1),
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 59,
                                        height: size.width * 59,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xff09ba07),
                                              width: 1),
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/work_avatar.png'),
                                          ),
                                        ),
                                      ),
                                      dataMap['inner'][index]['guarDian'] ==
                                              true
                                          ? Container(
                                              width: size.width * 26,
                                              height: size.width * 26,
                                              decoration: BoxDecoration(
                                                color: Color(0xff09ba07),
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '监',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          size.width * 16),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Text(
                                    dataMap['inner'][index]['name'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 20),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: dataMap['inner'].length,
                        ),
                      )
                    : Container(),
                dataMap['outer'] != null
                    ? Expanded(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Column(
                                children: dataMap['outer']
                                    .asMap()
                                    .keys
                                    .map<Widget>((index) {
                              return Column(
                                children: [
                                  Container(
                                    width: size.width * 148,
                                    height: size.width * 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xff6D9FFD), width: 1),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        // Image(
                                        //   width: size.width * 31,
                                        //   height: size.width * 27,
                                        //   image: AssetImage(
                                        //       'assets/images/icon_apply_people.png'),
                                        // ),
                                        Text(
                                          '人数：',
                                          style: TextStyle(
                                              color: Color(0xff6D9FFD),
                                              fontSize: size.width * 22),
                                        ),
                                        Text(
                                          dataMap['outer'][index]['names']
                                              .length
                                              .toString(),
                                          style: TextStyle(
                                              color: Color(0xff6D9FFD),
                                              fontSize: size.width * 22),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Text(
                                    dataMap['outer'][index]['name'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 20),
                                  ),
                                ],
                              );
                            }).toList())))
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WorkApplySecond extends StatefulWidget {
  final String chooseName;
  final VideoCallBackFunc listCallback;
  final Function({int pages, String msg}) callback;
  final Function(bool change) changeisPop;
  final Counter counter;
  final List tempData, workDutyCrowdList;
  // for renew Ticket;
  final List parentReceiptInformation;
  const WorkApplySecond({
    Key key,
    this.chooseName,
    this.callback,
    this.counter,
    this.listCallback,
    this.tempData,
    this.workDutyCrowdList,
    this.changeisPop,
    this.parentReceiptInformation,
  }) : super(key: key);
  @override
  _WorkApplySecondState createState() => _WorkApplySecondState();
}

class _WorkApplySecondState extends State<WorkApplySecond> {
  void initState() {
    super.initState();
    _getdata();
  }

  List data = [];
  _getdata() {
    if (widget.tempData.isEmpty) {
      int parentReceiptId = -1;
      if (widget.parentReceiptInformation is List) {
        for (var i = 0; i < widget.parentReceiptInformation.length; i++) {
          if (widget.chooseName ==
              widget.parentReceiptInformation[i]['workName']) {
            parentReceiptId = widget.parentReceiptInformation[i]['receiptId'];
            break;
          }
        }
      }
      myDio.request(
          type: 'get',
          url: Interface.getWorkTypeFieldList,
          queryParameters: {
            "workName": widget.chooseName,
            "parentReceiptId": parentReceiptId > -1 ? parentReceiptId : null
          }).then((value) {
        if (value is List) {
          data = value;
          if (parentReceiptId > -1) {
            data.forEach((element) {
              if (element['type'] == 'dropPeopleOnline') {
                widget.workDutyCrowdList.add({
                  "position": element['fieldName'],
                  "userId": element["userId"]
                });
              }
            });
          }
          if (mounted) {
            setState(() {});
          }
        }
      });
    } else {
      data = widget.tempData;
      if (widget.workDutyCrowdList.isEmpty) {
        data.forEach((element) {
          if (element['type'] == 'dropPeopleOnline') {
            widget.workDutyCrowdList.add({
              "position": element['fieldName'],
              "userId": element["userId"]
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: data.map((ele) {
                Widget _widget;
                switch (ele['type']) {
                  case 'input':
                    _widget = Container(
                      child: NewMyInput(
                        title: ele['fieldName'],
                        value: ele['fieldValue'],
                        onChange: (value) {
                          ele['fieldValue'] = value;
                        },
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: underColor))),
                    );
                    break;
                  case 'sign':
                    _widget = Container();
                    break;
                  case 'uploadImage':
                    _widget = NewMyImageCarma(
                      title: ele['fieldName'],
                      placeHolder: ele['fieldValue'],
                      callback: (value) {
                        ele['fieldValue'] = '';
                        for (var i = 0; i < value.length; i++) {
                          if (i == value.length - 1) {
                            ele['fieldValue'] += value[i];
                          } else {
                            ele['fieldValue'] += value[i] + '|';
                          }
                        }
                      },
                      score: 3,
                    );
                    break;
                  case 'time':
                    _widget = Container(
                      padding: EdgeInsets.symmetric(vertical: size.width * 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: underColor))),
                      child: NewMychooseTime(
                        title: ele['fieldName'],
                        placeholder: ele['fieldValue'].toString(),
                        callback: (msg) {
                          ele['fieldValue'] = msg;
                        },
                      ),
                    );
                    break;
                  case 'drop':
                    _widget = Container(
                      padding: EdgeInsets.symmetric(vertical: size.width * 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: underColor))),
                      child: NewMyDrop(
                        callSetstate: (value) {
                          ele['fieldValue'] = value['name'];
                        },
                        dataUrl: Interface.getWorkLevel,
                        placeHolder: ele['fieldValue'].toString(),
                        title: ele['fieldName'],
                        data: [],
                        queryParameters: {
                          "workType": widget.chooseName,
                        },
                      ),
                    );
                    break;
                  case 'dropPeopleOnline':
                    _widget = Container(
                      padding: EdgeInsets.symmetric(vertical: size.width * 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: underColor))),
                      child: prefiex.PageDrop(
                        ontap: () {
                          widget.changeisPop(true);
                        },
                        callSetstate: (value) {
                          bool has = false;
                          for (var i = 0;
                              i < widget.workDutyCrowdList.length;
                              i++) {
                            if (widget.workDutyCrowdList[i]["position"] ==
                                ele['fieldName']) {
                              widget.workDutyCrowdList[i]["userId"] =
                                  value["id"];
                              has = false;
                              break;
                            } else {
                              has = true;
                            }
                          }
                          if (has || widget.workDutyCrowdList.isEmpty) {
                            widget.workDutyCrowdList.add({
                              "position": ele['fieldName'],
                              "userId": value["id"]
                            });
                          }
                          ele['fieldValue'] = value['name'];
                          ele['userId'] = value['id'];
                        },
                        dataUrl: Interface.getWorkRoleUserList,
                        placeHolder: ele['fieldValue'].toString(),
                        title: ele['fieldName'],
                        data: [],
                        queryParameters: {
                          "workName": widget.chooseName,
                          'workRole': ele['fieldName']
                        },
                      ),
                    );
                    break;
                  case 'dropPeople':
                    _widget = Container(
                      padding: EdgeInsets.symmetric(vertical: size.width * 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: underColor))),
                      child: NewSourchMutiplePeople(
                        title: ele['fieldName'],
                        userId: myprefs.getInt('userId'),
                        value: ele['peopleData'],
                        callback: (map) {
                          for (var i = 0; i < map.length; i++) {
                            if (i == map.length - 1) {
                              ele['fieldValue'] += map[i].name;
                            } else {
                              ele['fieldValue'] += map[i].name + "|";
                            }
                          }
                          ele['peopleData'] = map;
                        },
                      ),
                    );
                    break;

                  default:
                    print(ele);
                    _widget = Center(child: Text('该版块正在开发'));
                }
                return _widget;
              }).toList(),
            ),
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                widget.counter.emptySubmitDates(key: '安全交底');
                widget.callback(pages: 1);
              },
              child: Text('上一步'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                data.forEach((element) {
                  if (element['type'] == 'sign') {
                    element['fieldValue'] = myprefs.getString('sign');
                  }
                });

                for (var i = 0; i < data.length; i++) {
                  if (data[i]['fieldValue'] == '') {
                    Fluttertoast.showToast(msg: '请填写完整所有数据');
                    return;
                  }
                }

                widget.listCallback(data);
                widget.callback(pages: 3);
              },
              child: Text('下一步'),
            ),
          ],
        ),
        SizedBox(
          height: size.width * 150,
        )
      ],
    );
  }
}

class Addpeople extends StatefulWidget {
  final Function({int pages, String msg}) changePage;
  final int id;
  final List parentReceiptInformation;
  final Function(bool) changeisPop;
  final Map tempData;
  final String workName;
  final Map mapData;
  final Function(
      {@required List<dynamic> inner,
      @required List<dynamic> outer,
      @required Map guarDian,
      @required List implementPeople}) addPeopel;
  const Addpeople(
      {Key key,
      @required this.changePage,
      this.id,
      @required this.changeisPop,
      @required this.addPeopel,
      this.tempData,
      this.mapData,
      this.parentReceiptInformation,
      this.workName})
      : super(key: key);
  @override
  _AddpeopleState createState() => _AddpeopleState();
}

class _AddpeopleState extends State<Addpeople> {
  PeopleStructure _grantian = PeopleStructure(id: -1);
  List<PeopleStructure> _workPeople = [];
  List data = [];
  List saveFiliter = [];
  List filiterId = [];
  int filiterGranId = -1;
  bool show = false;
  @override
  void initState() {
    super.initState();
    _getDate();
    _getGrantion();
  }

  _getGrantion() {
    myDio.request(
        type: "get",
        url: Interface.getWorkCrowdReceipyid,
        queryParameters: {"receiptId": widget.id}).then((value) {
      if (value is Map) {
        saveFiliter.clear();
        filiterGranId = value['guardianUserId'];
        filiterId = value['userIds'];
        filiterId.forEach((element) {
          saveFiliter.add(element);
        });
      }
      show = true;
      setState(() {});
    });
  }

  _getDate() {
    int parentReceiptId = -1;
    if (widget.parentReceiptInformation is List) {
      for (var i = 0; i < widget.parentReceiptInformation.length; i++) {
        if (widget.workName == widget.parentReceiptInformation[i]['workName']) {
          parentReceiptId = widget.parentReceiptInformation[i]['receiptId'];
          break;
        }
      }
    }
    myDio.request(
        type: 'get',
        url: Interface.getWorkApplyReceiptld,
        queryParameters: {
          "receiptId": widget.id,
          "parentReceiptId": parentReceiptId
        }).then((value) {
      if (value is List) {
        data = value;
        data.forEach((element) {
          element['fieldValue'] = element['user'];
        });
        if (widget.tempData.isNotEmpty &&
            widget.tempData['implement'] is List) {
          _grantian = widget.tempData['grantian'][0];
          _workPeople = widget.tempData['work'];
          for (var i = 0; i < widget.tempData['implement'].length; i++) {
            data[i]['fieldValue'] =
                widget.tempData['implement'][i]['fieldValue'];
            data[i]['userId'] = widget.tempData['implement'][i]['userId'];
          }
        }
      }
    });

    if (widget.mapData != null) {
      _workPeople.clear();
      if (widget.mapData['thisCompany'] is List) {
        List _temp = widget.mapData['thisCompany'];
        _temp.forEach((element) {
          if (element['guardian'] != 1) {
            _workPeople.add(PeopleStructure(
                id: element['userId'],
                name: element['name'],
                position: element['personnelDepartment']));
          } else {
            _grantian = PeopleStructure(
                id: element['userId'],
                name: element['name'],
                position: element['personnelDepartment']);
          }
        });
      }
    }
  }

  _jedgeInput() {
    if (_grantian.id < 0) {
      successToast('请选择作业监护人');
      return;
    }

    if (_workPeople.isEmpty) {
      successToast('请选择作业人');
      return;
    }
    List<Map> inner = [];
    _workPeople.forEach((element) {
      inner.add({"id": element.id, "name": element.name});
    });
    inner.add({"id": _grantian.id, "name": _grantian.name, "guarDian": true});
    for (var i = 0; i < data.length; i++) {
      if (data[i]['userId'] == null) {
        successToast('请选择措施落实人');
        return;
      }
    }

    widget.tempData['grantian'] = [_grantian];
    widget.tempData['work'] = _workPeople;
    widget.tempData['implement'] = data;

    widget.changePage(pages: 1);
    widget.addPeopel(
        guarDian: {
          "id": _grantian.id,
          "name": _grantian.name,
        },
        inner: inner,
        outer: [],
        implementPeople: data);
  }

// 超级
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        show
            ? Expanded(
                child: SingleChildScrollView(
                    child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/safejhr@2x.png",
                                width: size.width * 84,
                                height: size.width * 86,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  // width: size.width * 390,
                                  child: NewSourchMutiplePeople(
                                      palcehoder:
                                          _grantian.id > -1 ? [_grantian] : [],
                                      filterId: filiterId,
                                      way: true,
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Colors.black),
                                      title: '作业监护人',
                                      value: widget.tempData['grantian'],
                                      callback: (data) {
                                        filiterId =
                                            jsonDecode(jsonEncode(saveFiliter));
                                        _grantian = data[0];
                                        filiterId.add(_grantian.id);
                                        setState(() {});
                                      }))
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/safezyr@2x.png",
                                width: size.width * 84,
                                height: size.width * 86,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: NewSourchMutiplePeople(
                                      filterId: filiterId,
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Colors.black),
                                      title: '作业人',
                                      palcehoder: _workPeople,
                                      value: widget.tempData['work'],
                                      callback: (data) {
                                        filiterId =
                                            jsonDecode(jsonEncode(saveFiliter));
                                        filiterId.add(_grantian.id);
                                        data.forEach((element) {
                                          filiterId.add(element.id);
                                        });
                                        _workPeople = data;
                                        setState(() {});
                                      }))
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('安全措施落实人',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Column(
                    children: data
                        .asMap()
                        .keys
                        .map((index) => Padding(
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                onPressed: () {},
                                child: Column(children: [
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      child: prefiex.PageDrop(
                                        ontap: () {
                                          widget.changeisPop(true);
                                        },
                                        callSetstate: (value) {
                                          data[index]['userId'] = value['id'];
                                          data[index]['fieldValue'] =
                                              value['name'];
                                        },
                                        placeHolder:
                                            data[index]['fieldValue'] ?? '',
                                        dataUrl:
                                            Interface.getUserByControlAuthority,
                                        title: data[index]['controlAuthority']
                                            .toString(),
                                        queryParameters: {
                                          "controlAuthority": data[index]['controlAuthority']
                                        },
                                      ))
                                ]))))
                        .toList(),
                  ),
                ],
              )))
            : StaticLoding(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                widget.changePage(pages: 3);
              },
              child: Text('上一步'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: _jedgeInput,
              child: Text('确定'),
            ),
          ],
        ),
        SizedBox(
          height: size.width * 50,
        )
      ],
    );
  }
}
