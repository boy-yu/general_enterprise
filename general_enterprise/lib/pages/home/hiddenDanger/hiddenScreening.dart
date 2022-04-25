import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/myView/myDragContainer.dart';
import 'package:drag_container/drag/drag_controller.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/pages/home/checkLisk/data/alreadySubmitData.dart';
import 'package:enterprise/pages/home/checkLisk/data/hiddenData.dart';
import 'package:enterprise/pages/home/checkLisk/data/spotCheckData.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenReview.dart';
import 'package:enterprise/pages/home/hiddenDanger/hidden_dialog/_dialogRegulationsHidden.dart';
import 'package:enterprise/pages/home/risk/_riskButton.dart';
import 'package:enterprise/pages/home/work/work_dilog/_getVideo.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiddenScreening extends StatefulWidget {
  HiddenScreening(
      {@required this.id,
      @required this.fourId,
      this.type,
      this.title,
      this.authority,
      this.controlType,
      this.data,
      this.genre});
  final int id, type, controlType, authority, fourId;
  final String title, genre;
  final Map data;
  @override
  _HiddenScreeningState createState() => _HiddenScreeningState();
}

class _HiddenScreeningState extends State<HiddenScreening> {
  @override
  Widget build(BuildContext context) {
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
          ScrollTop(id: widget.fourId),
          BuildDragWidget(
            id: widget.id,
            type: widget.type,
            title: widget.title,
            controlType: widget.controlType,
            data: widget.data,
            authority: widget.authority,
            fourId: widget.fourId,
            genre: widget.genre,
          ),
        ],
      ),
    );
  }
}

class ScrollTop extends StatefulWidget {
  ScrollTop({this.id});
  final int id;
  @override
  _ScrollTopState createState() => _ScrollTopState();
}

extension JudgeHasCharacter on String {
  bool judgeHasCharacter() {
    if (this == '') return false;
    bool _bool = false;
    for (var i = 0; i < this.codeUnits.length; i++) {
      if (this.codeUnits[i] > 200) {
        _bool = true;
      }
    }
    return _bool;
    // return this.codeUnits[0] > 200 ? true : false;
  }
}

class _ScrollTopState extends State<ScrollTop> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Map daya;

  List<Map> dropData = [
    {"name": "风险分析对象", "value": '', "bindKey": 'riskPoint'},
    {"name": "固有危险等级", "value": '', "bindKey": 'inherentHazardLevel'},
    {"name": "责任部门", "value": '', "bindKey": 'responsibleDepartment'},
    {"name": "责任人", "value": '', "bindKey": 'personLiable'},
    {"name": "风险分析单元", "value": '', "bindKey": 'riskUnit'},
    {"name": "风险事件", "value": '', "bindKey": 'riskItem'},
    {"name": "风险名称", "value": '', "bindKey": 'riskName'},
    {"name": "风险等级", "value": '', "bindKey": 'riskLevel'},
    {"name": "风险类别", "value": '', "bindKey": 'riskType'},
    {"name": "风险描述", "value": '', "bindKey": 'riskDescription'},
    {"name": "初始风险后果", "value": '', "bindKey": 'riskConsequences'},
    {"name": "初始风险可能性", "value": '', "bindKey": 'initialRiskPossibility'},
    {"name": "初始风险度", "value": '', "bindKey": 'initialRiskDegree'},
    {"name": "初始风险等级", "value": '', "bindKey": 'initialRiskLevel'},
    {"name": "分类", "value": '', "bindKey": 'classification'},
    {"name": "隐患类型", "value": '', "bindKey": 'hiddenDangereType'},
    {"name": "管控部位", "value": '', "bindKey": 'responsibleDepartment'},
    {"name": "管控措施", "value": '', "bindKey": 'controlMeasures'},
    {"name": "检查方式", "value": '', "bindKey": 'checkWay'},
    {"name": "对应标准", "value": '', "bindKey": 'title'},
  ];
  _init() {
    myDio.request(
        type: 'get',
        url: Interface.getHiddenDetailDrow,
        mounted: false,
        queryParameters: {"fourId": widget.id}).then((value) async {
      if (value is Map) {
        daya = value;
        daya.forEach((key, value) {
          dropData.forEach((element) {
            if (element['bindKey'] == key) {
              element['value'] = value ?? '';
            }
          });
        });
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getText(String name, String value) {
    if (name == '风险等级' || name == '初始风险等级') {
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
          gradient: LinearGradient(colors: lineGradBlue),
        ),
        child: ListView.builder(
          itemCount: dropData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: InkWell(
                onTap: () {
                  if (dropData[index]['name'].toString() == '对应标准') {
                    String url = webUrl +
                        'national-standard?id=${daya['standardId']}' +
                        '&token=' +
                        myprefs.getString('token');
                    Navigator.pushNamed(context, '/webview',
                        arguments: {"url": url, 'title': '国标内容'});
                  }
                },
                child: dropData[index]['value'].toString() == ''
                    ? Container()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dropData[index]['name'].toString() + ":",
                            style: TextStyle(
                              color: Colors.white,
                              height: dropData[index]['value']
                                      .toString()
                                      .judgeHasCharacter()
                                  ? null
                                  : 1.1,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            child: Text(
                              _getText(dropData[index]['name'].toString(),
                                  dropData[index]['value'].toString()),
                              style: TextStyle(
                                color: Colors.white,
                                decoration:
                                    dropData[index]['name'].toString() == '对应标准'
                                        ? TextDecoration.underline
                                        : null,
                              ),
                            ),
                          )),
                        ],
                      ),
              ),
            );
          },
        ));
  }
}

