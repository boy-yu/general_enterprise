// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:enterprise/service/context.dart';

Future doSomething() async {
  html.window.localStorage.clear();
  String _cookies = html.document.cookie;

  List<String> split = _cookies.split(';');
  Map msg = {};
  split.forEach((element) {
    List<String> split2 = element.split("=");
    if (split2.length > 1) {
      msg[split2[0]] = split2[1];
    }
  });

  msg.forEach((key, value) {
    if (value != '') {
      myprefs.setString(key.toString().trimLeft(), value);
    }
  });
  return Future.value();
}
