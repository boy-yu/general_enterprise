import 'package:enterprise/common/MychooseTime.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class MyClosedMagInputBox extends StatefulWidget {
  MyClosedMagInputBox({this.callback});
  final Callback callback;
  @override
  State<MyClosedMagInputBox> createState() => _MyClosedMagInputBoxState();
}

class _MyClosedMagInputBoxState extends State<MyClosedMagInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * 76,
      width: size.width * 570,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFFAFAFB),
          border: Border.all(
              color: Color(0xFFF0F0F2),
              style: BorderStyle.solid,
              width: size.width * 4),
          borderRadius: BorderRadius.all(Radius.circular(size.width * 38))),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: size.width * 20),
          hintText: '请输入车牌/名字',
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: size.width * 24, color: Color(0xffACACBC)),
          icon: Padding(
            padding: EdgeInsets.only(left: size.width * 20),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          )
        ),
        style: TextStyle(fontSize: size.width * 24, color: Color(0xff333333)),
        textInputAction: TextInputAction.search,
        onSubmitted: widget.callback,
      ),
    );
  }
}
