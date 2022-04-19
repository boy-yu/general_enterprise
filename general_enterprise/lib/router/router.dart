import 'package:enterprise/common/MyWebView.dart';
import 'package:enterprise/common/blueList.dart';
import 'package:enterprise/common/myLedger.dart';
import 'package:enterprise/localtion.dart';
import 'package:enterprise/pages/chat/chat.dart';
import 'package:enterprise/pages/home/bigDanger/router.dart';
import 'package:enterprise/pages/home/checkLisk/router.dart';
import 'package:enterprise/pages/home/closedManagement/closedManagementRouter.dart';
import 'package:enterprise/pages/home/education/educationRouter.dart';
import 'package:enterprise/pages/home/education/personalImage.dart';
import 'package:enterprise/pages/home/emergencyRescue/emergencyRescueRoute.dart';
import 'package:enterprise/pages/home/fireControl/fireControlRoute.dart';
import 'package:enterprise/pages/home/fireworksCrackers/fireworksCrackersRouter.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenDangerRouter.dart';
// import 'package:enterprise/pages/home/detailedList/blueList.dart';
// import 'package:enterprise/pages/home/detailedList/flirOne.dart';
// import 'package:enterprise/pages/home/work/__cancelWork.dart';
// import 'package:enterprise/pages/home/work/_changeGuardian.dart';
import 'package:enterprise/pages/home/legitimate/legitimateRouter.dart';
import 'package:enterprise/pages/home/productList/router.dart';
import 'package:enterprise/pages/home/spotCheck/spotCheckRoute.dart';
import 'package:enterprise/pages/home/twoSingleCard/twoSingleCardRouter.dart';
import 'package:enterprise/pages/home/work/workRouter.dart';
import 'package:enterprise/pages/index.dart';
import 'package:enterprise/pages/person/avatar.dart';
import 'package:enterprise/pages/person/myMessage.dart';
import 'package:enterprise/pages/person/sign.dart';
import 'package:enterprise/pages/waitWork/_cancelWorkApply.dart';
import 'package:enterprise/pages/waitWork/waitRouter.dart';
import 'package:enterprise/pages/webRtc/_callView.dart';
import 'package:enterprise/pages/webRtc/__webRtc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/login.dart';
import '../pages/person/updata.dart';
import '../pages/person/amend_psd.dart';
import '../common/sign.dart';
import '../pages/home/risk/riskRoute.dart';

class Routers {
  Routers();
  init() {
    waitRouter.forEach((element) {
      _routers.addAll(element);
    });
    riskRouter.forEach((element) {
      _routers.addAll(element);
    });
    workList.forEach((element) {
      _routers.addAll(element);
    });
    hiddenDanger.forEach((element) {
      _routers.addAll(element);
    });
    checkList.forEach((element) {
      _routers.addAll(element);
    });
    productList.forEach((element) {
      _routers.addAll(element);
    });
    spotCheck.forEach((element) {
      _routers.addAll(element);
    });
    educationRouter.forEach((element) {
      _routers.addAll(element);
    });
    legitimateRouter.forEach((element) {
      _routers.addAll(element);
    });
    emergencyRescueRoute.forEach((element) {
      _routers.addAll(element);
    });
    bigDangerRouter.forEach((element) {
      _routers.addAll(element);
    });
    fireControlRoute.forEach((element) {
      _routers.addAll(element);
    });
    fireworksCrackersRouter.forEach((element) {
      _routers.addAll(element);
    });
    twoSingleCardRouter.forEach((element) {
      _routers.addAll(element);
    });
    closedManagementRouter.forEach((element) {
      _routers.addAll(element);
    });
  }

  List<OwnPage> list = [
    OwnPage(
      name: '/',
      key: Key('/'),
      build: (context, {arguments}) => Index(),
    ),
  ];

