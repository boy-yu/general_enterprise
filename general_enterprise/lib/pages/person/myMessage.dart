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
    RegExp postalCode = new RegExp(r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
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
      title: Text('编辑资料'),
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 85,
                ),
                Center(
                    child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          width: size.width * 200,
                          height: size.width * 200,
                          placeholder: AssetImage(
                              'assets/images/image_recent_control.jpg'),
                          image: NetworkImage(myprefs.getString('photoUrl'))),
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/person/avatar',
                                arguments: {
                                  'photoUrl': myprefs.getString('photoUrl')
                                }).then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: size.width * 57,
                            width: size.width * 57,
                            decoration: BoxDecoration(
                                color: Color(0xffFF7A0B),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/icon_my_mes_potot.png',
                              height: size.width * 27,
                              width: size.width * 33,
                            ),
                          ),
                        ))
                  ],
                )),
                SizedBox(
                  height: size.width * 34,
                ),
                Center(
                  child: Text(
                    '更改头像',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: size.width * 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: size.width * 30,
                ),
                // 手机号码
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width * 260,
                        ),
                        child: Text(
                          '手机号',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          controller: _controller1,
                          textAlign: TextAlign.right,
                          onChanged: (value) {
                            cellPhoneNum = value;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(5),
                              hintStyle: TextStyle(
                                  fontSize: size.width * 30,
                                  color: Color(0xff666666)),
                              hintText: cellPhoneNum == ''
                                  ? myprefs.getString('telephone') == ''
                                      ? '请输入手机号码'
                                      : myprefs.getString('telephone')
                                  : cellPhoneNum),
                          maxLines: 1,
                          minLines: 1,
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xff7D7D7D).withOpacity(0.25),
                  height: size.width * 1,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: size.width * 0),
                ),
                // 身份证号
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width * 260,
                        ),
                        child: Text(
                          '身份证号',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: _controller2,
                          textAlign: TextAlign.right,
                          onChanged: (value) {
                            idNum = value;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(5),
                              hintStyle: TextStyle(
                                  fontSize: size.width * 30,
                                  color: Color(0xff666666)),
                              hintText: idNum == ''
                                  ? myprefs.getString('identityNum') == ''
                                      ? '请输入身份证号'
                                      : myprefs.getString('identityNum')
                                  : idNum),
                          maxLines: 1,
                          minLines: 1,
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xff7D7D7D).withOpacity(0.25),
                  height: size.width * 1,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: size.width * 0),
                ),
                // 人员类别
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width * 260,
                        ),
                        child: Text(
                          '人员类别',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: _controller3,
                          textAlign: TextAlign.right,
                          onChanged: (value) {
                            perCategory = value;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(5),
                              hintStyle: TextStyle(
                                  fontSize: size.width * 30,
                                  color: Color(0xff666666)),
                              hintText: perCategory == ''
                                  ? myprefs.getString('type') == ''
                                      ? '例如：安全管理人员'
                                      : myprefs.getString('type')
                                  : perCategory),
                          maxLines: 1,
                          minLines: 1,
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xff7D7D7D).withOpacity(0.25),
                  height: size.width * 1,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: size.width * 0),
                ),
                // 学历
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 30, vertical: size.width * 30),
                    child: GestureDetector(
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
                                      education = dropList[index].toString();
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: ListTile(
                                      title: Text(dropList[index].toString()),
                                    ),
                                  );
                                },
                              );
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: size.width * 260,
                            ),
                            child: Text(
                              '学历',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 32,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          education == ''
                              ? Text(
                                  myprefs.getString('education') == ''
                                      ? '请选择'
                                      : myprefs.getString('education'),
                                  style: TextStyle(
                                      fontSize: size.width * 30,
                                      color: Color(0xff666666)),
                                )
                              : Text(
                                  education,
                                  style: TextStyle(
                                      fontSize: size.width * 30,
                                      color: Color(0xff666666)),
                                ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Color(0xff999999),
                          )
                        ],
                      ),
                    )),
                Container(
                  color: Color(0xff7D7D7D).withOpacity(0.25),
                  height: size.width * 1,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: size.width * 0),
                ),
                // 专业
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width * 260,
                        ),
                        child: Text(
                          '专业',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: _controller4,
                          textAlign: TextAlign.right,
                          onChanged: (value) {
                            major = value;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(5),
                              hintStyle: TextStyle(
                                  fontSize: size.width * 30,
                                  color: Color(0xff666666)),
                              hintText: major == ''
                                  ? myprefs.getString('specialty') == ''
                                      ? '请输入专业名称'
                                      : myprefs.getString('specialty')
                                  : major),
                          maxLines: 1,
                          minLines: 1,
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
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
                    type: 'put', url: Interface.amendAvatar, data: submitData)
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
            color: Colors.transparent,
            height: size.width * 128,
            width: size.width * 128,
            alignment: Alignment.center,
            child: Text(
              '保存',
              style: TextStyle(fontSize: size.width * 26),
            ),
          ),
        )
      ],
    );
  }
}
