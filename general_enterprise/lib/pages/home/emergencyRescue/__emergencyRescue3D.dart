import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmergencyRescue3D extends StatefulWidget {
  @override
  _EmergencyRescue3DState createState() => _EmergencyRescue3DState();
}

class _EmergencyRescue3DState extends State<EmergencyRescue3D> {
  MethodChannel _channel = MethodChannel('nativeView');
  @override
  void initState() {
    super.initState();
    _channel.invokeMethod('webView', 'http://baidu.com');
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('3D'),
      child: Container(),
    );
  }
}
