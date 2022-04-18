import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:enterprise/common/MychooseTime.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myDragContainer.dart';
import 'package:drag_container/drag/drag_controller.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myDrop.dart';
import 'package:enterprise/common/myInput.dart';
import 'package:enterprise/common/mySearchPeople.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenScreening.dart';
// import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HiddenConfirm extends StatefulWidget {
  HiddenConfirm({this.id, this.data, @required this.fourId});
  final int id, fourId;
  final Map data;
  @override
  _HiddenConfirmState createState() => _HiddenConfirmState();
}

class _HiddenConfirmState extends State<HiddenConfirm> {
  List dropData = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    myDio.request(
        type: 'get',
        url: Interface.getHiddenDetailDrow,
        queryParameters: {"fourId": widget.fourId}).then((value) async {
      if (value is Map) {
        dropData = await mytranslate.generateList(value);
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      elevation: 0,
      title: Text(
        '确认隐患',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 36,
            color: Colors.white),
      ),
      child: Stack(
        children: [
          ScrollTop(id: widget.fourId),
          BuildDragWidget(
              widghtSize: widghtSize, id: widget.id, data: widget.data, fourId: widget.fourId),
        ],
      ),
    );
  }
}

class BuildDragWidget extends StatefulWidget {
  BuildDragWidget({this.widghtSize, this.title, this.id, this.data, this.fourId});
  final Size widghtSize;
  final String title;
  final int id, fourId;
  final Map data;
  @override
  _BuildDragWidgetState createState() => _BuildDragWidgetState();
}

class _BuildDragWidgetState extends State<BuildDragWidget> {
  ScrollController scrollController = ScrollController();
  DragController dragController = DragController();
  @override
  Widget build(BuildContext context) {
    //层叠布局中的底部对齐
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragContainer(
        //抽屉关闭时的高度 默认0.4
        initChildRate: 0.1,
        //抽屉打开时的高度 默认0.4
        maxChildRate: 0.8,
        //是否显示默认的标题
        isShowHeader: true,
        //背景颜色
        backGroundColor: Colors.white,
        //背景圆角大小
        cornerRadius: 0,
        //自动上滑动或者是下滑的分界值
        maxOffsetDistance: 1.5,
        //抽屉控制器
        controller: dragController,
        //滑动控制器
        scrollController: scrollController,
        //自动滑动的时间
        duration: Duration(milliseconds: 800),
        //抽屉的子Widget
        dragWidget: ConfirmList(id: widget.id, data: widget.data, fourId: widget.fourId,),
        //抽屉标题点击事件回调
        dragCallBack: (isOpen) {},
      ),
    );
  }
}

class ConfirmList extends StatefulWidget {
  ConfirmList({this.id, this.data, this.fourId});
  final int id, fourId;
  final Map data;
  @override
  _ConfirmListState createState() => _ConfirmListState();
}

