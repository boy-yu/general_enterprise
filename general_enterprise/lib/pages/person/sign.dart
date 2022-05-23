import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/myView/myCancelSign.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PersonSign extends StatefulWidget {
  @override
  _PersonSignState createState() => _PersonSignState();
}

class _PersonSignState extends State<PersonSign> {
  String signUrl = '';
  Counter _counter = Provider.of(myContext);
  final TextEditingController firstPsd = TextEditingController();
  final TextEditingController secondPsd = TextEditingController();
  bool _obFirstPadText = true;
  bool _obSecondPadText = true;

  @override
  void initState() {
    super.initState();
    _init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.emptySubmitDates(key: 'mySign');
    });
  }

  _init() async {
    signUrl = myprefs.getString('sign');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MyAppbar(
          title: Text(
            '账号初始设置',
            style: TextStyle(fontSize: size.width * 32),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 30,
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(size.width * 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CancelSign(
                              title: '请点击进行签名',
                              purview: 'mySign',
                              url: signUrl,
                            ),
                            SizedBox(
                              height: size.width * 32,
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
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 32),
                                border: InputBorder.none,
                                suffixIcon: Container(
                                  width: size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                  _obFirstPadText =
                                                      !_obFirstPadText;
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
                                    color: Color(0xff7F8A9C),
                                    fontSize: size.width * 32),
                                border: InputBorder.none,
                                suffixIcon: Container(
                                  width: size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                  _obSecondPadText =
                                                      !_obSecondPadText;
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
                          ],
                        ))),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        bool next = false;
                        if (firstPsd.text == '' || secondPsd.text == '') {
                          Fluttertoast.showToast(msg: '密码不能为空');
                        } else {
                          if (firstPsd.text != secondPsd.text) {
                            Fluttertoast.showToast(msg: '两次密码不一致');
                          } else {
                            if (_counter.submitDates['mySign'] is List) {
                              _counter.submitDates['mySign'].forEach((element) {
                                if (element['title'] == '请点击进行签名') {
                                  next = true;
                                  signUrl = element['value'];
                                }else{
                                  Fluttertoast.showToast(msg: '签字不能为空');
                                }
                              });
                            }
                          }
                        }
                        if (next) {
                          myDio.request(
                              type: 'put',
                              url: Interface.putUpdatePasswordAndSign,
                              data: {
                                "passwordNew": secondPsd.text,
                                "sign": signUrl,
                              }).then((value) async {
                            await myprefs.setString('sign', signUrl);
                            successToast('保存成功');
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: size.width * 80,
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 32,
                            vertical: size.width * 50),
                        decoration: BoxDecoration(
                            color: Color(0xff3074FF),
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 8))),
                        alignment: Alignment.center,
                        child: Text(
                          '保  存',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          if (myprefs.getString('sign') == '' ||
              myprefs.getString('sign') == null) {
            Fluttertoast.showToast(msg: '为了正常使用app,请先进行初始设置');
            return false;
          } else {
            return true;
          }
        });
  }
}
