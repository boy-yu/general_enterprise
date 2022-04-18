import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class Loading {
  void show() {
    showDialog(context: myContext, builder: (_) => StaticLoding());
  }
}

class StaticLoding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/loading.gif',
        width: 60,
        height: 60,
      ),
    );
  }
}
