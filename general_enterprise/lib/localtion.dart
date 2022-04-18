import 'dart:developer';
import 'dart:isolate';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/work/work_dilog/_getVideo.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';

class Localtion extends StatefulWidget {
  @override
  _LocaltionState createState() => _LocaltionState();
}

class _LocaltionState extends State<Localtion> {
  // getLocal  getToken
  CameraController controller;
  List<CameraDescription> cameras;
  List video = [];
  List video1 = [];
  String image = '';
  MethodChannel platHot = const MethodChannel('FLIRONE');
  MethodChannel platform = const MethodChannel('getLocal');
  String haha = '';
  _getGps() async {
    // ios
    // AMapLocationClient.setApiKey("b3a797027711aedbe9a1c97a4b52e251");

    // platform.invokeMethod('getLocal', {"asd": 'asd'}).then((value) {
    //   print(value);
    // }).catchError((onError) {
    //   print(onError);
    // });

    myDio
        .request(
      type: 'get',
      url: Interface.baseUrl + '/api/v4/coInfo/ceshi',
      key: '564',
    )
        .then((value) {
      haha = 'asdasdas';
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initLister();
  }

  _initLister() {
    platHot.invokeMethod('endFlirOne').then((value) {}).catchError((onError) {
      print(onError);
    });
  }

  _startFilrOne() {
    platHot.invokeMethod('startFlirOne').then((value) {
      image = value['path'];
      setState(() {});
    }).catchError((onError) {
      log('value' + onError);
    });
  }

  // 创建一个新的 isolate
  createIsolate() async {
    ReceivePort rp = new ReceivePort();
    SendPort port1 = rp.sendPort;
    await Isolate.spawn(doWork, port1);
    rp.listen((message) {
      print("main isolate message: $message");
    });
  }

// 处理耗时任务
  static void doWork(SendPort port1) {
    print("new isolate start");
    ReceivePort rp2 = new ReceivePort();
    rp2.listen((message) {
      print("doWork message: $message");
    });

    port1.send('asdas');
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('获取GPS'),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(haha),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                print(mytranslate.getTranslate('input'));
              },
              child: Icon(Icons.translate),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: _getGps,
              child: Text('获取GPS'),
            ),
            WorkVideo(
              callbacks: (val) {
                print(val);
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                _startFilrOne();
              },
              child: Text('_startFilrOne'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: createIsolate,
              child: Text('createIsolate'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                Navigator.pushNamed(context, 'blueTooth');
              },
              child: Text('blue'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                Navigator.pushNamed(context, '/webview',
                    arguments: {'url': 'https://www.stbu.edu.cn/'});
              },
              child: Text('webview'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                Navigator.pushNamed(context, '/mapTest');
              },
              child: Text('goMap'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                // print('object');
                platform.invokeMapMethod('registerVivo');
                // platform.invokeMethod("clearNoti");
              },
              child: Text('clearAllNofity'),
            )
          ],
        ),
      ),
    );
  }
}
