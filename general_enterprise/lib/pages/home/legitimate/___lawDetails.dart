import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

import '../../../tool/interface.dart';

class LawDetails extends StatefulWidget {
  LawDetails({this.arguments});
  final arguments;
  @override
  _LawDetails createState() => _LawDetails(arguments: arguments);
}

class _LawDetails extends State<LawDetails> {
  _LawDetails({this.arguments});
  final arguments;

  @override
  void initState() {
    super.initState();
    _getDetails();
  }

  Map details = {'titleName': '《中华人民共和国宪法》', 'content': '法律法规'};

  _getDetails() {
    myDio
        .request(
            type: 'get',
            url: Interface.lawDetails + '/' + arguments['id'].toString())
        .then((value) {
      details = value;
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return MyAppbar(
      title: Text(
        details['titleName'].toString(),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width * 36,
            color: Colors.white),
      ),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (builder, index) {
            return Padding(
              padding: EdgeInsets.all(width * 30),
              child: Text(
                details['content'].toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 34,
                    height: width * 3),
              ),
            );
          }),
    );
  }
}
