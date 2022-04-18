import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppendUnplannedDialog extends StatefulWidget {
  AppendUnplannedDialog({this.callback});
  final Function callback;
  @override
  _AppendUnplannedDialogState createState() => _AppendUnplannedDialogState();
}

class _AppendUnplannedDialogState extends State<AppendUnplannedDialog> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

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
                    height: size.width * 600,
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
                        Container(
                          margin: EdgeInsets.only(top: size.width * 20),
                          padding: EdgeInsets.only(
                              left: size.width * 30, right: size.width * 30),
                          child: Row(
                            children: [
                              Text(
                                "其他风险事件信息",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 28,
                                    color: Color(0xff005AFF)),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.clear,
                                  size: size.width * 40,
                                ),
                              )
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.width * 15,
                              right: size.width * 50,
                              left: size.width * 50),
                          child: Text(
                            '风险分析单元名称：',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.width * 15,
                              right: size.width * 50,
                              left: size.width * 50),
                          child: Container(
                            height: size.width * 92,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _controller1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 28
                              ),
                              maxLines: 2,
                              decoration: InputDecoration(
                                hintText: '请输入风险分析单元名称',
                                hintStyle: TextStyle(
                                  color: Color(0xffB6BAC2),
                                  fontSize: size.width * 24
                                ),
                                fillColor: Color(0xffF1F5FD),
                                filled: true,
                                border: InputBorder.none,
                              ),
                              autofocus: false,
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.width * 15,
                              right: size.width * 50,
                              left: size.width * 50),
                          child: Text(
                            '风险事件名称：',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 28),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.width * 15,
                              right: size.width * 50,
                              left: size.width * 50),
                          child: Container(
                            height: size.width * 92,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _controller2,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 28
                              ),
                              maxLines: 2,
                              decoration: InputDecoration(
                                hintText: '请输入风险事件名称',
                                hintStyle: TextStyle(
                                  color: Color(0xffB6BAC2),
                                  fontSize: size.width * 24
                                ),
                                fillColor: Color(0xffF1F5FD),
                                filled: true,
                                border: InputBorder.none,
                              ),
                              autofocus: false,
                            ),
                          ),
                        ),
                        

                        Padding(
                          padding: EdgeInsets.only(top: size.width * 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if(_controller1.text == null || _controller1.text == ''){
                                    Fluttertoast.showToast(msg: "请输入风险风险分析名称");
                                  }else if(_controller1.text == null || _controller1.text == ''){
                                    Fluttertoast.showToast(msg: "请输入风险事件名称");
                                  }else{
                                    widget.callback(_controller1.text, _controller2.text);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Container(
                                  width: size.width * 505,
                                  height: size.width * 78,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/bg_btn_unplanned.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Text(
                                    '确定',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 36),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
}
