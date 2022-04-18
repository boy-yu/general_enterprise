import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/pages/home/checkLisk/data/alreadySubmitData.dart';
import 'package:enterprise/pages/home/checkLisk/data/hiddenData.dart';
import 'package:enterprise/pages/home/checkLisk/data/spotCheckData.dart';
import 'package:enterprise/pages/home/hiddenDanger/hidden_dialog/_dailogWorkPlan.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class IsWorkDialog extends StatefulWidget {
  IsWorkDialog({this.data, this.callback, this.fourId});
  final Map data;
  final Function callback;
  final int fourId;
  @override
  _IsWorkDialogState createState() => _IsWorkDialogState();
}

class _IsWorkDialogState extends State<IsWorkDialog> {
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
      //弹出框的具体事件
      child: Material(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          width: size.width * 467,
                          margin: EdgeInsets.only(
                              left: size.width * 90,
                              right: size.width * 90,
                              bottom: size.width * 30,
                              top: size.width * 10),
                          decoration: BoxDecoration(
                            //背景装饰
                            color: Color.fromRGBO(255, 255, 255, 0.15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(""))),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          width: size.width * 561,
                          margin: EdgeInsets.only(
                              left: size.width * 45,
                              right: size.width * 45,
                              bottom: size.width * 53,
                              top: size.width * 25),
                          decoration: BoxDecoration(
                            //背景装饰
                            color: Color.fromRGBO(255, 255, 255, 0.15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(""))),
                  Container(
                    width: size.width * 655,
                    height: size.width * 350,
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: []),
                    margin: EdgeInsets.only(
                        bottom: size.width * 74, top: size.width * 35),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              bottom: size.width * 30, top: size.width * 20),
                          padding: EdgeInsets.only(
                              left: size.width * 30, right: size.width * 30),
                          child: Text(
                            "是否生成作业",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 36,
                                color: Color(0xff005AFF)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.width * 20,
                              right: size.width * 50,
                              left: size.width * 50),
                          child: Text(
                            '根据隐患内容和五定措施，关于整改隐患是否需要生成特殊作业进行隐患的整改。',
                            style: TextStyle(
                                color: Color(0xff666666),
                                fontSize: size.width * 26),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.width * 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  widget.data['whetherWork'] = 2;
                                  if(network){
                                      myDio.request(
                                            type: 'post',
                                            url: Interface.postHiddenDangereConfirm,
                                            data: widget.data)
                                        .then((value) {
                                        successToast('上报成功');
                                        for (int i = 0; i < HiddenData.instance.download.length; i++) {
                                          if(HiddenData.instance.download[i]['id'] == widget.data['id']){
                                            HiddenData.instance.download.remove(HiddenData.instance.download[i]);
                                          }
                                        }
                                        for (int j = 0; j < SpotCheckData.instance.download.length; j++) {
                                          if(SpotCheckData.instance.download[j]['id'] == widget.data['id']){
                                            SpotCheckData.instance.download.remove(SpotCheckData.instance.download[j]);
                                          }
                                        }
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      });
                                  }else{
                                    AlreadySubmitData.instance.submitData.add({
                                      'url': Interface.postHiddenDangereConfirm,
                                      'data': widget.data,
                                      'type': '确认隐患',
                                      'name': widget.data['keyParameterIndex'],
                                    });
                                    for (int i = 0; i < HiddenData.instance.download.length; i++) {
                                        if(HiddenData.instance.download[i]['fourId'] == widget.data['id']){
                                          HiddenData.instance.download.remove(HiddenData.instance.download[i]);
                                        }
                                      }
                                      for (int j = 0; j < SpotCheckData.instance.download.length; j++) {
                                        if(SpotCheckData.instance.download[j]['fourId'] == widget.data['id']){
                                          SpotCheckData.instance.download.remove(SpotCheckData.instance.download[j]);
                                        }
                                      }
                                    Fluttertoast.showToast(msg: '保存成功');
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Container(
                                  width: size.width * 160,
                                  height: size.width * 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFF1818),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    '否',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: size.width * 28),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 100,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // print(widget.data);
                                  _counter.emptySubmitDates(key: '作业计划');
                                  widget.data['whetherWork'] = 1;
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (_) => WorkPlanDialog(
                                                callback: widget.callback,
                                                data: widget.data,
                                              )));
                                },
                                child: Container(
                                  width: size.width * 160,
                                  height: size.width * 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0059FF),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    '是',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: size.width * 28),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  )
                ],
              )
            ],
          )),
    );
  }
}
