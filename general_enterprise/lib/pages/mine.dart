import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/chat/chatDataBase.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class Mine extends StatefulWidget {
  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> with TickerProviderStateMixin{
  Counter _counter;

  bool isVersion = false;

  List data = [
    {
      "icon": 'assets/images/doubleRiskProjeck/icon_my_msg.png',
      'name': "个人信息",
      "active": 'assets/images/doubleRiskProjeck/icon_my_right_arrows.png',
      "router": '/person/myMessage',
    },
    {
      "icon": 'assets/images/doubleRiskProjeck/icon_my_update_pwd.png',
      'name': "修改密码",
      "active": 'assets/images/doubleRiskProjeck/icon_my_right_arrows.png',
      "router": '/person/psd',
    },
    {
      "icon": 'assets/images/doubleRiskProjeck/icon_my_ver_update.png',
      'name': "版本更新",
      "active": 'assets/images/doubleRiskProjeck/icon_my_right_arrows.png',
      "router": '/person/updata',
    },
  ];

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
    Future.delayed(Duration(seconds: 2), _getVersion);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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

  bool show = true;
  AnimationController _animationController;
  Animation<double> _opacity;

  String signUrl = '';

  @override
  Widget build(BuildContext context) {
    _counter = Provider.of<Counter>(context);
    return FadeTransition(
      opacity: _opacity,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.width * 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/doubleRiskProjeck/bg_home_my.png'),
                    fit: BoxFit.fill, // 完全填充
                  ),
                ),
                child: show ? Row(
                  children: [
                    SizedBox(
                      width: size.width * 40,
                    ),
                    Container(
                      height: size.width * 120,
                      width: size.width * 120,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 48)),
                        image: DecorationImage(
                          image: myprefs.getString('avatar') == '' ||
                                  myprefs.getString('avatar') == null
                              ? AssetImage(
                                  'assets/images/doubleRiskProjeck/image_avatar_default.png')
                              : NetworkImage(myprefs.getString('avatar')),
                          fit: BoxFit.fill, // 完全填充
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 24,
                    ),
                    Text(
                      myprefs.getString('nickname') ?? '',
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 30),
                    ),
                  ],
                ) : Container(),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: size.width * 200),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index){
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
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: size.width * 40, vertical: size.width * 30),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            data[index]['icon'],
                                            height: size.width * 44,
                                            width: size.width * 44,
                                          ),
                                          SizedBox(
                                            width: size.width * 26,
                                          ),
                                          Text(
                                            data[index]['name'],
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 32,
                                                fontWeight: FontWeight.w500),
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
                                            height: size.width * 40,
                                            width: size.width * 40,
                                          ),
                                          SizedBox(
                                            width: size.width * 20,
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          }
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // XgFlutterPlugin().unbindWithIdentifier(
                          //     identify: _accout, bindType: XGBindType.account);
                          // XgFlutterPlugin().cleanAccounts();
                          // XgFlutterPlugin().stopXg();
                          MethodChannel _channel = MethodChannel("messagePushChannel");
                          _channel.invokeMethod("logout").then((value) => print(value));
                          // myDio.request(
                          //     type: 'put',
                          //     url: Interface.putAmendChatStatus,
                          //     data: {"onlineStatus": "0"}).then((value) {});
                          myprefs.clear();
                          context.read<Counter>().emptyNotity();
                          ChatData().dropTable();
                          setState(() {
                            show = false;
                          });
                          Navigator.pushNamed(context, '/login').then((value) {
                            setState(() {
                              show = true;
                            });
                          });
                        },
                        child: Container(
                          height: size.width * 96,
                          width: size.width * 686,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: size.width * 20),
                          decoration: BoxDecoration(
                            border: Border.all(width: size.width * 2, color: Color(0xffF2F2F2)),
                            borderRadius: BorderRadius.all(Radius.circular(size.width * 16))
                          ),
                          child: Text(
                            "退出登录",
                            style: TextStyle(
                              color: Color(0xff7F8A9C),
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            ],
          ),
          Positioned(
            top: size.width * 370,
            child: Container(
              height: size.width * 280,
              width: size.width * 686,
              margin: EdgeInsets.symmetric(horizontal: size.width * 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 32)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff7F8A9C).withOpacity(0.1),
                      offset: Offset(size.width * 2, size.width * 6), //阴影xy轴偏移量
                      blurRadius: size.width * 60.0, //阴影模糊程度
                      spreadRadius: size.width *1.0 //阴影扩散程度
                    ),
                  ]
              ),
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
                          url: Interface.putUpdateUser,
                          data: {
                            "avatar": myprefs.getString('avatar'),
                            "description": myprefs.getString('description'),
                            "email": myprefs.getString('email'),
                            "mobile": myprefs.getString('mobile'),
                            "nickname": myprefs.getString('nickname'),
                            "sex": myprefs.getString('sex'),
                            "sign": signUrl,
                          }
                      ).then((value) async {
                        await myprefs.setString('sign', signUrl);
                        successToast('修改成功');
                        setState(() {});
                      });
                    } else {
                      Fluttertoast.showToast(msg: '签字不能为空');
                    }
                  },
                  child: Container(
                    height: size.width * 52,
                    width: size.width * 144,
                    margin: EdgeInsets.only(right: size.width * 32, top: size.width * 25),
                    decoration: BoxDecoration(
                      color: Color(0xff3074FF).withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(size.width * 8))
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '确认签字',
                      style: TextStyle(
                          color: Color(0xff3074FF), fontSize: size.width * 28, fontWeight: FontWeight.w400),
                    ),
                  )
                ),
                title: '请点击进行签名',
                purview: 'mySign',
                url: myprefs.getString('sign'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CancelSign extends StatefulWidget {
  CancelSign(
      {this.purview = '取消作业', this.title = '签字', this.url = '', this.widget});
  final String purview, title, url;
  final Widget widget;
  @override
  _CancelSignState createState() => _CancelSignState();
}

class _CancelSignState extends State<CancelSign> {
  String url;
  Counter _counter = Provider.of<Counter>(myContext);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.emptySubmitDates(key: widget.purview);
    });
  }

  generateImg() {
    if (_counter.submitDates[widget.purview] != null) {
      if (_counter.submitDates[widget.purview].toString().indexOf('http') >
          -1) {
        _counter.submitDates[widget.purview]?.forEach((ele) {
          if (ele['title'] == widget.title) {
            url = ele['value'];
          }
        });
      }
    }
    setState(() {});
  }

  Widget _judgeWidge() {
    Widget _widget = Container();
    if (url != null) {
      _widget = Padding(
          padding: EdgeInsets.symmetric(vertical: size.width * 10),
          child: FadeInImage(
            placeholder: AssetImage('assets/images/image_recent_control.jpg'),
            image: NetworkImage(url),
            height: size.width * 100,
          ));
    } else {
      if (widget.url.toString().indexOf('http') > -1) {
        _widget = Padding(
            padding: EdgeInsets.symmetric(vertical: size.width * 10),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/image_recent_control.jpg'),
              image: NetworkImage(widget.url),
              height: size.width * 100,
            ));
      }
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            widget.widget == null
                ? Expanded(
                    child: Text(
                    '签字',
                    style: TextStyle(fontSize: size.width * 30),
                  ))
                : Container(),
            widget.widget == null
                ? Text(
                    DateTime.now()
                        .toString()
                        .substring(0, DateTime.now().toString().length - 10),
                    style: TextStyle(fontSize: size.width * 24),
                  )
                : Container(),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/sign', arguments: {
              "purview": widget.purview,
              'title': widget.title
            }).then((value) {
              generateImg();
            });
          },
          child: Container(
            margin: EdgeInsets.only(top: size.width * 20),
            constraints: BoxConstraints(minHeight: size.width * 160),
            decoration: BoxDecoration(
                border: widget.widget == null
                    ? Border.all(width: 1, color: underColor)
                    : Border.all(width: 0, color: Colors.transparent)),
            width: double.infinity,
            child: _judgeWidge(),
          ),
        ),
        Row(
          children: [
            Spacer(),
            widget.widget == null
                ? Icon(
                    Icons.create,
                    color: placeHolder,
                    size: size.width * 30,
                  )
                : widget.widget,
          ],
        )
      ],
    );
  }
}

class Version {
  Future<String> getSever() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String state = packageInfo.version;
    return state;
  }
}