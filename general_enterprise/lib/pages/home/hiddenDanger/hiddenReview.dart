import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:drag_container/drag/drag_controller.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/checkLisk/data/alreadySubmitData.dart';
import 'package:enterprise/pages/home/checkLisk/data/hiddenData.dart';
import 'package:enterprise/pages/home/checkLisk/data/spotCheckData.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenScreening.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:enterprise/common/myDragContainer.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HiddenReview extends StatefulWidget {
  HiddenReview({this.title, @required this.id});
  final String title;
  final int id;
  @override
  _HiddenReviewState createState() => _HiddenReviewState();
}

class _HiddenReviewState extends State<HiddenReview> {
  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;

    return MyAppbar(
      elevation: 0,
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 36,
            color: Colors.white),
      ),
      child: Stack(
        children: [
          ScrollTop(
            id: widget.id,
          ),
          BuildDragWidget(
              widghtSize: widghtSize, title: widget.title, id: widget.id),
        ],
      ),
    );
  }
}

class BuildDragWidget extends StatefulWidget {
  BuildDragWidget({this.widghtSize, this.title, this.id});
  final Size widghtSize;
  final String title;
  final int id;
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
        dragWidget: ReviewList(title: widget.title, id: widget.id),
        //抽屉标题点击事件回调
        dragCallBack: (isOpen) {},
      ),
    );
  }
}

class ReviewList extends StatefulWidget {
  ReviewList({this.title, this.id, this.type});
  final String title;
  final int id, type;
  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  List reviewList = [];
  Map myData = {};

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // 检测网络
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
          _init();
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  // List images = [];
  List<Map> data = [
    {
      "title": '隐患信息',
      "list": [
        {'title': '隐患描述', 'type': 'input', 'value': ''},
        {'title': '', 'type': 'image', 'value': ''},
      ]
    },
    {
      "title": '五定措施',
      "list": [
        {'title': '隐患等级', 'type': 'input', 'value': ''},
        {'title': '负责人', 'type': 'input', 'value': ''},
        {'title': '整改期限', 'type': 'input', 'value': ''},
        {'title': '资金', 'type': 'input', 'value': ''},
        {'title': '整改措施', 'type': 'input', 'value': ''},
        {'title': '整改人', 'type': 'input', 'value': ''},
        {'title': '整改确认人', 'type': 'input', 'value': ''},
        {'title': '', 'type': 'image', 'value': ''},
        {'title': '未生成作业', 'type': 'input', 'value': ''},
      ]
    }
  ];

  String _filterString(var msg) {
    String _msg = '';
    if (msg is int)
      _msg = msg.toString();
    else if (msg is List) {
      for (var i = 0; i < msg.length; i++) {
        if (i == msg.length - 1) {
          _msg += msg[i]['nickname'];
        } else {
          _msg += msg[i]['nickname'] + ',';
        }
      }
    } else {
      _msg = msg ?? '';
    }
    return _msg;
  }

