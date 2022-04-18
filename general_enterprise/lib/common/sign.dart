// import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/waitState.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui show ImageByteFormat, Image;
import 'package:provider/provider.dart';

/// Created On 2020/5/27
/// Description: 签名画板并截图
///
class Sign extends StatefulWidget {
  Sign({@required this.arguments});
  final arguments;
  // arguments['index']  for  every call Sign img path;
  // type  mutipleSign name String , tableIndex
  // title is must be
  // purview is provide sumbitArr
  @override
  _SignState createState() =>
      _SignState(arguments['index'], arguments['title'], arguments['purview']);
}

class _SignState extends State<Sign> {
  _SignState(this.index, this.title, this.purview);
  final index, title, purview;

  /// 标记签名画板的Key，用于截图
  GlobalKey _globalKey;

  /// 已描绘的点
  List<Offset> _points = <Offset>[];

  /// 记录截图的本地保存路径
  // ignore: unused_field
  String _imageLocalPath;

  @override
  void initState() {
    super.initState();
    // Init
    _globalKey = GlobalKey();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    // _getContext();
  }

  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<Counter>(context);
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('签名板'),
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: placeHolder, width: 1)),
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: GestureDetector(
                      onPanUpdate: (details) => _addPoint(details),
                      onPanEnd: (details) => _points.add(null),
                      child: CustomPaint(painter: BoardPainter(_points)),
                    ),
                  ),
                )),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor)),
                      onPressed: () async {
                        setState(() {
                          _points?.clear();
                          _points = [];
                          _imageLocalPath = null;
                        });
                      },
                      child: Text(
                        '清除',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(child: Container()),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor)),
                      onPressed: () async {
                        if (_points.isEmpty) {
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp]);
                          Navigator.pop(context);
                        } else {
                          File toFile = await _saveImageToFile();
                          String toPath = await _capturePng(toFile);
                          // // note !!!
                          Future<dynamic> uploadImg() async {
                            final res = await Future.delayed(
                                Duration(seconds: 1), () async {
                              final res = await Dio().post(
                                Interface.uploadUrl,
                                data: FormData.fromMap({
                                  "file": await MultipartFile.fromFile(toPath)
                                }),
                              );
                              return res;
                            });
                            if (res.data['code'] == 200) {
                              if (index != null) {
                                _counter.changeSmallTicket(
                                  index,
                                  res.data['message'],
                                  type: widget.arguments['type'] != null
                                      ? widget.arguments['type'] +
                                          '|' +
                                          widget.arguments['tableIndex']
                                              .toString()
                                      : null,
                                );
                                _counter.changeSmallTicket(
                                    index,
                                    DateTime.now().toString().substring(0,
                                        DateTime.now().toString().length - 7),
                                    names: 'dateTimeValue');
                              } else {
                                _counter.changeSubmitDates(purview, {
                                  "title": title,
                                  "data":
                                      DateTime.now().toString().split(' ')[0],
                                  "value": res.data['message']
                                });
                              }

                              SystemChrome.setPreferredOrientations(
                                  [DeviceOrientation.portraitUp]);
                              if (widget.arguments['callback'] != null) {
                                widget.arguments['callback']();
                              }
                              Navigator.pop(context);
                            } else {
                              print('上传失败');
                            }
                            return res;
                          }

                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return NetLoadingDialog(
                                  requestCallBack: uploadImg(),
                                  outsideDismiss: false,
                                  loadingText: '等待网络上传',
                                );
                              });
                        }
                      },
                      child: Text(
                        '完成',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          return true;
        });
  }

  /// 添加点，注意不要超过Widget范围
  _addPoint(DragUpdateDetails details) {
    RenderBox referenceBox = _globalKey.currentContext.findRenderObject();
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    double maxW = referenceBox.size.width;
    double maxH = referenceBox.size.height;
    // 校验范围
    if (localPosition.dx <= 0 || localPosition.dy <= 0) return;
    if (localPosition.dx > maxW || localPosition.dy > maxH) return;
    setState(() {
      _points = List.from(_points)..add(localPosition);
    });
  }

  /// 选取保存文件的路径
  Future<File> _saveImageToFile() async {
    String name = PinyinHelper.getShortPinyin(title);
    Directory tempDir = await getTemporaryDirectory();
    String toFilePath = '${tempDir.path}/$name.png';
    File toFile = File(toFilePath);
    bool exists = await toFile.exists();
    if (!exists) {
      await toFile.create(recursive: true);
    }
    return toFile;
  }

  /// 截图，并且返回图片的缓存地址
  Future<String> _capturePng(File toFile) async {
    // 1. 获取 RenderRepaintBoundary
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    // 2. 生成 Image
    ui.Image image = await boundary.toImage();
    // 3. 生成 Uint8List
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    // 4. 本地存储Image
    toFile.writeAsBytes(pngBytes);
    return toFile.path;
  }
}

class BoardPainter extends CustomPainter {
  BoardPainter(this.points);
  final List<Offset> points;

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  bool shouldRepaint(BoardPainter other) => other.points != points;
}
