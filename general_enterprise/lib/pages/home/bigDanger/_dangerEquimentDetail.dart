import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';

class DangerEquimentDetail extends StatefulWidget {
  @override
  _DangerEquimentDetailState createState() => _DangerEquimentDetailState();
}

class _DangerEquimentDetailState extends State<DangerEquimentDetail> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('文件名字'),
        child: Center(
          child: Text('文件'),
        ));
  }
}