class _ConfirmListState extends State<ConfirmList> {
  List data = [
    {
      "title": "隐患等级",
      "type": "choose",
      "data": [
        {"name": "一般隐患"},
        {"name": "重大隐患"},
      ],
      "bindKey": "hiddenLevel"
    },
    {
      "title": "负责人",
      "type": "choosePeople",
      "data": [],
      "bindKey": "principal"
    },
    {
      "title": "整改期限",
      "type": "chooseTime",
      "data": [],
      "bindKey": "rectificationTime"
    },
    {"title": "资金", "type": "input", "bindKey": "rectificationFunds"},
    {"title": "请输入整改措施", "type": "input", "bindKey": "rectificationMeasures"},
    {
      "title": "选择整改人",
      "type": "choosePeople",
      "data": [],
      "bindKey": "rectificationPersonnelId"
    },
    {
      "title": "选择整改确认人",
      "type": "choosePeople",
      "data": [],
      "bindKey": "rectificationConfirmUserId"
    }
  ];
  Counter _counter = Provider.of(myContext);

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // 检测网络
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.emptySubmitDates(key: '确认隐患');
    });
  }

    @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool network = true;

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        // setState(() => _connectionStatus = result.toString());
        if (result.toString() == 'ConnectivityResult.none') {
          network = false;
          setState(() {});
        } else {
          network = true;
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF2F1F1),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 30),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: size.width * 30,
                        width: size.width * 5,
                        color: Color(0xff3073FE),
                        margin: EdgeInsets.only(left: 10, right: 10),
                      ),
                      Text(
                        '隐患信息',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: size.width * 1,
                  color: Color(0xffF2F1F1),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '隐患描述',
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 26),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(.3)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          widget.data['reportingOpinion'].toString(),
                          style: TextStyle(color: placeHolder),
                        ))
                      ],
                    ),
                  ),
                ),
                network ? Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 15),
                  child: Wrap(
                      children: widget.data['reportingUrl']
                          .split('|')
                          .map<Widget>((ele) {
                    return Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: ele.toString().indexOf('http') > -1
                          ? Image.network(
                              ele,
                              width: size.width * 200,
                              height: size.width * 150,
                            )
                          : Container(),
                    );
                  }).toList()),
                ) : Container(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: size.width * 30,
                        width: size.width * 5,
                        color: Color(0xff3073FE),
                        margin: EdgeInsets.only(left: 10, right: 10),
                      ),
                      Text(
                        '制定五定措施',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: data.map((ele) {
                    Widget _widget;
                    switch (ele['type']) {
                      case 'choose':
                        _widget = MyDrop(
                          title: ele['title'],
                          purview: '确认隐患',
                          data: ele['data'],
                          bindKey: ele['bindKey'],
                          callSetstate: () {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        );
                        break;
                      case 'choosePeople':
                        _widget = SourchMutiplePeople(
                          title: ele['title'],
                          purview: '确认隐患',
                          way: true,
                          bindKey: ele['bindKey'],
                        );
                        break;
                      case 'chooseTime':
                        _widget = MychooseTime(
                          title: ele['title'],
                          purview: '确认隐患',
                          bindKey: ele['bindKey'],
                        );
                        break;
                      case 'input':
                        _widget = MyInput(
                          title: ele['title'],
                          purview: '确认隐患',
                          bindKey: ele['bindKey'],
                        );
                        break;
                      default:
                        _widget = Center(
                          child: Text(ele['title'].toString() + '当前未开发'),
                        );
                    }

                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(color: underColor, width: 1))),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 20,
                          vertical: size.width * 10),
                      width: double.infinity,
                      child: _widget,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Container(
                //   width: size.width * 220,
                //   height: size.width * 60,
                //   child: RaisedButton(
                //     onPressed: () {},
                //     color: Color(0xff09BA07),
                //     textColor: Colors.white,
                //     child: Text('暂存'),
                //   ),
                // ),
                Container(
                  width: size.width * 220,
                  height: size.width * 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff0059FF))),
                    onPressed: () async {
                      Map sumbit = {};
                      bool next = true;
                      String toast = '请填写数据';
                      if (_counter.submitDates['确认隐患'] is List) {
                        if (_counter.submitDates['确认隐患'].length < 7) {
                          next = false;
                        }
                        _counter.submitDates['确认隐患'].forEach((ele) {
                          print(ele);
                          if (ele['value'] == '') {
                            next = false;
                          } else {
                            sumbit[ele['bindKey']] = ele['value'];
                            if (ele['bindKey'] == 'rectificationPersonnelId') {
                              sumbit['rectificationPersonnelId'] =
                                  ele['value'][0];
                              sumbit['rectificationPersonnel'] = ele['name'][0];
                            }
                            if (ele['bindKey'] ==
                                'rectificationConfirmUserId') {
                              sumbit['rectificationConfirmUserId'] =
                                  ele['value'][0];
                              sumbit['rectificationConfirmUser'] =
                                  ele['name'][0];
                            }
                            if (ele['bindKey'] == 'principal') {
                              if(ele['name'].isNotEmpty){
                                sumbit['principal'] = ele['name'][0];
                              }else{
                                Fluttertoast.showToast(msg: '请重新选择负责人');
                              }
                            }
                            if(ele['bindKey'] == 'rectificationTime'){
                              if(DateTime.now().millisecondsSinceEpoch > DateTime.parse(ele['value']).millisecondsSinceEpoch){
                                toast = '整改期限请大于当前时间';
                                next = false;
                              }
                            }
                          }
                        });
                      } else {
                        Fluttertoast.showToast(msg: '数据异常,请重新进入');
                      }
                      sumbit['id'] = network ? widget.data['id'] : widget.id;
                      sumbit['isHiddenDangere'] = 2;
                      sumbit['hiddenLevel'] =
                          sumbit['hiddenLevel'] == '重大隐患' ? 2 : 1;
                      if (next) {
                        await WorkDialog.myDialog(context, () {
                          // List workPlan = [
                          //   {"title": "作业名称", "bindKey": "workName"},
                          //   {"title": "作业区域", "bindKey": "region"},
                          //   {"title": "作业内容", "bindKey": "description"},
                          //   {"title": "属地单位", "bindKey": "territorialUnit"},
                          //   {
                          //     "title": "作业风险辨识人",
                          //     "bindKey": "riskIdentifierUserIds"
                          //   },
                          //   {"title": "作业时间", "bindKey": "planDate"},
                          // ];

                          // bool nexts = true;
                          // if (_counter.submitDates['作业计划'] is List) {
                          //   if (_counter.submitDates['作业计划'].length <
                          //       workPlan.length) {
                          //     next = false;
                          //   } else {
                          //     _counter.submitDates['作业计划'].forEach((ele) {
                          //       workPlan.forEach((_ele) {
                          //         if (ele['title'] == _ele['title']) {
                          //           sumbit[_ele['bindKey']] = ele['value'];
                          //         }
                          //       });
                          //     });
                          //   }
                          // } else {
                          //   nexts = false;
                          // }
                        }, 9, hiddenData: sumbit, fourId: widget.fourId);
                      } else {
                        Fluttertoast.showToast(msg: toast);
                      }
                    },
                    child: Text('提交'),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
