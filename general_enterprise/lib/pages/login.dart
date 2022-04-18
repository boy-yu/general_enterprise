import 'dart:io';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myUpdateDialog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/down.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../tool/interface.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime _lastPressedAt;
  String _version;

  @override
  void initState() {
    super.initState();
    if (Contexts.mobile) {
      _getVersion();
    }
  }

  _getVersion() async {
    _version = await Version().getSever();
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
      }else{
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size currenWidow = MediaQuery.of(context).size;
    print(_version);
    return WillPopScope(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Container(
                  height: currenWidow.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg_login.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      LoginForm(),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(bottom: size.width * 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                '四川省天顺慧智安全科技有限公司',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff2143AF).withOpacity(0.5),
                                    fontSize: size.width * 24),
                              ),
                              width: double.infinity,
                            ),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: size.width * 20,
                                    bottom: size.width * 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/login_left.png',
                                      height: size.width * 2,
                                      width: size.width * 54,
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Text(
                                      _version != null
                                          ? 'V' + _version.toString()
                                          : '',
                                      style: TextStyle(
                                          color: Color(0xff2143AF)
                                              .withOpacity(0.5),
                                          fontSize: size.width * 24),
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Image.asset(
                                      'assets/images/login_right.png',
                                      height: size.width * 2,
                                      width: size.width * 54,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ))
                    ],
                  ),
                )
              ),
            )),
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
              exit(-1);
            }
          }
          return true;
        });
  }
}

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

MethodChannel _channel = MethodChannel('messagePushChannel');

