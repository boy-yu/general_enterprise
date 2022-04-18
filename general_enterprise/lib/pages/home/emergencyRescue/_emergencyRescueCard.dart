import 'package:enterprise/pages/home/productList/_postList.dart';
import 'package:flutter/material.dart';

class EmergencyRescueCard extends StatefulWidget {
  @override
  _EmergencyRescueCardState createState() => _EmergencyRescueCardState();
}

class _EmergencyRescueCardState extends State<EmergencyRescueCard> {
  @override
  Widget build(BuildContext context) {
    return CheckPostList(rescueCard: 'rescueCard');
  }
}