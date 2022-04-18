import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 版本更新提示弹框
class UpdateDialog extends Dialog {
  final String upDateContent;
  final bool isForce;
  final String version;

  UpdateDialog({this.version, this.upDateContent, this.isForce});

  @override
  Widget build(BuildContext context) {
    // double width = Provider.of<Counter>(context).widths;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 300,
            height: 330,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  'assets/images/bg_update_dialog.png',
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 90),
                        child: Text(
                          '发现新版本！' + '(V' + version + ')',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            upDateContent,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      )),
                      Container(
                        width: 300,
                        height: 50,
                        // margin: EdgeInsets.only(bottom: 15),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff6EAFFA))),

                          // 设置按钮为圆角

                          child: Text(
                            '立即体验',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/person/updata');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isForce
              ? Container()
              : GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Offstage(
                    offstage: isForce,
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Image.asset(
                        'assets/images/icon_close.png',
                        width: 35,
                        height: 35,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  static showUpdateDialog(BuildContext context, String mVersion,
      String mUpdateContent, bool mIsForce) {
    DateTime _lastPressedAt;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // 点击弹框外透明区域，使弹框不消失
          return WillPopScope(
              child: UpdateDialog(
                upDateContent: mUpdateContent,
                isForce: mIsForce,
                version: mVersion,
              ),
              // onWillPop: _onWillPop,
              // ignore: missing_return
              onWillPop: () async {
                if (_lastPressedAt == null ||
                    DateTime.now().difference(_lastPressedAt) >
                        Duration(seconds: 1)) {
                  _lastPressedAt = DateTime.now();
                  Fluttertoast.showToast(
                    msg: "再次点击，退出APP",
                  );
                  return false;
                } else {
                  exit(0);
                }
              });
        });
  }

  // DateTime _lastPressedAt;
  // static Future<bool> _onWillPop() async {
  //   if (_lastPressedAt == null ||
  //             DateTime.now().difference(_lastPressedAt) >
  //                 Duration(seconds: 1)) {
  //           _lastPressedAt = DateTime.now();
  //           Fluttertoast.showToast(
  //             msg: "再次点击，立即退出App",
  //           );
  //           return false;
  //         } else {
  //           return true;
  //         }
  // }
}
