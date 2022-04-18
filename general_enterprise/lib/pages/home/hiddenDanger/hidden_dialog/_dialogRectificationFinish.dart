import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishRectificationDialog extends StatefulWidget {
  FinishRectificationDialog({this.callback});
  final Function callback;
  @override
  _FinishRectificationDialogState createState() =>
      _FinishRectificationDialogState();
}

class _FinishRectificationDialogState extends State<FinishRectificationDialog> {
  int selectbgColor = 0xff0ABA08;
  int selecttextColor = 0xffffffff;
  TextEditingController _editingController = TextEditingController();
  Counter _counter = Provider.of(myContext);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.emptySubmitDates(key: '完毕图片');
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          width: size.width * 467,
                          margin: EdgeInsets.only(
                              left: size.width * 90,
                              right: size.width * 90,
                              bottom: size.width * 30,
                              top: size.width * 10),
                          decoration: BoxDecoration(
                            //背景装饰
                            color: Color.fromRGBO(255, 255, 255, 0.15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(""))),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          width: size.width * 561,
                          margin: EdgeInsets.only(
                              left: size.width * 45,
                              right: size.width * 45,
                              bottom: size.width * 53,
                              top: size.width * 25),
                          decoration: BoxDecoration(
                            //背景装饰
                            color: Color.fromRGBO(255, 255, 255, 0.15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(""))),
                  Container(
                    width: size.width * 655,
                    height: size.width * 700,
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: []),
                    margin: EdgeInsets.only(
                        bottom: size.width * 74, top: size.width * 35),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _headers(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 30,
                                  bottom: size.width * 10),
                              child: Text(
                                '整改描述：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: ClipRRect(
                                child: Container(
                                    height: size.width * 160,
                                    color: Color(0xffF2F2F2).withOpacity(0.5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextField(
                                            controller: _editingController,
                                            onChanged: (val) {},
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '请输入描述...',
                                              hintStyle: TextStyle(
                                                  color: Color(0xffC8C8C8),
                                                  fontSize: size.width * 24),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                            ),
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            MyImageCarma(
                              title: "完毕图片",
                              name: '',
                              purview: '完毕图片',
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 50,
                                  right: size.width * 50),
                              child: GestureDetector(
                                onTap: () {
                                  if (widget.callback != null) {
                                    widget.callback(_editingController.text,
                                        _counter.submitDates['完毕图片']);
                                  }
                                },
                                child: Container(
                                  height: size.width * 75,
                                  // width: size.width * 505,
                                  alignment: Alignment.center,
                                  margin:
                                      EdgeInsets.only(bottom: size.width * 100),
                                  decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: lineGradBlue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25.0)),
                                  ),
                                  child: Text(
                                    '确定',
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: size.width * 36),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                  )
                ],
              )
            ],
          )),
    );
  }

  _headers() {
    return Container(
      margin: EdgeInsets.only(bottom: size.width * 30, top: size.width * 20),
      padding: EdgeInsets.only(left: size.width * 30, right: size.width * 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(),
          Container(
            margin: EdgeInsets.only(left: size.width * 100),
            child: Text(
              "整改完毕信息填写",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 36,
                  color: Color(0xff005AFF)),
            ),
          ),
          IconButton(
              icon: Image.asset(
                "assets/images/icon_dialog_close.png",
                width: 24 * size.width,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}
