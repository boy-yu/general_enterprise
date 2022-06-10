import 'package:drag_container/drag/drag_controller.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/myView/myDragContainer.dart';
import 'package:enterprise/pages/hiddenCheckGovern/taskHandle/_affirmHidden.dart';
import 'package:enterprise/pages/hiddenCheckGovern/taskHandle/_reformAccept.dart';
import 'package:enterprise/pages/hiddenCheckGovern/taskHandle/_reformFinish.dart';
import 'package:enterprise/pages/hiddenCheckGovern/taskHandle/_troubleshoot.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskHandle extends StatefulWidget {
  TaskHandle({this.dangerState, this.id, this.checkMeans, this.type});
  final String dangerState;
  final String id;
  final String checkMeans;
  final String type;
  @override
  State<TaskHandle> createState() => _TaskHandleState();
}

class _TaskHandleState extends State<TaskHandle> {
  String _getTitle(String dangerState) {
    // 隐患状态（待确认：-1；整改中：0；待验收：1；已验收：9）
    switch (dangerState) {
      case 'check':
        return '排查';
        break;
      case '-1':
        return '确认隐患';
        break;
      case '0':
        return '整改完毕';
        break;
      case '1':
        return '整改审批';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      elevation: 0,
      title: Text(
        _getTitle(widget.dangerState),
        style: TextStyle(fontSize: size.width * 32),
      ),
      child: Stack(
        children: [
          ScrollTop(
              dangerState: widget.dangerState,
              id: widget.id,
              type: widget.type),
          BuildDragWidget(
              dangerState: widget.dangerState,
              id: widget.id,
              checkMeans: widget.checkMeans),
        ],
      ),
    );
  }
}

class ScrollTop extends StatefulWidget {
  ScrollTop({this.id, this.dangerState, this.type});
  final String id, dangerState, type;
  @override
  State<ScrollTop> createState() => _ScrollTopState();
}

class _ScrollTopState extends State<ScrollTop> {
  @override
  void initState() {
    super.initState();
    _getDropData();
  }

