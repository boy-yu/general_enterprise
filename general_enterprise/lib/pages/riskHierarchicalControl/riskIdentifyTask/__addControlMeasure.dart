import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class AddControlMeasure extends StatefulWidget {
  @override
  State<AddControlMeasure> createState() => _AddControlMeasureState();
}

class _AddControlMeasureState extends State<AddControlMeasure> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          "新增管控措施",
          style: TextStyle(fontSize: size.width * 32),
        ),
        child: Container(),
    );
  }
}