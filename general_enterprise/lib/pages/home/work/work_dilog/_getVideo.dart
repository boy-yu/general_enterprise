import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/waitState.dart';
// import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/pages/home/work/work_dilog/_videoPlay.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class WorkVideoType {
  String fileUrl, httpurl;
  WorkVideoType(this.fileUrl, {this.httpurl = ''});
}

class WorkVideo extends StatefulWidget {
  @override
  const WorkVideo({
    Key key,
    this.callbacks,
    this.isUpload = false,
    this.videoList,
    this.widget,
  }) : super(key: key);
  final Function(List<WorkVideoType>) callbacks; //上传完成回调
  final bool isUpload; //是否录像完成直接上传
  final List<WorkVideoType> videoList; //文件列表
  final Widget widget;
  _WorkVideoState createState() => _WorkVideoState();
}

class _WorkVideoState extends State<WorkVideo> {
  List<WorkVideoType> videoLists = [];
  List<WorkVideoType> data = [];
  Directory _directory;
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    getApplicationDocumentsDirectory().then((value) {
      _directory = value;
    });
    if (widget.videoList != null) {
      setState(() {
        videoLists = widget.videoList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double widths = size.width;
    return Container(
      padding: EdgeInsets.all(3),
      child: Column(
        children: [
          Wrap(
              spacing: 10.0, // 主轴(水平)方向间距
              runSpacing: 10.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.start,
              children: videoItem(widths)),
          widget.callbacks != null
              ? ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(themeColor)),
                  onPressed: () {
                    widget.callbacks(data);
                  },
                  child: Text('确定'),
                )
              : Container()
        ],
      ),
    );
  }

  videoItem(widths) {
    List<Widget> videoElement = [];
    if (videoLists is List && videoLists.length > 0) {
      videoLists.asMap().keys.forEach((element) {
        videoElement.add(Container(
          height: (widths / 4) * size.width,
          width: (widths / 4) * size.width,
          child: Stack(
            children: [
              Container(
                child: VideoPlay(
                  videoUrl: videoLists[element].fileUrl,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                    onTap: () async {
                      data = jsonDecode(jsonEncode(videoLists));
                      File file = File(data[element].fileUrl);
                      if (await file.exists()) {
                        await file.delete();
                      }
                      data.removeAt(element);
                      setState(() {
                        videoLists = data;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    )),
              )
            ],
          ),
        ));
      });
      videoElement.add(addVideo(widths));
    } else {
      videoElement.add(addVideo(widths));
    }
    return videoElement;
  }

  //添加
  addVideo(widths) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xfff3f3f3), width: 1)),
        child: Icon(
          Icons.add,
          color: Color(0xff000000),
          size: (widths / 4) * size.width,
        ),
      ),
      onTap: () async {
        // final video = await ImagePicker.pickImage(source: ImageSource.camera);
        // final video = await ImagePicker().getVideo(source: ImageSource.camera);
        if (_directory == null) {
          Fluttertoast.showToast(msg: '相机错误');
          return;
        }
        showDialog(
          context: context,
          builder: (context) => MyVideo(
            path: _directory.path,
            callback: _getPath,
          ),
        );
      },
    );
  }

  _getPath(String path) {
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

  Future<dynamic> uploadImg(path) async {
    final res = await Future.delayed(Duration(seconds: 1), () async {
      final _res = await Dio().post(
        Interface.uploadUrl,
        data: FormData.fromMap({"file": await MultipartFile.fromFile(path)}),
      );
      return _res;
    });
    if (res.data['code'] == 200) {
      // List _tempData = jsonDecode(jsonEncode(videoLists ?? []));
      data.add(WorkVideoType(path, httpurl: res.data["message"]));
      if (widget.videoList is List) {
        widget.videoList.removeRange(0, widget.videoList.length);
        data.forEach((element) {
          widget.videoList.add(WorkVideoType(element.httpurl));
        });
        setState(() {
          videoLists = widget.videoList;
        });
      } else {
        setState(() {
          videoLists = data;
        });
      }
    } else {
      Interface().error({'message': "上传失败"}, context);
    }
  }
}

class MyVideo extends StatefulWidget {
  MyVideo({@required this.path, @required this.callback});
  final String path;
  final HiddenSpecificItemCallBackFunc callback;
  @override
  _MyVideoState createState() => _MyVideoState();
}

class _MyVideoState extends State<MyVideo> {
  CameraController _cameraController;
  bool showCamer = false, kinesscope = false;
  List<CameraDescription> cameras;
  int axisCamer = -1; //default 0 = back
  VideoPlayerController _videoPlayerController;
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
    // await _cameraController.dispose();
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
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size currenWindow = MediaQuery.of(context).size;
    return Scaffold(
      body: showCamer
          ? Stack(
              children: [
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
                          onPressed: () async {
                            String tempPath = widget.path +
                                '/' +
                                DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString() +
                                '.mp4';

                            if (!kinesscope) {
                              await _cameraController
                                  .prepareForVideoRecording();
                              await _cameraController
                                  .startVideoRecording(tempPath);
                              path = File(tempPath);
                              kinesscope = true;
                              if (mounted) {
                                setState(() {});
                              }
                            } else {
                              await _cameraController.stopVideoRecording();
                              kinesscope = false;
                              showCamer = false;
                              _videoPlayerController =
                                  VideoPlayerController.file(path);
                              _videoPlayerController.initialize();
                              _videoPlayerController.play();
                              if (mounted) {
                                setState(() {});
                              }
                            }
                          },
                          child: kinesscope ? Icon(Icons.pause) : Container(),
                        ),
                        InkWell(
                          onTap: () {
                            _changeCamer();
                          },
                          child: Icon(
                            Icons.all_inclusive,
                            color: Colors.white.withOpacity(.5),
                            size: size.width * 60,
                          ),
                        ),
                      ],
                    ))
              ],
            )
          : Stack(
              children: [
                path != null
                    ? Container(
                        width: currenWindow.width,
                        height: currenWindow.height,
                        child: VideoPlayer(_videoPlayerController),
                      )
                    : Container(),
                path != null
                    ? Positioned(
                        width: currenWindow.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                Navigator.pop(context);
                                widget.callback(path.path);
                              },
                              child: Icon(
                                Icons.done,
                                color: themeColor,
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () async {
                                await path.delete();
                                setState(() {
                                  path = null;
                                  showCamer = true;
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ))
                    : Container(),
              ],
            ),
    );
  }
}