  _getDropData() {
    if (widget.dangerState == 'check') {
      myDio.request(
          type: 'get',
          url: Interface.getRiskControlDataById,
          queryParameters: {'id': widget.id}).then((value) {
        if (value is Map) {
          value.forEach((key, value) {
            dropData.forEach((element) {
              if (element['bindKey'] == key) {
                element['value'] = value ?? '';
              }
            });
          });
        }
        if (mounted) {
          setState(() {});
        }
      });
    } else {
      myDio.request(
          type: 'get',
          url: Interface.getHiddenDangereById,
          queryParameters: {'id': widget.id}).then((value) {
        if (value is Map) {
          perData = value;
          if (widget.type == '上报') {
            dropData = [
              {"name": "风险分析对象", "value": '', "bindKey": 'riskObjectName'},
              {"name": "责任部门", "value": '', "bindKey": 'hazardDep'},
              {"name": "责任人", "value": '', "bindKey": 'hazardLiablePerson'},
              {"name": "地点", "value": '', "bindKey": 'address'},
            ];
            value.forEach((key, value) {
              dropData.forEach((element) {
                if (element['bindKey'] == key) {
                  element['value'] = value ?? '';
                }
              });
            });
          } else {
            value.forEach((key, value) {
              dropData.forEach((element) {
                if (element['bindKey'] == key) {
                  element['value'] = value ?? '';
                }
              });
            });
          }
        }
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  Map perData = {
    "checkUser": "",
    "checkUserTelephone": "",
    "checkDepartment": "",
    "registrant": "",
    "registDepartment": "",
    "registUserTelephone": "",
    "liablePerson": "",
    "liableUserTelephone": "",
    "liableDepartment": "",
    "checkAcceptPerson": "",
    "checkAcceptUserTelephone": "",
    "checkAcceptDepartment": "",
  };

  List<Map> dropData = [
    {"name": "风险分析对象", "value": '', "bindKey": 'riskObjectName'},
    {"name": "责任部门", "value": '', "bindKey": 'hazardDep'},
    {"name": "责任人", "value": '', "bindKey": 'hazardLiablePerson'},
    {"name": "风险分析单元", "value": '', "bindKey": 'riskUnitName'},
    {"name": "风险事件", "value": '', "bindKey": 'riskEventName'},
    {"name": "当前风险等级", "value": '', "bindKey": 'currentRiskLevel'},
    {"name": "风险描述", "value": '', "bindKey": 'riskDescription'},
    {"name": "初始风险后果", "value": '', "bindKey": 'initialRiskConsequences'},
    {"name": "初始风险度", "value": '', "bindKey": 'initialRiskDegree'},
    {"name": "初始风险等级", "value": '', "bindKey": 'initialRiskLevel'},
    {"name": "管控措施", "value": '', "bindKey": 'riskMeasureDesc'},
    {"name": "隐患排查任务", "value": '', "bindKey": 'troubleshootContent'},
  ];

  String _getText(String name, String value) {
    // 风险等级：1_重大2_较大3_一般4_低
    if (name == '当前风险等级' || name == '初始风险等级') {
      switch (value) {
        case '1':
          return '重大风险';
          break;
        case '2':
          return '较大风险';
          break;
        case '3':
          return '一般风险';
          break;
        case '4':
          return '低风险';
          break;
        default:
          return value.toString();
      }
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return Container(
        width: widghtSize.width,
        height: widghtSize.height,
        padding: EdgeInsets.only(bottom: size.width * 200),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/doubleRiskProjeck/bg_hidden_blue.png'),
              fit: BoxFit.fitHeight),
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: size.width * 32,
                  right: size.width * 32,
                  top: size.width * 32),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.15),
                      spreadRadius: size.width * 2,
                      blurRadius: size.width * 16)
                ],
                border: Border.all(
                    width: size.width * 2,
                    color: Colors.white.withOpacity(0.1)),
              ),
              child: ListView.builder(
                itemCount: dropData.length,
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: size.width * 22),
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 24,
                          vertical: size.width * 10),
                      child: Text(
                        '${dropData[index]['name']}：${_getText(dropData[index]['name'].toString(), dropData[index]['value'].toString())}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w500),
                      ));
                },
              ),
            ),
            perData['checkUser'] == '' || widget.dangerState == 'check'
                ? Container()
                : Container(
                    margin: EdgeInsets.only(
                        left: size.width * 32,
                        right: size.width * 32,
                        top: size.width * 32),
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 32, horizontal: size.width * 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.15),
                            spreadRadius: size.width * 2,
                            blurRadius: size.width * 16)
                      ],
                      border: Border.all(
                          width: size.width * 2,
                          color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: size.width * 300,
                                  child: Text(
                                    '隐患上报人：${perData['checkUser']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '部门：${perData['checkDepartment']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.width * 32,
                            ),
                            Text(
                              '电话：${perData['checkUserTelephone']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            launch('tel:${perData['checkUserTelephone']}');
                          },
                          child: Container(
                            height: size.width * 64,
                            width: size.width * 64,
                            decoration: BoxDecoration(
                                color: Color(0xff3074FF),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_dep_telephone.png',
                              height: size.width * 35,
                              width: size.width * 35,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            perData['registrant'] == '' || widget.dangerState == 'check'
                ? Container()
                : Container(
                    margin: EdgeInsets.only(
                        left: size.width * 32,
                        right: size.width * 32,
                        top: size.width * 32),
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 32, horizontal: size.width * 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.15),
                            spreadRadius: size.width * 2,
                            blurRadius: size.width * 16)
                      ],
                      border: Border.all(
                          width: size.width * 2,
                          color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: size.width * 300,
                                  child: Text(
                                    '隐患确认人：${perData['registrant']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '部门：${perData['registDepartment']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.width * 32,
                            ),
                            Text(
                              '电话：${perData['registUserTelephone']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            launch('tel:${perData['registUserTelephone']}');
                          },
                          child: Container(
                            height: size.width * 64,
                            width: size.width * 64,
                            decoration: BoxDecoration(
                                color: Color(0xff3074FF),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_dep_telephone.png',
                              height: size.width * 35,
                              width: size.width * 35,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            perData['liablePerson'] == '' || widget.dangerState == 'check'
                ? Container()
                : Container(
                    margin: EdgeInsets.only(
                        left: size.width * 32,
                        right: size.width * 32,
                        top: size.width * 32),
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 32, horizontal: size.width * 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.15),
                            spreadRadius: size.width * 2,
                            blurRadius: size.width * 16)
                      ],
                      border: Border.all(
                          width: size.width * 2,
                          color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: size.width * 300,
                                  child: Text(
                                    '整改责任人：${perData['liablePerson']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '部门：${perData['liableDepartment']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.width * 32,
                            ),
                            Text(
                              '电话：${perData['liableUserTelephone']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            launch('tel:${perData['liableUserTelephone']}');
                          },
                          child: Container(
                            height: size.width * 64,
                            width: size.width * 64,
                            decoration: BoxDecoration(
                                color: Color(0xff3074FF),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_dep_telephone.png',
                              height: size.width * 35,
                              width: size.width * 35,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            perData['checkAcceptPerson'] == '' || widget.dangerState == 'check'
                ? Container()
                : Container(
                    margin: EdgeInsets.only(
                        left: size.width * 32,
                        right: size.width * 32,
                        top: size.width * 32),
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 32, horizontal: size.width * 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.15),
                            spreadRadius: size.width * 2,
                            blurRadius: size.width * 16)
                      ],
                      border: Border.all(
                          width: size.width * 2,
                          color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: size.width * 300,
                                  child: Text(
                                    '验收人：${perData['checkAcceptPerson']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  width: size.width * 250,
                                  child: Text(
                                    '部门：${perData['checkAcceptDepartment']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.width * 32,
                            ),
                            Text(
                              '电话：${perData['checkAcceptUserTelephone']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            launch(
                                'tel:${perData['checkAcceptUserTelephone']}');
                          },
                          child: Container(
                            height: size.width * 64,
                            width: size.width * 64,
                            decoration: BoxDecoration(
                                color: Color(0xff3074FF),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 20))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/doubleRiskProjeck/icon_dep_telephone.png',
                              height: size.width * 35,
                              width: size.width * 35,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ));
  }
}

class BuildDragWidget extends StatefulWidget {
  BuildDragWidget({this.dangerState, this.id, this.checkMeans});
  final String dangerState;
  final String id;
  final String checkMeans;
  @override
  State<BuildDragWidget> createState() => _BuildDragWidgetState();
}

class _BuildDragWidgetState extends State<BuildDragWidget> {
  ScrollController scrollController = ScrollController();
  DragController dragController = DragController();

  Widget _judgeWidget() {
    // 隐患状态（排查：check；确认隐患：-1；整改完毕：0；整改审批：-1）
    switch (widget.dangerState) {
      case 'check':
        return Troubleshoot(id: widget.id, checkMeans: widget.checkMeans);
        break;
      case '-1':
        return AffirmHidden(id: widget.id);
        break;
      case '0':
        return ReformFinish(id: widget.id);
        break;
      case '1':
        return ReformAccept(id: widget.id);
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //层叠布局中的底部对齐
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragContainer(
        //抽屉的子Widget
        dragWidget: Column(
          children: [Expanded(child: _judgeWidget())],
        ),
        //抽屉关闭时的高度 默认0.4
        // initChildRate: 0.1,
        maxChildRate: .8,
        //是否显示默认的标题
        isShowHeader: true,
        //背景颜色
        backGroundColor: Colors.white,
        //背景圆角大小
        cornerRadius: 0,
        //自动上滑动或者是下滑的分界值
        maxOffsetDistance: 0,
        //抽屉控制器
        controller: dragController,
        //滑动控制器
        scrollController: scrollController,
        //自动滑动的时间
        duration: Duration(milliseconds: 800),
      ),
    );
  }
}
