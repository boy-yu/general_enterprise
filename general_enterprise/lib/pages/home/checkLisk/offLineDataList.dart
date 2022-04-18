import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:enterprise/pages/home/checkLisk/data/alreadySubmitData.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OffLineDataList extends StatefulWidget {
  @override
  _OffLineDataListState createState() => _OffLineDataListState();
}

class _OffLineDataListState extends State<OffLineDataList> {
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
          if (AlreadySubmitData.instance.submitData.isNotEmpty) {
            _regroupSubmitImage();
          }
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  _regroupSubmitImage() {
    for (int i = 0; i < AlreadySubmitData.instance.submitData.length; i++) {
      if (AlreadySubmitData.instance.submitData[i]['queryParameters'] == null) {
        _getImage(AlreadySubmitData.instance.submitData[i]['data']);
      } else {
        _getImage(AlreadySubmitData.instance.submitData[i]['queryParameters']);
      }
    }
  }

  _getImage(Map map) async {
    List<String> newImageMap = [];
    if (map['executionUrl'] != null) {
      List executionUrl = map['executionUrl'].split('|');
      for (int i = 0; i < executionUrl.length; i++) {
        if (executionUrl[i].toString().substring(0, 4) != 'http') {
          final res = await Dio().post(
            Interface.uploadUrl,
            data: FormData.fromMap(
                {"file": await MultipartFile.fromFile(executionUrl[i])}),
          );
          if (res.data['code'] == 200) {
            newImageMap.add(res.data['message']);
          }
        } else {
          newImageMap.add(executionUrl[i]);
        }
      }
      map['executionUrl'] = _listToString(newImageMap);
    }
    if (map['rectificationUrl'] != null) {
      List rectificationUrl = map['rectificationUrl'].split('|');
      for (int i = 0; i < rectificationUrl.length; i++) {
        if (rectificationUrl[i].toString().substring(0, 4) != 'http') {
          final res = await Dio().post(
            Interface.uploadUrl,
            data: FormData.fromMap(
                {"file": await MultipartFile.fromFile(rectificationUrl[i])}),
          );
          if (res.data['code'] == 200) {
            newImageMap.add(res.data['message']);
          }
        } else {
          newImageMap.add(rectificationUrl[i]);
        }
      }
      map['rectificationUrl'] = _listToString(newImageMap);
    }
    if (map['confirmUrl'] != null) {
      List confirmUrl = map['confirmUrl'].split('|');
      for (int i = 0; i < confirmUrl.length; i++) {
        if (confirmUrl[i].toString().substring(0, 4) != 'http') {
          final res = await Dio().post(
            Interface.uploadUrl,
            data: FormData.fromMap(
                {"file": await MultipartFile.fromFile(confirmUrl[i])}),
          );
          if (res.data['code'] == 200) {
            newImageMap.add(res.data['message']);
          }
        } else {
          newImageMap.add(confirmUrl[i]);
        }
      }
      map['confirmUrl'] = _listToString(newImageMap);
    }
  }

  String _listToString(List<String> list) {
    if (list == null) {
      return null;
    }
    String result;
    list.forEach((string) =>
        {if (result == null) result = string else result = '$result|$string'});
    return result.toString();
  }

