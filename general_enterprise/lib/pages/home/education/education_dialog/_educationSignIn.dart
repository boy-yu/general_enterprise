import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EducationSignIn extends StatefulWidget {
  EducationSignIn({this.planId});
  final int planId;
  @override
  _EducationSignInState createState() => _EducationSignInState();
}

class _EducationSignInState extends State<EducationSignIn> {
  @override
  void initState() {
    super.initState();
    _getNowTime();
  }

  _getNowTime() {
    DateTime now = new DateTime.now();
    String nowTime = now.toString().substring(11, 19);
    data['time'] = nowTime;
  }

  Map data = {
    'time': '10:10:10',
  };

  TextEditingController _controller = TextEditingController();
  Counter _counter = Provider.of<Counter>(myContext);

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('签到'),
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: size.width * 20, horizontal: size.width * 25),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/icon_sign_in_time.png",
                    width: size.width * 30,
                    height: size.width * 30,
                  ),
                  SizedBox(
                    width: size.width * 10,
                  ),
                  Text(
                    '签到时间：',
                    style: TextStyle(
                        color: Color(0xff999999), fontSize: size.width * 30),
                  ),
                  Text(
                    data['time'],
                    style: TextStyle(
                        color: Color(0xff000000), fontSize: size.width * 30),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.width * 10,
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                      height: size.width * 300,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: size.width * 20,
                          horizontal: size.width * 25),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: '请填写签到备注',
                          hintStyle: TextStyle(
                              color: Color(0xffCCCCCC),
                              fontSize: size.width * 30),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: size.width * 30),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        autofocus: true,
                      )),
                  MyImageCarma(
                    title: "executionUrls",
                    name: 'executionUrls',
                    purview: 'executionUrls',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.width * 300,
            ),
            GestureDetector(
              onTap: () {
                Map queryParameters = {
                  "planId": 0,
                  "signinPictures": "",
                };
                if (_counter.submitDates["executionUrls"] != null &&
                    _counter.submitDates["executionUrls"] is List &&
                    _counter.submitDates["executionUrls"][0]["value"] != null) {
                  queryParameters["signinPictures"] = _counter
                      .submitDates["executionUrls"][0]["value"]
                      .join("|");
                }
                queryParameters['planId'] = widget.planId;
                print(queryParameters);
                if (queryParameters['signinPictures'] == '') {
                  Fluttertoast.showToast(msg: "请拍照后再提交");
                } else {
                  myDio
                      .request(
                          type: 'post',
                          url: Interface.postSignin,
                          data: queryParameters)
                      .then((value) {
                    Fluttertoast.showToast(msg: '成功');
                    Navigator.pop(context);
                  });
                }
              },
              child: Container(
                height: size.width * 88,
                width: size.width * 690,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    vertical: size.width * 50, horizontal: size.width * 40),
                decoration: BoxDecoration(
                    color: Color(0xff3174FF),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Text(
                  '提交',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }
}
