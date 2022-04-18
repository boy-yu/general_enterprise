import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/chat/chatDataBase.dart';
import 'package:enterprise/pages/home/workBak/__cancelWork.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/down.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpns_flutter_plugin/tpns_flutter_plugin.dart';

class Person extends StatefulWidget {
  final double width;
  Person(this.width);
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacity;
  bool show = true;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: themeColor),
          child: Padding(
            padding:
                EdgeInsets.only(top: size.width * 67, bottom: size.width * 118),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '我的',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontSize: size.width * 42),
                ),
              ],
            ),
          ),
        ),
        show ? PersonMsg() : Container(),
        PersonList(),
        ExitLogin(
          widget.width,
          callback: () {
            setState(() {
              show = true;
            });
          },
          changeSign: () {
            setState(() {
              show = false;
            });
          },
        )
      ]),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  Paint _paint = Paint()
    ..color = Color(0xff4667F2)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;
  @override
  void paint(Canvas canvas, Size sizes) {
    Path _path = Path();
    _path.moveTo(-size.width * 40, sizes.height / 2.5);
    _path.lineTo(-size.width * 50, sizes.height / 1.2);
    _path.moveTo(-size.width * 24, sizes.height / 4);
    _path.lineTo(-size.width * 36, sizes.height / 1.2);
    _path.moveTo(sizes.width + size.width * 36, sizes.height / 4);
    _path.lineTo(sizes.width + size.width * 24, sizes.height / 1.2);
    _path.moveTo(sizes.width + size.width * 47, sizes.height / 2.8);
    _path.lineTo(sizes.width + size.width * 40, sizes.height / 1.4);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PersonMsg extends StatefulWidget {
  @override
  _PersonMsgState createState() => _PersonMsgState();
}

class _PersonMsgState extends State<PersonMsg> {
  String name = '';
  Counter _counter;
  String signUrl;
  int choosed = 0;

  _getPostState() {
    myDio.request(type: "get", url: Interface.getControlStatus).then((value) {
      if (value is Map) {
        if (value["controlStatus"] == 1) {
          choosed = 0;
        } else {
          choosed = 1;
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  _changePostState(int index) {
    myDio.request(type: "put", url: Interface.putControlStatus).then((value) {
      choosed = index;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _getPostState();
  }

  @override
  Widget build(BuildContext context) {
    _counter = Provider.of<Counter>(context);
    return Container(
        color: Colors.white,
        width: double.infinity,
        height: size.width * 250,
        child: Stack(clipBehavior: Clip.none, fit: StackFit.loose, children: [
          Container(
            margin: EdgeInsets.only(top: size.width * 30),
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.all(size.width * 20),
            height: size.width * 250,
            child: CancelSign(
              widget: InkWell(
                onTap: () {
                  bool next = false;
                  if (_counter.submitDates['mySign'] is List) {
                    _counter.submitDates['mySign'].forEach((element) {
                      if (element['title'] == '请点击进行签名') {
                        next = true;
                        signUrl = element['value'];
                      }
                    });
                  }
                  if (next) {
                    myDio.request(
                        type: 'put',
                        url: Interface.amendSign,
                        data: {"sign": signUrl}).then((value) async {
                      await myprefs.setString('sign', signUrl);
                      successToast('修改成功');
                      setState(() {});
                    });
                  } else {
                    Fluttertoast.showToast(msg: '签字不能为空');
                  }
                },
                child: Text(
                  '确认签字',
                  style: TextStyle(
                      color: Color(0xff4667F2), fontSize: size.width * 26),
                ),
              ),
              title: '请点击进行签名',
              purview: 'mySign',
              url: myprefs.getString('sign'),
            ),
          ),
          myprefs.getString('sign') != null
              ? Positioned(
                  top: -size.width * 50,
                  left: size.width * 34,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                        width: size.width * 120,
                        height: size.width * 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(size.width * 10),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: FadeInImage(
                                fit: BoxFit.cover,
                                width: size.width * 115,
                                height: size.width * 115,
                                placeholder: AssetImage(
                                    'assets/images/image_recent_control.jpg'),
                                image: NetworkImage(
                                    myprefs.getString('photoUrl'))),
                          ),
                      ),
                  ),
                )
              : Container(),
          Positioned(
            left: size.width * 175,
            child: Text(
              myprefs.getString('username') ?? '',
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 35.8),
            ),
          ),
        ]));
  }
}

class PersonList extends StatefulWidget {
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  bool isVersion = false;
  List data = [
    {
      "icon": 'assets/images/gerenxinxi@2x.png',
      'name': "个人信息",
      "active": 'assets/images/icon_person_tiaozhuan.png',
      "router": '/person/myMessage',
    },
    {
      "icon": 'assets/images/icon_home_my_list_fixed_pwd.png',
      'name': "修改密码",
      "active": 'assets/images/icon_person_tiaozhuan.png',
      "router": '/person/psd',
    },
    {
      "icon": 'assets/images/icon_home_my_list_update.png',
      'name': "版本更新",
      "active": 'assets/images/icon_person_tiaozhuan.png',
      "router": '/person/updata',
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), _getVersion);
  }

  String imagePath;

  _getVersion() async {
    // own app version
    String _version = await Version().getSever();
    myDio.request(type: 'get', url: Interface.cheakUpdate).then((value) async {
      await myprefs.setBool('isForcedUpgrade', false);
      // value['version'] serve version
      if (_version != value['version']) {
        isVersion = true;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: size.width * 20),
      child: ListView.builder(
          itemCount: data.length,
          // shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
          // physics: NeverScrollableScrollPhysics(), //禁用滑动事件
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (data[index]['router'] == null) {
                  Fluttertoast.showToast(msg: '敬请期待');
                } else {
                  Navigator.of(context).pushNamed(data[index]['router'],
                      arguments: {'width': size.width}).then((value) {
                    // 返回值
                  });
                }
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 20, horizontal: size.width * 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            data[index]['icon'],
                            height: size.width * 51,
                            width: size.width * 51,
                          ),
                          SizedBox(
                            width: size.width * 20,
                          ),
                          Text(
                            data[index]['name'],
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30),
                          ),
                          data[index]['name'] == '版本更新' && isVersion
                              ? Container(
                                  width: size.width * 12,
                                  height: size.width * 12,
                                  margin:
                                      EdgeInsets.only(left: size.width * 10),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFF3434),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0))),
                                )
                              : Container(),
                          Spacer(),
                          Image.asset(
                            data[index]['active'],
                            height: size.width * 30,
                            width: size.width * 18,
                          ),
                          SizedBox(
                            width: size.width * 20,
                          )
                        ],
                      ),
                      index != data.length - 1
                          ? Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffF0F0F0),
                              margin: EdgeInsets.only(top: size.width * 20),
                            )
                          : Container(),
                    ],
                  )),
            );
          }),
    ));
  }
}

