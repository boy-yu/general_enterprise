import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Appointment extends StatefulWidget {
  Appointment({this.data, this.type});
  final Map data;
  final String type;
  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  int appointmentType = 0;
  @override
  void initState() {
    super.initState();
    appointmentType = widget.type == '人员预约' ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text("预约"),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      appointmentType = 0;
                      setState(() {});
                    },
                    child: Container(
                      width: size.width * 225,
                      padding: EdgeInsets.symmetric(vertical: size.width * 30),
                      child: Column(
                        children: [
                          Text(
                            "车辆预约",
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28),
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Container(
                            height: size.width * 4,
                            width: size.width * 104,
                            color: appointmentType == 0
                                ? Color(0xff2E6BFB)
                                : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      appointmentType = 1;
                      setState(() {});
                    },
                    child: Container(
                      width: size.width * 225,
                      padding: EdgeInsets.symmetric(vertical: size.width * 30),
                      child: Column(
                        children: [
                          Text(
                            "人员预约",
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28),
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Container(
                            height: size.width * 4,
                            width: size.width * 104,
                            color: appointmentType == 1
                                ? Color(0xff2E6BFB)
                                : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // appointmentType: 0 车辆预约， 1 人员预约
            appointmentType == 0
                ? CarAppointment(data: widget.data)
                : PerAppointment(data: widget.data),
          ],
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: '可以帮非本企业内部人员预约');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 30),
                child: Image.asset(
                  'assets/images/zy.png',
                  width: size.width * 40,
                  height: size.width * 40,
                ),
              ))
        ]);
  }
}

class CarAppointment extends StatefulWidget {
  CarAppointment({this.data});
  final Map data;
  @override
  State<CarAppointment> createState() => _CarAppointmentState();
}

class _CarAppointmentState extends State<CarAppointment> {
  int carType = 0;
  @override
  void initState() {
    super.initState();
    carType = widget.data['type'] == 1 ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: size.width * 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  carType = 0;
                  setState(() {});
                },
                child: Container(
                  width: size.width * 225,
                  height: size.width * 76,
                  decoration: BoxDecoration(
                      color:
                          carType == 0 ? Color(0xffEAF1FF) : Color(0xffFAFAFB),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 38))),
                  alignment: Alignment.center,
                  child: Text(
                    "危险化学品车辆",
                    style: TextStyle(
                        color: carType == 0
                            ? Color(0xff3072FE)
                            : Color(0xffACACBC),
                        fontSize: size.width * 24),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  carType = 1;
                  setState(() {});
                },
                child: Container(
                  width: size.width * 225,
                  height: size.width * 76,
                  decoration: BoxDecoration(
                      color:
                          carType == 1 ? Color(0xffEAF1FF) : Color(0xffFAFAFB),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 38))),
                  alignment: Alignment.center,
                  child: Text(
                    "普通车辆",
                    style: TextStyle(
                        color: carType == 1
                            ? Color(0xff3072FE)
                            : Color(0xffACACBC),
                        fontSize: size.width * 24),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: size.width * 20,
        ),
        Expanded(
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: size.width * 25),
                // carType：0 危险化学品车辆， 1 普通车辆
                child: carType == 0
                    ? HazardousChemicalsCar(data: widget.data)
                    : GeneralCar(data: widget.data)))
      ],
    ));
  }
}

class PerAppointment extends StatefulWidget {
  PerAppointment({this.data});
  final Map data;
  @override
  State<PerAppointment> createState() => _PerAppointmentState();
}

