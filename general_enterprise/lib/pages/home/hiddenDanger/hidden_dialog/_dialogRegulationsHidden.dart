import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/pages/home/checkLisk/data/alreadySubmitData.dart';
import 'package:enterprise/pages/home/checkLisk/data/hiddenData.dart';
import 'package:enterprise/pages/home/checkLisk/data/spotCheckData.dart';
import 'package:enterprise/pages/home/risk/_riskButton.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class HiddenRegulationsDialog extends StatefulWidget {
  HiddenRegulationsDialog({this.id, @required this.fourId, this.data, this.genre});
  final int id, fourId;
  final Map data;
  final String genre;
  @override
  _HiddenRegulationsDialogState createState() =>
      _HiddenRegulationsDialogState();
}

class _HiddenRegulationsDialogState extends State<HiddenRegulationsDialog> {
  int selectbgColor = 0xff0ABA08;
  int selecttextColor = 0xffffffff;
  bool isFull = true;
  List<String> regulationsDialogList = [];
  TextEditingController _textEditingController = TextEditingController();
  Map data = {};
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
          _getData();
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  _getData() {
    myDio
        .request(
      type: 'get',
      url: Interface.getRectificationDetail + widget.id.toString(),
    ).then((value) {
      if (value is Map) {
        data = value;
        regulationsDialogList = value['reportingUrl'].toString().split('|');
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(15),
          boxShadow: []),
      margin: EdgeInsets.only(bottom: size.width * 74, top: size.width * 35),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    isFull = !isFull;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ),
              RiskButtons(
                text: "隐患",
                testcolor: isFull ? 0xff9A9A9A : 0xffffffff,
                bgcolor: isFull ? 0xffFFFFFF : 0xffFF1818,
                callback: () {
                  isFull = !isFull;
                  if (mounted) {
                    setState(() {});
                  }
                },
              )
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.width * 30, top: size.width * 10),
            child: Text(
              '描述：',
              style: TextStyle(
                  color: Color(0xff343434),
                  fontSize: size.width * 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 50,
                top: size.width * 10,
                right: size.width * 50),
            child: Text(
              data['reportingOpinion'].toString(),
              style: TextStyle(
                color: Color(0xff343434),
                fontSize: size.width * 26,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: size.width * 30),
            height: size.width * 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: regulationsDialogList.length,
                itemBuilder: (context, index) {
                  if (regulationsDialogList[index].toString().indexOf("mp4") >
                      -1)
                    return SizedBox(
                      width: size.width * 167,
                      height: size.width * 125,
                      child: ShowVideo(url: regulationsDialogList[index]),
                    );

                  return Padding(
                    padding: EdgeInsets.only(right: size.width * 10),
                    child: regulationsDialogList[index].isNotEmpty
                        ? Image.network(
                            regulationsDialogList[index],
                            width: size.width * 167,
                            height: size.width * 125,
                          )
                        : Container(),
                  );
                }),
          ),
          isFull
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: size.width * 655,
                      height: size.width * 1,
                      color: Color(0xffEFEFEF),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 30,
                          top: size.width * 10,
                          bottom: size.width * 10),
                      child: Text(
                        '驳回意见:',
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
                            height: size.width * 160,
                            color: Color(0xffF2F2F2).withOpacity(0.5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _textEditingController,
                                    onChanged: (val) {
                                      // callback('opinion', val);
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '请输入驳回意见...',
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
                    MyImageCarma(
                      title: "驳回图片",
                      name: '',
                      purview: '驳回图片',
                    ),
                  ],
                )
              : Container(),
          Padding(
            padding:
                EdgeInsets.only(left: size.width * 50, right: size.width * 50),
            child: GestureDetector(
              onTap: () {
                if (isFull) {
                  bool next = false;
                  String image = '';
                  if (_textEditingController.text != '' &&
                      _counter.submitDates['驳回图片'] != null) {
                    _counter.submitDates['驳回图片'].forEach((ele) {
                      if (ele['title'] == '驳回图片') {
                        for (var i = 0; i < ele['value'].length; i++) {
                          if (i == ele['value'].length - 1) {
                            image += ele['value'][i];
                          } else {
                            image += ele['value'][i] + '|';
                          }
                        }
                      }
                    });
                    if (image != '') {
                      next = true;
                    }
                  }
                  if (next) {
                    if(network){
                      myDio.request(
                          type: 'post',
                          url: Interface.postHiddenDangereConfirm,
                          data: {
                            "id": data['id'],
                            "isHiddenDangere": 1,
                            "confirmOpinion": _textEditingController.text,
                            "confirmUrl": image
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
                        Fluttertoast.showToast(
                            msg: '驳回成功',
                            backgroundColor: themeColor,
                            textColor: Colors.white,
                            webPosition: 'center');
                        Navigator.pop(context);
                      });
                    }else{
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
                      AlreadySubmitData.instance.submitData.add({
                        'url': Interface.postHiddenDangereConfirm,
                        'data': {
                          "id": widget.id,
                          "isHiddenDangere": 1,
                          "confirmOpinion": _textEditingController.text,
                          "confirmUrl": image
                        },
                        'type': widget.genre,
                        'name': widget.data['keyParameterIndex'],
                      });
                      Fluttertoast.showToast(msg: '保存成功');
                      Navigator.pop(context);
                    }
                  } else {
                    Fluttertoast.showToast(msg: '请填写驳回的原因以及拍照');
                  }
                } else {
                  if(network){
                    Navigator.pushNamed(context, '/home/hiddenConfirm',
                        arguments: {
                          "id": widget.id,
                          "data": data,
                          "fourId": widget.fourId
                        }).then((value) {
                      _getData();
                    });
                  }else{
                    Fluttertoast.showToast(msg: '请在网络连接状态下进行该操作');
                  }
                }
              },
              child: Container(
                height: size.width * 75,
                // width: size.width * 505,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    bottom: size.width * 100, top: size.width * 50),
                decoration: BoxDecoration(
                  gradient:  network ? LinearGradient(colors: lineGradBlue) : isFull ? LinearGradient(colors: lineGradBlue) : LinearGradient(colors: [Color(0xff999999),Color(0xff999999)]),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Text(
                  network ? '确定' : '保存',
                  style: TextStyle(
                      color: network ? Color(0xffFFFFFF) : isFull ? Color(0xffFFFFFF) : Colors.white, fontSize: size.width * 36),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class ShowVideo extends StatefulWidget {
  final String url;
  const ShowVideo({Key key, this.url}) : super(key: key);

  @override
  _ShowVideoState createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  VideoPlayerController _playerController;
  VideoPlayerController _playerController2;
  @override
  void dispose() {
    _playerController?.dispose();
    _playerController2?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.network(widget.url)
      ..initialize().then((value) {
        setState(() {});
      });
    _playerController2 = VideoPlayerController.network(widget.url)
      ..initialize().then((value) {
        setState(() {});
      });
    _init();
  }

  _init() {}

  @override
  Widget build(BuildContext context) {
    return _playerController.value.isInitialized
        ? Stack(
            children: [
              InkWell(
                onTap: () {
                  showBottomSheet(
                    context: context,
                    builder: (_) => VideoPlayer(_playerController2),
                  );
                  _playerController2.seekTo(Duration(seconds: 0));
                  _playerController2.play();
                },
                child: VideoPlayer(_playerController),
              ),
              Positioned(
                  child: Center(
                child: Icon(
                  Icons.play_arrow_sharp,
                  color: Colors.black38,
                ),
              ))
            ],
          )
        : Container();
  }
}
