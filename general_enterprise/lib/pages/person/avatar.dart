import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class PersonAvatar extends StatefulWidget {
  PersonAvatar({this.arguments});
  final arguments;
  @override
  _PersonAvatarState createState() => _PersonAvatarState();
}

class _PersonAvatarState extends State<PersonAvatar> {
  File _image;
  final picker = ImagePicker();
  String _photoUrl;

  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImg(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImg(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initMsg();
  }

  _initMsg() {
    _photoUrl = myprefs.getString('avatar');
    if (mounted) {
      setState(() {});
    }
  }

  Future<dynamic> uploadImg(String path) async {
    Fluttertoast.showToast(msg: '头像上传中请稍后。。。');
    final res = await Future.delayed(Duration(seconds: 1), () async {
      final res = await Dio().post(
        Interface.uploadUrl,
        data: FormData.fromMap({"file": await MultipartFile.fromFile(path)}),
      );
      return res;
    });
    if (res.data['code'] == 200) {
      _photoUrl = res.data['data']['url'];
      myDio.request(type: 'put', url: Interface.putUpdateUser, data: {
        "avatar": _photoUrl,
        "description": myprefs.getString('description'),
        "email": myprefs.getString('email'),
        "mobile": myprefs.getString('mobile'),
        "nickname": myprefs.getString('nickname'),
        "sex": myprefs.getInt('sex'),
        "sign": myprefs.getString('sign'),
      }).then((value) async {
        await myprefs.setString('avatar', _photoUrl);
        successToast('修改成功');
        setState(() {});
      });
    } else {
      Interface().error({'message': "上传失败"}, context);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(_photoUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text('头像'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (String value) {
                switch (value) {
                  case '拍照':
                    getCameraImage();
                    break;
                  case "相册":
                    getGalleryImage();
                    break;
                  default:
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    PopupMenuItem(
                        value: '拍照',
                        child: Row(
                          children: [
                            Icon(
                              Icons.photo_camera,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Text('拍照')
                          ],
                        )),
                    PopupMenuItem(
                        value: "相册",
                        child: Row(
                          children: [
                            Icon(
                              Icons.photo_library,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Text('从相册中选择')
                          ],
                        ))
                  ])
        ],
      ),
      body: Container(
          height: height,
          width: width,
          color: Colors.black,
          alignment: Alignment.center,
          child: _photoUrl != '' && _photoUrl != null
              ? Container(
                  height: width,
                  width: width,
                  child: Image.network(
                    _photoUrl.toString().indexOf('http:') > -1
                        ? _photoUrl
                        : Interface.fileUrl + _photoUrl,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: width,
                  width: width,
                  child: Image.asset(
                    'assets/images/doubleRiskProjeck/image_avatar_default.png',
                    fit: BoxFit.cover,
                  ),
                )),
    );
  }
}
