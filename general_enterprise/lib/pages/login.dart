import 'dart:io';
import 'package:enterprise/common/myUpdateDialog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/down.dart';
import 'package:flutter/material.dart';
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
                      image: AssetImage("assets/images/doubleRiskProjeck/bg_login.png"),
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
                                          color: Color(0xff7F8A9C),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w400),
                              ),
                              width: double.infinity,
                            ),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: size.width * 12,
                                    bottom: size.width * 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/login_left.png',
                                      height: size.width * 2,
                                      width: size.width * 72,
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Text(
                                      _version != null
                                          ? 'V' + _version.toString()
                                          : '',
                                      style: TextStyle(
                                          color: Color(0xff7F8A9C),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Image.asset(
                                      'assets/images/login_right.png',
                                      height: size.width * 2,
                                      width: size.width * 72,
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

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

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

    loginDio.request(type: 'post', url: Interface.loginUrl, data: {
      "grant_type": 'password',
      "username": _username.text,
      "password": _password.text
    }).then((value) async {
      print(value);
      if (value is Map) {
        String token = value['token_type'] + ' ' + value['access_token'];
        await myprefs.setString('token', token ?? '');
        // 用户名
        await myprefs.setString('username', value['systemUser']['username'] ?? '');
        // 头像
        await myprefs.setString('avatar', value['systemUser']['avatar'] ?? '');
        // 描述
        await myprefs.setString('description', value['systemUser']['description'] ?? '');
        // 电子邮箱
        await myprefs.setString('email', value['systemUser']['email'] ?? '');
        // 手机号
        await myprefs.setString('mobile', value['systemUser']['mobile'] ?? '');
        // 昵称
        await myprefs.setString('nickname', value['systemUser']['nickname'] ?? '');
        // 性别
        await myprefs.setString('sex', value['systemUser']['sex'] ?? -1);
        // 用户id
        await myprefs.setString('userId', value['systemUser']['id'] ?? '');
        // 用户部门id
        await myprefs.setString('departmentId', value['systemUser']['departmentId'] ?? '');
        isLogin = false;
        Navigator.pop(context);
        _getUrl();
        if (value['systemUser']['sign'] == '' || value['systemUser']['sign'] == null && Contexts.mobile) {
          Fluttertoast.showToast(msg: '检测到您的账号暂时未进行签字，请先设置签名');
          Navigator.pushNamed(context, '/person/sign');
        }else{
          // 签名
          await myprefs.setString('sign', value['systemUser']['sign'] ?? '');
        }
      }
    }).catchError((onError) {
      print(onError);
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
              left: size.width * 60,
                bottom: size.height * 160,
                top: size.height * 224),
            child: Image.asset(
              "assets/images/doubleRiskProjeck/text_login_title.png",
              height: size.width * 140,
              width: size.width * 462,
            )
                    ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  '登录',
                  style: TextStyle(
                      color: Color(0xff333333), fontSize: size.width * 40, fontWeight: FontWeight.w500),
                ),
              SizedBox(
                height: size.width * 20,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/doubleRiskProjeck/icon_login_usernae.png",
                    width: size.width * 36,
                    height: size.width * 36,
                  ),
                  SizedBox(
                    width: size.width * 16,
                  ),
                  Text(
                    '用户名',
                    style: TextStyle(color: Color(0xff333333), fontSize: size.width * 28, fontWeight: FontWeight.w500),
                  ),
                ],
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
              Row(
                children: [
                  Image.asset(
                    "assets/images/doubleRiskProjeck/icon_login_pwd.png",
                    width: size.width * 36,
                    height: size.width * 36,
                  ),
                  SizedBox(
                    width: size.width * 16,
                  ),
                  Text(
                    '密码',
                    style: TextStyle(color: Color(0xff333333), fontSize: size.width * 28, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: size.height * 0),
                  height: size.height * 74,
                  child: InputKey(
                      textEditingController: _password,
                      hintText: '请输入密码',
                      obscureText: true)),
              SizedBox(
                height: size.height * 120,
              ),
              GestureDetector(
                onTap: _login,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff3074FF),
                    borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
                  ),
                  height: size.height * 100,
                  width: size.height * 630,
                  alignment: Alignment.center,
                  child: Text(
                    '登录',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 36,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
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
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.obscureText != null ? TextInputType.visiblePassword : TextInputType.number,
      controller: widget.textEditingController,
      textInputAction: TextInputAction.next,
      onSubmitted: widget.onSubmitted,
      style: TextStyle(color: Color(0xff999999), fontSize: size.width * 26),
      obscureText: widget.obscureText != null ? obscureText : false,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder( // 不是焦点的时候颜色
                    borderSide: BorderSide(
                        color: Color(0xffECECEC),
                        width: size.width * 2
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder( // 焦点集中的时候颜色
                    borderSide: BorderSide(
                        color: Color(0xffECECEC),
                        width: size.width * 2
                    ),
                  ),
        hintText: widget.hintText,
        hintStyle:
            TextStyle(fontSize: size.width * 28, color: Color(0xff7F8A9C)),
        labelStyle:
            TextStyle(fontSize: size.width * 28, color: Color(0xff7F8A9C)),
        suffixIcon: widget.obscureText != null
            ? GestureDetector(
                child: obscureText ? Icon(Icons.visibility_off, color: Color(0xff7F8A9C),) 
                            : Icon(Icons.visibility, color: Color(0xff7F8A9C),),
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
