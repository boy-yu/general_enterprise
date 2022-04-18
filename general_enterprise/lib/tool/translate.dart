import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
// import 'package:path_provider/path_provider.dart';

class Translate {
  // most good way is global use
  bool lock = false; // baidu translate limit free 1s query so code need 1s
  File engFile;
  init() async {
    // Directory _directory = await getApplicationDocumentsDirectory();
    // File _file = File(_directory.path + '/english.txt');

    myDio.request(type: 'get', url: Interface.getTranslate).then((value) async {
      if (value is List) {
        for (var i = 0; i < value.length; i++) {
          await myprefs.setString(
              'translate' + value[i]['englishField'].toString(),
              value[i]['chineseField'].toString());
        }
      }
    });
  }

  List exception = ['id', 'standardId'];

  // ignore: missing_return
  Future<Map> getTranslate(String input) async {
    if (input == '' || input == null || exception.indexOf(input) > -1) {
      return Future.value({"way": 0, 'value': null});
    }

    String tempInput = '';
    input.split('').forEach((element) {
      if (utf8.encode(element)[0] < 90) {
        tempInput += ' ' + element.toLowerCase();
      } else {
        tempInput += element;
      }
    });

    if (myprefs.getString('translate' + input) == null ||
        myprefs.getString('translate' + input) == '') {
      String url = 'https://api.fanyi.baidu.com/api/trans/vip/translate?';
      String appleId = '20200930000577521';
      DateTime dateTime = DateTime.now().toLocal();
      String pass = 'rldWq6UkGxlEQIMiJ9pI';
      String salt = dateTime.millisecondsSinceEpoch.toString();
      String signStr = appleId + tempInput + salt + pass;
      List signArr = utf8.encode(signStr);
      String sign = md5.convert(signArr).toString();
      String requestUrl = url +
          'from=en&to=zh' +
          '&q=$tempInput' +
          '&appid=$appleId' +
          '&salt=$salt' +
          '&sign=$sign';
      Response res = await Dio().get(requestUrl);
      // Dio().get(requestUrl).then((value) async {
      if (res.data['error_code'] == null) {
        await myprefs.setString(
            'translate' + input, res.data['trans_result'][0]['dst'].toString());

        myDio.request(type: 'post', url: Interface.postTranslate, data: {
          "fieldTranslationList": [
            {
              "englishField": input.toString(),
              "chineseField": res.data['trans_result'][0]['dst']
            }
          ]
        }).then((value) {});

        return Future.value(
            {"value": res.data['trans_result'][0]['dst'], 'way': 1});
      } else {
        return Future.value({"value": input, 'way': 1});
      }
    } else {
      return Future.value(
          {'way': 0, "value": myprefs.getString('translate' + input)});
    }
  }

  /// List haha = mytranslate.generateList(Map value)
  Future<List> generateList(Map value) async {
    List data = [];

    List keyList = value.keys.toList();
    List valueList = value.values.toList();
    for (var i = 0; i < keyList.length; i++) {
      Map engLish = await getTranslate(keyList[i]);
      if (engLish['way'] == 1) {
        sleep(Duration(seconds: 2));
      }
      if (engLish['value'] != null &&
          valueList[i] != null &&
          valueList[i] != '') {
        data.add({
          'zhName': engLish['value'],
          'value': valueList[i],
          'enName': keyList[i]
        });
      }
    }
    return data;
  }
}
