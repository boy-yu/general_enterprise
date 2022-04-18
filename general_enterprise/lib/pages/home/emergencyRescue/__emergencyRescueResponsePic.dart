import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';

class EmergencyRescueResponsePic extends StatefulWidget {
  @override
  _EmergencyRescueResponsePicState createState() => _EmergencyRescueResponsePicState();
}

class _EmergencyRescueResponsePicState extends State<EmergencyRescueResponsePic> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('应急响应图'),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            'assets/images/img_response_pic.png'
          ),
        ),
      ),
    );
  }
}