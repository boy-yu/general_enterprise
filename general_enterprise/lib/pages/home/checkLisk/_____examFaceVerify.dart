import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:enterprise/common/loding.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ExamFaceVerify extends StatefulWidget {
  ExamFaceVerify({this.id, this.title, this.duration, this.stage, this.type, this.isHave, this.passLine});
  final int id;
  final String title;
  final int duration, stage, type, passLine;
  final bool isHave;
  @override
  _ExamFaceVerifyState createState() => _ExamFaceVerifyState();
}

class _ExamFaceVerifyState extends State<ExamFaceVerify> {
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
      title: widget.isHave != null ? Text(widget.isHave ? '人脸验证' : '人脸录入') : Text(''),
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
        margin: EdgeInsets.only(bottom: size.width * 50),
        child: GestureDetector(
          onTap: onTakePictureButtonPressed,
          child: Icon(
            Icons.camera_alt,
            color: Color(0xff999999),
            size: size.width * 100
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
        if (filePath != null) {
          // Navigator.of(context).pop(filePath);
          image2Base64(filePath).then((data) {
            String imageBase64 = data;
            createFileFromString(imageBase64).then((value) async {
              // 上传文件
              final res = await Future.delayed(Duration(seconds: 1), () async {
                final res = await Dio().post(
                  Interface.uploadUrlTwo,
                  data: FormData.fromMap(
                      {"file": await MultipartFile.fromFile(value)}),
                );
                return res;
              });
              if (res.data['code'] == 200) {
                if (widget.isHave) {
                  // 人脸验证
                  myDio.request(type: 'post', url: Interface.faceLogin, data: {
                    "url": res.data['message'],
                  }).then((value) async {
                    // 验证成功
                    int userId = myprefs.getInt('userId');
                    if(value['userId'] == userId){
                      controller?.dispose();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/home/education/mokExam",
                        arguments: {
                          "id": widget.id,
                          "formalExam": true,
                          'title': widget.title,
                          'duration': widget.duration,
                          'stage': widget.stage,
                          'type': widget.type,
                          'passLine': widget.passLine
                        });
                        
                        isShow = false;
                    setState(() {});
                      
                      // Navigator.pushNamedAndRemoveUntil(context, "/home/education/mokExam", (route) => route == null, arguments: {
                      //     "id": widget.id,
                      //     "formalExam": true,
                      //     'title': widget.title,
                      //     'duration': widget.duration,
                      //     'stage': widget.stage
                      //   });
                    }else{
                      Fluttertoast.showToast(msg: '您不是当前账号绑定人脸，无法参加考试');
                      isShow = false;
                      setState(() {});
                    }
                  }).catchError((onError) {
                    print(onError);
                    isShow = false;
                    setState(() {});
                  });
                } else {
                  // 人脸录入
                  // 录制人脸数据
                  myDio.request(
                    type: 'post',
                    url: Interface.addFaceRecognition,
                    data: {
                      "url": res.data['message'],
                    }).then((value) {
                      successToast('录入成功');
                      controller?.dispose();
                      Navigator.pop(context);
                    // 录入成功
                    Navigator.pushNamed(context, "/home/education/mokExam",
                        arguments: {
                          "id": widget.id,
                          "formalExam": true,
                          'title': widget.title,
                          'duration': widget.duration,
                          'stage': widget.stage,
                          'type': widget.type,
                          'passLine': widget.passLine
                        });
                      
                      isShow = false;
                      setState(() {});
                    }).catchError((onError) {
                      print(onError);
                      isShow = false;
                      setState(() {});
                    });
                  // myDio.request(
                  //     type: 'post',
                  //     url: Interface.addFaceRecognition,
                  //     data: {
                  //       "url": res.data['message'],
                  //     }).then((value) async {
                  //       Navigator.pop(context);
                  //   // 录入成功
                  //   Navigator.pushNamed(context, "/home/education/mokExam",
                  //       arguments: {
                  //         "id": widget.id,
                  //         "formalExam": true,
                  //         'title': widget.title,
                  //         'duration': widget.duration,
                  //         'stage': widget.stage,
                  //         'type': widget.type
                  //       });
  
                        
                  //   isShow = false;
                  //   setState(() {});
                    
                  //   // Navigator.pushNamedAndRemoveUntil(context, "/home/education/mokExam", (route) => null, arguments: {
                  //   //       "id": widget.id,
                  //   //       "formalExam": true,
                  //   //       'title': widget.title,
                  //   //       'duration': widget.duration,
                  //   //       'stage': widget.stage
                  //   //     });
                  //   // print(value);
                  //   // Navigator.pop(myContext);
                  // }).catchError((onError) {
                  //   print(onError);
                  //   isShow = false;
                  //   setState(() {});
                  // });
                }
              } else {
                Interface().error({'message': "网络连接失败"}, context);
                isShow = false;
                setState(() {});
              }
            });
            // String image = createFileFromString(imageBase64);
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
