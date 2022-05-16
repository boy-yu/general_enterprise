// import 'package:chmod/chmod.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:dio/dio.dart';
import 'package:install_plugin/install_plugin.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import './interface.dart';

class DownSever {
  final context;
  int showNet = 0;
  // quite install
  DownSever(this.context, _onReceiveProgress, _judgeShow);
  Future<String> getSever() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String state = packageInfo.version;
    return state;
  }

  _whileNetwork(url, version, _onReceiveProgress, _judgeShow) {
    myDio
        .request(
      type: 'get',
      url: url,
    )
        .then((res) {
      if (res['version'] == version) {
        showToast('最新版本!');
        _judgeShow(false);
      } else {
        _judgeShow(true);
        showToast('检测到新版本,开始后台下载');
        launch(res['downloadAddress']);
        // print(res['downloadAddress']);
        // getExternalStorageDirectory().then((paths) {
        //   showToast('开始下载');
        //   _downloadApk(res['downloadAddress'], paths.path, _onReceiveProgress);
        // }).catchError((onError) {
        //   showToast("无法获取目录$onError");
        // });
      }
    }).catchError((onError) {
      // print(onError);
      if (showNet == 0) {
        showToast('网络错误，请稍后重试');
        showNet++;
      }
    });
  }

  DownSever.cheakSever(this.context, _onReceiveProgress, _judgeShow) {
    PackageInfo.fromPlatform().then((version) {
      String versions = version.version;

      _getServerApp(versions, context, _onReceiveProgress, _judgeShow);
    }).catchError((onError) {
      showToast('获取版本号失败');
    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: duration,
        backgroundColor: Colors.black.withOpacity(.5),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _getServerApp(version, context, _onReceiveProgress, _judgeShow) {
    String uop = Interface.cheakUpdate;
    _whileNetwork(uop, version, _onReceiveProgress, _judgeShow);
  }

  // _downloadApk(String url, String sDCardDir, _onReceiveProgress) {
  //   print(url);
  //   Dio()
  //       .download(url, sDCardDir + '/app.apk',
  //           onReceiveProgress: _onReceiveProgress)
  //       .then((res) {
  //     showToast('下载成功');
  //     // chmod(sDCardDir + '/app.apk', '0o777').then((e) {
  //     onClickInstallApk(sDCardDir + '/app.apk');
  //     // }).catchError((onError) {
  //     // print(onError);
  //     // });
  //   }).catchError((onError) {
  //     showToast(onError.toString());
  //   });
  // }

  void onClickInstallApk(_apkFilePath) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses[Permission.storage] == PermissionStatus.granted) {
      InstallPlugin.installApk(_apkFilePath, 'com.example.enterprise')
          .then((result) {})
          .catchError((error) {
        InstallPlugin.installApk(_apkFilePath, 'com.example.enterprise');
      });
    } else {
      print('Permission request fail!');
    }
  }
}

class Version {
  Future<String> getSever() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String state = packageInfo.version;
    return state;
  }
}
