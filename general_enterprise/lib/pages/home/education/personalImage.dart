import 'dart:convert';
import 'dart:typed_data';

import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class PersonalImage extends StatefulWidget {
  PersonalImage({this.barcode});
  final String barcode;
  @override
  _PersonalImageState createState() => _PersonalImageState();
}

class _PersonalImageState extends State<PersonalImage> {
  @override
  void initState() {
    super.initState();
    _getBase64();
  }

  Uint8List bytes;

  _getBase64(){
    myDio.request(
      type: "get",
      url: Interface.getBase64,
      queryParameters: {
        'key': widget.barcode
      }
    ).then((value) {
      if(value is Map){
        String captchaCode = value['result'].toString().split(',')[1];
        bytes = Base64Decoder().convert(captchaCode);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('个人档案'),
      child: bytes != null 
        ? InteractiveViewer(
          child: Image.memory(
            bytes,
            fit: BoxFit.fitHeight,
          ),
        )
        : Container(),
    );
  }
}