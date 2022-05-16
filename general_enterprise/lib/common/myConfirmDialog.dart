import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class ConfirmDialog {
  static showConfirmDialog(BuildContext context,
      {String title = '',
      bool onlyRight = false,
      String content = '',
      String leftButton = '取消',
      String rightButton = '确定',
      Function confirmCallback,
      Function cancelCallback,
      String confirmRouteUri = '',
      bool input = false}) {
    showDialog(
        context: context,
        builder: (_) => MyDialog(
            title: title,
            content: content,
            leftText: leftButton,
            rightText: rightButton,
            onlyRight: onlyRight,
            okCallBack: confirmCallback,
            cancelCallBack: cancelCallback,
            okRouteUri: confirmRouteUri,
            input: input));
  }
}

class MyDialog extends Dialog {
  final String title; //标题
  final String content; //内容
  final String leftText; //左边按钮文字
  final String rightText; //右边按钮文字
  final bool onlyRight; //是否只要一个按钮
  final Function okCallBack; //右边回调
  final Function cancelCallBack; //左边回调
  final String okRouteUri; //右边按钮跳转路由
  final bool input; //是否展示输入框
  MyDialog(
      {this.title = '标题',
      this.content = '',
      this.leftText = '确定',
      this.rightText = '取消',
      this.onlyRight = false,
      @required this.okCallBack,
      this.cancelCallBack,
      this.okRouteUri = '',
      this.input = false});
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: Padding(
          padding: EdgeInsets.only(top: 200.0),
          child: Column(
            children: <Widget>[
              Container(
                width: 300,
                height: size.width * 300,
                decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15.0),
                  )),
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/bg_confirmdialog.png'),
                    //这里是从assets静态文件中获取的，也可以new NetworkImage(）从网络上获取
                    centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: input
                          ? Container(
                              // 输入框样式
                              )
                          : Text(content,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 50,
                decoration: ShapeDecoration(
                  color: Color(0xff3679FF),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15.0)),
                  ),
                ),
                // 是否只要一个按钮
                child: onlyRight
                    ? GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: Text(
                            rightText,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        onTap: () {
                          if (okCallBack != null) {
                            //确认按钮回调
                            okCallBack();
                          }
                          if (okRouteUri.isEmpty) {
                            Navigator.of(context).pop();
                          } else {
                            //跳转页面，
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(okRouteUri);
                          }
                        },
                      )
                    : Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                    ),
                                  )),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        leftText,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  if (cancelCallBack != null) {
                                    cancelCallBack();
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                decoration: ShapeDecoration(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        rightText,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (okCallBack != null) {
                                      if (input) {
                                        //若带输入框，回调返回输入的内容
                                        okCallBack(_controller.text);
                                      } else {
                                        okCallBack();
                                      }
                                    }
                                    if (okRouteUri.isEmpty) {
                                      Navigator.of(context).pop();
                                    } else {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed(okRouteUri);
                                    }
                                  },
                                )),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
