import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProcessesDetails extends StatefulWidget {
  ProcessesDetails({this.id});
  final int id;
  @override
  _ProcessesDetailsState createState() => _ProcessesDetailsState();
}

class _ProcessesDetailsState extends State<ProcessesDetails> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('化工工艺详情'),
      child: WebView(
        initialUrl: webUrl +
            'supervise-risk-detail?id=${widget.id}' +
            '&token=' + myprefs.getString('token'),
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
