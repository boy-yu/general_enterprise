import 'package:flutter/material.dart';

class RiskButtons extends StatelessWidget {
  final String text;
  final int bgcolor;
  final int testcolor;
  final Function callback;
  const RiskButtons(
      {Key key, this.text, this.bgcolor, this.testcolor, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xffDCDCDC),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8))),
            backgroundColor: MaterialStateProperty.all(Color(bgcolor))),
        child: Text(
          "$text",
          style: TextStyle(color: Color(testcolor)),
        ),
        onPressed: this.callback);
  }
}
