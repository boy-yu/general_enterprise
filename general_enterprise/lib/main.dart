import 'package:enterprise/pages/index.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import './router/router.dart';
import 'common/myCount.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Counter())],
      child: MyApp()));
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  final router = Routers()..init();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale('en', 'US'), Locale('zh', 'ZH')],
      theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
              subtitle2:
                  TextStyle(color: Colors.white, fontSize: size.width * 26)),
          platform: TargetPlatform.iOS,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyContext(),
      onGenerateRoute: (settings) => router.sonGenerateRoute(settings),
    );
  }
}

class MyContext extends StatefulWidget {
  @override
  _MyContextState createState() => _MyContextState();
}

class _MyContextState extends State<MyContext> {
  bool show = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await Contexts.init(context);
    myDio.request(
      type: 'get', 
      url: Interface.getAllConfigUrl
    ).then((value) async {
      if (value is Map) {
        Interface.mainBaseUrl = value["mainApiUrl"];
        Interface.eduBaseUrl = value["etApiUrl"];
        Interface.closeBaseUrl = value["accessControlUrl"];
      }

      Mysize().init();

      show = true;
      setState(() {});
    }).catchError((onError) {
      successToast('服务器错误，正在重试');
      _init();
    });
  }

  DateTime _lastPressedAt;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: show ? Index() : Container(),
        onWillPop: () async {
          if (Contexts.mobile) {
            if (_lastPressedAt == null ||
                DateTime.now().difference(_lastPressedAt) >
                    Duration(seconds: 1)) {
              _lastPressedAt = DateTime.now();
              Fluttertoast.showToast(
                msg: "再次点击，立即退出App",
              );
              return false;
            } else {
              return true;
            }
          }
          return true;
        });
  }
}
