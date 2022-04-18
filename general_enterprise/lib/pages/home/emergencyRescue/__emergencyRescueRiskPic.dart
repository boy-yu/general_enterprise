import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';

class EmergencyRescueRiskPic extends StatefulWidget {
  @override
  _EmergencyRescueRiskPicState createState() => _EmergencyRescueRiskPicState();
}

class _EmergencyRescueRiskPicState extends State<EmergencyRescueRiskPic> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('个人和社会可接受风险图'),
      child: Center(
        child: Image.asset('assets/images/personAndSoc.png'),
      ),
    );
  }
}
