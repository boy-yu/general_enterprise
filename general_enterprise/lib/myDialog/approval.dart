import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../common/myCount.dart';

class Approval extends StatelessWidget {
  Approval(
      {this.callback, this.widget, this.type, this.callState, this.cancel});
  final Function callback, cancel;
  final Widget widget;
  final String type;
  final List callState;
  @override
  Widget build(BuildContext context) {
    Counter _counter = Provider.of<Counter>(context);
    return Material(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
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
                  left: 0,
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
                  )),
              Container(
                  width: size.width * 655,
                  decoration: BoxDecoration(
                    //背景装饰
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(
                      bottom: size.width * 74, top: size.width * 35),
                  child: Column(
                    children: <Widget>[
                      _headers(size.width, cancel: cancel),
                      widget != null ? widget : _content(size.width),
                      widget != null
                          ? Container()
                          : _bottomDilog(size.width, context, _counter)
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }

  _bottomDilog(width, context, _counter) {
    return GestureDetector(
        onTap: () {
          if (callback.toString().indexOf('counter') > -1) {
            callback(counter: _counter);
          } else {
            callback();
          }
          Navigator.of(context).pop();
        },
        child: Container(
          width: width * 500,
          height: width * 75,
          margin: EdgeInsets.only(top: width * 58, bottom: width * 112),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 38),
            gradient: LinearGradient(
              //背景径向渐变
              colors: [Color(0xff1C3AEA), Color(0xff3174FF)],
            ),
          ),
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
    Counter _context = Provider.of<Counter>(myContext);
    return Container(
        padding: EdgeInsets.only(left: width * 95, right: width * 95),
        child: Column(
          children: <Widget>[
            type == '驳回'
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: width * 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "原因",
                              style: TextStyle(
                                  fontSize: width * 28,
                                  color: Color(0xff666666)),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          _context.changeSubmitDates(
                              '取消作业', {'title': '原因', "value": value});
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff3274FF), //边线颜色为黄色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff3274FF),
                              width: 1,
                            ),
                          ),
                          labelText: "请输入内容",
                        ),
                      ),
                    ],
                  )
                : Container(),
            // Padding(
            //   padding: EdgeInsets.only(bottom: width * 20, top: width * 30),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            //       CancelSign(),
            //     ],
            //   ),
            // ),
          ],
        ));
  }

  _headers(width, {Function cancel}) {
    return Container(
        margin: EdgeInsets.only(top: width * 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              // padding: EdgeInsets.all(0),
              onTap: () {
                if (cancel != null) cancel();
                if (callState != null) callState.add(false);
                Navigator.pop(myContext);
              },

              child: Icon(
                Icons.close,
                size: size.width * 40,
              ),
            )
          ],
        ));
  }
}
