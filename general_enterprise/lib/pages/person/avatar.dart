import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonAvatar extends StatefulWidget {
  PersonAvatar({this.arguments});
  final arguments;
  @override
  _PersonAvatarState createState() => _PersonAvatarState();
}

class _PersonAvatarState extends State<PersonAvatar> {
  File _image;
  final picker = ImagePicker();
  SharedPreferences prefs;
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

  _initMsg() async {
    prefs = await SharedPreferences.getInstance();
    _photoUrl = prefs.getString('photoUrl');
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
      prefs = await SharedPreferences.getInstance();
      _photoUrl = res.data['data']['url'];
      myDio.request(
          type: 'put',
          url: Interface.amendAvatar,
          data: {"photoUrl": _photoUrl}).then((value) {
        prefs.setString('photoUrl', _photoUrl);
        successToast('修改成功');
        if (mounted) {
          setState(() {});
        }
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
        child: _photoUrl != null
            ? Container(
                height: width,
                width: width,
                child: Image.network(
                  _photoUrl,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                child: Text(
                  '头像获取中。。。',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
