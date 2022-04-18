import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/education/exam/db_examCache.dart';
import 'package:enterprise/pages/home/education/exam/sumbit.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class MokExam extends StatefulWidget {
  final bool isExam;
  final List<ExamCacheType> data;
  final int id;
  final bool formalExam;
  final String title;
  final int duration, stage, type, passLine;
  final Map submitStudyRecords;
  const MokExam(
      {Key key,
      this.isExam = true,
      this.data,
      @required this.id,
      this.formalExam = false,
      this.title,
      this.duration,
      this.submitStudyRecords,
      this.stage,
      this.type,
      this.passLine})
      : super(key: key);
  @override
  _MokExamState createState() => _MokExamState();
}

Color commonColor = Color(0xff295FF7);

class _MokExamState extends State<MokExam> {
  Duration _duration;
  bool show = false;
  bool _start = false;
  bool _isExam = true;
  List<ExamCacheType> data = [];
  PageController _pageController = PageController();
  ThrowFunc _throwFunc = ThrowFunc();
  int grade = 0;
  DateTime _lastPressedAt;
  CameraController controller;
  List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    if (!widget.formalExam) {
      _init();
    } else {
      _duration = Duration(minutes: widget.duration);
      _formalExamInit();
      // 下个版本的过程人脸验证
      // _camera();
    }
  }

  _formalExamInit() {
    myDio.request(
        type: 'get',
        url: Interface.getLibraryListByid,
        queryParameters: {"id": widget.id}).then((value) {
      if (value is List) {
        data = ExamCacheType.assgin(value);
        setState(() {
          show = true;
          _isExam = widget.isExam ?? true;
        });
      }
    });
  }

  _init() {
    ExamCache().getAlreadyQuestion(widget.id).then((value) {
      setState(() {
        data = value;
        show = true;
        _isExam = widget.isExam ?? true;
      });
    });
  }

  _dumpPage(bool next, int index, List anwser) {
    if (next) {
      data[index].sumbit = anwser;
      if (_pageController.page == data.length - 1) {
        if (!_isExam) {
          successToast("已无更多题目");
          return;
        }
        WorkDialog.myDialog(context, () {}, 2,
            widget: Column(
              children: [
                Text('是否提交您的答案'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('取消')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (widget.formalExam) {
                            controller?.dispose();
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, "/home/education/ExamResult",
                                arguments: {
                                  "data": data,
                                  "formalExam": widget.formalExam,
                                  "id": widget.id,
                                  'submitStudyRecords':
                                      widget.submitStudyRecords,
                                  'stage': widget.stage,
                                  'type': widget.type
                                }).then((value) {
                              if (value is Map) {
                                if (mounted) {
                                  setState(() {
                                    _isExam = false;
                                    grade = value['grade'] ?? 0;
                                    _pageController.jumpToPage(
                                      value['index'],
                                    );
                                  });
                                }
                              } else {
                                if (mounted) {
                                  setState(() {
                                    _isExam = value ?? true;
                                  });
                                }
                              }
                            });
                          } else {
                            myDio.request(
                              type: 'get', 
                              url: Interface.getPicQuestionList
                            ).then((value) {
                              if(value is List){
                                List picQuestionData = value;
                                if(picQuestionData.isNotEmpty){
                                  Navigator.pushNamed(
                                    context, "/home/education/examSpotPic",
                                    arguments: {
                                      "data": data,
                                      "formalExam": widget.formalExam,
                                      "id": widget.id,
                                      'submitStudyRecords':
                                          widget.submitStudyRecords,
                                      'stage': widget.stage,
                                      'type': widget.type,
                                      'picQuestionData': picQuestionData
                                    }).then((value) {
                                    if (value is Map) {
                                      if (mounted) {
                                        setState(() {
                                          _isExam = false;
                                          grade = value['grade'] ?? 0;
                                          _pageController.jumpToPage(
                                            value['index'],
                                          );
                                        });
                                      }
                                    } else {
                                      if (mounted) {
                                        setState(() {
                                          _isExam = value ?? true;
                                        });
                                      }
                                    }
                                  });
                                }else{
                                  Navigator.pushNamed(
                                    context, "/home/education/ExamResult",
                                    arguments: {
                                      "data": data,
                                      "formalExam": widget.formalExam,
                                      "id": widget.id,
                                      'submitStudyRecords':
                                          widget.submitStudyRecords,
                                      'stage': widget.stage,
                                      'type': widget.type,
                                      'isPicList': 2
                                    }).then((value) {
                                      if(value is Map){
                                        if (mounted) {
                                          setState(() {
                                            _isExam = false;
                                            grade = value['grade'] ?? 0;
                                            _pageController.jumpToPage(
                                              value['index'],
                                            );
                                          });
                                        }
                                      }
                                    });
                                }
                              }
                            });
                          }
                        },
                        child: Text('确定')),
                  ],
                )
              ],
            ));
      } else {
        _pageController.animateToPage(_pageController.page.toInt() + 1,
            duration: Duration(milliseconds: 400), curve: Curves.linear);
        _throwFunc.run(argument: {"page": _pageController.page.toInt() + 1});
      }
    } else {
      if (_pageController.page == 0) {
        successToast("当前已经是第一题");
      } else {
        _pageController.animateToPage(_pageController.page.toInt() - 1,
            duration: Duration(milliseconds: 400), curve: Curves.linear);
        _throwFunc.run(argument: {"page": _pageController.page.toInt() - 1});
      }
    }
  }
  // 下个版本的过程人脸
  // void _camera() async{
  //   cameras = await availableCameras();
  //   if(cameras != null){
  //     controller = CameraController(cameras[1], ResolutionPreset.medium);
  //     controller.initialize().then((_) {
  //       if (!mounted) {
  //         return;
  //       }
  //       setState(() {});
  //     });
  //   }
  // }
  
  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return _start || !_isExam
        ? WillPopScope(
            child: MyAppbar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                        child: Text(widget.formalExam ? '考试' : "模拟考试"),
                        margin: EdgeInsets.only(
                          right: size.width * 80,
                        )),
                    _isExam
                        ? _start && _duration != null
                            ? TimeCount(_duration, () {
                                // print(_duration);
                                Navigator.pop(context);
                                if (widget.formalExam) {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, "/home/education/ExamResult",
                                      arguments: {
                                        "data": data,
                                        "formalExam": widget.formalExam,
                                        "id": widget.id,
                                        'submitStudyRecords':
                                            widget.submitStudyRecords,
                                        'stage': widget.stage,
                                        'type': widget.type
                                      }).then((value) {
                                    if (value is Map) {
                                      if (mounted) {
                                        setState(() {
                                          _isExam = false;
                                          grade = value['grade'] ?? 0;
                                          _pageController.jumpToPage(
                                            value['index'],
                                          );
                                        });
                                      }
                                    } else {
                                      if (mounted) {
                                        setState(() {
                                          _isExam = value ?? true;
                                        });
                                      }
                                    }
                                  });
                                } else {
                                  Navigator.pushNamed(
                                      context, "/home/education/examSpotPic",
                                      arguments: {
                                        "data": data,
                                        "formalExam": widget.formalExam,
                                        "id": widget.id,
                                        'submitStudyRecords':
                                            widget.submitStudyRecords,
                                        'stage': widget.stage,
                                        'type': widget.type
                                      }).then((value) {
                                    if (value is Map) {
                                      if (mounted) {
                                        setState(() {
                                          _isExam = false;
                                          grade = value['grade'] ?? 0;
                                          _pageController.jumpToPage(
                                            value['index'],
                                          );
                                        });
                                      }
                                    } else {
                                      if (mounted) {
                                        setState(() {
                                          _isExam = value ?? true;
                                        });
                                      }
                                    }
                                  });
                                }
                              })
                            : Container()
                        : IconButton(
                            icon: Icon(Icons.view_comfy),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => ModelBox(
                                  data: data,
                                  grade: grade,
                                  formalExam: true,
                                  callback: (e, index) {
                                    _pageController.jumpToPage(index);
                                  },
                                ),
                              );
                            }),
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                      children: [
                        ExamIndex(_throwFunc, data.length, _isExam),
                        Expanded(
                          child: PageView.builder(
                            itemCount: data.length,
                            controller: _pageController,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) => 
                              ExamPage(
                                data[index],
                                (bool page, List anwser) {
                                  _dumpPage(page, index, anwser);
                                },
                                isExam: _isExam,
                                formalExam: widget.formalExam,
                              ),
                          )
                        )
                      ],
                    ),
                    ),
                    // 下个版本的过程人脸验证
                    // widget.formalExam ? Positioned(
                    //   right: size.width * 10,
                    //   top: size.width * 10,
                    //   child: Container(
                    //     height: size.width * 180,
                    //     width: size.width * 150,
                    //     child: cameras == null
                    //     ? Container(
                    //       child: Center(child: Text("加載中..."),),
                    //     )
                    //     : Expanded(
                    //       child: AspectRatio(
                    //         aspectRatio: controller.value.aspectRatio,
                    //         child: CameraPreview(controller),
                    //       ),
                    //     )
                    //   ),
                    // ) : Container(),
                    Positioned(
                          top: size.width * 45,
                          left: size.width * 200,
                          child: Container(
                            width: size.width * 341,
                            height: size.width * 70,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 35),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/title_bg_textbook_ewg.png'),
                                  fit: BoxFit.cover),
                            ),
                            child: Text(
                              widget.title.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.title.toString().length > 8
                                    ? size.width * 22
                                    : size.width * 28,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                          )),
                  ],
                )
              ),
            onWillPop: () async {
              if (!_isExam) return true;
              if (Contexts.mobile) {
                if (_lastPressedAt == null ||
                    DateTime.now().difference(_lastPressedAt) >
                        Duration(seconds: 1)) {
                  _lastPressedAt = DateTime.now();
                  successToast("再次点击，退出考试");
                  return false;
                } else {
                  return true;
                }
              }
              return true;
            })
        : MyAppbar(
            title: Text(widget.formalExam ? '考试' : "模拟考试"),
            child: Container(
              color: Colors.white,
              child: Transtion(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 30,
                            vertical: size.width * 40),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 30,
                            vertical: size.width * 40),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.formalExam ? RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xff404040)),
                                  children: [
                                    TextSpan(
                                        text: '考试时间：',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: '${widget.duration}分钟',
                                    ),
                                  ]),
                            ) : Container(),
                            widget.formalExam ? SizedBox(
                              height: size.width * 21,
                            ) : Container(),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xff404040)),
                                  children: [
                                    TextSpan(
                                        text: '考题数量：',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: data.length.toString(),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 21,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xff404040)),
                                  children: [
                                    TextSpan(
                                        text: '合格标准：',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: widget.formalExam ? '${widget.passLine}分及格（满分100分）' : '80分及格（满分100分）',
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: size.width * 21,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '计分规则：',
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xff404040),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '单选题2分/题\n多选题4分/题\n判断题2分/题\n填空题4分/题\n问答题8分/题。',
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xff404040),
                                      height: size.width * 3.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 21,
                            ),
                            Text(
                              '提示：多选题选择一个正确答案得1分，选有错误答案不得分。（在模拟考试中，问答题无需作答，默认正确）',
                              style: TextStyle(
                                  color: Color(0xffFF6666),
                                  fontSize: size.width * 24),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (data.length != 0) {
                              _start = true;
                            }
                          });
                        },
                        child: Container(
                          height: size.width * 96,
                          width: size.width * 631,
                          decoration: BoxDecoration(
                              color: data.length == 0
                                  ? Color(0xffcacaca)
                                  : Color(0xff295FF7),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 48))),
                          alignment: Alignment.center,
                          child: Text(
                            data.length == 0 ? '暂无考试' : '开始考试',
                            style: TextStyle(
                                color: Colors.white, fontSize: size.width * 30),
                          ),
                        ),
                      )
                    ],
                  ),
                  show),
            ));
  }
}

