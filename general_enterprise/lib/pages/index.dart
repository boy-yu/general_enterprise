import 'package:enterprise/common/myUpdateDialog.dart';
import 'package:enterprise/pages/hiddenCheckGovern.dart';
import 'package:enterprise/pages/hiddenReported.dart';
import 'package:enterprise/pages/home.dart';
import 'package:enterprise/pages/mine.dart';
import 'package:enterprise/pages/riskHierarchicalControl.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/eventBus.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'navite.dart' if (dart.library.html) 'diffPlat.dart' as html;

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  MethodChannel _channel = MethodChannel('messagePushChannel');
  MethodChannel _stopChannel = MethodChannel('stop');
  @override
  void dispose() {
    EventBusUtils.getInstance().destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
    _getUrl();
  }

  _init() async {
    if (!Contexts.mobile) {
      await html.doSomething();
    }
    if (Contexts.mobile) {
      await _channel.invokeMethod('init');
    }

    if (Contexts.mobile) {
      NotificationPermissions.requestNotificationPermissions();
    }

    if (_jumpLogin()) {
      _stopChannel.setMethodCallHandler((call) async {
        if (myprefs.getString('token') != null) {
          if (call.method == 'stop') {
            // myDio.request(
            //     type: 'put',
            //     url: Interface.putAmendChatStatus,
            //     data: {"onlineStatus": "0"}).then((value) {});
          } else if (call.method == 'reStart') {
            // myDio.request(
            //     type: 'put',
            //     url: Interface.putAmendChatStatus,
            //     data: {"onlineStatus": "1"}).then((value) {});
          }
        }
      });
    }
  }

  _getVersion() async {
    // own app version
    String _version = await Version().getSever();
    myDio.request(type: 'get', url: Interface.cheakUpdate).then((value) async {
      await myprefs.setBool('isForcedUpgrade', false);
      // value['version'] serve version
      if (_version != value['version']) {
        Fluttertoast.showToast(msg: '有新版本需要更新!');
        if (value['isForcedUpgrade'] == 1) {
          await myprefs.setBool('isForcedUpgrade', true);
          // 版本强制更新dialog
          UpdateDialog.showUpdateDialog(
              context, value['version'], value['upgradeDescription'], true);
        } else {
          // 版本不强制更新dialog
          UpdateDialog.showUpdateDialog(
              context, value['version'], value['upgradeDescription'], false);
        }
      }
    });
  }

  bool _jumpLogin() {
    if (myprefs.getString('token') == null ||
        myprefs.getString('token') == '') {
      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.pushNamed(myContext, '/login').then((value) {
          // if (Contexts.mobile) _initMessageChannel();
          if (mounted) {
            setState(() {});
          }
        });
      });
      return false;
    } else {
      // _getFileUrl();
      // mytranslate = Translate();
      // mytranslate.init();
      if (myprefs.getString('sign') == '' ||
          myprefs.getString('sign') == null) {
        Navigator.pushNamed(context, '/person/sign');
      }
      if (Contexts.mobile) {
        // _initMessageChannel();
        _getVersion();
        // initPlatformState(myprefs.getString('account'), mounted);
      }
    }
    return true;
  }

  // init and login message and communication
  // _initMessageChannel() {
  //   _channel.invokeMethod('login', myprefs.getString('account'));
  //   glomessageChannel.setMessageHandler((message) => _detail(message));
  // }

  // _detail(message) {
  //   context
  //       .read<Counter>()
  //       .assginNotity(Notify('聊天', {message['userID']: message['message']}));
  //   ChatData().assginData(AssChat(
  //       userID: message['userID'],
  //       message: message['message'],
  //       groups: message['userID'] + '+' + myprefs.getString('account')));
  //   EventBusUtils.getInstance().fire(ChatEvent(message));
  // }

  _getUrl() {
    print(Interface.webUrl);
    myDio.request(
        type: 'get',
        url: Interface.webUrl).then((value) async {
      // print(mainBaseUrl);
      // print(value);
      if (value is Map) {
        if (myprefs.getString('webUrl') == null ||
            myprefs.getString('webUrl') == '') {
          await myprefs.setString('webUrl', value['ticketUrl'] ?? '');
          webUrl = value['ticketUrl'] ?? '';
        } else {
          webUrl = myprefs.getString('webUrl');
        }
        if (myprefs.getString('fileUrl') == null ||
            myprefs.getString('fileUrl') == '') {
          await myprefs.setString('fileUrl', value['fileViewPath'] ?? '');
          fileUrl = value['fileViewPath'] ?? '';
        } else {
          fileUrl = myprefs.getString('fileUrl');
        }
      }
    });
  }

  _geneateBottom(width) {
    List name = [
      {
        "icon": 'assets/images/doubleRiskProjeck/icon_home.png',
        "iconDis": "assets/images/doubleRiskProjeck/un_icon_home.png",
        "name": "首页"
      },
      {
        "icon": 'assets/images/doubleRiskProjeck/icon_risk_control.png',
        "iconDis": "assets/images/doubleRiskProjeck/un_icon_risk_control.png",
        "name": "风险分级管控"
      },
      {
        "icon": 'assets/images/doubleRiskProjeck/menu_home_hidden_reported.png',
        "name": "上报隐患"
      },
      {
        "icon": 'assets/images/doubleRiskProjeck/icon_hidden_check_govern.png',
        "iconDis": "assets/images/doubleRiskProjeck/un_icon_hidden_check_govern.png",
        "name": "隐患排查治理"
      },
      {
        "icon": 'assets/images/doubleRiskProjeck/icon_my.png',
        "iconDis": "assets/images/doubleRiskProjeck/un_icon_my.png",
        "name": "我的"
      },
    ];

    List<BottomNavigationBarItem> bottomRoute = [];
    for (var item in name) {
      if (item['name'] == '上报隐患') {
        bottomRoute.add(BottomNavigationBarItem(
          icon: Image.asset(
            item['icon'],
            width: width * 96,
            height: width * 96,
          ),
          // ignore: deprecated_member_use
          title: Text(
            '',
            style: TextStyle(
              fontSize: width * 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
      }else{
        bottomRoute.add(BottomNavigationBarItem(
          activeIcon: Image.asset(
            item['icon'],
            width: width * 40,
            height: width * 40,
          ),
          icon: Image.asset(
            item['iconDis'],
            width: width * 40,
            height: width * 40,
          ),
          // ignore: deprecated_member_use
          title: Text(
            item['name'],
            style: TextStyle(
              fontSize: width * 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
      }
    }
    return bottomRoute;
  }

  _pages(width) {
    List<Widget> pages = [Home(), RiskHierarchicalControl(), HiddenReported(callback: (){setState(() {_currentIndex = 3;});}), HiddenCheckGovern(), Mine()];
    return pages[_currentIndex];
  }

  changeIndex(int index) {
    _currentIndex = index;
    if (mounted) {
      setState(() {});
    }
  }

  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return Scaffold(
        body: _pages(width),
        bottomNavigationBar: Contexts.mobile
            ? BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xff2C3750),
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.shifting,
                onTap: (index) {
                  // if (PeopleStructure.state && index == 2) {
                  //   successToast('通讯录正在加载，请稍后重试');
                  //   return;
                  // }
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: _geneateBottom(width),
              )
            : null);
  }
}
