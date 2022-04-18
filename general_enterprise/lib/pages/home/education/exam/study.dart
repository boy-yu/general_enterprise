import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myVideoPlay.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/education/exam/db_examCache.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// enum EduStudyType {video, text, file, image}

class EduStudy extends StatefulWidget {
  EduStudy({this.id, this.submitStudyRecords, this.stage});
  final int id, stage;
  final Map submitStudyRecords;
  @override
  _EduStudyState createState() => _EduStudyState();
}

class _EduStudyState extends State<EduStudy> {
  bool isFavorite = false;
  double opacity = 1.0;
  bool show = false;
  bool state = false;
  ThrowFunc _throwFunc = ThrowFunc();
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Widget _judgeWay(String resourcesType, dynamic value, String coverUrl) {
    switch (resourcesType) {
      case '文字':
        return SingleChildScrollView(
          child: Column(
            children: [EduOcclude(value: value)],
          ),
        );
        break;
      case '影音':
        return MyVideoPlay(url: value, throwFunc: _throwFunc);
        break;
      case '文件':
        return Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              coverUrl,
              height: size.width * 251,
              width: size.width * 643,
            ),
            // Spacer(),
            // InkWell(
            //     onTap: () {
            //       Navigator.pushNamed(context, '/webview', arguments: {
            //         "url": Interface.online(value),
            //         "title": '课件学习'
            //       });
            //     },
            //     child: Container(
            //       margin: EdgeInsets.symmetric(vertical: size.width * 20),
            //       padding: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
            //       decoration: BoxDecoration(color: Color(0xff295FF7), borderRadius: BorderRadius.all(Radius.circular(size.width * 8))),
            //       child: Text(
            //         '开始学习文件',
            //         style: TextStyle(color: Colors.white, fontSize: size.width * 30),
            //       ),
            //     ))
          ],
        );
        break;
      case '图片':
        return Image.network(value);
        break;
      default:
        return Container();
    }
  }

  Map data = {
    "id": -1,
    "resourcesCode": "",
    "title": "",
    "introduction": "",
    "classHours": 0,
    "coverUrl": "",
    "content": "",
    "resourcesType": "",
    "dataUrl": "",
    "typeId": -1,
    "optionOne": "",
    "optionTwo": "",
    "optionThree": "",
    "optionFour": "",
    "optionFive": "",
    "industrys": "",
    "createDate": 0,
    "modifyDate": 0
  };

  _getData() {
    myDio
        .request(
            type: "get",
            url: Interface.getNewEducationTrainingResourcesList +
                widget.id.toString())
        .then((value) {
      if (value is Map) {
        data = value;
        if (data['isFavorites'] == 0) {
          isFavorite = false;
        } else if (data['isFavorites'] == 1) {
          isFavorite = true;
        }
        setState(() {
          show = true;
        });
      }
    });
  }

  // 收藏教材
  _favoritesResources(int resourcesId) {
    myDio.request(
        type: "post",
        url: Interface.postFavoritesResources,
        data: {'resourcesId': resourcesId}).then((value) {
      Fluttertoast.showToast(msg: '收藏成功');
    });
  }

  // 取消收藏
  _deleteFavoritesResources(int resourcesId) {
    myDio.request(
        type: "delete",
        url: Interface.postDeleteFavoritesResources,
        data: {'resourcesId': resourcesId}).then((value) {
      Fluttertoast.showToast(msg: '取消收藏');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text("培训教案"),
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
              child: Transtion(
                  Stack(
                    children: [
                      Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Color(0xff0059FF).withOpacity(0.1),
                              spreadRadius: 1.0,
                              blurRadius: 5,
                            )
                          ]),
                          margin: EdgeInsets.fromLTRB(
                              size.width * 24,
                              size.width * 60,
                              size.width * 24,
                              size.width * 30),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 20,
                              vertical: size.width * 30),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: size.width * 30,
                                    bottom: size.width * 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/icon@2x.png",
                                      height: size.width * 28,
                                      width: size.width * 28,
                                    ),
                                    SizedBox(
                                      width: size.width * 20,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          // style: DefaultTextStyle.of(context).style,
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: data['classHours']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color(0xff295FF7),
                                                    fontSize: size.width * 32,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: '学时',
                                                style: TextStyle(
                                                  color: Color(0xff666666),
                                                  fontSize: size.width * 24,
                                                )),
                                          ]),
                                    ),
                                    SizedBox(
                                      width: size.width * 150,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (!isFavorite) {
                                          // 收藏教材
                                          _favoritesResources(data['id']);
                                        } else {
                                          // 取消收藏
                                          _deleteFavoritesResources(data['id']);
                                        }
                                        setState(() {
                                          isFavorite = !isFavorite;
                                          opacity = 0.0;
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            setState(() {
                                              opacity = 1.0;
                                            });
                                          });
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          AnimatedOpacity(
                                            opacity: opacity,
                                            duration: Duration(seconds: 1),
                                            child: Icon(
                                              !isFavorite
                                                  ? Icons.star_border
                                                  : Icons.star,
                                              color: Colors.yellow[400],
                                              size: size.width * 40,
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 10,
                                          ),
                                          Text(
                                            '收藏',
                                            style: TextStyle(
                                              color: Color(0xff666666),
                                              fontSize: size.width * 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: size.width * 1,
                                width: double.infinity,
                                color: Color(0xffeeeeee),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 20,
                                          vertical: size.width * 15),
                                      child: Text(
                                        data['introduction'].toString(),
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: size.width * 24),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                  child: _judgeWay(
                                      data['resourcesType'],
                                      data['resourcesType'] == '文字'
                                          ? data['content']
                                          : data['dataUrl'],
                                      data['coverUrl'])),
                              data['resourcesType'] == '文件'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/webview',
                                                arguments: {
                                                  "url": Interface.online(
                                                      data['dataUrl']),
                                                  "title": '课件学习'
                                                });
                                          },
                                          child: Container(
                                            width: size.width * 240,
                                            margin: EdgeInsets.symmetric(
                                                vertical: size.width * 20),
                                            height: size.width * 70,
                                            decoration: BoxDecoration(
                                                color: Color(0xff3074FF),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 10))),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '开始学习文件',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width * 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            ExamCache()
                                                .writeTable(data)
                                                .then((value) {
                                              if (widget.submitStudyRecords !=
                                                  null) {
                                                Navigator.pushNamed(context,
                                                    "/home/education/mokExam",
                                                    arguments: {
                                                      'id': data['id'],
                                                      "formalExam": false,
                                                      'title': data['title'],
                                                      'submitStudyRecords':
                                                          widget
                                                              .submitStudyRecords
                                                    }).then((value) {
                                                  _throwFunc.run();
                                                });
                                              } else {
                                                Navigator.pushNamed(context,
                                                    "/home/education/mokExam",
                                                    arguments: {
                                                      'id': data['id'],
                                                      "formalExam": false,
                                                      'title': data['title'],
                                                    });
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: size.width * 240,
                                            margin: EdgeInsets.symmetric(
                                                vertical: size.width * 20),
                                            height: size.width * 70,
                                            decoration: BoxDecoration(
                                                color: Color(0xff3074FF),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 10))),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '模拟考试',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width * 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        ExamCache()
                                            .writeTable(data)
                                            .then((value) {
                                          if (widget.submitStudyRecords !=
                                              null) {
                                            Navigator.pushNamed(context,
                                                "/home/education/mokExam",
                                                arguments: {
                                                  'id': data['id'],
                                                  "formalExam": false,
                                                  'title': data['title'],
                                                  'submitStudyRecords':
                                                      widget.submitStudyRecords
                                                }).then((value) {
                                              _throwFunc.run();
                                            });
                                          } else {
                                            Navigator.pushNamed(context,
                                                "/home/education/mokExam",
                                                arguments: {
                                                  'id': data['id'],
                                                  "formalExam": false,
                                                  'title': data['title'],
                                                });
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: size.width * 240,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.width * 20),
                                        height: size.width * 70,
                                        decoration: BoxDecoration(
                                            color: Color(0xff3074FF),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.width * 10))),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '模拟考试',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                            ],
                          )),
                      Positioned(
                          top: size.width * 28,
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
                              data['title'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: data['title'].toString().length > 8
                                    ? size.width * 22
                                    : size.width * 28,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                          )),
                    ],
                  ),
                  show))
        ],
      ),
      // actions: [
      //   GestureDetector(
      //     onTap: () {
      //       ExamCache().writeTable(data).then((value) {
      //         if (widget.submitStudyRecords != null) {
      //           Navigator.pushNamed(context, "/home/education/mokExam",
      //               arguments: {
      //                 'id': data['id'],
      //                 "formalExam": false,
      //                 'title': data['title'],
      //                 'submitStudyRecords': widget.submitStudyRecords
      //               }).then((value) {
      //             _throwFunc.run();
      //           });
      //         } else {
      //           Navigator.pushNamed(context, "/home/education/mokExam",
      //               arguments: {
      //                 'id': data['id'],
      //                 "formalExam": false,
      //                 'title': data['title'],
      //               });
      //         }
      //       });
      //     },
      //     child: Container(
      //         padding: EdgeInsets.all(size.width * 30),
      //         child: Image.asset(
      //           "assets/images/icon_edu_monikaoshi.png",
      //           height: size.width * 40,
      //           width: size.width * 36,
      //         )),
      //   ),
      // ],
    );
  }
}

class EduOcclude extends StatefulWidget {
  final String value;
  const EduOcclude({Key key, @required this.value}) : super(key: key);

  @override
  _EduOccludeState createState() => _EduOccludeState();
}

class _EduOccludeState extends State<EduOcclude> with TickerProviderStateMixin {
  double _opacity = 0;
  double _top = 0;
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _opacity = 1;
          _top = -33;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration:
          BoxDecoration(border: Border.all(width: 2, color: Color(0xff3A80FC))),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 1),
            child: Text(widget.value),
          ),
          AnimatedPositioned(
              top: _top,
              width: MediaQuery.of(context).size.width - 120,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                  child: Text("文字教材",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              duration: Duration(seconds: 1))
        ],
      ),
    );
  }
}
