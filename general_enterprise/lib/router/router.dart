import 'package:enterprise/common/MyWebView.dart';
import 'package:enterprise/common/myLedger.dart';
import 'package:enterprise/pages/chat/chat.dart';
import 'package:enterprise/pages/hiddenCheckGovern/hiddenCheckGovernRouter.dart';
import 'package:enterprise/pages/index.dart';
import 'package:enterprise/pages/person/adress_book.dart';
import 'package:enterprise/pages/person/avatar.dart';
import 'package:enterprise/pages/person/myMessage.dart';
import 'package:enterprise/pages/person/sign.dart';
import 'package:enterprise/pages/riskHierarchicalControl/riskIdentifyTask/riskIdentifyTaskRouter.dart';
import 'package:enterprise/pages/riskHierarchicalControl/safetyRiskList/safetyRiskListRouter.dart';
import 'package:enterprise/pages/webRtc/_callView.dart';
import 'package:enterprise/pages/webRtc/__webRtc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/login.dart';
import '../pages/person/updata.dart';
import '../pages/person/amend_psd.dart';
import '../common/sign.dart';

class Routers {
  Routers();
  init() {
    // 风险分级管控 风险辨识任务
    riskIdentifyTaskRouter.forEach((element) {
      _routers.addAll(element);
    });
    // 风险分级管控 安全风险清单
    safetyRiskListRouter.forEach((element) {
      _routers.addAll(element);
    });
    // 隐患排查治理
    hiddenCheckGovernRouter.forEach((element) {
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

    '/person/adressBook': (context, {arguments}) => AdressBook(), 
    
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

    '/index': (context, {arguments}) => Index(), // 主页
    '/person/updata': (context, {arguments}) => Updata(), //更新页面
    '/person/psd': (context, {arguments}) => AmendPsd(), //密码
    '/person/sign': (context, {arguments}) => PersonSign(), //签名
    '/person/avatar': (context, {arguments}) =>
        PersonAvatar(arguments: arguments), //头像上传
    '/person/myMessage': (context, {arguments}) => MyMessage(), // 个人信息

    '/sign': (context, {arguments}) => Sign(arguments: arguments), //签名组件

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