class BuildDragWidget extends StatefulWidget {
  BuildDragWidget(
      {this.widghtSize,
      this.title,
      this.id,
      this.type,
      this.data,
      this.authority,
      this.controlType,
      this.fourId,
      this.genre});
  final Size widghtSize;
  final String title, genre;
  final Map data;
  final int id, type, controlType, authority, fourId;
  @override
  _BuildDragWidgetState createState() => _BuildDragWidgetState();
}

class _BuildDragWidgetState extends State<BuildDragWidget> {
  ScrollController scrollController = ScrollController();
  DragController dragController = DragController();

  _judgeWidget() {
    switch (widget.type) {
      case 0:
        return ScreeningList(id: widget.id, data: widget.data, genre: widget.genre);
      case 1:
        return HiddenRegulationsDialog(id: widget.id, fourId: widget.fourId, data: widget.data, genre: widget.genre);
      case 2:
        return ReviewList(
            title: widget.title, id: widget.id, type: widget.type);
      case 3:
        return ReviewList(
            title: widget.title, id: widget.id, type: widget.type);
      default:
        return Container();
    }
  }

  SharedPreferences prefs;
  List history = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    prefs = await SharedPreferences.getInstance();
    myDio.request(
        type: 'get',
        url: Interface.getControlBook,
        queryParameters: {
          "current": 1,
          "size": 3,
          "fourId": widget.fourId,
          "controlType": widget.controlType == 2 ? 2 : 1,
        }).then((value) {
      if (value['records'] is List) {
        history = value['records'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //层叠布局中的底部对齐
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragContainer(
        //抽屉的子Widget
        dragWidget: Column(
          children: [
            widget.authority == 0
                ? History(history, prefs)
                : Expanded(child: _judgeWidget())
          ],
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

class History extends StatelessWidget {
  History(this.history, this.prefs);
  final List history;
  final SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size.width * 50),
      height: size.width * 515,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '近期管控记录:',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 30),
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: history.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/webviews', arguments: {
                            "url":
                                '$webUrl/risk-account-list?token=${prefs.getString("token")}&id=${history[index]["uuid"]}&${DateTime.now().microsecondsSinceEpoch.toString()}'
                          });
                        },
                        child: Container(
                          width: size.width * 200,
                          margin: EdgeInsets.only(right: size.width * 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              history[index]['reportingUrl'].indexOf('http') >
                                      -1
                                  ? FadeInImage(
                                      placeholder: AssetImage(
                                          'assets/images/image_recent_control.jpg'),
                                      image: NetworkImage(history[index]
                                              ['reportingUrl']
                                          .toString()
                                          .split('|')[history[index]
                                                  ['reportingUrl']
                                              .toString()
                                              .split('|')
                                              .length -
                                          1]),
                                      width: size.width * 200,
                                      height: size.width * 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      child: Center(
                                        child: Text('暂无图片'),
                                      ),
                                      color: underColor,
                                      width: size.width * 200,
                                      height: size.width * 150),
                              Expanded(
                                  child: Text(
                                    DateTime.fromMillisecondsSinceEpoch(history[index]['reportingTime']).toString().substring(0, 19),))
                            ],
                          ),
                        ),
                      )))
        ],
      ),
    );
  }
}

