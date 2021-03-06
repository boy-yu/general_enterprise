import 'dart:io';
import 'package:dio/dio.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/waitState.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';

// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'dart:typed_data';
class NewMyImageCarma extends StatefulWidget {
  NewMyImageCarma(
      {this.title,
      this.name,
      this.memo = '',
      this.index,
      this.type,
      this.placeHolder,
      this.score = 4,
      @required this.callback});
  final String title, name, type, placeHolder, memo;
  final List index;
  final int score;
  final Function(List list) callback;
  @override
  _NewMyImageCarmaState createState() => _NewMyImageCarmaState();
}

class _NewMyImageCarmaState extends State<NewMyImageCarma> {
  // File _image;
  // final picker = ImagePicker();
  Directory _directory;
  List images = [0];
  List submitImage = [];
  Future getImage() async {
    if (_directory == null) {
      Fluttertoast.showToast(msg: '相机错误');
      return;
    }
    showDialog(
      context: context,
      builder: (context) => MyCamer(
        path: _directory.path,
        callback: _getPath,
      ),
    );
  }

  _getPath(String path) {
    setState(() {
      images.add(File(path));
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return NetLoadingDialog(
            requestCallBack: uploadImg(path),
            outsideDismiss: false,
            loadingText: '等待网络上传',
          );
        });
  }

  Future<dynamic> uploadImg(String path) async {
    final res = await Future.delayed(Duration(seconds: 1), () async {
      final res = await Dio().post(
        Interface.uploadUrl,
        data: FormData.fromMap({"file": await MultipartFile.fromFile(path)}),
      );
      return res;
    });
    if (res.data['code'] == 200) {
      submitImage.add(res.data['message']);
      widget.callback(submitImage);
      if (mounted) {
        setState(() {});
      }
    } else {
      Interface().error({'message': "上传失败"}, context);
    }
    return res;
  }

  _generateDate(index) {
    List<Widget> data = [];
    for (var i = index * widget.score; i < (index + 1) * widget.score; i++) {
      // print(images);
      if (i >= images.length) return data;
      data.add(Stack(
        children: [
          images[i] == 0
              ? InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: textBgColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.add,
                      size: size.width * 100,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(size.width * 30),
                  ),
                )
              : ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(size.width * 20),
                            child: Image.file(
                              images[i],
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.black.withOpacity(.01))),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  child: images[i].toString() == '' ||
                          images[i].toString() == null
                      ? Container(
                          child: Image.network(
                            images[i].toString().indexOf('http:') > -1
                                ? images[i]
                                : Interface.fileUrl + images[i],
                            width: size.width * 150,
                            height: size.width * 150,
                            fit: BoxFit.fill,
                          ),
                          margin: EdgeInsets.all(size.width * 10),
                        )
                      : Container(
                          child: images[i] != ''
                              ? Image.file(
                                  images[i],
                                  width: size.width * 140,
                                  height: size.width * 140,
                                  fit: BoxFit.fill,
                                )
                              : Container(),
                          margin:
                              EdgeInsets.symmetric(vertical: size.width * 10),
                        ),
                ),
          images[i] == 0
              ? Container()
              : Positioned(
                  right: -size.width * 12,
                  top: -size.width * 12,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        images.removeAt(i);
                        submitImage.removeAt(i - 1);
                        widget.callback(submitImage);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 10),
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                    ),
                  ))
        ],
      ));
    }
    return data;
  }

  _generate(x) {
    return Row(
      children: _generateDate(x),
    );
  }

  culumn() {
    List<Widget> tiles = [];
    for (int x = 0; x < images.length / widget.score; x++) {
      tiles.add(Row(
        children: <Widget>[_generate(x)],
      ));
    }
    return tiles;
  }

  _init() {
    getApplicationDocumentsDirectory().then((value) {
      _directory = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
    if (widget.placeHolder != null && widget.placeHolder != '') {
      widget.placeHolder.split('|').forEach((element) {
        images.add(element);
        submitImage.add(element);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: size.width * 20),
            height: (images.length / widget.score).ceil() * size.width * 240.0,
            color: Colors.white,
            child: Column(
              children: culumn(),
            ),
          )
        ],
      ),
    );
  }
}

class MyCamer extends StatefulWidget {
  MyCamer({@required this.path, @required this.callback});
  final String path;
  final HiddenSpecificItemCallBackFunc callback;
  @override
  _MyCamerState createState() => _MyCamerState();
}

class _MyCamerState extends State<MyCamer> {
  CameraController _cameraController;
  bool showCamer = false;
  List<CameraDescription> cameras;
  int axisCamer = -1; //default 0 = back
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) axisCamer = 0;
    _cameraController =
        CameraController(cameras[axisCamer], ResolutionPreset.high);
    _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      showCamer = true;
      if (mounted) {
        setState(() {});
      }
    });
  }

  _changeCamer() async {
    if (axisCamer + 1 == cameras.length)
      axisCamer = 0;
    else {
      axisCamer++;
    }
    await _cameraController.dispose();
    _cameraController =
        CameraController(cameras[axisCamer], ResolutionPreset.high);
    _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  File path;
  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size currenWindow = MediaQuery.of(context).size;
    return Scaffold(
        body: showCamer
            ? Stack(children: [
                CameraPreview(_cameraController),
                Positioned(
                    width: currenWindow.width,
                    bottom: 20,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    CircleBorder(side: BorderSide.none)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.white.withOpacity(.5))),
                            child: Container(),
                            onPressed: () async {
                              String tempPath = widget.path +
                                  '/' +
                                  DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString() +
                                  '.png';
                              _cameraController
                                  .takePicture(tempPath)
                                  .then((value) {
                                path = File(tempPath);
                                showCamer = false;
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                            },
                          ),
                          InkWell(
                            onTap: () {
                              _changeCamer();
                            },
                            child: Icon(Icons.all_inclusive,
                                color: Colors.white.withOpacity(.5),
                                size: size.width * 60),
                          )
                        ]))
              ])
            : Stack(children: [
                path != null
                    ? Container(
                        width: currenWindow.width,
                        height: currenWindow.height,
                        child: Image.file(path, fit: BoxFit.fill))
                    : Container(),
                path != null
                    ? Positioned(
                        width: currenWindow.width,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  widget.callback(path.path);
                                },
                                child: Icon(Icons.done, color: themeColor),
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  onPressed: () async {
                                    await path.delete();
                                    setState(() {
                                      path = null;
                                      showCamer = true;
                                    });
                                  },
                                  child: Icon(Icons.close, color: Colors.red))
                            ]))
                    : Container()
              ]));
  }
}
