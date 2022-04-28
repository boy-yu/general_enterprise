import 'dart:convert';

import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../service.dart';

class Interface {
  static String mainBaseUrl = '';
  // static String eduBaseUrl = '';

  // 封闭化管理地址
  // static String closeBaseUrl = '';

  static String getAkyCompAppApiConfig = baseAliUrl + "/akyCompAppApiConfig";

  static String online(String url) {
    String base64 = base64Encode(utf8.encode(url));
    String result = Uri.encodeComponent(base64);
    return '$fileUrl/onlinePreview?url=$result';
  }
  // 服务器接口地址前缀
  static String baseUrl = mainBaseUrl;
  // baseUrl Sql 数据app全局使用
  static String getAllPeople =
      baseUrl + '/tUser/userListAll'; // funcType 首页通讯录人员集合
  static String getAlldeparment = baseUrl +
      '/tUser/departmentAndPositionListAll'; // funcType 首页通讯录部门职位集合
  // 首页 person 我的页面修改签名使用 sign签名页面使用
  static String amendSign = baseUrl + '/tUser/updateSign';
  // 获取服务器当前配置 包括文件路径前缀 票路径前缀 webview路径前缀等 facelogin login index
  static String webUrl = baseAliUrl + '/akyCompAppApiConfig';
  // 获取版本信息及最新版本下载更新地址 index login person update down
  static String cheakUpdate = baseAliUrl + '/appVersionConfig/aky';
  // 登陆接口 login
  static String loginUrl = baseUrl + '/oauth/token';
  /*
   * 图片上传服务器并获取服务器地址图片接口 所有拍照上传地方都有用
   *  myImageCarme和newMyImageCarme拍照组件
   *  sign签名上传及修改
   *  offlinedatalist我的清单隐患巡检离线数据照片上传
   *  hiddenscreening隐患排查提交拍照上传
   *  licenseupdate企业合规性证照更新
   *  workcontrollist作业热成像拍照上传
   *  getvideo作业模块视频上传
   *  avatar首页我的个人信息头像修改上传
   */
  static String uploadUrl = baseUrl + '/upload';
  // amendPsd 首页我的修改密码
  static String putAmendPsd = baseUrl + '/tUser/updatePassword';
  // 风险一级项下拉 hiddenSpecificItem inspecion risklist worklist controlIndex
  static String getCheckOneListAll = baseUrl + '/api/v4/riskControl/oneListAll';
  // 风险二级项下拉 hiddenSpecificItem inspecion risklist worklist
  static String getCheckTwoListAll = baseUrl + '/api/v4/riskControl/twoListAll';
  // 风险三级项下拉 hiddenSpecificItem inspecion
  static String getCHeckThreeListAll =
      baseUrl + '/api/v4/riskControl/threeListAll';
  // 修改头像 avatar myMessage
  static String amendAvatar = baseUrl + '/updateUrl';

  error(onError, BuildContext context) async {
    if (onError.toString().indexOf('DioError') > -1 ||
        onError.toString() == 'null') {
      Fluttertoast.showToast(
          msg: "网络错误",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black.withOpacity(.5),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: onError['message'].toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb:
              (1 + (onError['message'].toString().length ~/ 3)) > 5
                  ? 5
                  : (1 + (onError['message'].toString().length ~/ 3)),
          backgroundColor: Colors.black.withOpacity(.5),
          textColor: Colors.white,
          fontSize: 16.0);

      if (myprefs.getString('token') != null) {
        if (onError is Map && onError['code'] == 401 && !isLogin) {
          myprefs.clear();
          // XgFlutterPlugin().cleanAccounts();
          // XgFlutterPlugin().stopXg();
          isLogin = true;
          String _accout = myprefs.getString('account');
          String _company = myprefs.getString('enterpriseName');
          // XgFlutterPlugin().unbindWithIdentifier(
          //     identify: _accout, bindType: XGBindType.account);
          // XgFlutterPlugin().cleanAccounts();
          // XgFlutterPlugin().stopXg();
          MethodChannel _channel = MethodChannel("messagePushChannel");
          _channel.invokeMethod("logout").then((value) => print(value));
          // myDio.request(
          //     type: 'put',
          //     url: Interface.putAmendChatStatus,
          //     data: {"onlineStatus": "0"}).then((value) {});

          await myprefs.clear();
          await myprefs.setString('account', _accout ?? '');
          await myprefs.setString('SavedenterpriseName', _company ?? '');

          Navigator.pushNamed(context, '/login');
        }
      }
    }
  }
}
