import 'dart:io';
import 'dart:ui';
import 'package:enterprise/common/cacheData.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/tool/dio.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:enterprise/common/cacheData.dart';

BuildContext myContext;
CacheData cacheData = CacheData();
Size size = Size(0.5, 0.5);
// BasicMessageChannel glomessageChannel =
//     BasicMessageChannel('chat', StandardMessageCodec());
SharedPreferences myprefs;
String webUrl = '';
String fileUrl = '';
MyDio myDio;
bool isLogin = false;
// CacheData cacheData = CacheData();
// MethodChannel platform = const MethodChannel('getLocal');
void successToast(String msg) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: themeColor,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      webPosition: 'center');
}

class Contexts {
  static bool mobile = false;
  bool get isMobile => mobile;

  Widget shadowWidget(Widget child,
      {EdgeInsets padding,
      EdgeInsets margin,
      BorderRadius borderRadius,
      Color color}) {
    return Container(
      padding: padding,
      margin: margin,
      color: color,
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                offset: Offset(2, 2),
                blurRadius: 5)
          ]),
      child: child,
    );
  }

  static judgePlat() {
    try {
      if (Platform.isAndroid) {
        mobile = true;
      }
    } catch (e) {
      mobile = false;
    }
  }

  static Future init(context) async {
    myContext = context;
    myprefs = await SharedPreferences.getInstance();
    judgePlat();
    if (mobile) {
      db = await openDatabase('my_db.db');
    }
    myDio = MyDio();
  }
}

class Mysize {
  void init() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    double _width =
        mediaQuery.size.width / 750 == 0 ? 0.5 : mediaQuery.size.width / 750;
    double _height = mediaQuery.size.height / 1334 == 0
        ? 0.5
        : mediaQuery.size.height / 1334;
    size = Size(_width, _height);
  }
}

List chatIdList = [];
// Future<void> initPlatformState(String identify, bool mounted) async {
//   if (!mounted) return;
//   XgFlutterPlugin.xgApi.enableOtherPush();
//   XgFlutterPlugin.xgApi.regPush();
//   // XgFlutterPlugin.xgApi.s
//   /// 开启DEBUG
//   // XgFlutterPlugin().setEnableDebug(true);
//   /// 添加回调事件
//   XgFlutterPlugin().addEventHandler(
//     xgPushDidUnbindWithIdentifier: (String msg) async {
//       print("flutter xgPushDidUnbindWithIdentifier: $msg");
//     },
//     onReceiveNotificationResponse: (event) async {
//       List split = event['title'].toString().split(':');
//       if (split[0] == '待办项') {
//         if (split[1] == '作业') {
//           myContext
//               .read<Counter>()
//               .assginNotity(Notify('作业', {split[2]: split[2]}));
//         } else if (split[1] == '应急') {
//           myContext
//               .read<Counter>()
//               .assginNotity(Notify('应急', {split[2]: split[2]}));
//         } else if (split[1] == '视频') {
//           platform
//               .invokeMethod(
//                   'getAppState', int.parse(event['notifactionId'].toString()))
//               .then((value) async {
//             if (value) {
//               List spilt = event['content'].toString().split(':');
//               PeopleStructure people =
//                   await PeopleStructure.getAccountPeople(split[3].toString());
//               Future.delayed(Duration(seconds: 1), () {
//                 Navigator.pushNamed(myContext, '/callview', arguments: {
//                   "data": people,
//                   "state": true,
//                   "self": spilt[1]
//                 });
//               });
//             }
//           });
//         } else if (split[1] == '聊天') {
//           chatIdList.add(event['notifactionId']);
//         } else if (split[1] == '作业审核审批') {
//           myContext
//               .read<Counter>()
//               .assginNotity(Notify('作业', {split[2]: split[2]}));
//         }
//       }
//     },
//     xgPushClickAction: (event) async {
//       if (event['actionType'] == 0) {
//         List split = event['title'].toString().split(':');
//         String _router = '';
//         int way = -1;
//         if (split[0] == '我的清单') {
//           _router = "/index/checkList";
//           way = 0;
//         } else if (split[0] == '待办项') {
//           _router = "/index/waitWork";
//           if (split[1] == '聊天') {
//             for (var i = 0; i < chatIdList.length; i++) {
//               platform.invokeMethod(
//                   'getAppState', int.parse(chatIdList[i].toString()));
//             }
//             chatIdList = [];
//             way = 1;
//           } else if (split[1] == '作业') {
//             way = 0;
//           } else if (split[1] == '应急') {
//             way = 2;
//           } else if (split[1] == '视频') {
//             List spilt = event['content'].toString().split(':');
//             PeopleStructure people =
//                 await PeopleStructure.getAccountPeople(split[3].toString());
//             Future.delayed(Duration(seconds: 2), () {
//               while (Navigator.canPop(myContext) == true) {
//                 Navigator.pop(myContext);
//               }
//               Navigator.pushNamed(myContext, '/callview',
//                   arguments: {"data": people, "state": true, "self": spilt[1]});
//             });

//             return;
//           }
//         }

//         // xgPushDidClearAllIdentifiers
//         if (way != -1) {
//           Future.delayed(Duration(seconds: 2), () {
//             while (Navigator.canPop(myContext) == true) {
//               Navigator.pop(myContext);
//             }
//             Navigator.pushNamed(myContext, _router, arguments: {"way": way});
//           });
//         }
//       }
//     },
//   );

//   /// 如果您的应用非广州集群则需要在startXG之前调用此函数
//   /// 香港：tpns.hk.tencent.com
//   /// 新加坡：tpns.sgp.tencent.com
//   /// 上海：tpns.sh.tencent.com
//   // XgFlutterPlugin().configureClusterDomainName("tpns.hk.tencent.com");

//   /// 启动TPNS服务 ios 启动
//   XgFlutterPlugin().startXg("1500017971", "A7VLPYQEM8K3");
//   XgFlutterPlugin()
//       .bindWithIdentifier(identify: identify, bindType: XGBindType.account);
// }
// 15196460037  1127954788