  final Map<String, Widget Function(BuildContext context, {dynamic arguments})>
      _routers = {
    '/login': (context, {arguments}) => Login(), // 登陆页面
    '/personalImage': (context, {arguments}) => PersonalImage(
      barcode: arguments['barcode']
    ), 

    '/webview': (context, {arguments}) =>
        MyWebView(arguments: arguments), // 内嵌浏览器
    '/webviews': (context, {arguments}) =>
        FlutterWebView(arguments: arguments), // flutter 端
    '/chat': (context, {arguments}) => MyChat(data: arguments['data']), // 聊天
    '/callview': (context, {arguments}) => Callview(
        data: arguments['data'],
        state: arguments['state'],
        self: arguments['self']), // 视频呼出/接收
    '/webrtc': (context, {arguments}) => MyWebRtc(), // 视频聊天
    '/index/waitWork/cancelWorkPage': (context, {arguments}) =>
        CancelWorkApply(arguments: arguments), //取消作业
    '/index': (context, {arguments}) => Index(), // 主页
    '/person/updata': (context, {arguments}) => Updata(), //更新页面
    '/person/psd': (context, {arguments}) => AmendPsd(), //密码
    '/person/sign': (context, {arguments}) => PersonSign(), //签名
    '/person/avatar': (context, {arguments}) =>
        PersonAvatar(arguments: arguments), //头像上传
    '/person/myMessage': (context, {arguments}) => MyMessage(), // 个人信息

    '/sign': (context, {arguments}) => Sign(arguments: arguments), //签名组件

    'tempLocation': (context, {arguments}) => Localtion(), //临时测试页面

    // 蓝牙振动仪  flir one热成像
    'blueTooth': (context, {arguments}) => BlueList(),
    // 'blueTooth': (context, {arguments}) => FlirOne(),

    // 总览

    // 台账
    '/home/myLedger' : (context, {arguments}) => MyLedger(
        oneId: arguments['oneId'],
        twoId: arguments['twoId'],
        threeId: arguments['threeId'],
        fourId: arguments['fourId'],
        coDepartmentId: arguments['coDepartmentId'],
        hiddenType: arguments['hiddenType'],
        controlType: arguments['controlType'],
        // status: arguments['status'],
    ),
  };

  Route onGenerateRoute(RouteSettings settings) {
    final String name = settings.name;

    final Function pageContentBuilder = _routers[name];
    Route route;
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        route = CupertinoPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments));
      } else {
        route = CupertinoPageRoute(
            builder: (context) => pageContentBuilder(
                  context,
                ));
        // OwnPageRoute(builder: (context) => pageContentBuilder(context));
      }
    }
    return route;
  }

 

  Route sonGenerateRoute(RouteSettings settings) {
    final String name = settings.name;

    Function(BuildContext, {dynamic arguments}) pageContentBuilder =
        _routers[name];

    Route route;
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        route = CupertinoPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments));
      } else {
        route = CupertinoPageRoute(
            builder: (context) => pageContentBuilder(
                  context,
                ));
      }
    }
    return route;
  }
}

class OwnPage<T> extends Page<T> {
  /// Creates a material page.
  const OwnPage({
    this.build,
    this.maintainState = true,
    this.fullscreenDialog = false,
    LocalKey key,
    String name,
    Object arguments,
  }) : super(key: key, name: name, arguments: arguments);

  /// The content to be shown in the [Route] created by this page.
  final Widget Function(BuildContext context, {dynamic arguments}) build;

  /// {@macro flutter.widgets.ModalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  @override
  Route<T> createRoute(BuildContext context) {
    return _PageBasedMaterialPageRoute<T>(page: this);
  }
}

class _PageBasedMaterialPageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  _PageBasedMaterialPageRoute({
    @required OwnPage<T> page,
  })  : assert(page != null),
        super(settings: page) {
    assert(opaque);
  }

  OwnPage<T> get _page => settings as OwnPage<T>;

  @override
  Widget buildContent(BuildContext context) {
    return _page.build.call(context, arguments: T);
  }

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}
