import 'package:enterprise/common/myAppbar.dart';
// import 'package:enterprise/common/myConfirmDialog.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/mySearchPeople.dart';
import 'package:enterprise/pages/home/work/Component/circuit.dart';
import 'package:enterprise/pages/home/work/_workClose.dart';
import 'package:enterprise/pages/home/work/_workPlan.dart';
import 'package:enterprise/pages/home/work/_workRiskIdentification.dart';
import 'package:enterprise/pages/home/work/_workApply.dart';
import 'package:enterprise/pages/home/work/_workSafeList.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

Map mapLocation = {};

class WorkTicker extends StatefulWidget {
  WorkTicker(
      {this.circuit,
      this.id,
      this.operable = true,
      this.bookId,
      this.executionMemo = '',
      this.outSide,
      this.userId = -1,
      this.type,
      this.parentId = 0,
      this.parentReceiptWorkTypeAll = const [],
      this.receiptIdList = const [],
      this.parentReceiptInformation = const []})
      : assert(executionMemo != null, '驳回原因');
  final int circuit, id, bookId, userId, parentId;
  final List<int> receiptIdList;
  final List parentReceiptWorkTypeAll;
  final List parentReceiptInformation;
  final bool operable, outSide;
  final String type;
  final String executionMemo;
  @override
  _WorkTickerState createState() => _WorkTickerState();
}

