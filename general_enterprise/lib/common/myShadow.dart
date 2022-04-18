import 'package:flutter/material.dart';

class MyShadow extends StatefulWidget {
  final Widget child;
  MyShadow({@required this.child});
  @override
  _MyShadowState createState() => _MyShadowState();
}

class _MyShadowState extends State<MyShadow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Color(0xff0059FF).withOpacity(.1),
                spreadRadius: 2,
                offset: Offset(1, 1))
          ]),
      child: widget.child,
    );
  }
}
