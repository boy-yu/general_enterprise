import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class DilagContent extends StatelessWidget {
  @override
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
                              _headers(width),
                              _content(width),
                              _bottomDilog(width, context)
                            ],
                          ))),
                ],
              )
            ],
          )),
    );
  }

  _bottomDilog(width, context) {
    return Container(
        width: width * 240,
        height: width * 60,
        margin: EdgeInsets.only(top: width * 110, bottom: width * 55),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 8),
          gradient: LinearGradient(
            //背景径向渐变
            colors: [Color(0xff1C3AEA), Color(0xff3174FF)],
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); //关闭对话框
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "确定",
                style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontSize: width * 32,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }

  _content(width) {
    return Container(
        child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: width * 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "检测方式",
                style:
                    TextStyle(fontSize: width * 21, color: Color(0xff000000)),
              ),
              Container(
                margin: EdgeInsets.only(left: width * 20),
                width: width * 300,
                decoration: BoxDecoration(
                  //背景装饰
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xffDFDFDF), style: BorderStyle.solid)),
                ),
                padding: EdgeInsets.only(bottom: width * 20),
                child: Text(
                  "请选择",
                  style:
                      TextStyle(fontSize: width * 21, color: Color(0xff808080)),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: width * 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "检测点位",
                style:
                    TextStyle(fontSize: width * 21, color: Color(0xff000000)),
              ),
              Container(
                margin: EdgeInsets.only(left: width * 20),
                width: width * 300,
                decoration: BoxDecoration(
                  //背景装饰
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xffDFDFDF), style: BorderStyle.solid)),
                ),
                padding: EdgeInsets.only(bottom: width * 20),
                child: Text(
                  "请输入",
                  style:
                      TextStyle(fontSize: width * 21, color: Color(0xff808080)),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: width * 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "检测内容",
                style:
                    TextStyle(fontSize: width * 21, color: Color(0xff000000)),
              ),
              Container(
                margin: EdgeInsets.only(left: width * 20),
                width: width * 300,
                decoration: BoxDecoration(
                  //背景装饰
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xffDFDFDF), style: BorderStyle.solid)),
                ),
                padding: EdgeInsets.only(bottom: width * 20),
                child: Text(
                  "请选择",
                  style:
                      TextStyle(fontSize: width * 21, color: Color(0xff808080)),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }

  _headers(width) {
    return Container(
      margin: EdgeInsets.only(bottom: width * 60),
      decoration: BoxDecoration(
        //背景装饰
        color: Color(0xff0059FF),
        borderRadius: new BorderRadius.vertical(
            top: Radius.elliptical(width * 26, width * 26)),
        boxShadow: [
          BoxShadow(
              color: Color(0x29000000),
              offset: Offset(4.0, 4.0),
              blurRadius: 13.0,
              spreadRadius: 0.16),
        ],
      ),
      width: width * 521,
      height: width * 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "气体检测要求",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: width * 36,
                color: Color(0xffffffff)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
