import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';

class EmergencyRescueEvacuate extends StatefulWidget {
  @override
  _EmergencyRescueEvacuateState createState() =>
      _EmergencyRescueEvacuateState();
}

class _EmergencyRescueEvacuateState extends State<EmergencyRescueEvacuate> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('应急疏散图'),
      child: Center(
        child: Image.asset('assets/images/emergencyRescue.png'),
      ),
    );
  }
}