class _LoginFormState extends State<LoginForm> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  _getUrl() {
    myDio.request(
        type: 'get',
        url: Interface.webUrl,
        queryParameters: {"url": Interface.mainBaseUrl}).then((value) {
      if (value is Map) {
        myprefs.setString('webUrl', value['ticketUrl'] ?? '');
        webUrl = value['ticketUrl'] ?? '';
        myprefs.setString('fileUrl', value['fileViewPath'] ?? '');
        fileUrl = value['fileViewPath'] ?? '';
      }
    });
  }

  _login() {
    if (_username.text.length == 0) {
      Fluttertoast.showToast(msg: '请输入用户名');
      return;
    } else if (_password.text.length == 0) {
      Fluttertoast.showToast(msg: '请输入密码');
      return;
    }

    myDio.request(type: 'post', url: Interface.loginUrl, data: {
      "username": _username.text,
      "password": _password.text
    }).then((value) async {
      if (value is Map) {
        String token = value['token'];
        await myprefs.setString('token', token ?? '');
        await myprefs.setString('username', value['userName'] ?? '');
        await myprefs.setString('department', value['department'] ?? '');
        await myprefs.setString('account', _username.text);
        await myprefs.setString('sign', value['sign'] ?? '');
        await myprefs.setString(
            'enterpriseName', value['enterpriseName'] ?? '');
        await myprefs.setInt('userId', value['userId'] ?? -1);
        // 安全教育培训
        await myprefs.setInt('isEducationInitiate', value['isEducationInitiate'] ?? -1);
        // 个人信息新加字段
        await myprefs.setString('telephone', value['telephone'] ?? ''); // 手机号
        await myprefs.setString('identityNum', value['identityNum'] ?? ''); //  身份证号
        await myprefs.setString('type', value['type'] ?? ''); //  人员类别
        await myprefs.setString('education', value['education'] ?? ''); //  学历
        await myprefs.setString('specialty', value['specialty'] ?? ''); //  专业

        _getAppFunctionMenu();
        
        if (value['photoUrl'] == '') {
          await myprefs.setString('photoUrl',
              'https://shuangkong.oss-cn-qingdao.aliyuncs.com/temp/1605250244862/u%3D1763186968%2C2658905759%26fm%3D26%26gp%3D0.jpg');
        } else {
          await myprefs.setString('photoUrl', value['photoUrl'] ?? '');
        }
        isLogin = false;
        Navigator.pop(context);
        myDio.request(
            type: 'put',
            url: Interface.putAmendChatStatus,
            data: {"onlineStatus": "1"});
        if (Contexts.mobile) {
          _channel.invokeMethod('login', myprefs.getString('account'));
          Future.delayed(Duration(seconds: 5), () {
            initPlatformState(_username.text, true);
          });
        }
        _getUrl();
        mytranslate = Translate();
        mytranslate.init();

        if (value['sign'] == '' || value['sign'] == null && Contexts.mobile) {
          Fluttertoast.showToast(msg: '检测到您的账号暂时未进行签字，请先设置签名');
          Navigator.pushNamed(context, '/person/sign');
        }

        if (Contexts.mobile) {
          Future.delayed(Duration(seconds: 1), () {
            if (myprefs.getString("SavedenterpriseName") !=
                myprefs.getString('enterpriseName')) {
              PeopleStructure.getNetpeople(delete: true);
            }
          });
        }
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  _getAppFunctionMenu() {
    myDio.request(
          type: 'get',
          url: Interface.getAppFunctionMenu,
    ).then((value)  {
      if(value is List){
        myprefs.setStringList('appFunctionMenu', value.cast<String>());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Mysize().init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
                bottom: size.height * 75,
                left: size.height * 56,
                top: size.height * 230),
            child: Text('清单制管理信息化平台',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 40,
                    fontWeight: FontWeight.bold))),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.height * 57, vertical: size.height * 60),
          padding: EdgeInsets.only(
              left: size.height * 59,
              top: size.height * 40,
              right: size.height * 57),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                    blurRadius: 15.0, //阴影模糊程度
                    spreadRadius: 1.0 //阴影扩散程度
                    )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // IconButton(
              //     icon: Icon(Icons.face),
              //     onPressed: () {
              //       Navigator.pushNamed(context, "/waitFaceLogin");
              //     }),
              Center(
                child: Text(
                  '欢迎登录',
                  style: TextStyle(
                      color: Color(0xff4684FF), fontSize: size.width * 44),
                ),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Text(
                '用户名',
                style: TextStyle(color: placeHolder, fontSize: 11),
              ),
              Container(
                height: size.height * 74,
                child: InputKey(
                  textEditingController: _username,
                  hintText: '请输入用户名',
                ),
              ),
              SizedBox(
                height: size.height * 40,
              ),
              Text(
                '密码',
                style: TextStyle(color: placeHolder, fontSize: 11),
              ),
              Container(
                  margin: EdgeInsets.only(top: size.height * 0),
                  height: size.height * 74,
                  child: InputKey(
                      textEditingController: _password,
                      hintText: '请输入密码',
                      obscureText: true)),
              SizedBox(
                height: size.height * 47,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xff4481FE),
                    // gradient: LinearGradient(colors: lineGradBlue),
                    borderRadius: BorderRadius.all(Radius.circular(43)),
                  ),
                  height: size.height * 85,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(43),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff4481FE))),
                      onPressed: _login,
                      child: Center(
                          child: Text(
                        '登录',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 40),
                      )),
                    ),
                  )),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('/faceLogin',
                          arguments: {'width': size.width}).then((value) {
                          // 返回值
                          if(value == '登录成功'){
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Text(
                        '切换人脸登录',
                        style: TextStyle(
                            color: Color(0xff2143AF), fontSize: size.width * 21),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '忘记密码？',
                      style: TextStyle(
                          color: Color(0xff2143AF), fontSize: size.width * 21),
                    )
                  ],
                ),
                width: double.infinity,
                margin: EdgeInsets.only(
                    left: size.width * 40,
                    top: size.width * 35,
                    bottom: size.height * 32),
              )
            ],
          ),
        )
      ],
    );
  }
}

class InputKey extends StatefulWidget {
  InputKey(
      {this.textEditingController,
      this.onSubmitted,
      this.hintText = '',
      this.obscureText});
  final TextEditingController textEditingController;
  final Function(String) onSubmitted;
  final String hintText;
  final bool obscureText;
  @override
  _InputKeyState createState() => _InputKeyState();
}

class _InputKeyState extends State<InputKey> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      textInputAction: TextInputAction.next,
      onSubmitted: widget.onSubmitted,
      style: TextStyle(color: Color(0xff999999), fontSize: size.width * 26),
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle:
            TextStyle(fontSize: size.width * 26, color: Color(0xff999999)),
        // contentPadding: EdgeInsets.only(
        //     top: size.width * 0,
        //     bottom: size.width * 25,
        //     left: size.width * 0,
        //     right: size.width * 0),
        labelStyle:
            TextStyle(fontSize: size.width * 26, color: Color(0xff999999)),
        suffixIcon: widget.textEditingController.text.length > 0
            ? GestureDetector(
                child: Icon(Icons.clear),
                onTap: () {
                  setState(() {
                    widget.textEditingController.text = '';
                  });
                },
              )
            : null,
      ),
    );
  }
}