class ExamIndex extends StatefulWidget {
  final ThrowFunc throwFunc;
  final int allLength;
  final bool _isExam;
  ExamIndex(this.throwFunc, this.allLength, this._isExam);
  @override
  _ExamIndexState createState() => _ExamIndexState();
}

class _ExamIndexState extends State<ExamIndex> {
  int page = 0;
  @override
  void initState() {
    super.initState();
    widget.throwFunc.init([changeDate]);
  }

  changeDate({dynamic argument}) {
    setState(() {
      page = argument["page"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(size.width * 20, size.width * 20, size.width * 20, 0),
      child: Row(
        children: [
          widget._isExam
              ? Text('${page + 1}/${widget.allLength}',
                  style: TextStyle(color: Color(0xff295FF7)))
              : Text('1',
                  style: TextStyle(color: Colors.transparent)),
        ],
      ),
    );
  }
}

class TimeCount extends StatefulWidget {
  final Duration duration;
  final Function callback;
  const TimeCount(this.duration, this.callback);
  @override
  _TimeCountState createState() => _TimeCountState();
}

class _TimeCountState extends State<TimeCount> {
  Duration _duration = Duration();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _duration = widget.duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 1) {
        _timer.cancel();
        widget.callback();
      }
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(Icons.timer), Text(_duration.toString().split('.')[0])],
    );
  }
}

