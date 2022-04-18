import 'dart:io';
import 'package:app_uninstaller/app_uninstaller.dart' as appUnin;
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/down.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/myCustomColor.dart';

class Updata extends StatefulWidget {
  Updata();

  @override
  _UpdataState createState() => _UpdataState();
}

class _UpdataState extends State<Updata> with TickerProviderStateMixin {
  double circular = 0;
  bool showCir = false;
  AnimationController _animationController;
  Animation<double> _scale;
  ScrollController _scrollController = ScrollController();
  SharedPreferences pref;
  _onReceiveProgress(int receivedBytes, int totalBytes) {
    setState(() {
      circular = receivedBytes / totalBytes;
    });
    if (receivedBytes == totalBytes) {
      setState(() {
        showCir = false;
      });
    }
  }

  _judgeShow(bool showCirs) {
    setState(() {
      showCir = showCirs;
    });
  }

  List _updateMsg = [];
  String version = '';
  String currenVersion = '';
  bool isInstall = false;
  bool showInstall = false;
  bool show = true;
  DateTime _lastPressedAt;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _scale = Tween(begin: 0.6, end: 1.0).animate(_animationController);
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else {
        isForward = false;
      }
    });
    _animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(20000,
          duration: Duration(seconds: 2000), curve: Curves.linear);
    });
    _getDate();
  }

  _getDate() async {
    pref = await SharedPreferences.getInstance();
    _updateMsg = [];
    currenVersion =
        await DownSever(context, _onReceiveProgress, _judgeShow).getSever();
    myDio.request(type: 'get', url: Interface.cheakUpdate).then((value) {
      if (value is Map) {
        isInstall = value['isReload'] == 0 ? false : true;
        _updateMsg.add(value['upgradeDescription']);
        version = value['version'];
        if (version == currenVersion) {
          show = true;
        } else {
          show = false;
        }
        if (mounted) {
          setState(() {});
        }
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('版本更新'),
        lineGradColor: [Color(0xff3469FE), Color(0xff3B6FFF)],
        backgroundColor: Colors.white,
        elevation: 0,
        child: WillPopScope(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: size.width * 220),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff3469FE), Color(0xff3B6FFF)],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            ScaleTransition(
                              scale: _scale,
                              child: Container(
                                padding: EdgeInsets.all(60),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/versionDecoration@2x.png'),
                                )),
                                child: Text(
                                  '$currenVersion',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white,
                                      fontSize: size.width * 130),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.width * 40,
                            ),
                            !show
                                ? Text(
                                    isInstall ? '新版本需要卸载此版本\n重新安装' : '发现新版本',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Container(),
                            isInstall
                                ? ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                showInstall
                                                    ? Colors.red
                                                    : Colors.grey)),
                                    onPressed: () {
                                      showInstall
                                          ? WorkDialog.myDialog(
                                              context, () {}, 2,
                                              widget: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text('请确定下载过最新版app，在进行卸载'),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .red)),
                                                          onPressed: () async {
                                                            await appUnin
                                                                    .AppUninstaller
                                                                .Uninstall(
                                                                    "com.example.enterprise");
                                                          },
                                                          child: Text('确定卸载')),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('取消卸载')),
                                                    ],
                                                  )
                                                ],
                                              ))
                                          : successToast('请先点击下载');
                                    },
                                    child: Text('卸载'))
                                : Container()
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      child: ClipPath(
                        // clipper: ClipMost(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          physics: NeverScrollableScrollPhysics(),
                          child: Container(
                            height: size.width * 166,
                            width: 20000,
                            child: Image.asset(
                              'assets/images/versionBottom@2x.png',
                              repeat: ImageRepeat.repeatX,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(size.width * 20),
                  width: MediaQuery.of(context).size.width,
                  child: Text('新版本特性  $version',
                      style: TextStyle(
                          color: themeColor, fontSize: size.width * 30)),
                ),
                Expanded(
                    child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: size.width * 40),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                color: themeColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: size.width * 10,
                              height: size.width * 10,
                              margin: EdgeInsets.only(
                                  right: size.width * 15,
                                  top: size.width * 15)),
                          Expanded(
                              child: Text(
                            _updateMsg[index],
                            style: TextStyle(fontSize: size.width * 30),
                          )),
                        ],
                      ),
                    );
                  },
                  itemCount: _updateMsg.length,
                )),
                circular > 0
                    ? Center(
                        child: CircularProgressIndicator(
                          value: circular,
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Container(),
                !show
                    ? GestureDetector(
                        onTap: () async {
                          DownSever.cheakSever(
                              context, _onReceiveProgress, _judgeShow);
                          setState(() {
                            showInstall = true;
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 160,
                                vertical: size.width * 40),
                            padding:
                                EdgeInsets.symmetric(vertical: size.width * 20),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: lineGradBlue),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                '立即下载',
                                style: TextStyle(
                                    fontSize: size.width * 30,
                                    color: Colors.white),
                              ),
                            )),
                      )
                    : Container(),
              ],
            ),
            onWillPop: () async {
              if (pref.getBool('isForcedUpgrade') == true) {
                if (_lastPressedAt == null ||
                    DateTime.now().difference(_lastPressedAt) >
                        Duration(seconds: 1)) {
                  _lastPressedAt = DateTime.now();
                  Fluttertoast.showToast(
                    msg: "再次点击，立即退出App",
                  );
                  return false;
                } else {
                  exit(0);
                }
              } else {
                return true;
              }
            }));
  }
}

class DrawWater extends CustomPainter {
  DrawWater({double value = 0.0}) : value = value ?? 0.0;
  double value;
  Paint _paint = Paint()
    ..color = Colors.white
    ..strokeWidth = 2
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;
  Paint _backPaint = Paint()
    ..color = themeColor
    ..strokeWidth = 2
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;
  Paint _clipRoundPaint = Paint()
    ..color = Colors.red
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    Rect _backRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(_backRect, _backPaint);
    canvas.drawCircle(Offset(value + 5, -10), size.width / 4, _clipRoundPaint);

    canvas.drawCircle(Offset(value + size.width / 2, size.width - 160),
        size.width / 2, _paint);

    canvas.drawCircle(Offset(value + size.width + value, -22), size.width / 4,
        _clipRoundPaint);
    // canvas.drawCircle(
    //     Offset(value + size.width, size.width / 2), size.width / 2, _paint);
    // canvas.drawCircle(Offset(value + 200, size.height + 50 + 20), 100, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width, size.height, size.width / 4, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldPath) => true;
}

class ClipMost extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path _path = Path();
    _path.addRect(Rect.fromLTWH(-1, -1, size.width, size.height - 15));
    return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
