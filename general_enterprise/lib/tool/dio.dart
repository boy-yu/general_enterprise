import 'dart:async';

import 'package:dio/dio.dart';
// import 'package:enterprise/service.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import '../service/context.dart';

// import '../common/myProgressDialog.dart';
enum Methods { gets, post }

class MyDio {
  Dio dios = Dio();
  List<String> _urls = [];
  List<String> methods = ['get', 'post', 'delete'];
  MyDio() {
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
    dios.options.headers = {"Authorization": myprefs.getString('token')};
    // dios.options.headers = {"Authorization": 'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzeXN0ZW1Vc2VyIjp7ImlkIjoiMjVkZGE5MTAtMGY5OC00NTgxLTlmNzgtMzhiZDk4NWVlOWQxIiwidXNlcm5hbWUiOiIxMjMiLCJuaWNrbmFtZSI6IuS4jeiDveWIoCIsIm90aGVyVWlkIjoiM0Y0NzM5OEQtQjk2RS00NTdELUEzM0EtQTE0NzA4MUQwQUIzIiwicGFzc3dvcmQiOiIkMmEkMTAkNVFhQVdVeHMvQUhUZW1YNC80cWZSdW82UWUucHBUa2hLbXJGOXVLZVRSVFJBcUhPM1R2djYiLCJlbWFpbCI6IiIsIm1vYmlsZSI6IjE3ODk4NzQ4OTg0Iiwic3RhdHVzIjoxLCJsYXN0TG9naW5UaW1lIjpudWxsLCJzZXgiOiIwIiwiYXZhdGFyIjoiIiwiaXNTeXN0ZW0iOjEsInNpZ24iOiIiLCJkZXNjcmlwdGlvbiI6IiIsImNvbXBhbnlDb2RlIjoiIiwidHlwZSI6MSwiZGVsZXRlZCI6bnVsbCwicm9sZUlkIjpudWxsLCJyb2xlTmFtZSI6bnVsbH0sImV4cCI6MTY1MTEwODg3MSwidXNlcl9uYW1lIjoiMTIzIiwianRpIjoiZDlhNTc2NzQtMWYxYi00ZGE5LWIxM2UtZTA0OTNkNjgyMjc5IiwiY2xpZW50X2lkIjoic3dhZ2dlciIsInNjb3BlIjpbImFsbCJdfQ.XF6IfolSDF8AosXfRVxlDOEYKQqB37kAb2z80JUy1LY'};
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