class ScreeningList extends StatefulWidget {
  ScreeningList({@required this.id, this.data, this.genre});
  final int id;
  final Map data;
  final String genre;
  @override
  _ScreeningListState createState() => _ScreeningListState();
}

class _ScreeningListState extends State<ScreeningList> {
  int selectbgColor = 0xff0ABA08;
  int selecttextColor = 0xffffffff;
  bool isFull = true;
  Counter _counter = Provider.of(myContext);
  TextEditingController _textEditingController = TextEditingController();
  bool toggle = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // 检测网络
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    _initLister();
    _textEditingController.text = '正常';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.emptySubmitDates(key: '隐患排查');
      _counter.emptySubmitDates(key: '取消作业');
    });
  }

  bool network = true;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

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

  MethodChannel platHot = const MethodChannel('FLIRONE');
  String image = '';

  _initLister() {
    platHot.invokeMethod('endFlirOne').then((value) {}).catchError((onError) {
      print(onError);
    });
  }

  _startFilrOne() {
    platHot.invokeMethod('startFlirOne').then((value) {
      image = value['path'];
      print('imageimageimageimageimageimageimageimageimageimageimageimageimageimageimageimageimageimageimage' + image);
      if(image != ''){
        uploadImg(image);
      }
      setState(() {});
    }).catchError((onError) {
      log('value' + onError);
    });
  }

  String netImage = '';

  Future<dynamic> uploadImg(String path) async {
    Fluttertoast.showToast(msg: '头像上传中请稍后。。。');
    final res = await Future.delayed(Duration(seconds: 1), () async {
      final res = await Dio().post(
        Interface.uploadUrl,
        data: FormData.fromMap({"file": await MultipartFile.fromFile(path)}),
      );
      return res;
    });
    if (res.data['code'] == 200) {
      netImage = res.data['message'];
      setState(() {});
    } else {
      Interface().error({'message': "上传失败"}, context);
    }
    return res;
  }

  String dataInput = '';
  List<WorkVideoType> videoList = [];
  Widget _judgeWidget() {
    Widget _widget;
    if (toggle) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          toggle = false;
        });
      });
      return Container();
    }

    switch (widget.data['controlMeans']) {
      case '数据录入':
        _widget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 30,
                  top: size.width * 10,
                  bottom: size.width * 10),
              child: Text(
                '数据录入:',
                style: TextStyle(
                    color: Color(0xff343434),
                    fontSize: size.width * 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: ClipRRect(
                child: Container(
                    color: Color(0xffF2F2F2).withOpacity(0.5),
                    child: TextField(
                      onChanged: (val) {
                        dataInput = val;
                      },
                      decoration: InputDecoration(
                        suffixText: widget.data['unit'].toString(),
                        border: InputBorder.none,
                        hintText:
                            '${widget.data['lWarning'].toString() + " " + widget.data['unit'].toString()} ~ ${widget.data['hWarning'].toString() + " " + widget.data['unit'].toString()}',
                        hintStyle: TextStyle(
                            color: Color(0xffC8C8C8),
                            fontSize: size.width * 24),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      keyboardType: TextInputType.number,
                    )),
              ),
            ),
            MyImageCarma(
              title: "隐患排查",
              name: '',
              purview: '隐患排查',
            )
          ],
        );
        break;
      case '拍照':
        _widget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 30,
                  top: size.width * 10,
                  bottom: size.width * 10),
              child: Text(
                '拍照:',
                style: TextStyle(
                    color: Color(0xff343434),
                    fontSize: size.width * 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            MyImageCarma(
              title: "隐患排查",
              name: '',
              purview: '隐患排查',
            )
          ],
        );
        break;
      case '摄像':
        _widget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 30,
                  top: size.width * 10,
                  bottom: size.width * 10),
              child: Text(
                '摄像:',
                style: TextStyle(
                    color: Color(0xff343434),
                    fontSize: size.width * 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 40),
              child: WorkVideo(videoList: videoList),
            ),
            SizedBox(
              height: size.width * 100,
            )
          ],
        );
        break;
      case '热成像':
        _widget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 30,
                  top: size.width * 10,
                  bottom: size.width * 10),
              child: Text(
                '热成像:',
                style: TextStyle(
                    color: Color(0xff343434),
                    fontSize: size.width * 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 40),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(themeColor)),
                onPressed: () {
                  _startFilrOne();
                },
                child: Text('热成像'),
              ), // 临时测试页面
            ),
            netImage != '' ? Image.network(netImage, height: size.width * 200, width: size.width * 200,) : Container(),
            SizedBox(
              height: size.width * 100,
            )
          ],
        );
        break;
      default:
        if (!isFull) {
          _widget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 30,
                    top: size.width * 10,
                    bottom: size.width * 10),
                child: Text(
                  '拍照:',
                  style: TextStyle(
                      color: Color(0xff343434),
                      fontSize: size.width * 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              MyImageCarma(
                title: "隐患排查",
                name: '',
                purview: '隐患排查',
              )
            ],
          );
        } else {
          _widget = Container();
        }
    }
    return _widget;
  }

  List _generateImage({String state}) {
    List image = [];
    if (_counter.submitDates['隐患排查'] == null) {
      // Fluttertoast.showToast(msg: '请拍照');
    } else {
      bool next = false;
      _counter.submitDates['隐患排查'].forEach((ele) {
        if (ele['title'] == '隐患排查') {
          image = ele['value'];
          if (image.length > 0) {
            next = true;
          }
        }
      });
      if (!next && state != '数据录入') {
        Fluttertoast.showToast(msg: '请拍照');
      }
    }
    return image;
  }

  _sumbit() async {
    if (_textEditingController.text == '') {
      Fluttertoast.showToast(msg: '请输入意见');
      return;
    }
    dynamic queryParameters = {
      "id": widget.id,
      "opinion": _textEditingController.text,
      "executionStatus": isFull ? 1 : 2,
    };
    if (!isFull) {
      if (widget.data['controlMeans'] == '摄像') {
        if (videoList.isEmpty) {
          Fluttertoast.showToast(msg: '请录像');
          return;
        }
        String videoListStr = '';
        for (var i = 0; i < videoList.length; i++) {
          if (i == videoList.length - 1) {
            videoListStr += videoList[i].fileUrl;
          } else {
            videoListStr += videoList[i].fileUrl + '|';
          }
        }
        queryParameters['executionUrl'] = videoListStr;
      } else {
        List image = _generateImage();
        if (image.isEmpty) {
          Fluttertoast.showToast(msg: '请拍照');
          return;
        }
        String carmaStr = '';
        for (var i = 0; i < image.length; i++) {
          if (i == image.length - 1) {
            carmaStr += image[i];
          } else {
            carmaStr += image[i] + '|';
          }
        }

        queryParameters['executionUrl'] = carmaStr;
        if (widget.data['controlMeans'] == "数据录入") {
          if (dataInput == '') {
            Fluttertoast.showToast(msg: '请录入数据');
            return;
          } else {
            queryParameters['executionData'] =
                {"dataInput": dataInput}.toString();
          }
        }
      }
    } else {
      switch (widget.data['controlMeans']) {
        case '台账':
          break;
        case '数据录入':
          if (dataInput == '') {
            Fluttertoast.showToast(msg: '请录入数据');
            return;
          }
          List image = _generateImage(state: '数据录入');
          String carmaStr = '';
          for (var i = 0; i < image.length; i++) {
            if (i == image.length - 1) {
              carmaStr += image[i];
            } else {
              carmaStr += image[i] + '|';
            }
          }
          queryParameters['executionUrl'] = carmaStr;
          queryParameters['executionData'] =
              {"dataInput": dataInput}.toString();
          break;
        case '拍照':
          List image = _generateImage();
          if (image.isEmpty) {
            Fluttertoast.showToast(msg: '请拍照');
            return;
          }
          String carmaStr = '';
          for (var i = 0; i < image.length; i++) {
            if (i == image.length - 1) {
              carmaStr += image[i];
            } else {
              carmaStr += image[i] + '|';
            }
          }
          queryParameters['executionUrl'] = carmaStr;
          break;
        case '摄像':
          if (videoList.isEmpty) {
            Fluttertoast.showToast(msg: '请录像');
            return;
          }
          String videoListStr = '';
          for (var i = 0; i < videoList.length; i++) {
            if (i == videoList.length - 1) {
              videoListStr += videoList[i].fileUrl;
            } else {
              videoListStr += videoList[i].fileUrl + '|';
            }
          }
          queryParameters['executionUrl'] = videoListStr;
          break;
        default:
      }
    }
    if(network){
      myDio.request(
        type: 'post',
        url: Interface.postHiddenDangereControl,
        data: queryParameters
      ).then((value) {
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
      });
    }else{
      AlreadySubmitData.instance.submitData.add({
        'url': Interface.postHiddenDangereControl,
        'data': queryParameters,
        'type': widget.genre,
        'name': widget.data['keyParameterIndex'],
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffFfFfFf),
        width: double.infinity,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: size.width * 60,
                  right: size.width * 20,
                  left: size.width * 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 60),
                        child: RiskButtons(
                          text: "正常",
                          testcolor: isFull ? selecttextColor : 0xff9A9A9A,
                          bgcolor: isFull ? selectbgColor : 0xffFFFFFF,
                          callback: () {
                            _textEditingController.text = '正常';
                            _counter.emptySubmitDates(key: '隐患排查');
                            if (mounted) {
                              setState(() {
                                isFull = !isFull;
                                toggle = true;
                              });
                            }
                          },
                        ),
                      ),
                      RiskButtons(
                        text: "隐患",
                        testcolor: isFull ? 0xff9A9A9A : 0xffffffff,
                        bgcolor: isFull ? 0xffFFFFFF : 0xffFF1818,
                        callback: () {
                          _counter.emptySubmitDates(key: '隐患排查');
                          _textEditingController.text = '';
                          if (mounted) {
                            setState(() {
                              isFull = !isFull;
                              toggle = true;
                            });
                          }
                        },
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 30,
                            top: size.width * 10,
                            bottom: size.width * 10),
                        child: Text(
                          isFull ? '排查人意见:' : '隐患描述：',
                          style: TextStyle(
                              color: Color(0xff343434),
                              fontSize: size.width * 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: ClipRRect(
                          child: Container(
                              height: size.width * 160,
                              color: Color(0xffF2F2F2).withOpacity(0.5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      onChanged: (val) {
                                        // callback('opinion', val);
                                      },
                                      controller: _textEditingController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            isFull ? '请输入意见...' : '请输入内容...',
                                        hintStyle: TextStyle(
                                            color: Color(0xffC8C8C8),
                                            fontSize: size.width * 24),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      _judgeWidget(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 50, right: size.width * 50),
                        child: GestureDetector(
                          onTap: _sumbit,
                          child: Container(
                            height: size.width * 75,
                            // width: size.width * 505,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: size.width * 100),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: lineGradBlue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: Text(
                              network ? '确定' : '保存',
                              style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: size.width * 36),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