  TextEditingController _controller = TextEditingController();
  _init() {
    myDio
        .request(
            type: 'get',
            url: Interface.getRectificationDetail + widget.id.toString())
        .then((value) {
      if (value is Map) {
        // images = value['rectificationUrl'].toString().split('|');
        data[0]['list'][0]['value'] = _filterString(value['reportingOpinion']);
        data[0]['list'][1]['value'] = _filterString(value['reportingUrl']);
        data[1]['list'][0]['value'] =
            _filterString(value['hiddenLevel']) == '1' ? '一般隐患' : '重大隐患';
        data[1]['list'][1]['value'] = _filterString(value['principal']);
        data[1]['list'][2]['value'] = _filterString(value['rectificationTime']);
        data[1]['list'][3]['value'] =
            _filterString(value['rectificationFunds']);
        data[1]['list'][4]['value'] =
            _filterString(value['rectificationMeasures']);
        data[1]['list'][5]['value'] =
            _filterString(value['rectificationPersonnel']);
        data[1]['list'][6]['value'] =
            _filterString(value['rectificationConfirmUser']);
        data[1]['list'][7]['value'] = value['rectificationUrl'];
        data[1]['list'][8]['title'] =
            _filterString(value['whetherWork']) == '0' ? '未生成作业' : '已生成作业';
        print(value);
        if (_filterString(value['whetherWork']) != '0') {
          data.add({
            "title": '作业内容',
            "list": [
              {
                "title": '作业名称',
                'type': 'input',
                "value": _filterString(value['workName'])
              },
              {
                "title": '作业区域',
                'type': 'input',
                "value": _filterString(value['region'])
              },
              // {
              //   "title": '作业地点',
              //   'type': 'input',
              //   "value": _filterString(value['location'])
              // },
              {
                "title": '属地单位',
                'type': 'input',
                "value": _filterString(value['territorialUnit'])
              },
              {
                "title": '作业风险辨识人',
                'type': 'input',
                "value": _filterString(
                    value['riskIdentifierUserIds']) //planApprovalUserIds
              },
              // {
              //   "title": '计划审批人',
              //   'type': 'input',
              //   "value": _filterString(value['planApprovalUserIds'])
              // },
              {
                "title": '作业时间',
                'type': 'input',
                "value": _filterString(value['planDate'])
              },
              {
                "title": '作业内容',
                'type': 'input',
                "value": _filterString(value['description'])
              },
            ]
          });
        }

        myData = value;
        if (mounted) {
          setState(() {});
        }
        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffF2F1F1),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 50, horizontal: size.width * 20),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 20,
                            vertical: size.width * 20),
                        margin: EdgeInsets.only(top: size.width * 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: size.width * 6,
                                  height: size.width * 36,
                                  color: Color(0xff3073FE),
                                  margin:
                                      EdgeInsets.only(right: size.width * 20),
                                ),
                                Text(data[index]['title']),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.width * 20),
                                child: Column(
                                  children: data[index]['list']
                                      .map<Widget>(
                                        (ele) => Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(ele['title']),
                                              ele['type'] == 'image' &&
                                                      ele['value'] != ''
                                                  ? Expanded(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: ele['value']
                                                              .toString()
                                                              .split('|')
                                                              .map(
                                                                (_ele) =>
                                                                    Container(
                                                                  margin: EdgeInsets.only(
                                                                      right:
                                                                          size.width *
                                                                              3),
                                                                  child:
                                                                      FadeInImage(
                                                                    placeholder:
                                                                        AssetImage(
                                                                            'assets/images/image_recent_control.jpg'),
                                                                    image: NetworkImage(
                                                                        _ele.toString()),
                                                                    height:
                                                                        size.width *
                                                                            155,
                                                                  ),
                                                                ),
                                                              )
                                                              .toList()))
                                                  : Expanded(
                                                      child: Text(
                                                      ele['value'].toString(),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ))
                                            ],
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.width * 20),
                                          decoration: BoxDecoration(
                                              border: ele['title'] == ''
                                                  ? null
                                                  : Border(
                                                      top: BorderSide(
                                                          width: 1,
                                                          color: underColor
                                                              .withOpacity(
                                                                  .3)))),
                                        ),
                                      )
                                      .toList()
                                      .toList(),
                                ))
                          ],
                        ));
                  }),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: size.width * 30),
              child: widget.type == 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(themeColor)),
                          onPressed: () async {
                            await WorkDialog.myDialog(context,
                                (String text, List data) {
                              bool next = true;
                              String image = '';
                              data.forEach((element) {
                                if (element['title'] == '完毕图片') {
                                  for (var i = 0;
                                      i < element['value'].length;
                                      i++) {
                                    if (i == element['value'].length - 1) {
                                      image += element['value'][i];
                                    } else {
                                      image += element['value'][i] + '|';
                                    }
                                  }
                                }
                              });
                              if (text == '' || image == '') {
                                next = false;
                              }
                              if (next) {
                                if (network) {
                                  // print(myData['id']);
                                  // print(widget.id);
                                  myDio.request(
                                      type: 'post',
                                      url: Interface.postRectificationCompleted,
                                      data: {
                                        "id": myData['id'],
                                        "rectificationPersonnelOpinion": text,
                                        "rectificationUrl": image
                                      }).then((value) {
                                    for (int i = 0; i < HiddenData.instance.download.length; i++) {
                                      if(HiddenData.instance.download[i]['id'] == widget.id){
                                        HiddenData.instance.download.remove(HiddenData.instance.download[i]);
                                      }
                                    }
                                    for (int j = 0; j < SpotCheckData.instance.download.length; j++) {
                                      if(SpotCheckData.instance.download[j]['id'] == widget.id){
                                        SpotCheckData.instance.download.remove(SpotCheckData.instance.download[j]);
                                      }
                                    }
                                    successToast('成功');
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                                } else {
                                  AlreadySubmitData.instance.submitData.add({
                                    'url': Interface.postRectificationCompleted,
                                    'data': {
                                      "id": widget.id,
                                      "rectificationPersonnelOpinion": text,
                                      "rectificationUrl": image
                                    },
                                    'type': '整改完毕',
                                    'name': widget.title,
                                  });
                                  for (int i = 0; i < HiddenData.instance.download.length; i++) {
                                    if(HiddenData.instance.download[i]['id'] == widget.id){
                                      HiddenData.instance.download.remove(HiddenData.instance.download[i]);
                                    }
                                  }
                                  for (int j = 0; j < SpotCheckData.instance.download.length; j++) {
                                    if(SpotCheckData.instance.download[j]['id'] == widget.id){
                                      SpotCheckData.instance.download.remove(SpotCheckData.instance.download[j]);
                                    }
                                  }
                                  Fluttertoast.showToast(msg: '保存成功');
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              } else {
                                if (text == '') {
                                  Fluttertoast.showToast(msg: '请填写数据');
                                } else if (image == '') {
                                  Fluttertoast.showToast(msg: '请拍照');
                                }
                              }
                            }, 8);
                          },
                          child: Text('整改完毕'),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () {
                              WorkDialog.myDialog(context, () {}, 2,
                                  widget: Padding(
                                    padding: EdgeInsets.all(size.width * 50),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('驳回意见'),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: TextField(
                                              controller: _controller,
                                              decoration: InputDecoration(
                                                  hintText: '请输入驳回意见'),
                                            ))
                                          ],
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        themeColor)),
                                            onPressed: () {
                                              if (_controller.text == '') {
                                                Fluttertoast.showToast(
                                                    msg: '请输入驳回意见');
                                              } else {
                                                if (network) {
                                                  myDio.request(
                                                      type: 'post',
                                                      url: Interface
                                                          .postRectificationCompletedApprove,
                                                      data: {
                                                        "id": myData['id'],
                                                        "dismissed": 2,
                                                        "rectificationConfirmMemo":
                                                            _controller.text
                                                      }).then((value) {
                                                    successToast('驳回成功');
                                                    for (int i = 0; i < HiddenData.instance.download.length; i++) {
                                                      if(HiddenData.instance.download[i]['id'] == widget.id){
                                                        HiddenData.instance.download.remove(HiddenData.instance.download[i]);
                                                      }
                                                    }
                                                    for (int j = 0; j < SpotCheckData.instance.download.length; j++) {
                                                      if(SpotCheckData.instance.download[j]['id'] == widget.id){
                                                        SpotCheckData.instance.download.remove(SpotCheckData.instance.download[j]);
                                                      }
                                                    }
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  });
                                                } else {
                                                  AlreadySubmitData
                                                      .instance.submitData
                                                      .add({
                                                    'url': Interface
                                                        .postRectificationCompletedApprove,
                                                    'data': {
                                                      "id": widget.id,
                                                      "dismissed": 2,
                                                      "rectificationConfirmMemo":
                                                          _controller.text
                                                    },
                                                    'type': '审批驳回',
                                                    'name': widget.title,
                                                  });
                                                  Fluttertoast.showToast(
                                                      msg: '保存成功');
                                                  for (int i = 0; i < HiddenData.instance.download.length; i++) {
                                                    if(HiddenData.instance.download[i]['id'] == widget.id){
                                                      HiddenData.instance.download.remove(HiddenData.instance.download[i]);
                                                    }
                                                  }
                                                  for (int j = 0; j < SpotCheckData.instance.download.length; j++) {
                                                    if(SpotCheckData.instance.download[j]['id'] == widget.id){
                                                      SpotCheckData.instance.download.remove(SpotCheckData.instance.download[j]);
                                                    }
                                                  }
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                }
                                              }
                                            },
                                            child: Text('确定'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                            child: Text('驳回')),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(themeColor)),
                            onPressed: () {
                              if (network) {
                                myDio.request(
                                    type: 'post',
                                    url: Interface
                                        .postRectificationCompletedApprove,
                                    data: {
                                      "id": myData['id'],
                                      "dismissed": 1,
                                    }).then((value) {
                                  for (int i = 0; i < HiddenData.instance.download.length; i++) {
                                    if(HiddenData.instance.download[i]['id'] == widget.id){
                                      HiddenData.instance.download.remove(HiddenData.instance.download[i]);
                                    }
                                  }
                                  for (int j = 0; j < SpotCheckData.instance.download.length; j++) {
                                    if(SpotCheckData.instance.download[j]['id'] == widget.id){
                                      SpotCheckData.instance.download.remove(SpotCheckData.instance.download[j]);
                                    }
                                  }
                                  successToast('成功');
                                  Navigator.pop(context);
                                });
                              } else {
                                AlreadySubmitData.instance.submitData.add({
                                  'url': Interface
                                      .postRectificationCompletedApprove,
                                  'data': {
                                    "id": widget.id,
                                    "dismissed": 1,
                                  },
                                  'type': '审批确认',
                                  'name': widget.title,
                                });
                                for (int i = 0; i < HiddenData.instance.download.length; i++) {
                                  if(HiddenData.instance.download[i]['id'] == widget.id){
                                    HiddenData.instance.download.remove(HiddenData.instance.download[i]);
                                  }
                                }
                                for (int j = 0; j < SpotCheckData.instance.download.length; j++) {
                                  if(SpotCheckData.instance.download[j]['id'] == widget.id){
                                    SpotCheckData.instance.download.remove(SpotCheckData.instance.download[j]);
                                  }
                                }
                                Fluttertoast.showToast(msg: '保存成功');
                                Navigator.pop(context);
                              }
                            },
                            child: Text('确认')),
                      ],
                    ),
            )
          ],
        ));
  }
}
