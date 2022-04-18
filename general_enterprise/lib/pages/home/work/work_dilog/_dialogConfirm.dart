import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class DialogConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.width * 655,
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
                  bottom: size.width * 20,
                  left: size.width * 57,
                  right: size.width * 57),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            width: size.width * 24,
                            height: size.width * 24,
                            image: AssetImage(
                                'assets/images/icon_dialog_close.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '确认指定',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: size.width * 36),
                        ),
                        Text(
                          '张三',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: size.width * 36),
                        ),
                        Text(
                          '为动火作业监护人',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: size.width * 36),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 500,
                    height: size.width * 75,
                    margin: EdgeInsets.only(top: 50, bottom: 30),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff3174FF))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '确定',
                        style: TextStyle(fontSize: size.width * 36),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