class _PerAppointmentState extends State<PerAppointment> {
  String chooseDate = '';
  int clickNum = 0;

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      submitData['name'] = widget.data['name'];
      submitData['telephone'] = widget.data['telephone'];
      submitData['oppositePerson'] = widget.data['oppositePerson'];
      submitData['oppositeTelephone'] = widget.data['oppositeTelephone'];
      submitData['subjectMatter'] = widget.data['subjectMatter'];
    }
  }

  _chooseDate() {
    ++clickNum;
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    ).then((value) {
      if (value != null) {
        showTimePicker(context: context, initialTime: TimeOfDay.now())
            .then((time) {
          if (time != null) {
            String currenTime = value.toLocal().toString().split(' ')[0] +
                ' ' +
                (time.hour > 9
                    ? time.hour.toString()
                    : '0' + time.hour.toString()) +
                ':' +
                (time.minute > 9
                    ? time.minute.toString()
                    : '0' + time.minute.toString());
            chooseDate = currenTime;
            submitData['visitingTime'] =
                value.toLocal().toString().split(' ')[0] +
                    ' ' +
                    (time.hour > 9
                        ? time.hour.toString()
                        : '0' + time.hour.toString()) +
                    ':' +
                    (time.minute > 9
                        ? time.minute.toString()
                        : '0' + time.minute.toString()) +
                    ':' +
                    '00';
            setState(() {});
          } else {
            clickNum = 0;
          }
        });
      } else {
        clickNum = 0;
      }
    });
  }

  _sumbit() {
    if (submitData['name'] == '') {
      Fluttertoast.showToast(msg: "请填写姓名");
    } else if (submitData['telephone'] == '') {
      Fluttertoast.showToast(msg: "请填写电话");
    } else if (submitData['oppositePerson'] == '') {
      Fluttertoast.showToast(msg: "请填写对接人姓名");
    } else if (submitData['oppositeTelephone'] == '') {
      Fluttertoast.showToast(msg: "请填写对接人电话");
    } else if (submitData['visitingTime'] == '') {
      Fluttertoast.showToast(msg: "请选择预计来访时间");
    } else if (submitData['subjectMatter'] == '') {
      Fluttertoast.showToast(msg: "请填写来访事由");
    } else if (submitData['url'] == '') {
      Fluttertoast.showToast(msg: "请上传人脸照片");
    } else {
      // print(submitData)
      myDio
          .request(
              type: 'post',
              url: Interface.postVisitorSubscribe,
              data: submitData)
          .then((value) {
        Fluttertoast.showToast(msg: '预约成功');
        Navigator.of(context).pop();
      });
    }
  }

  Map submitData = {
    "companyId": 0,
    "createDate": "",
    "destination": "",
    "deviceSn": "",
    "id": 0,
    "isInput": 0,
    "modifyDate": "",
    "name": "",
    "openid": "",
    "oppositePerson": "",
    "oppositeTelephone": "",
    "result": "",
    "status": 0,
    "subjectMatter": "",
    "telephone": "",
    "uid": "",
    "url": "",
    "userId": 0,
    "visitingTime": ""
  };

  final picker = ImagePicker();

  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        File _image = File(pickedFile.path);
        uploadImg(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<dynamic> uploadImg(String path) async {
    Fluttertoast.showToast(msg: '照片上传中请稍后。。。');
    final res = await Future.delayed(Duration(seconds: 1), () async {
      final res = await Dio().post(
        Interface.uploadUrl,
        data: FormData.fromMap({"file": await MultipartFile.fromFile(path)}),
      );
      return res;
    });
    if (res.data['code'] == 200) {
      submitData['url'] = res.data['message'];
      Fluttertoast.showToast(msg: '照片上传成功');
      setState(() {});
    } else {
      Interface().error({'message': "上传失败"}, context);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: size.width * 25),
      margin: EdgeInsets.only(top: size.width * 30),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                "*",
                style: TextStyle(color: Colors.red, fontSize: size.width * 28),
              ),
              Text(
                "姓名",
                style: TextStyle(
                    color: Color(0xff333333), fontSize: size.width * 28),
              ),
              Spacer(),
              Container(
                width: size.width * 200,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: submitData['name'] == ''
                          ? '请输入姓名'
                          : submitData['name'],
                      hintStyle: TextStyle(
                          color: Color(0xffE0E0E0), fontSize: size.width * 28),
                      border: InputBorder.none),
                  onChanged: (str) {
                    submitData['name'] = str;
                  },
                  autofocus: false,
                ),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            width: double.infinity,
            color: Color(0xffEEEEEE),
          ),
          Row(
            children: [
              Text(
                "*",
                style: TextStyle(color: Colors.red, fontSize: size.width * 28),
              ),
              Text(
                "电话",
                style: TextStyle(
                    color: Color(0xff333333), fontSize: size.width * 28),
              ),
              Spacer(),
              Container(
                width: size.width * 200,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: submitData['telephone'] == ''
                          ? '请输入电话'
                          : submitData['telephone'],
                      hintStyle: TextStyle(
                          color: Color(0xffE0E0E0), fontSize: size.width * 28),
                      border: InputBorder.none),
                  onChanged: (str) {
                    submitData['telephone'] = str;
                  },
                  autofocus: false,
                ),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            width: double.infinity,
            color: Color(0xffEEEEEE),
          ),
          Row(
            children: [
              Text(
                "*",
                style: TextStyle(color: Colors.red, fontSize: size.width * 28),
              ),
              Text(
                "对接人姓名",
                style: TextStyle(
                    color: Color(0xff333333), fontSize: size.width * 28),
              ),
              Spacer(),
              Container(
                width: size.width * 200,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: submitData['oppositePerson'] == ''
                          ? '请输入姓名'
                          : submitData['oppositePerson'],
                      hintStyle: TextStyle(
                          color: Color(0xffE0E0E0), fontSize: size.width * 28),
                      border: InputBorder.none),
                  onChanged: (str) {
                    submitData['oppositePerson'] = str;
                  },
                  autofocus: false,
                ),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            width: double.infinity,
            color: Color(0xffEEEEEE),
          ),
          Row(
            children: [
              Text(
                "*",
                style: TextStyle(color: Colors.red, fontSize: size.width * 28),
              ),
              Text(
                "对接人电话",
                style: TextStyle(
                    color: Color(0xff333333), fontSize: size.width * 28),
              ),
              Spacer(),
              Container(
                width: size.width * 200,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: submitData['oppositeTelephone'] == ''
                          ? '请输入电话'
                          : submitData['oppositeTelephone'],
                      hintStyle: TextStyle(
                          color: Color(0xffE0E0E0), fontSize: size.width * 28),
                      border: InputBorder.none),
                  onChanged: (str) {
                    submitData['oppositeTelephone'] = str;
                  },
                  autofocus: false,
                ),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            width: double.infinity,
            color: Color(0xffEEEEEE),
          ),
          Row(
            children: [
              Text(
                "*",
                style: TextStyle(color: Colors.red, fontSize: size.width * 28),
              ),
              Text(
                "预计来访时间",
                style: TextStyle(
                    color: Color(0xff333333), fontSize: size.width * 28),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  chooseDate = "";
                  _chooseDate();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 30, horizontal: size.width * 50),
                  child: Text(
                    chooseDate == "" ? "请选择时间 >" : chooseDate,
                    style: TextStyle(
                        color: chooseDate == ""
                            ? Color(0xffE0E0E0)
                            : Color(0xff333333),
                        fontSize: size.width * 28),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: size.width * 1,
            width: double.infinity,
            color: Color(0xffEEEEEE),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: size.width * 25),
            child: Row(children: [
              Text(
                "*",
                style: TextStyle(color: Colors.red, fontSize: size.width * 28),
              ),
              Text(
                "来访事由",
                style: TextStyle(
                    color: Color(0xff333333), fontSize: size.width * 28),
              ),
            ]),
          ),
          Container(
            height: size.width * 130,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(width: size.width * 1, color: Color(0xffEEEEEE)),
            ),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: submitData['subjectMatter'] == ''
                      ? '请输入来访事由'
                      : submitData['subjectMatter'],
                  hintStyle: TextStyle(
                    color: Color(0xffE0E0E0),
                    fontSize: size.width * 28,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 20, vertical: size.width * 10)),
              onChanged: (str) {
                submitData['subjectMatter'] = str;
              },
              autofocus: false,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: size.width * 25),
            child: Row(children: [
              Text(
                "*",
                style: TextStyle(color: Colors.red, fontSize: size.width * 28),
              ),
              Text(
                "人脸照片",
                style: TextStyle(
                    color: Color(0xff333333), fontSize: size.width * 28),
              ),
            ]),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: getGalleryImage,
                child: submitData['url'] == ''
                    ? Image.asset(
                        'assets/images/rlpz@2x.png',
                        height: size.width * 150,
                        width: size.width * 150,
                      )
                    : Image.network(
                        submitData['url'],
                        height: size.width * 150,
                        width: size.width * 150,
                      ),
              ),
            ],
          ),
          GestureDetector(
            onTap: _sumbit,
            child: Container(
              height: size.width * 62,
              margin: EdgeInsets.only(
                  top: size.width * 50,
                  left: size.width * 250,
                  right: size.width * 250,
                  bottom: size.width * 100),
              decoration: BoxDecoration(
                  color: Color(0xff3072FE),
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 8))),
              alignment: Alignment.center,
              child: Text(
                "提交预约",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class HazardousChemicalsCar extends StatefulWidget {
  HazardousChemicalsCar({this.data});
  final Map data;
  @override
  State<HazardousChemicalsCar> createState() => _HazardousChemicalsCarState();
}

class _HazardousChemicalsCarState extends State<HazardousChemicalsCar> {
  int deliveryStatus = 1; // 1重载 0空载
  String chooseDate = '';
  int clickNum = 0;

  @override
  void initState() {
    super.initState();
    print(widget.data);
    if (widget.data.isNotEmpty) {
      submitData['carNo'] = widget.data['carNo'];
      submitData['name'] = widget.data['name'];
      submitData['telephone'] = widget.data['telephone'];
      submitData['supercargoName'] = widget.data['supercargoName'];
      submitData['supercargoTelephone'] = widget.data['supercargoTelephone'];
      submitData['hazardousMaterial'] = widget.data['hazardousMaterial'];
      deliveryStatus = widget.data['carryingStatus'];
      submitData['carryingStatus'] = widget.data['carryingStatus'];
      submitData['oppositePerson'] = widget.data['oppositePerson'];
      submitData['oppositeTelephone'] = widget.data['oppositeTelephone'];
      submitData['subjectMatter'] = widget.data['subjectMatter'];
    }
  }

  _chooseDate() {
    ++clickNum;
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    ).then((value) {
      if (value != null) {
        showTimePicker(context: context, initialTime: TimeOfDay.now())
            .then((time) {
          if (time != null) {
            String currenTime = value.toLocal().toString().split(' ')[0] +
                ' ' +
                (time.hour > 9
                    ? time.hour.toString()
                    : '0' + time.hour.toString()) +
                ':' +
                (time.minute > 9
                    ? time.minute.toString()
                    : '0' + time.minute.toString());
            chooseDate = currenTime;
            submitData['visitingTime'] =
                value.toLocal().toString().split(' ')[0] +
                    ' ' +
                    (time.hour > 9
                        ? time.hour.toString()
                        : '0' + time.hour.toString()) +
                    ':' +
                    (time.minute > 9
                        ? time.minute.toString()
                        : '0' + time.minute.toString()) +
                    ':' +
                    '00';

            setState(() {});
          } else {
            clickNum = 0;
          }
        });
      } else {
        clickNum = 0;
      }
    });
  }

  _sumbit() {
    print(submitData);
    submitData['carryingStatus'] = deliveryStatus;
    if (submitData['carNo'] == '') {
      Fluttertoast.showToast(msg: "请填写车牌号");
    } else if (submitData['name'] == '') {
      Fluttertoast.showToast(msg: "请填写驾驶员姓名");
    } else if (submitData['telephone'] == '') {
      Fluttertoast.showToast(msg: "请填写驾驶员电话");
    } else if (submitData['supercargoName'] == '') {
      Fluttertoast.showToast(msg: "请填写押运员姓名");
    } else if (submitData['supercargoTelephone'] == '') {
      Fluttertoast.showToast(msg: "请填写押运员电话");
    } else if (submitData['hazardousMaterial'] == '') {
      Fluttertoast.showToast(msg: "请填写危险化学品名称");
    } else if (submitData['oppositePerson'] == '') {
      Fluttertoast.showToast(msg: "请填写对接人姓名");
    } else if (submitData['oppositeTelephone'] == '') {
      Fluttertoast.showToast(msg: "请填写对接人电话");
    } else if (submitData['visitingTime'] == '') {
      Fluttertoast.showToast(msg: "请选择预计来访时间");
    } else if (submitData['subjectMatter'] == '') {
      Fluttertoast.showToast(msg: "请填写来访事由");
    } else {
      myDio
          .request(
              type: 'post', url: Interface.addCarSubscribe, data: submitData)
          .then((value) {
        Fluttertoast.showToast(msg: '预约成功');
        Navigator.of(context).pop();
      });
    }
  }

  Map submitData = {
    "carNo": "",
    "carryingStatus": 0,
    "companyId": 0,
    "createDate": "",
    "destination": "",
    "equipmentIdList": "",
    "hazardousMaterial": "",
    "id": 0,
    "modifyDate": "",
    "name": "",
    "openid": "",
    "oppositePerson": "",
    "oppositeTelephone": "",
    "result": "",
    "status": 0,
    "subjectMatter": "",
    "supercargoName": "",
    "supercargoTelephone": "",
    "telephone": "",
    "type": 1,
    "url": "",
    "userId": 0,
    "visitingTime": ""
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: size.width * 20,
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "车牌号",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['carNo'] == ''
                        ? '请输入车牌号'
                        : submitData['carNo'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['carNo'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "驾驶员姓名",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText:
                        submitData['name'] == '' ? '请输入姓名' : submitData['name'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['name'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "驾驶员电话",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['telephone'] == ''
                        ? '请输入电话'
                        : submitData['telephone'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['telephone'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "押运员姓名",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['supercargoName'] == ''
                        ? '请输入姓名'
                        : submitData['supercargoName'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['supercargoName'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "押运员电话",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['supercargoTelephone'] == ''
                        ? '请输入电话'
                        : submitData['supercargoTelephone'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['supercargoTelephone'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "危险化学品名称",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['hazardousMaterial'] == ''
                        ? '请输入名称'
                        : submitData['hazardousMaterial'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['hazardousMaterial'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "运载状态",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Radio(
                  // 按钮的值
                  value: 1,
                  // 改变事件
                  onChanged: (value) {
                    deliveryStatus = value;
                    setState(() {});
                  },
                  // 按钮组的值
                  groupValue: deliveryStatus,
                ),
                Text(
                  "重载",
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.width * 40,
                ),
                Radio(
                  value: 0,
                  onChanged: (value) {
                    deliveryStatus = value;
                    setState(() {});
                  },
                  groupValue: deliveryStatus,
                ),
                Text(
                  "空载",
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: size.width * 28,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "对接人姓名",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['oppositePerson'] == ''
                        ? '请输入姓名'
                        : submitData['oppositePerson'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['oppositePerson'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "对接人电话",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['oppositeTelephone'] == ''
                        ? '请输入电话'
                        : submitData['oppositeTelephone'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['oppositeTelephone'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "预计来访时间",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                chooseDate = "";
                _chooseDate();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.width * 30, horizontal: size.width * 50),
                child: Text(
                  chooseDate == "" ? "请选择时间 >" : chooseDate,
                  style: TextStyle(
                      color: chooseDate == ""
                          ? Color(0xffE0E0E0)
                          : Color(0xff333333),
                      fontSize: size.width * 28),
                ),
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: size.width * 25),
          child: Row(children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "来访事由",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
          ]),
        ),
        Container(
          height: size.width * 130,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: size.width * 1, color: Color(0xffEEEEEE)),
          ),
          child: TextField(
            maxLines: 5,
            decoration: InputDecoration(
                hintText: submitData['subjectMatter'] == ''
                    ? '请输入来访事由'
                    : submitData['subjectMatter'],
                hintStyle: TextStyle(
                  color: Color(0xffE0E0E0),
                  fontSize: size.width * 28,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: size.width * 20, vertical: size.width * 10)),
            onChanged: (str) {
              submitData['subjectMatter'] = str;
            },
            autofocus: false,
          ),
        ),
        GestureDetector(
          onTap: _sumbit,
          child: Container(
            height: size.width * 62,
            margin: EdgeInsets.only(
                top: size.width * 50,
                left: size.width * 250,
                right: size.width * 250,
                bottom: size.width * 100),
            decoration: BoxDecoration(
                color: Color(0xff3072FE),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            alignment: Alignment.center,
            child: Text(
              "提交预约",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}

class GeneralCar extends StatefulWidget {
  GeneralCar({this.data});
  final Map data;
  @override
  State<GeneralCar> createState() => _GeneralCarState();
}

class _GeneralCarState extends State<GeneralCar> {
  String chooseDate = '';
  int clickNum = 0;

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      submitData['carNo'] = widget.data['carNo'];
      submitData['name'] = widget.data['name'];
      submitData['telephone'] = widget.data['telephone'];
      submitData['oppositePerson'] = widget.data['oppositePerson'];
      submitData['oppositeTelephone'] = widget.data['oppositeTelephone'];
      submitData['subjectMatter'] = widget.data['subjectMatter'];
    }
  }

  _chooseDate() {
    ++clickNum;
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    ).then((value) {
      if (value != null) {
        showTimePicker(context: context, initialTime: TimeOfDay.now())
            .then((time) {
          if (time != null) {
            String currenTime = value.toLocal().toString().split(' ')[0] +
                ' ' +
                (time.hour > 9
                    ? time.hour.toString()
                    : '0' + time.hour.toString()) +
                ':' +
                (time.minute > 9
                    ? time.minute.toString()
                    : '0' + time.minute.toString());
            chooseDate = currenTime;
            submitData['visitingTime'] =
                value.toLocal().toString().split(' ')[0] +
                    ' ' +
                    (time.hour > 9
                        ? time.hour.toString()
                        : '0' + time.hour.toString()) +
                    ':' +
                    (time.minute > 9
                        ? time.minute.toString()
                        : '0' + time.minute.toString()) +
                    ':' +
                    '00';
            setState(() {});
          } else {
            clickNum = 0;
          }
        });
      } else {
        clickNum = 0;
      }
    });
  }

  _sumbit() {
    if (submitData['carNo'] == '') {
      Fluttertoast.showToast(msg: "请填写车牌号");
    } else if (submitData['name'] == '') {
      Fluttertoast.showToast(msg: "请填写驾驶员姓名");
    } else if (submitData['telephone'] == '') {
      Fluttertoast.showToast(msg: "请填写驾驶员电话");
    } else if (submitData['oppositePerson'] == '') {
      Fluttertoast.showToast(msg: "请填写对接人姓名");
    } else if (submitData['oppositeTelephone'] == '') {
      Fluttertoast.showToast(msg: "请填写对接人电话");
    } else if (submitData['visitingTime'] == '') {
      Fluttertoast.showToast(msg: "请选择预计来访时间");
    } else if (submitData['subjectMatter'] == '') {
      Fluttertoast.showToast(msg: "请填写来访事由");
    } else {
      myDio
          .request(
              type: 'post', url: Interface.addCarSubscribe, data: submitData)
          .then((value) {
        Fluttertoast.showToast(msg: '预约成功');
        Navigator.of(context).pop();
      });
    }
  }

  Map submitData = {
    "carNo": "",
    "carryingStatus": 0,
    "companyId": 0,
    "createDate": "",
    "destination": "",
    "equipmentIdList": "",
    "hazardousMaterial": "",
    "id": 0,
    "modifyDate": "",
    "name": "",
    "openid": "",
    "oppositePerson": "",
    "oppositeTelephone": "",
    "result": "",
    "status": 0,
    "subjectMatter": "",
    "supercargoName": "",
    "supercargoTelephone": "",
    "telephone": "",
    "type": 2,
    "url": "",
    "userId": 0,
    "visitingTime": ""
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: size.width * 20,
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "车牌号",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['carNo'] == ''
                        ? '请输入车牌号'
                        : submitData['carNo'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['carNo'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "驾驶员姓名",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText:
                        submitData['name'] == '' ? '请输入姓名' : submitData['name'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['name'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "驾驶员电话",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['telephone'] == ''
                        ? '请输入电话'
                        : submitData['telephone'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['telephone'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "对接人姓名",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['oppositePerson'] == ''
                        ? '请输入姓名'
                        : submitData['oppositePerson'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['oppositePerson'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "对接人电话",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            Container(
              width: size.width * 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: submitData['oppositeTelephone'] == ''
                        ? '请输入电话'
                        : submitData['oppositeTelephone'],
                    hintStyle: TextStyle(
                        color: Color(0xffE0E0E0), fontSize: size.width * 28),
                    border: InputBorder.none),
                onChanged: (str) {
                  submitData['oppositeTelephone'] = str;
                },
                autofocus: false,
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Row(
          children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "预计来访时间",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                chooseDate = "";
                _chooseDate();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.width * 30, horizontal: size.width * 50),
                child: Text(
                  chooseDate == "" ? "请选择时间 >" : chooseDate,
                  style: TextStyle(
                      color: chooseDate == ""
                          ? Color(0xffE0E0E0)
                          : Color(0xff333333),
                      fontSize: size.width * 28),
                ),
              ),
            )
          ],
        ),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEEEEEE),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: size.width * 25),
          child: Row(children: [
            Text(
              "*",
              style: TextStyle(color: Colors.red, fontSize: size.width * 28),
            ),
            Text(
              "来访事由",
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 28),
            ),
          ]),
        ),
        Container(
          height: size.width * 130,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: size.width * 1, color: Color(0xffEEEEEE)),
          ),
          child: TextField(
            maxLines: 5,
            decoration: InputDecoration(
                hintText: submitData['subjectMatter'] == ''
                    ? '请输入来访事由'
                    : submitData['subjectMatter'],
                hintStyle: TextStyle(
                  color: Color(0xffE0E0E0),
                  fontSize: size.width * 28,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: size.width * 20, vertical: size.width * 10)),
            onChanged: (str) {
              submitData['subjectMatter'] = str;
            },
            autofocus: false,
          ),
        ),
        GestureDetector(
          onTap: _sumbit,
          child: Container(
            height: size.width * 62,
            margin: EdgeInsets.only(
                top: size.width * 50,
                left: size.width * 250,
                right: size.width * 250,
                bottom: size.width * 100),
            decoration: BoxDecoration(
                color: Color(0xff3072FE),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 8))),
            alignment: Alignment.center,
            child: Text(
              "提交预约",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
