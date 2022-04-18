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
          ? SingleChildScrollView(
              child: AmendPsdContext(state, onPress: (map) {
                myDio
                    .request(type: 'put', url: Interface.putAmendPsd, data: map)
                    .then((value) {
                  setState(() {
                    showApp = true;
                  });
                });
              }),
            )
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
          // RaisedButton(
          //   onPressed: () {},
          //   child: Container(
          //     child: Center(
          //       child: Text(
          //         '快速登录',
          //         style:
          //             TextStyle(color: Colors.white, fontSize: size.width * 38),
          //       ),
          //     ),
          //     width: size.width * 400,
          //     height: size.width * 100,
          //     decoration: BoxDecoration(
          //         gradient: LinearGradient(colors: lineGradBlue),
          //         borderRadius: BorderRadius.circular(size.width * 50)),
          //   ),
          //   color: Colors.transparent,
          //   padding: EdgeInsets.all(0),
          //   highlightElevation: size.width * 100,
          //   shape:
          //       StadiumBorder(side: BorderSide(width: 0, color: Colors.white)),
          // ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: size.width * 20),
          color: Colors.white,
          height: size.width * 200,
          child: Center(
            child: Text(
              '请为您的账号修改密码',
              style: TextStyle(fontSize: size.width * 30, color: placeHolder),
            ),
          ),
        ),
        Container(
          child: Text(
            '旧密码',
            style: TextStyle(color: placeHolder),
          ),
          margin: EdgeInsets.fromLTRB(size.width * 31, size.width * 31,
              size.width * 31, size.width * 5),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 24, vertical: size.width * 30),
          child: Row(
            children: <Widget>[
              Text(
                '请输入旧密码',
                style: TextStyle(
                    color: Color.fromRGBO(38, 38, 38, 1),
                    fontSize: size.width * 30),
              ),
//              Spacer(),
              SizedBox(width: size.width * 200),
              Expanded(
                child: TextField(
                  controller: oldPad,
                  obscureText: _obOldPadText,
                  style: TextStyle(),
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: "请输入旧密码",
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
              ),
              SizedBox(width: size.width * 5),
            ],
          ),
        ),
        Container(
          child: Text(
            '新密码',
            style: TextStyle(color: placeHolder),
          ),
          margin: EdgeInsets.fromLTRB(
              size.width * 31, size.width * 5, size.width * 31, size.width * 5),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 24, vertical: size.width * 30),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '请输入新密码',
                    style: TextStyle(
                        color: Color.fromRGBO(38, 38, 38, 1),
                        fontSize: size.width * 30),
                  ),
                  //Spacer(),
                  SizedBox(width: size.width * 200),
                  Expanded(
                    child: TextField(
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
                  ),
                  SizedBox(width: size.width * 5),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    '请确认新密码',
                    style: TextStyle(
                        color: Color.fromRGBO(38, 38, 38, 1),
                        fontSize: size.width * 30),
                  ),
                  //Spacer(),
                  SizedBox(width: size.width * 200),
                  Expanded(
                    child: TextField(
                      controller: secondPsd,
                      obscureText: _obSecondPadText,
                      style: TextStyle(),
                      onChanged: (value) {
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "请确认新密码",
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
                  ),
                  SizedBox(width: size.width * 5),
                ],
              ),
            ],
          ),
        ),
        Center(
            child: GestureDetector(
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
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: lineGradBlue),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              '保存新密码',
              style: TextStyle(fontSize: size.width * 30, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            width: MediaQuery.of(context).size.width * .8,
            padding: EdgeInsets.symmetric(vertical: size.width * 31),
            margin: EdgeInsets.only(top: 60),
          ),
        ))
      ],
    );
  }
}