class _WorkTickerState extends State<WorkTicker> {
  List circuit = [
    //type 0 fill in ; 1 approve
    {
      'name': '计划',
      "isClick": "assets/images/plan-3@2x.png",
      "notClick": "assets/images/plan-2@2x.png",
      'choosed': false,
      'title': '作业计划',
      'allowClick': false,
    },
    {
      'name': '辨识',
      "isClick": "assets/images/identify-1@2x.png",
      "notClick": "assets/images/identify-0@2x.png",
      'choosed': false,
      'title': '风险辨识',
      'allowClick': false,
    },
    {
      'name': '交底',
      "isClick": "assets/images/apply-3@2x.png",
      "notClick": "assets/images/apply-2@2x.png",
      'choosed': false,
      'title': '申请作业',
      'allowClick': false,
    },
    {
      'name': '清单',
      "isClick": "assets/images/list-3@2x.png",
      "notClick": "assets/images/list-2@2x.png",
      'choosed': false,
      'title': '',
      'allowClick': false,
    },
    {
      'name': '关闭',
      "isClick": "assets/images/close-3@2x.png",
      "notClick": "assets/images/close-2@2x.png",
      'choosed': false,
      'title': '',
      'allowClick': false,
    },
  ];
  List<String> titleList = [
    '新增作业计划',
    '作业计划审批',
    '特殊作业风险及危害辨识',
    '作业风险及危害审批',
    '特殊作业相关人员配置',
    '特殊作业安全交底',
    '特殊作业清单',
    '特殊作业清单审批',
    '作业关闭',
    '作业审批关闭'
  ];
  String addtionTitle = '';
  int chooseCircuit = 0;
  MethodChannel platform = const MethodChannel('getLocal');
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    if (Contexts.mobile) {
      mapLocation = await platform.invokeMethod("getLocal");
    }
    if (widget.circuit % 2 == 0) {
      chooseCircuit = widget.circuit ~/ 2 - 1;
    } else {
      chooseCircuit = widget.circuit ~/ 2;
    }
    if (widget.circuit % 2 == 0) {
      circuit[(widget.circuit ~/ 2) - 1]['choosed'] = true;
    } else {
      circuit[widget.circuit ~/ 2]['choosed'] = true;
    }
    for (int i = widget.circuit - 1; i >= 0; i--) {
      circuit[i ~/ 2]['allowClick'] = true;
      if (i == widget.circuit - 1) {
        circuit[i ~/ 2]['type'] = 0;
        if (widget.circuit ~/ 2 > 0) {
          if (widget.operable) {
            circuit[i ~/ 2]['sumbit'] = widget.circuit % 2;
          }
        } else {
          if (widget.operable) {
            circuit[i ~/ 2]['sumbit'] = widget.circuit % 2;
          }
        }
      } else {
        circuit[i ~/ 2]['type'] = 1;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.executionMemo != '') {
        WorkDialog.myDialog(context, () {}, 2,
            widget: Padding(
              padding: EdgeInsets.all(size.width * 20),
              child: Column(
                children: [
                  // Text('驳回原因:' + widget.executionMemo),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '驳回原因:  ', style: TextStyle(color: Colors.amber)),
                    TextSpan(text: widget.executionMemo),
                  ])),
                  SizedBox(
                    height: size.width * 40,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(themeColor)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('确定'),
                  ),
                  SizedBox(
                    height: size.width * 40,
                  )
                ],
              ),
            ));
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  _changeAddtionTitle(String limited) {
    addtionTitle = limited;
    if (mounted) {
      setState(() {});
    }
  }

  _changeState(index) {
    chooseCircuit = index;
    circuit.forEach((element) {
      element['choosed'] = false;
    });
    circuit[index]['choosed'] = true;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _judgeWidget(windowSize) {
    Widget _widget;
    switch (chooseCircuit) {
      case 0:
        // 新建作业计划
        _widget = WorkPlan(
            sumbitWidget: SumbitButton(
              bookId: widget.bookId,
              type: circuit[chooseCircuit]['sumbit'],
              id: widget.id,
              executionMemo: widget.executionMemo,
              circuit: widget.circuit,
              userId: widget.userId,
              parentId: widget.parentId,
              receiptIdList: widget.receiptIdList,
            ),
            circuit: widget.circuit,
            executionMemo: widget.executionMemo,
            id: widget.bookId);
        break;
      case 1:
        _widget = WorkRiskIdentification(
          id: widget.id,
          circuit: widget.circuit,
          bookId: widget.bookId,
          executionMemo: widget.executionMemo,
          parentId: widget.parentId,
          parentReceiptWorkTypeAll: widget.parentReceiptWorkTypeAll,
          sumbitWidget: (int total) {
            return SumbitButton(
                bookId: widget.bookId,
                executionMemo: widget.executionMemo,
                type: circuit[chooseCircuit]['sumbit'],
                id: widget.id,
                userId: widget.userId,
                circuit: widget.circuit,
                riskIdentifiTotal: total);
          },
        );
        break;
      case 2:
        _widget = WorkApply(
          id: widget.id,
          circuit: widget.circuit,
          executionMemo: widget.executionMemo,
          operable: widget.operable,
          parentReceiptInformation: widget.parentReceiptInformation,
          bookId: widget.bookId,
          parentId: widget.parentId,
          sumbitWidget: SumbitButton(
            bookId: widget.bookId,
            userId: widget.userId,
            executionMemo: widget.executionMemo,
            type: circuit[chooseCircuit]['sumbit'],
            id: widget.id,
            circuit: widget.circuit,
          ),
        );
        break;
      case 3:
        _widget = WorkSafeList(
          id: widget.id,
          circuit: widget.circuit,
          executionMemo: widget.executionMemo,
          bookId: widget.bookId,
          operable: widget.operable,
          changeTitle: _changeAddtionTitle,
          sumbitWidget: SumbitButton(
            executionMemo: widget.executionMemo,
            type: circuit[chooseCircuit]['sumbit'],
            id: widget.id,
            bookId: widget.bookId,
            userId: widget.userId,
            circuit: widget.circuit,
          ),
        );
        break;
      case 4:
        _widget = WorkClose(
          id: widget.id,
          circuit: widget.circuit,
          bookId: widget.bookId,
          operable: widget.operable,
          parentId: widget.parentId,
          sumbitWidget: SumbitButton(
            bookId: widget.bookId,
            userId: widget.userId,
            executionMemo: widget.executionMemo,
            type: circuit[chooseCircuit]['sumbit'],
            id: widget.id,
            circuit: widget.circuit,
          ),
        );

        break;
      default:
        _widget = Container();
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    return MyAppbar(
      elevation: 0,
      title: Text(titleList[widget.circuit - 1] + addtionTitle),
      child: WorkCircuit(
        id: widget.id,
        circuit: circuit,
        type: widget.type,
        bookId: widget.bookId,
        circuitInt: widget.circuit,
        outSide: widget.outSide,
        changeState: _changeState,
        child: _judgeWidget(windowSize),
      ),
    );
  }
}

// lock button
class SumbitButton extends StatefulWidget {
  SumbitButton(
      {this.type,
      this.id = 0,
      this.circuit,
      this.executionMemo,
      this.riskIdentifiTotal,
      this.bookId,
      this.userId = -1,
      this.parentId = 0,
      this.receiptIdList = const []});

  // plan need data
  final int parentId;
  final List<int> receiptIdList;
  //
  final int type, id, circuit, bookId, userId;
  final int riskIdentifiTotal;
  final String executionMemo;

  @override
  _SumbitButtonState createState() => _SumbitButtonState();
}

class _SumbitButtonState extends State<SumbitButton> {
  bool click = true;

  _assginWorkPlan(Counter _context, Map post, Function changeOtherNet) {
    String tempTitle = '作业计划';
    post["workName"] = _assginValue(_context.submitDates, '作业名称', tempTitle);
    post["region"] = _assginValue(_context.submitDates, '作业区域', tempTitle);
    post["description"] = _assginValue(_context.submitDates, '作业内容', tempTitle);
    post["territorialUnit"] =
        _assginValue(_context.submitDates, '属地单位', tempTitle);
    post["territorialUnitId"] =
        _assginValue(_context.submitDates, '属地单位', tempTitle, field: 'id');
    post["riskIdentifierUserIds"] =
        _assginValue(_context.submitDates, '作业风险辨识人', tempTitle);
    post['regionId'] =
        _assginValue(_context.submitDates, '作业区域', tempTitle, field: 'id');
    post["planDate"] = _assginValue(_context.submitDates, '作业时间', tempTitle);
    post["isfavorites"] = _assginValue(_context.submitDates, '是否收藏', tempTitle);
    for (var item in post.values) {
      if (item == '') {
        changeOtherNet();
        Fluttertoast.showToast(msg: '请填写完整');
        break;
      }
    }
  }

  _submit(Counter _context, Size windowSize,
      {String types = '通过', String executionMemo = ''}) async {
    String url, typeDio;
    bool otherNet = true; //not await dio
    Map<String, dynamic> post = {};
    __changeOtherNet() {
      otherNet = false;
    }

    FocusScope.of(context).unfocus();
    _context.emptySubmitDates(key: '取消作业');

    if (widget.circuit > 1) {
      post['executionMemo'] = types == '通过' ? null : '';
      // post['executionSign'] = '';
      post['dismissed'] = types == '通过' ? 1 : 2;
      if (types == '驳回') {
        List listTable = [];
        await WorkDialog.myDialog(myContext, ({String dismiss}) {
          if (_context.submitDates['取消作业'] is List) {
            _context.submitDates['取消作业'].forEach((ele) {
              if (ele['title'] == '原因') {
                post['executionMemo'] = ele['value'];
              }
            });
          }
        }, 2, way: types, listTable: listTable);
        if (listTable.isNotEmpty) {
          click = !click;
          setState(() {});
          return;
        }
        if (post['executionMemo'] == '') {
          Fluttertoast.showToast(msg: "请输入驳回原因!");
          click = !click;
          setState(() {});
          return;
        }
      }
    }

    post['longitude'] = mapLocation['longitude'] ?? 0;
    post['latitude'] = mapLocation['latitude'] ?? 0;

    switch (widget.circuit) {
      case 1:
        _assginWorkPlan(_context, post, __changeOtherNet);
        post['planApprovalDepartmentUids'] = [];

        if (post['riskIdentifierUserIds'] is List) {
          for (var i = 0; i < post['riskIdentifierUserIds'].length; i++) {
            if (post['riskIdentifierUserIds'][i] is Map) {
              post['riskIdentifierUserIds'][i] =
                  post['riskIdentifierUserIds'][i]['id'];
            }
          }
        }

        if (post['planApprovalUserIds'] is List) {
          for (var i = 0; i < post['planApprovalUserIds'].length; i++) {
            if (post['planApprovalUserIds'][i] is Map) {
              post['planApprovalUserIds'][i] =
                  post['planApprovalUserIds'][i]['id'];
            }
          }
        }
        post['parentId'] = widget.parentId;
        post['receiptIdList'] = widget.receiptIdList;

        if (executionMemo != '') {
          post["riskIdentifierIds"] = _assginValue(
              _context.submitDates, '作业风险辨识人', '作业计划',
              field: 'id');
          url = Interface.putUpdataWorkPlan + widget.id.toString();
          typeDio = 'put';
        } else {
          url = Interface.postAddWorkPlan;
          typeDio = "post";
        }

        break;
      case 2:
        post['id'] = widget.id;
        url = Interface.postApprovePlan;
        typeDio = "post";
        break;
      case 3:
        otherNet = false;
        List workRiskIdentifyVoList = [];
        if (_context.submitDates['风险辨识'] is List) {
          _context.submitDates['风险辨识'].forEach((ele) {
            workRiskIdentifyVoList.add({
              "factorIds": ele['hazardIds'],
              "workTypeId": ele['workTypeId'],
              "workWays": ele['workWays'],
              "hazardNum": ele['hazardNum'],
              "measuresNum": ele['measuresNum'],
              "hazardMeasures": ele['value'],
              "gasDetectionVo": {
                "samplingDetection": ele['samplingDetection'],
                "portableDetectionint": ele['portableDetectionint'],
                "detectionSiteList": ele["detectionSiteList"]
              }
            });
          });
        }
        _context.emptySubmitDates(key: '辨识作业');

        List listTable = [];
        if (workRiskIdentifyVoList.length < widget.riskIdentifiTotal ||
            workRiskIdentifyVoList.isEmpty) {
          Fluttertoast.showToast(msg: '请完整作业');
          click = !click;
          setState(() {});
          return;
        }

        await WorkDialog.myDialog(myContext, ({String dismiss}) {}, 2,
            listTable: listTable,
            way: types,
            widget: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(width: 1, color: underColor)),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(size.width * 20),
                  child: SourchMutiplePeople(
                    title: '作业交底',
                    purview: '辨识作业',
                    userId: widget.userId,
                    // userId: true,
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(themeColor)),
                    onPressed: () {
                      if (_context.submitDates['辨识作业'] is List) {
                        _context.submitDates['辨识作业'].forEach((ele) {
                          // if (ele['title'] == '风险辨识审批') {
                          //   post['riskIdentifierApprovalUserIds'] =
                          //       ele['value'];
                          //   post['riskIdentifierApprovalDepartmentUids'] = [];
                          // }
                          if (ele['title'] == '作业交底') {
                            post['workApplicationUserIds'] = ele['value'];
                            post['workApplicationDepartmentUids'] = [];
                          }
                        });
                      }
                      if (
                          // post['riskIdentifierApprovalUserIds'] == null ||
                          //   post['riskIdentifierApprovalUserIds'].length == 0 ||
                          post['workApplicationUserIds'] == null ||
                              post['workApplicationUserIds'].length == 0) {
                        Fluttertoast.showToast(msg: '请填写完整');
                      } else {
                        Navigator.pop(myContext);
                      }
                    },
                    child: Text('确定'),
                  ),
                )
              ],
            ));
        if (listTable.isNotEmpty) {
          click = !click;
          setState(() {});
          return;
        }

        myDio.request(
            type: 'post',
            url: Interface.postAddWorkRiskIdentify,
            data: {
              "id": widget.id,
              "executionSign": post['executionSign'],
              "longitude": post['longitude'],
              "latitude": post['latitude'],
              "riskIdentifierApprovalUserIds":
                  post['riskIdentifierApprovalUserIds'],
              "riskIdentifierApprovalDepartmentUids":
                  post['riskIdentifierApprovalDepartmentUids'],
              "workApplicationUserIds": post['workApplicationUserIds'],
              "workApplicationDepartmentUids":
                  post['workApplicationDepartmentUids'],
              "workRiskIdentifyVoList": workRiskIdentifyVoList
            }).then((value) {
          _context.emptySubmitDates(key: '风险辨识');
          Navigator.pop(context);
        }).catchError((onError) {
          click = !click;
          setState(() {});
        });
        break;
      case 4:
        otherNet = false;
        myDio.request(
            type: 'post',
            url: Interface.postApproveRiskIdentify,
            data: {
              "id": widget.id,
              "dismissed": post['dismissed'],
              "executionSign": post['executionSign'],
              "longitude": post['longitude'],
              "latitude": post['latitude'],
              "executionMemo": post['executionMemo']
            }).then((value) {
          Navigator.pop(context);
        }).catchError((onError) {
          click = !click;
          setState(() {});
        });
        break;
      case 5:
        List tempList = _context.submitDates['作业申请'];
        bool next = true;
        List workApplicationVoList = [];
        if (tempList is List) {
          for (var i = 0; i < tempList.length; i++) {
            if (tempList[i]['title'] is int &&
                tempList[i]['value'].isNotEmpty) {
              if (tempList[i]['value']['workDepartmentOpinionList'] == null) {
                Fluttertoast.showToast(msg: "请完成人员配置");
                next = false;
                break;
              }
              workApplicationVoList.add({
                "id": tempList[i]['value']['id'],
                "userIds": tempList[i]['value']['userIds'],
                "guardianId": tempList[i]['value']['guardianId'],
                "workContractorsVoList": tempList[i]['value']
                    ['workContractorsVoList'],
                "safetyMeasuresImplementerVoList": tempList[i]['value']
                    ["safetyMeasuresImplementerVoList"],
                "workTypeFieldList": tempList[i]['value']['workTypeFieldList'],
                "workDepartmentOpinionList": tempList[i]['value']
                    ['workDepartmentOpinionList'],
                "workDutyCrowdList": tempList[i]['value']["workDutyCrowdList"]
              });
            } else if (tempList[i]['title'] is int &&
                tempList[i]['value'].isEmpty) {
              Fluttertoast.showToast(msg: "请完成人员配置");
              next = false;
              break;
            }
          }
        }
        _context.emptySubmitDates(key: '安全交底审批');
        List listTable = [];
        if (!next) {
          click = !click;
          setState(() {});
          return;
        }
        await WorkDialog.myDialog(myContext, ({String dismiss}) {}, 2,
            listTable: listTable,
            way: types,
            widget: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: underColor)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(size.width * 20),
                    child: SourchMutiplePeople(
                        title: '作业关闭人',
                        purview: '安全交底审批',
                        userId: widget.userId)),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(themeColor)),
                    onPressed: () {
                      if (_context.submitDates['安全交底审批'] is List) {
                        _context.submitDates['安全交底审批'].forEach((ele) {
                          // if (ele['title'] == '安全交底审批') {
                          //   post['workApplicationApprovalUserIds'] =
                          //       ele['value'];
                          //   post['workApplicationApprovalDepartmentUids'] = [];
                          // }
                          if (ele['title'] == '作业关闭人') {
                            post['workClosureUserIds'] = ele['value'];
                            post['workClosureDepartmentUids'] = [];
                          }
                        });
                      }
                      if (
                          // post['workApplicationApprovalUserIds'] == null ||
                          //   post['workApplicationApprovalUserIds'].length == 0 ||
                          post['workClosureUserIds'] == null ||
                              post['workClosureUserIds'].length == 0) {
                        Fluttertoast.showToast(msg: '请填写完整');
                      } else {
                        Navigator.pop(myContext);
                      }
                    },
                    child: Text('确定'),
                  ),
                )
              ],
            ));
        if (listTable.isNotEmpty) {
          click = !click;
          setState(() {});
          return;
        }

        if (next) {
          myDio.request(
              type: 'post',
              url: Interface.postAddWorkApplication,
              data: {
                "flowId": widget.id,
                "executionSign": null,
                "longitude": post['longitude'],
                "latitude": post['latitude'],
                "workApplicationVoList": workApplicationVoList,
                "workApplicationApprovalUserIds":
                    post['workApplicationApprovalUserIds'],
                "workApplicationApprovalDepartmentUids":
                    post['workApplicationApprovalDepartmentUids'],
                "workClosureUserIds": post['workClosureUserIds'],
              }).then((value) {
            Navigator.pop(context);
          }).catchError((onError) {
            click = !click;
            setState(() {});
          });
        }
        break;
      case 6:
        otherNet = false;
        myDio.request(type: "post", url: Interface.postApplyApprove, data: {
          "id": widget.id,
          "dismissed": post['dismissed'],
          "executionSign": post['executionSign'],
          "longitude": post['longitude'],
          "latitude": post['latitude'],
          "executionMemo": post['executionMemo']
        }).then((value) {
          Navigator.pop(context);
        });
        break;
      case 7:
        otherNet = false;
        bool _judge = true;
        if (_context.submitDates['作业清单'] is List) {
          _context.submitDates['作业清单'].forEach((ele) {
            if (ele['title'] == '是否可提交') {
              _judge = ele['value'];
            }
          });
        }
        if (_judge) {
          myDio.request(
              type: 'post',
              url: Interface.postCarryOutWorkChecklist,
              data: {
                "id": widget.id,
                "dismissed": post['dismissed'],
                "executionSign": post['executionSign'],
                "longitude": post['longitude'],
                "latitude": post['latitude'],
                "executionMemo": post['executionMemo']
              }).then((value) {
            Navigator.pop(context);
          });
        } else {
          Fluttertoast.showToast(msg: '小票流程未完成');
          click = !click;
          setState(() {});
        }

        break;
      case 9:
        otherNet = false;
        myDio.request(type: 'post', url: Interface.postClose, data: {
          "id": widget.id,
          "dismissed": post['dismissed'],
          "executionSign": post['executionSign'],
          "longitude": post['longitude'],
          "latitude": post['latitude'],
          "executionMemo": post['executionMemo']
        }).then((value) {
          Navigator.pop(context);
        }).catchError((onError) {
          click = !click;
          setState(() {});
        });
        break;
      default:
    }

    if (url == null) return;

    if (otherNet) {
      myDio
          .request(
              type: typeDio,
              url: url,
              queryParameters: typeDio == 'get' ? post : null,
              data: typeDio == 'post' || typeDio == 'put' ? post : null)
          .then((value) {
        // _refreshBack(_context);
        cacheData.change = false;
        Navigator.pop(context);
      }).catchError((onError) {
        click = !click;
        setState(() {});
      });
      // WorkDateBase().insertTable(0, '创建作业', 0, post);
      // click = !click;
      // setState(() {});
    }
  }
  // 聂
  /// return T
  _assginValue(data, name, title, {String field}) {
    var value;
    data[title].forEach((element) {
      if (element['title'] == name) {
        if (element['value'] != null) {
          if (field != null) {
            value = element['id'].toString();
          } else {
            value = element['value'];
          }
        }
      }
    });
    return value;
  }

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    Counter _context = Provider.of<Counter>(context);
    return widget.type != null
        ? Container(
            width: windowSize.width - size.width * 140,
            margin:
                EdgeInsets.only(top: size.width * 30, bottom: size.width * 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widget.type == 0
                    ? Container(
                        width: windowSize.width - size.width * 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(themeColor)),
                              onPressed: click
                                  ? () {
                                      click = !click;
                                      setState(() {});
                                      _submit(_context, windowSize,
                                          types: '驳回');
                                    }
                                  : null,
                              child: Text('驳回'),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff09B907))),
                              onPressed: click
                                  ? () {
                                      click = !click;
                                      setState(() {});
                                      _submit(_context, windowSize,
                                          types: '通过');
                                    }
                                  : null,
                              child: Text('通过'),
                            )
                          ],
                        ),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(themeColor)),
                        onPressed: click
                            ? () {
                                click = !click;
                                setState(() {});
                                _submit(_context, windowSize,
                                    types: "提交",
                                    executionMemo: widget.executionMemo);
                              }
                            : null,
                        child: Text('提交'),
                      )
              ],
            ))
        : Container();
  }
}
