import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyMessage extends StatefulWidget {
  @override
  _MyMessageState createState() => _MyMessageState();
}

class _MyMessageState extends State<MyMessage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  String nickname = '';
  String mobile = '';
  String email = '';
  String description = '';

  List sexList = [
    '男',
    '女',
    '保密',
  ];

  int selectSex = 0;

  @override
  void initState() {
    super.initState();
    selectSex = myprefs.getInt('sex');
  }

  // 大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
  // 此方法中前三位格式有：
  // 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  static bool isChinaPhoneLegal(String str) {
    return RegExp(
            r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$")
        .hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(
        '编辑资料',
        style: TextStyle(fontSize: size.width * 32),
      ),
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.width * 40,
                    ),
                    Center(
                        child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 68)),
                          child: FadeInImage(
                              fit: BoxFit.cover,
                              width: size.width * 160,
                              height: size.width * 160,
                              placeholder: AssetImage(
                                  'assets/images/image_recent_control.jpg'),
                              image: myprefs.getString('avatar') == ''
                                  ? AssetImage(
                                      'assets/images/doubleRiskProjeck/image_avatar_default.png')
                                  : NetworkImage(myprefs.getString('avatar'))),
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/person/avatar', arguments: {
                                  'photoUrl': myprefs.getString('avatar')
                                }).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Image.asset(
                                'assets/images/doubleRiskProjeck/icon_my_ava_update.png',
                                height: size.width * 56,
                                width: size.width * 56,
                              ),
                            ))
                      ],
                    )),
                    SizedBox(
                      height: size.width * 24,
                    ),
                    Center(
                      child: Text(
                        '更改头像',
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 60,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w500),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '*',
                                      style:
                                          TextStyle(color: Color(0xffF56271))),
                                  TextSpan(
                                      text: '用户名',
                                      style:
                                          TextStyle(color: Color(0xff333333))),
                                ]),
                          ),
                          Container(
                            height: size.width * 68,
                            width: double.infinity,
                            color: Color(0xffECECEC),
                            margin: EdgeInsets.only(
                                bottom: size.width * 32, top: size.width * 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              myprefs.getString('username').toString(),
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w500),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '*',
                                      style:
                                          TextStyle(color: Color(0xffF56271))),
                                  TextSpan(
                                      text: '昵称',
                                      style:
                                          TextStyle(color: Color(0xff333333))),
                                ]),
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _controller1,
                            onChanged: (value) {
                              nickname = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 32,
                                    color: Color(0xff333333)),
                                hintText: nickname == ''
                                    ? myprefs.getString('nickname') == ''
                                        ? '请输入昵称'
                                        : myprefs.getString('nickname')
                                    : nickname),
                            maxLines: 1,
                            minLines: 1,
                          ),
                          Container(
                            color: Color(0xffF2F2F2),
                            height: size.width * 2,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: size.width * 32),
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w500),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '*',
                                      style:
                                          TextStyle(color: Color(0xffF56271))),
                                  TextSpan(
                                      text: '联系电话',
                                      style:
                                          TextStyle(color: Color(0xff333333))),
                                ]),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            controller: _controller2,
                            onChanged: (value) {
                              mobile = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 32,
                                    color: Color(0xff333333)),
                                hintText: mobile == ''
                                    ? myprefs.getString('mobile') == ''
                                        ? '请输入联系电话'
                                        : myprefs.getString('mobile')
                                    : mobile),
                            maxLines: 1,
                            minLines: 1,
                          ),
                          Container(
                            color: Color(0xffF2F2F2),
                            height: size.width * 2,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: size.width * 32),
                          ),
                          Text(
                            '邮箱',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _controller3,
                            onChanged: (value) {
                              email = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 32,
                                    color: Color(0xff333333)),
                                hintText: email == ''
                                    ? myprefs.getString('email') == ''
                                        ? '请输入邮箱'
                                        : myprefs.getString('email')
                                    : email),
                            maxLines: 1,
                            minLines: 1,
                          ),
                          Container(
                            color: Color(0xffF2F2F2),
                            height: size.width * 2,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: size.width * 32),
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.w500),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: '*',
                                      style:
                                          TextStyle(color: Color(0xffF56271))),
                                  TextSpan(
                                      text: '性别',
                                      style:
                                          TextStyle(color: Color(0xff333333))),
                                ]),
                          ),
                          Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  bottom: size.width * 32,
                                  top: size.width * 20),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      selectSex = 0;
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: size.width * 200,
                                      height: size.width * 68,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: size.width * 32,
                                            width: size.width * 32,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: selectSex == 0
                                                    ? Border.all(
                                                        color:
                                                            Color(0xff3074FF),
                                                        width: size.width * 10)
                                                    : Border.all(
                                                        color:
                                                            Color(0xffE0E0E0),
                                                        width: size.width * 2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 50))),
                                          ),
                                          SizedBox(
                                            width: size.width * 16,
                                          ),
                                          Text(
                                            '男',
                                            style: TextStyle(
                                                color: selectSex == 0
                                                    ? Color(0xff262626)
                                                    : Color(0xff8D95A3),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selectSex = 1;
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: size.width * 200,
                                      height: size.width * 68,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: size.width * 32,
                                            width: size.width * 32,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: selectSex == 1
                                                    ? Border.all(
                                                        color:
                                                            Color(0xff3074FF),
                                                        width: size.width * 10)
                                                    : Border.all(
                                                        color:
                                                            Color(0xffE0E0E0),
                                                        width: size.width * 2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 50))),
                                          ),
                                          SizedBox(
                                            width: size.width * 16,
                                          ),
                                          Text(
                                            '女',
                                            style: TextStyle(
                                                color: selectSex == 1
                                                    ? Color(0xff262626)
                                                    : Color(0xff8D95A3),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selectSex = 2;
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: size.width * 200,
                                      height: size.width * 68,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: size.width * 32,
                                            width: size.width * 32,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: selectSex == 2
                                                    ? Border.all(
                                                        color:
                                                            Color(0xff3074FF),
                                                        width: size.width * 10)
                                                    : Border.all(
                                                        color:
                                                            Color(0xffE0E0E0),
                                                        width: size.width * 2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 50))),
                                          ),
                                          SizedBox(
                                            width: size.width * 16,
                                          ),
                                          Text(
                                            '保密',
                                            style: TextStyle(
                                                color: selectSex == 2
                                                    ? Color(0xff262626)
                                                    : Color(0xff8D95A3),
                                                fontSize: size.width * 28,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Text(
                            '描述',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _controller4,
                            onChanged: (value) {
                              description = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 32,
                                    color: Color(0xff333333)),
                                hintText: description == ''
                                    ? myprefs.getString('description') == ''
                                        ? '请输入描述'
                                        : myprefs.getString('description')
                                    : description),
                            maxLines: 1,
                            minLines: 1,
                          ),
                          Container(
                            color: Color(0xffF2F2F2),
                            height: size.width * 2,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: size.width * 32),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (nickname == '') {
                    if (myprefs.getString('nickname') == '') {
                      Fluttertoast.showToast(msg: '请填写昵称');
                      return;
                    } else {
                      nickname = myprefs.getString('nickname');
                    }
                  }
                  print(mobile);
                  if (mobile == '') {
                    if (myprefs.getString('mobile') == '') {
                      Fluttertoast.showToast(msg: '请填写联系电话');
                      return;
                    } else if (!isChinaPhoneLegal(
                        myprefs.getString('mobile'))) {
                      Fluttertoast.showToast(msg: '请输入正确手机号码');
                      return;
                    } else {
                      mobile = myprefs.getString('mobile');
                    }
                  } else {
                    if (!isChinaPhoneLegal(mobile)) {
                      Fluttertoast.showToast(msg: '请输入正确手机号码');
                      return;
                    }
                  }
                  if (email == '') {
                    email = myprefs.getString('email');
                  }
                  if (description == '') {
                    description = myprefs.getString('description');
                  }
                  myDio.request(
                      type: 'put',
                      url: Interface.putUpdateUser,
                      data: {
                        "avatar": myprefs.getString('avatar'),
                        "description": description,
                        "email": email,
                        "mobile": mobile,
                        "nickname": nickname,
                        "sex": selectSex,
                        "sign": myprefs.getString('sign'),
                      }).then((value) async {
                    await myprefs.setString('description', description);
                    await myprefs.setString('email', email);
                    await myprefs.setString('mobile', mobile);
                    await myprefs.setString('nickname', nickname);
                    await myprefs.setInt('sex', selectSex);
                    successToast('保存成功');
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  height: size.width * 80,
                  width: size.width * 686,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: size.width * 50),
                  decoration: BoxDecoration(
                      color: Color(0xff3074FF),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 8))),
                  child: Text(
                    "保  存",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 32,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
