import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class LicenseUpDate extends StatefulWidget {
  LicenseUpDate({this.id, this.fixedType});
  final int id;
  final int fixedType;
  @override
  _LicenseUpDateState createState() => _LicenseUpDateState();
}

class _LicenseUpDateState extends State<LicenseUpDate> {
  DateTime grantDate;
  DateTime expireDate;

  File _image;
  final picker = ImagePicker();
  String frontPhotoUrl = '';
  String flipPhotoUrl = '';

  Future getCameraImage(String type) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImg(_image.path, type);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getGalleryImage(String type) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImg(_image.path, type);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<dynamic> uploadImg(String path, String type) async {
    Fluttertoast.showToast(msg: '证照上传中请稍后。。。');
    final res = await Future.delayed(Duration(seconds: 1), () async {
      final res = await Dio().post(
        Interface.uploadUrl,
        data: FormData.fromMap({"file": await MultipartFile.fromFile(path)}),
      );
      return res;
    });
    if (res.data['code'] == 200) {
      Fluttertoast.showToast(msg: '证照生成中。。。');
      if (type == '正面') {
        frontPhotoUrl = res.data['message'];
        if (mounted) {
          setState(() {});
        }
      } else if (type == '翻页') {
        flipPhotoUrl = res.data['message'];
        if (mounted) {
          setState(() {});
        }
      }
    } else {
      Interface().error({'message': "上传失败"}, context);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('证照'),
        child: Stack(
          children: [
            ListView(
              physics: ClampingScrollPhysics(),
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/imge_license_up_date_title.png",
                  height: size.width * 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: size.width * 200,
                ),
                Row(
                  children: [
                    Container(
                      color: Color(0xff2E6DFC),
                      height: size.width * 30,
                      width: size.width * 10,
                      margin: EdgeInsets.symmetric(horizontal: size.width * 20),
                    ),
                    Text(
                      '上传证件材料',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 36,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 28,
                ),
                Container(
                  width: double.infinity,
                  height: size.width * 322,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.photo_camera),
                                          title: Text("拍照"),
                                          onTap: () async {
                                            // imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
                                            getCameraImage('正面');
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.photo_library),
                                          title: Text("从文件夹中选择"),
                                          onTap: () async {
                                            // imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                                            getGalleryImage('正面');
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: frontPhotoUrl == ''
                                ? Image.asset(
                                    'assets/images/image_license_uploading.png',
                                    width: size.width * 310,
                                    height: size.width * 200,
                                  )
                                : Image.network(
                                    frontPhotoUrl,
                                    width: size.width * 310,
                                    height: size.width * 200,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(
                            height: size.width * 18,
                          ),
                          Text(
                            '证书照片（正面）',
                            style: TextStyle(
                                color: Color(0xffA4A4A4),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.photo_camera),
                                          title: Text("拍照"),
                                          onTap: () async {
                                            // imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
                                            getCameraImage('翻页');
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.photo_library),
                                          title: Text("从文件夹中选择"),
                                          onTap: () async {
                                            // imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                                            getGalleryImage('翻页');
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: flipPhotoUrl == ''
                                ? Image.asset(
                                    'assets/images/image_license_uploading.png',
                                    width: size.width * 310,
                                    height: size.width * 200,
                                  )
                                : Image.network(
                                    flipPhotoUrl,
                                    width: size.width * 310,
                                    height: size.width * 200,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(
                            height: size.width * 18,
                          ),
                          Text(
                            '证书照片（翻页）',
                            style: TextStyle(
                                color: Color(0xffA4A4A4),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 70,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.blue,
                        size: size.width * 28,
                      ),
                      SizedBox(
                        width: size.width * 10,
                      ),
                      Expanded(
                          child: Text(
                        '证件必须是清晰彩色原件电子版本。可以是扫描件或者数码拍摄照片。支持jpg、png、jpeg的图片格式',
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: size.width * 24,
                            color: Color(0xff999999)),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * 50,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.width * 50),
                  child: GestureDetector(
                    onTap: () {
                      if (grantDate == null) {
                        Fluttertoast.showToast(msg: '请选择颁发日期');
                      } else if (expireDate == null && widget.fixedType == 1) {
                        Fluttertoast.showToast(msg: '请选择到期日期');
                      } else if (frontPhotoUrl == '') {
                        Fluttertoast.showToast(msg: '请上传证书正面');
                      } else {
                        Map data = {
                          'grantDate': grantDate.toString(),
                          'expireDate': expireDate.toString(),
                          'frontPicture': frontPhotoUrl,
                          'tailsPicture': flipPhotoUrl,
                        };
                        myDio.request(
                          type: 'put',
                          url: Interface.putUpdateCoCertificateFileById + widget.id.toString(),
                          data: data
                        ).then((value) {
                          Fluttertoast.showToast(msg: '更新成功');
                          Navigator.pop(myContext);
                        });
                      }
                    },
                    child: Container(
                      height: size.width * 64,
                      margin: EdgeInsets.symmetric(horizontal: size.width * 250),
                      decoration: BoxDecoration(
                          color: Color(0xff234CF0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      alignment: Alignment.center,
                      child: Text(
                        '更新证照',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 32),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                top: size.width * 180,
                child: Container(
                  height: size.width * 234,
                  width: size.width * 720,
                  margin: EdgeInsets.symmetric(horizontal: size.width * 18),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '*',
                            style: TextStyle(
                                color: Color(0xffDE2B2A),
                                fontSize: size.width * 28),
                          ),
                          Text(
                            '颁发日期',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          ),
                          // MyDateSelect(
                          //   title: 'grantDate',
                          //   purview: 'grantDate',
                          //   placeholder: '请选择颁发日期时间',
                          //   width: size.width * 518,
                          //   height: size.width * 88,
                          //   isShowIcon: 'false',
                          //   dateTime: 'true',
                          //   callback: (value) {
                          //     grantDate = value;
                          //   },
                          // ),
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDatePickerMode: DatePickerMode.day,
                                      initialDate: DateTime.now().toLocal(),
                                      firstDate: DateTime(
                                          DateTime.now().toLocal().year - 30),
                                      lastDate: DateTime(
                                          DateTime.now().toLocal().year + 30))
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    grantDate = value;
                                  });
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: size.width * 10),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 20),
                              width: size.width * 518,
                              height: size.width * 88,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: underColor, width: 1)),
                              child: Text(grantDate != null ? grantDate.toString().split(' ')[0] : '请选择颁发日期'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.width * 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.fixedType == 1 ? Text(
                            '*',
                            style: TextStyle(
                                color: Color(0xffDE2B2A),
                                fontSize: size.width * 28),
                          ) : Container(),
                          Text(
                            '到期日期',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold),
                          ),
                          // MyDateSelect(
                          //   title: 'expireDate',
                          //   purview: 'expireDate',
                          //   placeholder: '请选择到期日期时间',
                          //   width: size.width * 518,
                          //   height: size.width * 88,
                          //   isShowIcon: 'false',
                          //   dateTime: 'true',
                          //   callback: (value) {
                          //     expireDate = value;
                          //   },
                          // ),
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now().toLocal(),
                                      firstDate: DateTime(
                                          DateTime.now().toLocal().year - 30),
                                      lastDate: DateTime(
                                          DateTime.now().toLocal().year + 30))
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    // expireDate = value.toString().split(' ')[0];
                                    expireDate = value;
                                  });
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: size.width * 10),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 20),
                              width: size.width * 518,
                              height: size.width * 88,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: underColor, width: 1)),
                              child: Text(expireDate != null ? expireDate.toString().split(' ')[0] : '请选择到期日期'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
