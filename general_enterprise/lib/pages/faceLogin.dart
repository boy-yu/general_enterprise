import 'package:enterprise/common/loding.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/translate.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';

class FaceLogin extends StatefulWidget {
  @override
  _FaceLoginState createState() => _FaceLoginState();
}

MethodChannel _channel = MethodChannel('messagePushChannel');

_getUrl() {
  myDio.request(
      type: 'get',
      url: Interface.webUrl,
      queryParameters: {"url": Interface.mainBaseUrl}).then((value) {
    if (value is Map) {
      myprefs.setString('webUrl', value['ticketUrl'] ?? '');
      webUrl = value['ticketUrl'] ?? '';
      myprefs.setString('fileUrl', value['fileViewPath'] ?? '');
      fileUrl = value['fileViewPath'] ?? '';
    }
  });
}

class _FaceLoginState extends State<FaceLogin> {
  CameraController controller;
  List<CameraDescription> cameras;

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void _camera() async{
    cameras = await availableCameras();
    if(cameras != null){
      controller = CameraController(cameras[1], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _camera();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('人脸登录'),
      child: cameras==null
      ? Container(
        child: Center(child: Text("加載中..."),),
      )
      : Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            _cameraWidget(),
          ],
        ),
      ),
    );
  }

  bool isShow = false;

  Widget _cameraWidget(){
    return Expanded(
      flex: 1,
      child: Stack(
        children: <Widget>[
          _cameraPreviewWidget(),
          _cameraScan(),
          isShow ? Container(
              color: Color(0xffcccccc).withOpacity(0.5),
              child: Center(
                child: SizedBox(
                  height: size.width * 300,
                  width: size.width * 300,
                  child: StaticLoding(),
                ),
              ),
            ) : Container()
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget(){
    return Container(
      width:double.infinity,
      height: double.infinity,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
    );
  }

  Widget _cameraScan(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage("assets/images/lvru@2x.png"),
          fit: BoxFit.cover
        ),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(bottom: size.width * 80),
        child: GestureDetector(
          onTap: onTakePictureButtonPressed,
          child: Container(
            height: size.width * 88,
            width: size.width * 532,
            decoration: BoxDecoration(
              color: Color(0xff4481FE),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 44)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff4481FE).withOpacity(0.47),
                  blurRadius: 1.0,
                  spreadRadius: 1.0
                ),
              ]
            ),
            alignment: Alignment.center,
            child: Text(
              '登 录',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 40,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onTakePictureButtonPressed() {
    isShow = true;
    setState(() {});
    takePicture().then((String filePath) {
      if (mounted) {
        if (filePath != null){
          // Navigator.of(context).pop(filePath);
          image2Base64(filePath).then((data){
            String imageBase64 = data;
            createFileFromString(imageBase64).then((value) async {
              // 上传文件
              final res = await Future.delayed(Duration(seconds: 1), () async {
                final res = await Dio().post(
                  Interface.uploadUrlTwo,
                  data: FormData.fromMap({"file": await MultipartFile.fromFile(value)}),
                );
                return res;
              });
              if (res.data['code'] == 200) {
                print(res.data['message']);
                // 人脸登录
                myDio.request(
                  type: 'post',
                  url: Interface.faceLogin,
                  data: {
                    "url": res.data['message'],
                  }).then((value) async {
                    if (value is Map) {
                      String token = value['token'];
                      await myprefs.setString('token', token ?? '');
                      await myprefs.setString('username', value['userName'] ?? '');
                      await myprefs.setString('department', value['department'] ?? '');
                      await myprefs.setString('account', value['account'] ?? '');
                      await myprefs.setString('sign', value['sign'] ?? '');
                      await myprefs.setString(
                          'enterpriseName', value['enterpriseName'] ?? '');
                      await myprefs.setInt('userId', value['userId'] ?? -1);
                      // 安全教育培训
                      await myprefs.setInt('isEducationInitiate', value['isEducationInitiate'] ?? -1);
                      // 个人信息新加字段
                      await myprefs.setString('telephone', value['telephone'] ?? ''); // 手机号
                      await myprefs.setString('identityNum', value['identityNum'] ?? ''); //  身份证号
                      await myprefs.setString('type', value['type'] ?? ''); //  人员类别
                      await myprefs.setString('education', value['education'] ?? ''); //  学历
                      await myprefs.setString('specialty', value['specialty'] ?? ''); //  专业

                      if (value['photoUrl'] == '') {
                        await myprefs.setString('photoUrl',
                            'https://shuangkong.oss-cn-qingdao.aliyuncs.com/temp/1605250244862/u%3D1763186968%2C2658905759%26fm%3D26%26gp%3D0.jpg');
                      } else {
                        await myprefs.setString('photoUrl', value['photoUrl'] ?? '');
                      }
                      isLogin = false;
                      isShow = false;
                      Navigator.pop(context, '登录成功');
                      myDio.request(
                          type: 'put',
                          url: Interface.putAmendChatStatus,
                          data: {"onlineStatus": "1"});
                      if (Contexts.mobile) {
                        _channel.invokeMethod('login', myprefs.getString('account'));
                        Future.delayed(Duration(seconds: 5), () {
                          initPlatformState(value['account'], true);
                        });
                      }
                      _getUrl();
                      mytranslate = Translate();
                      mytranslate.init();

                      if (value['sign'] == '' || value['sign'] == null && Contexts.mobile) {
                        Fluttertoast.showToast(msg: '检测到您的账号暂时未进行签字，请先设置签名');
                        Navigator.pushNamed(context, '/person/sign');
                      }

                      if (Contexts.mobile) {
                        Future.delayed(Duration(seconds: 1), () {
                          if (myprefs.getString("SavedenterpriseName") !=
                              myprefs.getString('enterpriseName')) {
                            PeopleStructure.getNetpeople(delete: true);
                          }
                        });
                      }
                    }
                  }).catchError((onError) {
                    print(onError);
                    isShow = false;
                    setState(() {});
                  });
              } else {
                Interface().error({'message': "登录失败"}, context);
              }
            });
          });
        }
      }
    });
  }

    /*
   * 将Base64字符串转换为图片路径
   */
  static Future<String> createFileFromString(String base64Str) async {
    Uint8List bytes = base64.decode(base64Str);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  /*
   * 通过图片路径将图片转换成Base64字符串
   */
  static Future image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }


  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print("出现异常$e");
      return null;
    }
    return filePath;
  }
}