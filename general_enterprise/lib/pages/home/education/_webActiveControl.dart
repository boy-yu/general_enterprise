import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:web_controller/web_controller.dart';

String saveQrMessage = '';

class WebActiveControl extends StatefulWidget {
  final String qrMessage, title;
  WebActiveControl({this.qrMessage, this.title});
  @override
  _WebActiveControlState createState() => _WebActiveControlState();
}

class _WebActiveControlState extends State<WebActiveControl> {
  WebControllerInterface _controllerInterface;
  @override
  void initState() {
    super.initState();
    if (widget.qrMessage is String) {
      saveQrMessage = widget.qrMessage;
    }

    _controllerInterface =
        WebControllerInterface(callback: (String type, {String value}) {
      myDio.request(type: 'post', url: Interface.scanCode, data: {
        "code": saveQrMessage,
        "jsonObject": {"type": type, "value": value}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebControllerBase(
      controllerInterface: _controllerInterface,
    );
  }
}
