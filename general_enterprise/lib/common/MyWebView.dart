import 'package:enterprise/common/loding.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:clone_flutter_webview_plugin/clone_flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  MyWebView({this.arguments});
  final Map arguments;
  // title url
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  bool _loading = true;
  MethodChannel _channel = MethodChannel('nativeView');  
  @override
  void initState() {
    super.initState();
    print('widget.arguments' + widget.arguments.toString());
    _channel.invokeMethod("webView", widget.arguments).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.arguments['title'] ?? '历史记录'),
      backgroundColor: Colors.white,
      child: Column(
        children: [
          _loading ? StaticLoding() : Container(),
          // Expanded(
          //     child: WebViewExample(
          //   callback: (url) {
          //     setState(() {
          //       _loading = false;
          //     });
          //   },
          //   url: widget.arguments['url'],
          // ))
        ],
      ),
    );
  }
}

class FlutterWebView extends StatefulWidget {
    FlutterWebView({this.arguments});
  final Map arguments;
  @override
  _FlutterWebViewState createState() => _FlutterWebViewState();
}

class _FlutterWebViewState extends State<FlutterWebView> {
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.arguments['title'] ?? '历史记录'),
      backgroundColor: Colors.white,
      child: Column(
        children: [
          _loading ? StaticLoding() : Container(),
          Expanded(
            child: WebViewExample(
              callback: (url) {
                setState(() {
                  _loading = false;
                });
              },
              url: widget.arguments['url'],
            )
          )
        ],
      ),
    );
  }
}

class WebViewExample extends StatelessWidget {
  WebViewExample({this.url, this.callback});
  final String url;
  final Function(String url) callback;
  @override
  Widget build(BuildContext context) {
    print(url);
    return WebView(
      onPageFinished: callback,
      initialUrl: url,
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
