import 'dart:async';

import 'package:dio/dio.dart';
// import 'package:enterprise/service.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import '../service/context.dart';

// import '../common/myProgressDialog.dart';
enum Methods { gets, post }

class LoginDio {
  Dio dios = Dio();
  List<String> _urls = [];
  List<String> methods = ['get', 'post', 'delete'];
  LoginDio() {
    dios.options.connectTimeout = 20000;
  }

  Future request({
    @required String type,
    @required String url,
    dynamic queryParameters,
    dynamic data,
    String key,
    bool mounted = true,
  }) async {
    dios.options.headers = {"Authorization":"Basic c3dhZ2dlcjoxMjM0NTY="};
    dios.options.headers['content-type'] = 'application/x-www-form-urlencoded';
    Response res;
    dynamic hasValue = data ?? queryParameters;

    if (!_urls.contains(url + hasValue.toString()) || !mounted) {
      if (mounted) {
        _urls.add(url + hasValue.toString());
      }
      try {
        res = await dios.request(url,
            options: Options(
              method: type,
            ),
            data: data,
            queryParameters: queryParameters);
        if (res.data['code'] == 200) {
          if (mounted) {
            _urls.remove(url + hasValue.toString());
          }

          return res.data['data'];
        } else if (res.data['code'] == 401) {
          Interface()
              .error({"message": '当前账户已在其他设备登录', "code": 401}, myContext);
          if (mounted) {
            _urls.remove(url + hasValue.toString());
          }
          return Future.error({"message": res.data['message'], "code": 401});
        } else {
          Interface().error({"message": res.data['message']}, myContext);

          if (mounted) {
            _urls.remove(url + hasValue.toString());
          }
          return Future.error({"message": res.data['message']});
        }
      } catch (e) {
        print('e------------------------------------------'+ e.toString());
        Interface().error({"message": '网络开小差了，请稍后重试'}, myContext);
        if (mounted) {
          _urls.remove(url + hasValue.toString());
          // ProgressDialog.dismiss(myContext);
        }
        return Future.error({"message": '数据缺失，请联系管理员'});
      }
    } else {
      Interface().error({"message": '重复请求,请稍后再试'}, myContext);
      return Future.error("重复请求,请稍后再试");
    }
  }
}
