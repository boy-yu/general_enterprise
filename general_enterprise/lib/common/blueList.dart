import 'dart:async';
import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'myAppbar.dart';

const platform = const MethodChannel('getToken');

class BlueList extends StatefulWidget {
  @override
  _BlueListState createState() => _BlueListState();
}

class _BlueListState extends State<BlueList> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool blueState = false;
  Map state = {"linkButton": true};
  Timer _timer;
  ScanResult blueList;
  double yAxis = 0.0;
  List<double> xAxisList = [];
  _init() {
    flutterBlue.isOn.then((value) {
      blueState = value;
      if (blueState) {
        flutterBlue.startScan();
        flutterBlue.scanResults.listen((val) {
          val.forEach((element) {
            if (element.device.id.toString() == '4E:18:01:01:01:13') {
              blueList = element;
              flutterBlue.stopScan();
              if (mounted) {
                setState(() {});
              }
            }
          });
        });
      } else {
        Fluttertoast.showToast(msg: "请打开蓝牙");
      }
    });
  }

  @override
  void dispose() {
    platform.invokeMethod('close');
    flutterBlue.stopScan();
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MyAppbar(
            title: Text(
              '蓝牙列表',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 36,
                  color: Colors.white),
            ),
            child: blueState
                ? Container(
                    padding: EdgeInsets.all(size.width * 20),
                    child: Column(
                      children: <Widget>[
                        blueList != null
                            ? Text("蓝牙名称:" +
                                blueList.device.id.toString() +
                                "\n" +
                                blueList.device.name.toString())
                            : Container(),
                        state['linkButton']
                            ? ElevatedButton(
                                child: Text("链接"),
                                onPressed: () {
                                  String mac = blueList.device.id.toString();
                                  platform
                                      .invokeMethod('putBlue', mac)
                                      .then((value) {
                                    state['linkButton'] = false;
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  });
                                },
                              )
                            : Container(),
                        Expanded(
                            child: CustomEchart()
                                .lineChart(yAxis: yAxis, xAxisList: xAxisList)),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(themeColor)),
                          onPressed: !state['linkButton']
                              ? () async {
                                  if (_timer == null) {
                                    _timer = Timer.periodic(
                                        Duration(seconds: 2), (timer) {
                                      platform
                                          .invokeMethod('startGet')
                                          .then((value) {
                                        platform
                                            .invokeMethod('getData')
                                            .then((value) {
                                          if (yAxis < value) {
                                            yAxis = value;
                                          }
                                          xAxisList.add(value);
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        }).catchError((onError) {
                                          print("onError" + onError.toString());
                                        });
                                      });
                                    });
                                  } else {
                                    _timer.cancel();
                                    _timer = null;
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                }
                              : null,
                          child: Text(_timer == null ? '获取数据' : '结束获取'),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (mounted) {
                          setState(() {});
                        }
                        _init();
                      },
                      icon: Icon(Icons.refresh),
                      label: Text('请打开蓝牙进行刷新'),
                    ),
                  )),
        onWillPop: () async {
          Navigator.pop(context, yAxis);
          return false;
        });
  }
}
