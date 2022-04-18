import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';

class LookFile extends StatefulWidget {
  @override
  _LookFileState createState() => _LookFileState();
}

class _LookFileState extends State<LookFile> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('查看文件'),
        child: Center(
          child: Text('查看文件'),
        ));
  }
}