class ExamPage extends StatefulWidget {
  final ExamCacheType data;
  final bool formalExam;
  final Function(bool, List) callback;
  final bool isExam;

  ExamPage(this.data, this.callback,
      {this.isExam = true, this.formalExam = false});
  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  double opacity = 1.0;
  bool isFavorite = false;
  List<String> choose = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    choose = widget.data.sumbit ?? [];
  }

  Widget judegeType(TopicTye type) {
    switch (type) {
      case TopicTye.singe:
        return chooseTopic();
      case TopicTye.mutiple:
        return chooseTopic();
      case TopicTye.input:
        return inputTopic();
      case TopicTye.judge:
        return chooseTopic();
      case TopicTye.FAQs:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fAQsTopic(),
            SizedBox(
              height: size.width * 10,
            ),
            !(widget.formalExam) && widget.isExam
                ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("解析：", style: TextStyle(color: Color(0xff3074FF), fontSize: size.width * 24)),
                      Expanded(child: Text(widget.data.parsing,style: TextStyle(color: Color(0xff404040), fontSize: size.width * 24)))
                    ],
                  )
                : Container(),
          ],
        );

      default:
        return Container(
          child: Text("类型异常，请联系相关人员进行反馈"),
        );
    }
  }
  // 单选 多选 判断
  Widget chooseTopic() {
    return Column(
      children: widget.data.choose
          .asMap()
          .keys
          .map((i) => InkWell(
                onTap: widget.isExam
                    ? () {
                        if (widget.data.type == TopicTye.mutiple) {
                          setState(() {
                            if (choose.contains(ascii.decode([65 + i]))) {
                              choose.remove(ascii.decode([65 + i]));
                            } else {
                              choose.add(ascii.decode([65 + i]));
                            }
                          });
                        } else {
                          setState(() {
                            choose.clear();
                            choose.add(ascii.decode([65 + i]));
                          });
                        }
                      }
                    : null,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      choose.contains(ascii.decode([65 + i]))
                          ? !widget.isExam
                              ? Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    widget.data.anwser.contains(
                                            ascii.decode([65 + i]).toString())
                                        ? Icons.check_circle
                                        : Icons.highlight_off,
                                    color: widget.data.anwser.contains(
                                            ascii.decode([65 + i]).toString())
                                        ? commonColor
                                        : Colors.red,
                                    size: 30,
                                  ),
                                )
                              : Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Color(0xff5CCC84),
                                    size: 30,
                                  ),
                                )
                          : Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(right: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 1, color: commonColor)),
                              child: Text(
                                ascii.decode([65 + i]),
                                style: TextStyle(color: commonColor),
                              ),
                            ),
                      Expanded(
                        child: Text(
                          widget.data.choose[i].toString(),
                          style: TextStyle(
                            color: Color(0xff404040),
                            fontSize: size.width * 24
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
  // 填空
  Widget inputTopic() {
    choose = widget.data.sumbit.isEmpty
        ? List.generate(widget.data.choose.length, (index) => "")
        : widget.data.sumbit;
    return Column(
      children: widget.data.choose
          .asMap()
          .keys
          .map((i) => Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  !widget.isExam
                      ? Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.data.anwser.contains(choose[i])
                                ? Icons.check_circle
                                : Icons.highlight_off,
                            color: widget.data.anwser.contains(choose[i])
                                ? commonColor
                                : Colors.red,
                          ),
                        )
                      : Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: commonColor)),
                          child: Text(
                            ascii.decode([65 + i]),
                            style: TextStyle(color: commonColor),
                          ),
                        ),
                  Expanded(
                      child: TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: choose[i]),
                    readOnly: !widget.isExam,
                    onChanged: (value) {
                      choose[i] = value;
                    },
                  ))
                ],
              ))
          .toList(),
    );
  }
  // 问答
  Widget fAQsTopic() {
    choose = widget.data.sumbit.isEmpty
        ? List.generate(widget.data.choose.length, (index) => "")
        : widget.data.sumbit;
    if (choose.isEmpty) choose.add('');
    if (widget.data.choose.isEmpty) widget.data.choose.add('');
    return Column(
      children: widget.data.choose
          .asMap()
          .keys
          .map((i) => Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "答:",
                    style: TextStyle(
                      color: Color(0xff404040),
                      fontSize: size.width * 24
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: TextField(
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      color: Color(0xff404040),
                      fontSize: size.width * 24
                    ),
                    maxLines: 3,
                    decoration: InputDecoration(
                        labelText: choose.isNotEmpty ? choose[i] : ''),
                    readOnly: !widget.isExam,
                    onChanged: (value) {
                      choose[i] = value;
                    },
                  ))
                ],
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1.0,
                spreadRadius: 1.0
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.width * 50, bottom: size.width * 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.data.typeString,
                        style: TextStyle(color: Color(0xff3074FF), fontSize: size.width * 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                height: size.width * 2,
                width: double.infinity,
                color: Color(0xffeeeeee),
              ),
              // Question
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.data.question,
                  style: TextStyle(
                    color: Color(0xff404040), 
                    fontSize: size.width * 24, 
                  )
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // answer
                    judegeType(widget.data.type),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.callback(false, choose);
                          },
                          child: Container(
                            width: size.width * 220,
                            height: size.width * 80,
                            decoration: BoxDecoration(
                                color: Color(0xff3074FF),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 10))),
                            alignment: Alignment.center,
                            child: Text(
                              '上一题',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.callback(true, choose);
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            width: size.width * 220,
                            height: size.width * 80,
                            decoration: BoxDecoration(
                                color: Color(0xff3074FF),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 10))),
                            alignment: Alignment.center,
                            child: Text(
                              '下一题',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    !widget.isExam
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              widget.data.type != TopicTye.FAQs
                                  ? Row(
                                      children: [
                                        Text("答案：",
                                            style:
                                                TextStyle(color: Color(0xff3074FF), fontSize: size.width * 24)),
                                        Expanded(
                                            child: Row(
                                          children: widget.data.anwser
                                              .map((e) => Text(
                                                e + ',',
                                                style:
                                                TextStyle(color: Color(0xff404040), fontSize: size.width * 24)
                                              ))
                                              .toList(),
                                        ))
                                      ],
                                    )
                                  : Container(),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text("题目解析",
                                      style: TextStyle(color: Color(0xff3074FF), fontSize: size.width * 24))),
                              Text(widget.data.parsing ?? '',style:
                                                TextStyle(color: Color(0xff404040), fontSize: size.width * 24))
                            ],
                          )
                        : Container()
                  ],
                ),
              )),
            ],
          ),
        );
  }
}