  List<String> originStrs = [];
  bool isRun = false;
   deteItem(String originStr) {
    if (originStrs.isEmpty) {
      originStrs.add(originStr);
    }
    if (isRun) {
      originStrs.add(originStr);
    } else {
      isRun = true;
      int _j = -1;

      for (var j =  0; j < AlreadySubmitData.instance.submitData.length; j++) {
        if (originStr == AlreadySubmitData.instance.submitData[j]['url'] + AlreadySubmitData.instance.submitData[j]['data'].toString()) {
          _j = j;
          break;
        }
      }
      
      if (_j > -1) {    
        AlreadySubmitData.instance.submitData.removeAt(_j);
      }
      Fluttertoast.showToast(msg: '提交成功');
      setState(() {});
      isRun = false;
      originStrs.removeAt(0);
      if (originStrs.isNotEmpty) {
        deteItem(originStrs[0]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AlreadySubmitData.instance.submitData.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                    itemCount: AlreadySubmitData.instance.submitData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (network) {
                            if (AlreadySubmitData.instance.submitData[index]
                                    ['queryParameters'] ==
                                null) {
                              myDio
                                  .request(
                                type: 'post',
                                url: AlreadySubmitData
                                    .instance.submitData[index]['url'],
                                data: AlreadySubmitData
                                    .instance.submitData[index]['data'],
                              )
                                  .then((value) {
                                successToast('提交成功');
                                AlreadySubmitData.instance.submitData.remove(
                                    AlreadySubmitData
                                        .instance.submitData[index]);
                                setState(() {});
                              });
                            } else {
                              myDio
                                  .request(
                                type: 'post',
                                url: AlreadySubmitData
                                    .instance.submitData[index]['url'],
                                queryParameters: AlreadySubmitData.instance
                                    .submitData[index]['queryParameters'],
                              )
                                  .then((value) {
                                successToast('提交成功');
                                AlreadySubmitData.instance.submitData.remove(
                                    AlreadySubmitData
                                        .instance.submitData[index]);
                                setState(() {});
                              });
                            }
                          }
                        },
                        child: Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: size.width * 20),
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 110,
                                height: size.width * 36,
                                margin: EdgeInsets.only(
                                    top: size.width * 37,
                                    bottom: size.width * 37,
                                    left: size.width * 35),
                                decoration: BoxDecoration(
                                  color: Color(0xffD9E5FF),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 18)),
                                  border: Border.all(
                                      width: size.width * 1,
                                      color: Color(0xff3073FE)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  // AlreadySubmitData.instance.submitData[index]
                                  AlreadySubmitData.instance.submitData[index]['type'],
                                  style: TextStyle(
                                      color: Color(0xff3073FE),
                                      fontSize: size.width * 20),
                                ),
                              ),
                              Container(
                                width: size.width * 1,
                                height: size.width * 70,
                                color: Color(0xffECEEEF),
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 30),
                              ),
                              Expanded(
                                  child: Text(
                                      // AlreadySubmitData
                                      //     .instance.submitData[index]
                                      AlreadySubmitData.instance.submitData[index]['name'],
                                      style: TextStyle(
                                          color: Color(0xff262626),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)),
                              Container(
                                height: size.width * 40,
                                width: size.width * 80,
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 20),
                                decoration: BoxDecoration(
                                    color: network
                                        ? Color(0xff3073FE)
                                        : Color(0xff999999),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 8))),
                                alignment: Alignment.center,
                                child: Text(
                                  '提交',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * 22),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
            : Expanded(
                child: Center(
                child: Text('暂无离线提交数据'),
              )),
        GestureDetector(
          onTap: () {
            if (network) {
              // print(AlreadySubmitData.instance.submitData);
              if (AlreadySubmitData.instance.submitData.isNotEmpty) {
                for (int i = AlreadySubmitData.instance.submitData.length-1; i > -1 ; i--) {
                  Map _map = AlreadySubmitData.instance.submitData[i];
                  if (AlreadySubmitData.instance.submitData[i]['queryParameters'] == null) {
                    myDio.request(
                      type: 'post',
                      url: AlreadySubmitData.instance.submitData[i]['url'],
                      data: AlreadySubmitData.instance.submitData[i]['data'],
                    ).then((value) {
                      // AlreadySubmitData.instance.submitData.remove(AlreadySubmitData.instance.submitData[i]);
                      deteItem(_map['url'] + _map['data'].toString());
                    });
                  } else {
                    myDio.request(
                      type: 'post',
                      url: AlreadySubmitData.instance.submitData[i]['url'],
                      queryParameters: AlreadySubmitData.instance.submitData[i]['queryParameters'],
                    ).then((value) {
                      deteItem(_map['url'] + _map['data'].toString());
                    });
                  }
                }
              }
              // if (AlreadySubmitData.instance.submitData.isNotEmpty) {
              //   for (int i = 0;
              //       i < AlreadySubmitData.instance.submitData.length;
              //       i++) {
              //     if (AlreadySubmitData.instance.submitData[i]
              //             ['queryParameters'] ==
              //         null) {
              //       myDio
              //           .request(
              //         type: 'post',
              //         url: AlreadySubmitData.instance.submitData[i]['url'],
              //         data: AlreadySubmitData.instance.submitData[i]['data'],
              //       )
              //           .then((value) {
              //         // AlreadySubmitData.instance.submitData.remove(AlreadySubmitData.instance.submitData[i]);
              //         deteItem(AlreadySubmitData.instance.submitData[i]['url'] +
              //             AlreadySubmitData.instance.submitData[i]['data']
              //                 .toString());
              //       }).catchError((onError) {
              //         deteItem(AlreadySubmitData.instance.submitData[i]['url'] +
              //             AlreadySubmitData.instance.submitData[i]['data']
              //                 .toString());
              //       });
              //     } else {
              //       myDio
              //           .request(
              //         type: 'post',
              //         url: AlreadySubmitData.instance.submitData[i]['url'],
              //         queryParameters: AlreadySubmitData.instance.submitData[i]
              //             ['queryParameters'],
              //       )
              //           .then((value) {
              //         deteItem(AlreadySubmitData.instance.submitData[i]['url'] +
              //             AlreadySubmitData.instance.submitData[i]['data']
              //                 .toString());
              //       }).catchError((onError) {
              //         deteItem(AlreadySubmitData.instance.submitData[i]['url'] +
              //             AlreadySubmitData.instance.submitData[i]['data']
              //                 .toString());
              //       });
              //     }
              //   }
              // }
            }
          },
          child: Container(
            width: size.width * 220,
            height: size.width * 60,
            margin: EdgeInsets.symmetric(vertical: size.width * 30),
            decoration: BoxDecoration(
                color:
                    network && AlreadySubmitData.instance.submitData.isNotEmpty
                        ? Color(0xff09BA07)
                        : Color(0xff999999),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            alignment: Alignment.center,
            child: Text(
              '一键提交',
              style: TextStyle(color: Colors.white, fontSize: size.width * 30),
            ),
          ),
        )
      ],
    );
  }
}
