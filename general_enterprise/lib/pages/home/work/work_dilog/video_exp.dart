import 'package:enterprise/pages/home/work/work_dilog/_getVideo.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class VideoExmple extends StatefulWidget {
  @override
  _VideoExmpleState createState() => _VideoExmpleState();
}

class _VideoExmpleState extends State<VideoExmple> {
  List videoLists = [];
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    double width = size.width;
    return Container(
      //弹出框的具体事件
      child: Material(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            //背景装饰
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.only(
                              left: width * 77, right: width * 77),
                          child: Text(""))),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              //背景装饰
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                //卡片阴影
                                BoxShadow(
                                    color: Color(0x29000000),
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 13.0,
                                    spreadRadius: 0.16),
                              ]),
                          margin: EdgeInsets.only(
                              bottom: width * 10,
                              left: width * 67,
                              right: width * 67),
                          child: Text(""))),
                  Positioned(
                      child: Container(
                          width: width * 521,
                          decoration: BoxDecoration(
                              //背景装饰
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                //卡片阴影
                                BoxShadow(
                                    color: Color(0x29000000),
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 13.0,
                                    spreadRadius: 0.16),
                              ]),
                          margin: EdgeInsets.only(
                              bottom: width * 20,
                              left: width * 57,
                              right: width * 57),
                          child: Column(
                            children: <Widget>[
                              WorkVideo(
                                callbacks: (val) {
                                  try {
                                    setState(() {
                                      videoLists = val;
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                isUpload: false,
                                videoList: videoLists,
                              ),
                            ],
                          ))),
                ],
              )
            ],
          )),
    );
  }
}
