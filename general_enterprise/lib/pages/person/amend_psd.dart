import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/myCustomColor.dart';

class AmendPsd extends StatefulWidget {
  @override
  _AmendPsdState createState() => _AmendPsdState();
}

class _AmendPsdState extends State<AmendPsd> {
  GlobalKey<_AmendPsdContextState> state = GlobalKey();
  bool showApp = false;
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('修改密码'),
      child: !showApp
          ? AmendPsdContext(state, onPress: (map) {
                myDio
                    .request(type: 'put', url: Interface.putAmendPsd, data: map)
                    .then((value) {
                  setState(() {
                    showApp = true;
                  });
                });
              })
          : AmendPsdLogin(),
    );
  }
}

class AmendPsdLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
        // return true;
      },
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/icon-amend.png',
              width: size.width * 206,
              height: size.width * 241,
            ),
          ),
          SizedBox(
            height: size.width * 172,
          ),
          Container(
            child: Text('您已成功更改密码'),
          ),
          SizedBox(
            height: size.width * 80,
          ),
        ],
      )),
    );
  }
}

class AmendPsdContext extends StatefulWidget {
  AmendPsdContext(Key key, {this.onPress}) : super(key: key);

  final Function(Map _map) onPress;
  @override
  _AmendPsdContextState createState() => _AmendPsdContextState();
}

class _AmendPsdContextState extends State<AmendPsdContext> {
  bool _obOldPadText = true;
  bool _obFirstPadText = true;
  bool _obSecondPadText = true;

  final TextEditingController oldPad = TextEditingController();
  final TextEditingController firstPsd = TextEditingController();
  final TextEditingController secondPsd = TextEditingController();

  onPress(bool state) {
    return state;
  }

  @override
  void initState() {
    oldPad
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    firstPsd
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.width * 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: size.width * 32,
          ),
          Text(
            '旧密码',
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
          TextField(
            controller: oldPad,
            obscureText: _obOldPadText,
            style: TextStyle(),
            onChanged: (value) {
              if (mounted) {
                setState(() {});
              }
            },
            decoration: InputDecoration(
              hintText: "请输入旧密码",
              hintStyle: TextStyle(
                  color: Color(0xff7F8A9C), fontSize: size.width * 32),
              border: InputBorder.none,
              suffixIcon: Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    oldPad.text.length > 0
                        ? GestureDetector(
                            child: Icon(Icons.clear),
                            onTap: () {
                              setState(() {
                                oldPad.text = '';
                              });
                            },
                          )
                        : Container(),
                    oldPad.text.length > 0
                        ? GestureDetector(
                            child: Image.asset(
                              _obOldPadText
                                  ? 'assets/images/icon_eye_close.png'
                                  : 'assets/images/icon_eye_open.png',
                              width: size.width * 40,
                              height: size.width * 40,
                            ),
                            onTap: () {
                              setState(() {
                                _obOldPadText = !_obOldPadText;
                              });
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Color(0xffF2F2F2),
            height: size.width * 2,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: size.width * 32),
          ),
          Text(
            '新密码',
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
          TextField(
            controller: firstPsd,
            obscureText: _obFirstPadText,
            style: TextStyle(),
            onChanged: (value) {
              if (mounted) {
                setState(() {});
              }
            },
            decoration: InputDecoration(
              //contentPadding: EdgeInsets.symmetric(horizontal: 20),
              hintText: "请输入新密码",
              hintStyle: TextStyle(
                  color: Color(0xff7F8A9C), fontSize: size.width * 32),
              border: InputBorder.none,
              suffixIcon: Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    firstPsd.text.length > 0
                        ? GestureDetector(
                            child: Icon(Icons.clear),
                            onTap: () {
                              setState(() {
                                firstPsd.text = '';
                              });
                            },
                          )
                        : Container(),
                    firstPsd.text.length > 0
                        ? GestureDetector(
                            child: Image.asset(
                              _obFirstPadText
                                  ? 'assets/images/icon_eye_close.png'
                                  : 'assets/images/icon_eye_open.png',
                              width: size.width * 40,
                              height: size.width * 40,
                            ),
                            onTap: () {
                              setState(() {
                                _obFirstPadText = !_obFirstPadText;
                              });
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Color(0xffF2F2F2),
            height: size.width * 2,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: size.width * 32),
          ),
          Text(
            '确认新密码',
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: size.width * 28,
                fontWeight: FontWeight.w500),
          ),
          TextField(
            controller: secondPsd,
            obscureText: _obSecondPadText,
            style: TextStyle(),
            onChanged: (value) {
              if (mounted) {
                setState(() {});
              }
            },
            decoration: InputDecoration(
              hintText: "请再次输入新密码",
              hintStyle: TextStyle(
                  color: Color(0xff7F8A9C), fontSize: size.width * 32),
              border: InputBorder.none,
              suffixIcon: Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    secondPsd.text.length > 0
                        ? GestureDetector(
                            child: Icon(Icons.clear),
                            onTap: () {
                              setState(() {
                                secondPsd.text = '';
                              });
                            },
                          )
                        : Container(),
                    secondPsd.text.length > 0
                        ? GestureDetector(
                            child: Image.asset(
                              _obSecondPadText
                                  ? 'assets/images/icon_eye_close.png'
                                  : 'assets/images/icon_eye_open.png',
                              width: size.width * 40,
                              height: size.width * 40,
                            ),
                            onTap: () {
                              setState(() {
                                _obSecondPadText = !_obSecondPadText;
                              });
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Color(0xffF2F2F2),
            height: size.width * 2,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: size.width * 32),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              if (oldPad.text == '' ||
                  firstPsd.text == '' ||
                  secondPsd.text == '') {
                Fluttertoast.showToast(msg: '密码不能为空');
              } else {
                if (firstPsd.text != secondPsd.text) {
                  Fluttertoast.showToast(msg: '两次密码不一致');
                } else {
                  widget.onPress({
                    "oldPassword": oldPad.text,
                    "newPassword": firstPsd.text,
                    "confirmPassword": secondPsd.text
                  });
                }
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: size.width * 30),
              decoration: BoxDecoration(
                  color: Color(0xff3074FF),
                  borderRadius: BorderRadius.circular(size.width * 8)),
              alignment: Alignment.center,
              child: Text(
                '保  存',
                style:
                    TextStyle(fontSize: size.width * 32, color: Colors.white),
              ),
              width: size.width * 686,
              height: size.width * 80,
            ),
          )
        ],
      ),
    );
  }
}
