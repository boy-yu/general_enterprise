import 'package:flutter/material.dart';

const placeHolder = Color.fromRGBO(153, 153, 153, 1);

const underColor = Color(0xffCCCCCC);

// const themeColor = Color.fromRGBO(110, 163, 249, 1);
const themeColor = Color(0xff2674FD);

const titleColor = Color.fromRGBO(76, 159, 255, 1);

const motaiColor = Color.fromRGBO(0, 0, 0, .5);

const textBgColor = Color(0xffF3F4F8);

const textChooseBgColor = Color.fromRGBO(111, 160, 249, 1);

const yellowBg = Color.fromRGBO(243, 182, 37, 1);

const backgroundBg = Color.fromRGBO(245, 245, 245, 1);

List<BoxShadow> shadowColor = [
  BoxShadow(
    color: Colors.grey.withOpacity(.05),
    blurRadius: 10,
    offset: Offset(0, 2), // changes position of shadow
  )
];

const List<Color> lineGradRed = [
  Color.fromRGBO(253, 151, 176, 1),
  Color.fromRGBO(255, 195, 183, 1)
];

const List<Color> lineGradBlue = [
  // Color.fromRGBO(95, 166, 249, 1),
  // Color.fromRGBO(114, 118, 247, 1)
  Color(0xff3174FF),
  Color(0xff1D3AEA)
];

const List<Color> lineGradPurple = [
  // Color.fromRGBO(95, 166, 249, 1),
  // Color.fromRGBO(114, 118, 247, 1)
  Color(0xff99A3FD),
  Color(0xff6559D9)
];

List<Color> changePross(int allgress, int curren) {
  List<Color> workListPross = [];

  for (var i = 0; i < allgress; i++) {
    if (i < curren) {
      workListPross.add(Color(0xff6D9FFD).withOpacity(0.1 + (0.03 * i / 2)));
    } else {
      workListPross.add(Colors.white);
    }
  }
  if (workListPross.length < 2) {
    workListPross.add(Colors.white);
    workListPross.add(Colors.white);
  }

  return workListPross;
}
