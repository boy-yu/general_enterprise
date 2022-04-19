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

  String cellPhoneNum = '';
  String idNum = '';
  String perCategory = '';
  String major = '';
  String education = '';

  List dropList = [
    '无',
    '小学',
    '初中',
    '高中',
    '中专',
    '大专',
    '本科',
    '硕士',
    '博士',
  ];

  // 大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
  // 此方法中前三位格式有：
  // 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  static bool isChinaPhoneLegal(String str) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
  }

  // 验证身份证号码是否合法
  bool isCardId(String cardId) {
    if (cardId.length != 18) {
      Fluttertoast.showToast(msg: '请输入18位身份证号');
      return false;
    }
    // 身份证号码正则
    RegExp postalCode = new RegExp(
        r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
    // 验证格式格式正确，但仍需计算准确性
    if (!postalCode.hasMatch(cardId)) {
      Fluttertoast.showToast(msg: '请输入正确格式身份证号');
      return false;
    }
    // 将前17位加权因子保存在数组里
    final List idCardList = [
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2",
      "1",
      "6",
      "3",
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2"
    ];
    // 这是除以11后，可能产生的11位余数、验证码，也保存成数组
    final List idCardYArray = [
      '1',
      '0',
      '10',
      '9',
      '8',
      '7',
      '6',
      '5',
      '4',
      '3',
      '2'
    ];
    // 前17位各自乖以加权因子后的总和
    int idCardWiSum = 0;
    for (int i = 0; i < 17; i++) {
      int subStrIndex = int.parse(cardId.substring(i, i + 1));
      int idCardWiIndex = int.parse(idCardList[i]);
      idCardWiSum += subStrIndex * idCardWiIndex;
    }
    // 计算出校验码所在数组的位置
    int idCardMod = idCardWiSum % 11;
    // 得到最后一位号码
    String idCardLast = cardId.substring(17, 18);
    //  如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if (idCardMod == 2) {
      if (idCardLast != 'x' && idCardLast != 'X') {
        Fluttertoast.showToast(msg: '您输入的是无效身份证号，请确认');
        return false;
      }
    } else {
      //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
      if (idCardLast != idCardYArray[idCardMod]) {
        Fluttertoast.showToast(msg: '您输入的是无效身份证号，请确认');
        return false;
      }
    }
    return true;
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
                              image:
                                  NetworkImage(myprefs.getString('photoUrl'))),
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/person/avatar', arguments: {
                                  'photoUrl': myprefs.getString('photoUrl')
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
                          Text(
                            '手机号',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          TextField(
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            controller: _controller1,
                            onChanged: (value) {
                              cellPhoneNum = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 32,
                                    color: Color(0xff333333)),
                                hintText: cellPhoneNum == ''
                                    ? myprefs.getString('telephone') == ''
                                        ? '请输入手机号码'
                                        : myprefs.getString('telephone')
                                    : cellPhoneNum),
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
                            '身份证号',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            controller: _controller2,
                            onChanged: (value) {
                              idNum = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 32,
                                    color: Color(0xff333333)),
                                hintText: idNum == ''
                                    ? myprefs.getString('identityNum') == ''
                                        ? '请输入身份证号'
                                        : myprefs.getString('identityNum')
                                    : idNum),
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
                            '人员类别',
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
                              perCategory = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 32,
                                    color: Color(0xff333333)),
                                hintText: perCategory == ''
                                    ? myprefs.getString('type') == ''
                                        ? '例如：安全管理人员'
                                        : myprefs.getString('type')
                                    : perCategory),
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
                            '学历',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: false,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  builder: (BuildContext context) {
                                    return ListView.builder(
                                      itemCount: dropList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            education =
                                                dropList[index].toString();
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: Text(
                                                dropList[index].toString()),
                                          ),
                                        );
                                      },
                                    );
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 20),
                              child: Row(
                                children: [
                                  education == ''
                                      ? Text(
                                          myprefs.getString('education') == ''
                                              ? '请选择'
                                              : myprefs.getString('education'),
                                          style: TextStyle(
                                              fontSize: size.width * 32,
                                              color: Color(0xff333333)),
                                        )
                                      : Text(
                                          education,
                                          style: TextStyle(
                                              fontSize: size.width * 32,
                                              color: Color(0xff333333)),
                                        ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xff999999),
                                  )
                                ],
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
                            '专业',
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
                              major = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: size.width * 32,
                                    color: Color(0xff333333)),
                                hintText: major == ''
                                    ? myprefs.getString('specialty') == ''
                                        ? '请输入专业名称'
                                        : myprefs.getString('specialty')
                                    : major),
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
                  Map submitData = {
                    'telephone': myprefs.getString('telephone'),
                    'identityNum': myprefs.getString('identityNum'),
                    'type': myprefs.getString('type'),
                    'education': myprefs.getString('education'),
                    'specialty': myprefs.getString('specialty'),
                  };
                  if (cellPhoneNum != '') {
                    if (!isChinaPhoneLegal(cellPhoneNum)) {
                      Fluttertoast.showToast(msg: '请输入正确手机号码');
                      return;
                    } else {
                      submitData['telephone'] = cellPhoneNum;
                    }
                  }
                  if (idNum != '') {
                    if (!isCardId(idNum)) {
                      return;
                    } else {
                      submitData['identityNum'] = idNum;
                    }
                  }
                  if (perCategory != '') {
                    submitData['type'] = perCategory;
                  }
                  if (major != '') {
                    submitData['specialty'] = major;
                  }
                  if (education != '') {
                    submitData['education'] = education;
                  }
                  myDio
                      .request(
                          type: 'put',
                          url: Interface.amendAvatar,
                          data: submitData)
                      .then((value) {
                    if (cellPhoneNum != '') {
                      myprefs.setString('telephone', cellPhoneNum);
                    }
                    if (idNum != '') {
                      myprefs.setString('identityNum', idNum);
                    }
                    if (perCategory != '') {
                      myprefs.setString('type', perCategory);
                    }
                    if (education != '') {
                      myprefs.setString('education', education);
                    }
                    if (major != '') {
                      myprefs.setString('specialty', major);
                    }
                    successToast('修改成功');
                    if (mounted) {
                      setState(() {});
                    }
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
