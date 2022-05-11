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
  static String getRiskObjectByDepartmentId = baseUrl + '/riskTemplate/getRiskObjectByDepartmentId';
  // 风险二级项下拉 hiddenSpecificItem inspecion risklist worklist
  static String getRiskUnitByDepartmentId = baseUrl + '/riskTemplate/getRiskUnitByDepartmentId';
  // 风险三级项下拉 hiddenSpecificItem inspecion
  static String getRiskEventByDepartmentId = baseUrl + '/riskTemplate/getRiskEventByDepartmentId';
  // （上报）风险一级项下拉
  static String getCheckRiskObjectList = baseUrl + '/hiddenDangerInvestigation/checkRiskObjectList';


  // 安全风险清单 风险管控措施列表
  static String getRiskTemplateFourList = baseUrl + '/riskTemplate/riskTemplateFourList';
  // 根据id查看落实情况
  static String getRiskTemplateFourImplementationById = baseUrl + '/riskTemplate/getRiskTemplateFourImplementationById';
  // 根据id查看风险管控措施详情
  static String getRiskTemplateFourById = baseUrl + '/riskTemplate/getRiskTemplateFourById';
  
  // 隐患排查记录
  static String getCheckRecordList = baseUrl + '/hiddenDangerInvestigation/checkRecordList';
  // 根据id查看排查记录详情
  static String getcheckRecordById = baseUrl + '/hiddenDangerInvestigation/getcheckRecordById';

  // 隐患治理列表（排查）
  static String getCheckHiddenDangereBookList = baseUrl + '/hiddenDangerInvestigation/checkHiddenDangereBookList';
  // 隐患治理列表（排查）详情
  static String getcheckHiddenDangereBookById = baseUrl + '/hiddenDangerInvestigation/getcheckHiddenDangereBookById';

  // 隐患治理列表（上报）
  static String getReportHiddenDangereBookList = baseUrl + '/hiddenDangerInvestigation/reportHiddenDangereBookList';
  // 隐患治理列表（上报）详情
  static String getreportHiddenDangereBookById = baseUrl + '/hiddenDangerInvestigation/getreportHiddenDangereBookById';
  
  // 隐患排查任务执行列表
  static String getRiskControlDataList = baseUrl + '/riskControlDataController/riskControlDataList';
  // 根据执行id查看详情 (蓝色部分)
  static String getRiskControlDataById = baseUrl + '/riskControlDataController/getRiskControlDataById';
  // 提交排查任务
  static String postImplementTask = baseUrl + '/riskControlDataController/implementTask';
  // 隐患上报
  static String postHiddenDangerReporting = baseUrl + '/riskControlDataController/hiddenDangerReporting';
  // 隐患治理任务列表  排查/上报   isFromCheck  1：排查 0：上报
  static String getHiddenDangerTreatment = baseUrl + '/riskControlDataController/hiddenDangerTreatment';
  // 根据隐患治理id查看详情 (蓝色部分)
  static String getHiddenDangereById = baseUrl + '/riskControlDataController/getHiddenDangereById';
  // 查看整改中白色部分详情
  static String getRiskHiddenDangereBook = baseUrl + '/riskControlDataController/getRiskHiddenDangereBook';
  // 确认隐患
  static String postIdentifyHiddenDangers = baseUrl + '/riskControlDataController/identifyHiddenDangers';
  // 整改隐患
  static String postRectificationHiddenDanger = baseUrl + '/riskControlDataController/rectificationHiddenDanger';
  // 整改验收
  static String postRectificationAcceptance = baseUrl + '/riskControlDataController/rectificationAcceptance';
  



  // 修改个人信息 (头像 描述 电子邮箱 手机号码 昵称 性别 签名)
  static String putUpdateUser = baseUrl + '/tUser/updateUser';
  // 风险分析单元列表(风险辨识任务)
  static String getRiskTemplateTwoListAllTask = baseUrl + '/riskTemplateTwo/riskTemplateTwoListAllTask';
  // 风险事件列表
  static String getRiskTemplateThreeWarehouseAll = baseUrl + '/riskTemplateThree/RiskTemplateThreeWarehouseAll';
  // 新增风险事件
  static String postRiskTemplateThreeWarehouseAll = baseUrl + '/riskTemplateThree/addRiskTemplateThreeWarehouse';
  // 风险管控措施列表
  static String getRiskTemplateFourWarehouseAll = baseUrl + '/riskTemplateFour/RiskTemplateFourWarehouseAll';
  // 新增风险管控措施
  static String postRiskTemplateFourWarehouse = baseUrl + '/riskTemplateFour/addRiskTemplateFourWarehouse';
  // 风险管控任务列表
  static String getRiskTemplateFiveWarehouseAll = baseUrl + '/riskTemplateFive/RiskTemplateFiveWarehouseAll';
  // 新增风险管控任务
  static String postAddRiskTemplateFiveWarehouse = baseUrl + '/riskTemplateFive/addRiskTemplateFiveWarehouse';

  // 查看该企业已分配部门的树状结构
  static String getDepartmentTree = baseUrl + '/coDepartment/getDepartmentTree';
  // 根据部门查看该部门下所以人员信息
  static String getCoUserByDepartment = baseUrl + '/coDepartment/getCoUserByDepartment';
  
  
  
  
  

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