class ExitLogin extends StatefulWidget {
  ExitLogin(this.width, {@required this.callback, @required this.changeSign});
  final width;
  final Function callback, changeSign;
  @override
  _ExitLoginState createState() => _ExitLoginState();
}

class _ExitLoginState extends State<ExitLogin> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          String _accout = prefs.getString('account');
          String _company = prefs.getString('enterpriseName');
          XgFlutterPlugin().unbindWithIdentifier(
              identify: _accout, bindType: XGBindType.account);
          XgFlutterPlugin().cleanAccounts();
          XgFlutterPlugin().stopXg();
          MethodChannel _channel = MethodChannel("messagePushChannel");
          _channel.invokeMethod("logout").then((value) => print(value));
          myDio.request(
              type: 'put',
              url: Interface.putAmendChatStatus,
              data: {"onlineStatus": "0"}).then((value) {});

          await prefs.clear();
          context.read<Counter>().emptyNotity();
          await prefs.setString('account', _accout);
          await prefs.setString('SavedenterpriseName', _company);
          ChatData().dropTable();
          widget.changeSign();

          Navigator.pushNamed(context, '/login',
              arguments: {"width": widget.width}).then((value) {
            widget.callback();
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.power_settings_new,
              color: Color(0xffFF6060),
              size: widget.width * 40,
            ),
            SizedBox(
              width: widget.width * 20,
            ),
            Text(
              '退出',
              style: TextStyle(
                  color: Color(0xffFF6060), fontSize: size.width * 30),
            )
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
    );
  }
}
