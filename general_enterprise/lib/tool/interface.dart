import 'dart:convert';

import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tpns_flutter_plugin/tpns_flutter_plugin.dart';
import '../service.dart';

class Interface {
  // static String baseAliUrl = "http://project.conf.tshzsafe.com/";
  static String mainBaseUrl = '';
  static String eduBaseUrl = '';

  // 封闭化管理地址
  static String closeBaseUrl = '';

  static String getAllConfigUrl = baseAliUrl + "/gyCompAppApiConfig";
  // static List<String> onlineWorkList = [
  //   'http://ow365.cn/?i=23893&ssl=1&furl=',
  //   'http://ow365.cn/?i=23810&furl=',
  //   'http://ow365.cn/?i=23069&ssl=1&furl='
  // ];

  static String online(String url) {
    print(url);

    String base64 = base64Encode(utf8.encode(url));
    String result = Uri.encodeComponent(base64);

    print('fileUrl/onlinePreview?url--------------------------' +
        '$fileUrl/onlinePreview?url=$result');
    return '$fileUrl/onlinePreview?url=$result';
  }

  // 已弃用接口地址
  // static String onlineWork = 'http://ow365.cn/?i=23069&ssl=1&furl=';
  // static String onlineWorkLyco = 'http://ow365.cn/?i=23810&furl=';
  // static String onlineWork = 'http://ow365.cn/?i=23069&ssl=1&furl=';
  // static String getWorkTemplateUrl = baseUrl + '/api/v4/workTemplate';
  // static String getDepartMentUrl = baseUrl + '/api/v4/department';
  // static String departMentUrl = baseUrl + '/api/v4/department';
  // static String departUserUrl = baseUrl + '/api/v4/companyUser';
  // static String workTemplateUrl = baseUrl + '/api/v4/workTemplate';
  // static String applyUrl = baseUrl + '/api/v4/workStandingBook'; // post sumbit  get =>get
  // static String verifyUrl = baseUrl + '/api/v4/workApplicationFlow';
  // static String getTempUrl = baseUrl + '/api/v4/workStandingBook/getTemporaryStorage';
  // static String strogeUrl = baseUrl + '/api/v4/workStandingBook/addTemporaryStorage';
  // static String getPrincipal = baseUrl + '/api/v4/workPublic/responsibilitiesList';
  // static String guardianListUrl = baseUrl + '/api/v4/workPerform/guardianList';
  // static String contractorListUrl = baseUrl + '/api/v4/workPublic/workContractorsList';
  // static String getInterruptWork = baseUrl + '/api/v4/workMainRoute/interruptWork';
  // static String getStatistics = baseUrl + '/api/v4/hiddenDangereStatistics/investigationResultsStatistics';
  // static String getHiddenDangerDropList = baseUrl + '/api/v4/hiddenDangereCheckControl/hiddenDangereTypeAll';
  // static String getThreeListByhiddenDangere = baseUrl + '/api/v4/hiddenDangereCheckControl/threeListByhiddenDangere';
  // static String postWorkControl = baseUrl + '/api/v4/workChecklist/workControlById/';
  // static String getDepartmentAndUser = baseUrl + '/api/v4/coInfo/getCoDepartmentAndUser';
  // 近期管控记录
  // static String getHiddenDangereHistory = baseUrl + '/api/v4/riskControl/getControlBook';
  //  my checkList
  // static String getMyHiddenDangereList = baseUrl + '/api/v4/hiddenDangereCheckControl/myHiddenDangereList';
  // static String getMyRiskList = baseUrl + '/api/v4/riskControl/myRiskControlList';
  // static String putWorkFlowInterction = baseUrl + '/api/v4/workPerform/workFlowInteraction';
  // static String getUpdateGuardianConfirm = baseUrl + '/api/v4/beTreated/updateGuardianConfirm/';
  // static String getChangeGuardianList = baseUrl + '/api/v4/beTreated/changeGuardianList';
  // static String getCancelWorkList = baseUrl + '/api/v4/beTreatedWork/cancelWorkList';
  // static String getIdentifyRiskList = baseUrl + '/api/v4/beTreatedWork/workRiskIdentifyList';
  // static String getCheckHiddenList = baseUrl + '/api/v4/hiddenDangereCheckControl/myHiddenDangereList';
  // static String getCheckHiddenRiskList = baseUrl + '/api/v4/listJob/riskControlList';
  // static String getCheckMainDetail = baseUrl + '/api/v4/listMain/showListMainDetail';
  // static String getCheckJumpWorkList = baseUrl + '/api/v4/listJob/workListByUser';
  // 项目合规详情
  // static String projectDetails = baseUrl + '/api/v4/coProjectCompliance/getCoProjectComplianceById/';
  // 作业许可证统计(曲线图)
  // static String licenceCurve = baseUrl + '/api/v4/workStatistics/statisticsByWorkDays';
  // static String getListByResourcesID = baseUrl + '/api/v4/educationTrainingResources/listByResourcesId';
  // 今日作业类型统计(柱状图)
  // static String workTypeToday2 = baseUrl + '/api/v4/workStatistics/statisticsByWorkTypeToday';
  // 根据属地单位统计作业数量(柱状图)
  // static String unitOperation = baseUrl + '/api/v4/workStatistics/statisticsByTerritorialUnit';
  // 日常巡检清单列表
  // static String getInspectionList = baseUrl + '/api/v4/riskManagement/riskList';
  // 风险相关详情  通用接口
  // static String getRiskDetails = baseUrl + '/api/v4/riskManagement/riskDetails';
  // 巡检详情
  // static String getRiskManagement = baseUrl + '/api/v4/riskManagement/riskDetailsList';
  // 日常巡检清单提交
  // static String submitPost = baseUrl + '/api/v4/riskManagement/performInspection';
  // 风险点/风险单元 台账列表
  // static String getAccountList = baseUrl + "/api/v4/riskControl/riskHistoryStatistics";
  //  风险管控进度
  // static String getRiskProgress = baseUrl + "/api/v4/riskControlStatistics/controlProgress";
  // 重大风险管控清单三级项列表
  // static String getListMajorRiskThree = baseUrl + "/api/v4/listMajorRisk/listMajorRiskThree";
  // 重大风险管控清单四级项列表
  // static String getListMajorRiskFour = baseUrl + "/api/v4/listMajorRisk/listMajorRiskFour";
  // 岗位作业清单部门列表
  // static String getListJobDepartment = baseUrl + "/api/v4/listJob/listJobDepartment";
  // 岗位作业清单部门列表
  // static String getListJobUser = baseUrl + "/api/v4/listJob/listJobUserByDepartmentId";
  // 重大风险管控清单进度统计
  // static String getMajorStatistics = baseUrl + "/api/v4/listStatistics/listMajorRiskStatistics";
  // 岗位作业清单进度统计
  // static String getJobStatistics = baseUrl + "/api/v4/listStatistics/ListJobWorkStatistics";
  // 重大风险管控清单根据四级项查看台账列表
  // static String getMajorRiskHistory = baseUrl + "/api/v4/listMajorRisk/listMajorRiskHistory";
  // 日常工作清单根据四级项查看台账列表
  // static String getDayWorkHistory = baseUrl + "/api/v4/listDayWork/listDayWorkHistory";
  // 日常工作清单进度统计
  // static String getDayStatistics = baseUrl + "/api/v4/listStatistics/listDayWorkStatistics";
  //  教育培训计划列表
  // static String getListCurrent = baseUrl + '/api/v4/educationTrainingPlan/listCurrent';
  //  教育培训计划需完成计划数量
  // static String getCompletedNum = baseUrl + '/api/v4/educationTrainingPlan/completedNum';
  //  教育培训计划详情
  // static String getById = baseUrl + '/api/v4/educationTrainingPlan/getById/';
  //  教育培训 根据大类查看类型列表
  // static String getEducationTypeListAll = baseUrl + '/api/v4/educationTrainingResources/educationTypeListAll';
  //  教育培训 根据id查看教材详情
  // static String getEducationTrainingResourcesById = baseUrl + '/api/v4/educationTrainingResources/getEducationTrainingResourcesById/';
  // 不知道干嘛地！ 后端已经没这些接口了
  static String workBaseInfoUrl = baseUrl + '/api/v4/workBaseInfo';
  static String workTemplateListUrl = baseUrl + '/api/v4/workTemplate/list';
  static String getWorkRiskIdentify =
      baseUrl + '/api/v4/workPerform/getWorkRiskIdentify/';
  static String postCancelWorkApply =
      baseUrl + '/api/v4/workPerform/cancelWorkApplication';
  static String deleteCancelWorkApply =
      baseUrl + '/api/v4/workPerform/withdrawalCancelWorkApplication/';
  static String sumbitPlan = baseUrl + '/api/v4/workPerform/addPlanWork';
  static String getWorkDetailUrl =
      baseUrl + '/api/v4/workPerform/getApplicantWorkById/';
  static String putUpdataWorkPlan =
      baseUrl + '/api/v4/workPlan/updateWorkPlan/';
  static String postApprovePlan = baseUrl + '/api/v4/workPlan/workApprovePlan';
  static String getIdentifyData =
      baseUrl + '/api/v4/workRiskIdentify/identificationDetails/';
  static String postApproveRiskIdentify =
      baseUrl + '/api/v4/workRiskIdentify/approveRiskIdentify';
  static String postApplyApprove =
      baseUrl + '/api/v4/workApplication/approveWorkApplication';
  static String submitApplyUrl =
      baseUrl + '/api/v4/workPerform/submittedApplicantWork';
  static String historyListUrl =
      baseUrl + '/api/v4/historyWork/historyWorkList';
  static String getWorkTypeDetailUrl =
      baseUrl + '/api/v4/workPerform/getApprovalById/';
  static String generalOperUrl =
      baseUrl + '/api/v4/workPerform/submittedApprovalWork/';
  static String postInputDate = baseUrl + '/api/v4/workPerform/updateWork/';
  static String workHistoryUrl =
      baseUrl + '/api/v4/historyWork/getHistoryWorkById/';
  static String lookTicketUrl =
      baseUrl + '/api/v4/historyWork/getWorkDataById/';
  static String putConfirmationWork =
      baseUrl + '/api/v4/beTreated/confirmationWorkApplication/';
  static String getWorkEnvirnmentalFatorTree =
      baseUrl + '/api/v4/beTreatedWork/getWorkEnvirnmentalFactorTree';
  static String getWorkPlan = baseUrl + '/api/v4/workPerform/getPlanById/';
  static String getGuartian =
      baseUrl + '/api/v4/workPerform/userByDepartmentId/';
  static String getChangeGuartian =
      baseUrl + '/api/v4/workPerform/updateGuardian';
  static String getChangeClose = baseUrl + '/api/v4/workPerform/specifyEndWork';
  static String getChangeDataInput =
      baseUrl + '/api/v4/workPerform/specifyPreData';
  static String getDropTypeList = baseUrl + '/api/v4/workPerform/workTypeList';
  static String workTypeList = baseUrl + '/api/v4/workPerform/workTypeList';
  static String generateHazardIdentification =
      baseUrl + '/api/v4/beTreatedWork/generateHazardIdentification';
  static String getWorkWayListAll =
      baseUrl + '/api/v4/beTreatedWork/workWayListAll';
  static String postGnerateSecurityMeasures =
      baseUrl + '/api/v4/beTreatedWork/generateSecurityMeasures';
  static String postSubmitRiskIdentification =
      baseUrl + '/api/v4/beTreatedWork/submitRiskIdentification';
  static String getriskControlDataList =
      baseUrl + "/api/v4/riskControl/riskControlDataList";
  static String setriskdata = baseUrl + "/api/v4/riskControl/riskControl";
  static String riskControlHistoryList =
      baseUrl + "/api/v4/riskControl/riskControlHistoryList";
  static String getRiskItemHistory =
      baseUrl + "/api/v4/riskControl/riskItemHistory";
  static String getListMajorFireEmergencyHistory =
      baseUrl + '/api/v4/listMajorFireEmergency/listMajorFireEmergencyHistory';

  // 封闭化管理接口
  static String addCarSubscribe = closeBaseUrl + '/subscribe/addCarSubscribe';

  static String postVisitorSubscribe =
      closeBaseUrl + '/subscribe/visitorSubscribe';

  static String getHistoricalSubscribe =
      closeBaseUrl + '/subscribe/getHistoricalSubscribe';

  static String putUploadPhotos = closeBaseUrl + '/wxController/uploadPhotos';

  static String getSubscribeList = closeBaseUrl + '/subscribe/getSubscribeList';

  static String getFaceGate =
      closeBaseUrl + '/faceAccessControlEquipment/getFaceGate';

  static String putSubscribeApproval =
      closeBaseUrl + '/subscribe/subscribeApproval';

  static String getCarEquipmentList =
      closeBaseUrl + '/humanGarage/getCarEquipmentList';

  static String getCurrentRecordList =
      closeBaseUrl + '/currentRecord/getCurrentRecordList';

  // 服务器接口地址前缀
  static String baseUrl = mainBaseUrl;
  // baseUrl Sql 数据app全局使用
  static String getAllPeople =
      baseUrl + '/api/v4/coInfo/userListAll'; // funcType 首页通讯录人员集合
  static String getAlldeparment = baseUrl +
      '/api/v4/coInfo/departmentAndPositionListAll'; // funcType 首页通讯录部门职位集合
  // get: 获取字段列表 post: 批量添加 put: 修改字段  (Translate使用)
  static String getTranslate = baseUrl + '/fieldTranslation';
  static String postTranslate = baseUrl + '/fieldTranslation';
  // 首页 person 我的页面修改签名使用 sign签名页面使用
  static String amendSign = baseUrl + '/updateSign';
  // 获取服务器当前配置 包括文件路径前缀 票路径前缀 webview路径前缀等 facelogin login index
  static String webUrl = baseUrl + '/coWebConfig';
  // 获取版本信息及最新版本下载更新地址 index login person update down
  static String cheakUpdate = baseAliUrl + '/appVersionConfig';
  // 登陆接口 login
  static String loginUrl = baseUrl + '/login';
  //  扫码登陆PC端 首页右上角扫描二维码
  static String scanCode = baseUrl + '/scanCode';
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
  // 人脸登陆 facelogin登陆页面 examFaceverify 我的清单教育培训正式考试人脸验证
  static String faceLogin = baseUrl + '/faceLogin';
  // 查询账号是否已经录入人脸数据 ExamList 我的清单教育培训正式考试前判断人脸验证操作方式
  static String getFaceData = baseUrl + '/getFaceData';
  // home 菜单配置 获取账号权限菜单
  static String getAppFunctionMenu = baseUrl + '/api/v4/menu';
  // interrruptWork 作业变更监护人
  static String postChangeGuardian =
      baseUrl + '/api/v4/workChecklist/changeGuardian';
  // amendPsd 首页我的修改密码
  static String putAmendPsd = baseUrl + '/updatePassword';
  // reNewWork 作业根据大票id查看需要续票的小票  小票list供选择
  static String getReceiptBookList =
      baseUrl + '/api/v4/workChecklist/getContinuedReceiptBookList';
  // myCount 作业数据 根据区域id查看属地单位
  static String territorialUrl =
      baseUrl + '/api/v4/workPublic/getTerritorialUnitById/';
  // 作业区域下拉选 workPlan history
  static String areaUrl = baseUrl + '/api/v4/workPublic/regionList';
  // workApply 根据流程id查看该小票包含的安全措施的管控权限
  static String getWorkApplyReceiptld =
      baseUrl + '/api/v4/workApplication/getControlAuthorityListByReceiptId';
  // 作业列表 checklisttoday我的清单 worklist作业首页列表 apply
  static String workListUrl = baseUrl + '/api/v4/workMainRoute/workList';
  // workApply 根据作业类型获取相应的特殊字段
  static String getWorkTypeFieldList =
      baseUrl + '/api/v4/workApplication/getWorkTypeFieldList';
  // changeGuardian 作业根据条件搜索人员
  static String getSearchPeople = baseUrl + '/api/v4/coInfo/listUserByKeywords';
  // workriskIdentification 作业风险辨识作业方式下拉选
  static String getWorkWayList =
      baseUrl + '/api/v4/workRiskIdentify/workWayList';
  // history 作业历史列表
  static String getWorkHistory =
      baseUrl + '/api/v4/workMainRoute/workHistoryList';
  // apply 作业单位下拉选
  static String getWorkDrop = baseUrl + '/api/v4/workPublic/workUnitsList';
  // workTicker 添加作业计划
  static String postAddWorkPlan = baseUrl + '/api/v4/workPlan/addWorkPlan';
  // workriskIdentification 作业风险辨识查看默认因素
  static String getFactor = baseUrl + '/api/v4/workRiskIdentify/defaultFactor';
  // workriskIdentification 根据选择的因素查看危害识别和安全措施
  static String postHazardAndMeasure =
      baseUrl + '/api/v4/workRiskIdentify/getHazardAndMeasures';
  // workTicker 作业票风险辨识数据提交
  static String postAddWorkRiskIdentify =
      baseUrl + '/api/v4/workRiskIdentify/addWorkRiskIdentify';
  // 根据流程id 查看作业小票及相关人员或承包商  workapply work close
  static String getApplyData =
      baseUrl + '/api/v4/workApplication/receiptAndPersonnelList';
  // workaddpeople 搜索查看企业人员或承包商
  static String getSourchUnit =
      baseUrl + '/api/v4/workApplication/workPersonnelOrContractor';
  // workTicker 作业申请作业票安全交底数据提交
  static String postAddWorkApplication =
      baseUrl + '/api/v4/workApplication/addWorkApplication';
  // worksafelist 作业清单根据流程id查看作业小票完成进度
  static String getReceiptPlannedSpeedList =
      baseUrl + '/api/v4/workChecklist/receiptPlannedSpeedList/';
  // postWork 我的岗位责任清单列表
  static String getMyCompletedListJobRolesDuty =
      baseUrl + '/api/v4/listJob/myCompletedListJobRolesDuty';
  // workControlList 作业清单根据小票id查看清单管控项目
  static String getReceiptDetail =
      baseUrl + '/api/v4/workChecklist/receiptDetailsById/';
  // workControlList 作业清单根据小票id查看当前正在完成安全措施的人员
  static String getImplementerList =
      baseUrl + '/api/v4/workChecklist/getImplementerList/';
  // workControlList 作业清单根据小票id提交当前清单节点
  static String postCarryOutWorkControl =
      baseUrl + '/api/v4/workChecklist/carryOutWorkControl';
  // gasDetect 作业清单根据id提交气体检测的数据
  static String postAddWorkGas =
      baseUrl + '/api/v4/workChecklist/addWorkGasDetectionBook';
  // gasDetectList 作业主流程 根据bookid查看气体检测小票
  static String getGasList =
      baseUrl + '/api/v4/workMainRoute/getGasReceiptBook';
  // workTicker 作业清单提交清单
  static String postCarryOutWorkChecklist =
      baseUrl + '/api/v4/workChecklist/carryOutWorkChecklist';
  // workTicker 作业关闭
  static String postClose = baseUrl + '/api/v4/workShutDown/shutDown';
  // workRiskIdentification 作业风险辨识因素下拉选
  static String getWorkRiskDrop =
      baseUrl + '/api/v4/workRiskIdentify/factorList';
  // 代办项作业人或监护人承诺签字列表 企业风险研判承诺 waitWork
  static String getWorkCommitmentList =
      baseUrl + '/api/v4/workPendingItems/workCommitmentList';
  // waitWork 代办项 作业人或监护人承诺签字
  static String putAddWorkCommon =
      baseUrl + '/api/v4/workPendingItems/addWorkCommitment/';
  // waitWork 代办项 作业负责人承诺签字列表
  static String getWorkDutyList =
      baseUrl + "/api/v4/workPendingItems/workDutyCommitmentList";
  // waitWork 代办项 作业负责人承诺签字
  static String putWorkDuty =
      baseUrl + "/api/v4/workPendingItems/addWorkDutyCommitment/";
  // waitWork 代办项 作业执行部门确认列表
  static String getWorkDepartmentListApply =
      baseUrl + '/api/v4/workPendingItems/workDepartmentList';
  // waitWork 代办项 作业变更监护人列表
  static String getWorkChangeGuardianList =
      baseUrl + '/api/v4/workPendingItems/workChangeGuardianList';
  // waitWork 代办项 作业执行部门确认提交
  static String putWorkDepartmentListApply =
      baseUrl + '/api/v4/workPendingItems/securityDepartmentConfirmed/';
  // productsInAndOut 产品出入库 扫码出入库
  static String postAddProductWarehousing =
      baseUrl + '/api/v4/warehousing/addProductWarehousing';
  // productsInAndOut 产品出入库 添加商品信息
  static String postAddProduct = baseUrl + '/api/v4/warehousing/addProduct';
  // baseHidden 隐患排查 隐患类型列表
  static String getHiddenDangerList =
      baseUrl + '/api/v4/hiddenDangereCheckControl/hiddenDangereTypeList';
  // hiddenDepartment 隐患排查 根据隐患类型查看部门列表
  static String getHiddenDeparmentList = baseUrl +
      '/api/v4/hiddenDangereCheckControl/departmentListByHiddenDangereType';
  // hiddenSpecific 隐患排查 根据部门查看隐患类型列表
  static String getHiddenTypeList = baseUrl +
      '/api/v4/hiddenDangereCheckControl/hiddenDangereTypeListByDepartmentId';
  // 隐患排查 排查项详情 hiddenConfirm hiddenScreening
  static String getHiddenDetailDrow =
      baseUrl + '/api/v4/hiddenDangereCheckControl/fourDetails';
  // hiddenScreening 隐患排查数据提交
  static String postHiddenDangereControl =
      baseUrl + '/api/v4/hiddenDangereCheckControl/hiddenDangereControl';
  // 隐患详情 hiddenReview dialogRegulationsHidden
  static String getRectificationDetail =
      baseUrl + '/api/v4/hiddenDangereCheckControl/rectificationDetails/';
  // 隐患排查 确认隐患 dailogWorkPlan dialogIsWork dialogRegulationsHidden
  static String postHiddenDangereConfirm =
      baseUrl + '/api/v4/hiddenDangereCheckControl/hiddenDangereConfirm';
  // hiddenReview 隐患排查 整改完成
  static String postRectificationCompleted =
      baseUrl + '/api/v4/hiddenDangereCheckControl/rectificationCompleted';
  // hiddenReview 隐患排查 整改审批
  static String postRectificationCompletedApprove = baseUrl +
      '/api/v4/hiddenDangereCheckControl/rectificationCompletedApprove';
  // 企业清单
  // mainList 主体责任清单 查询一级列表
  static String getlistMain = baseUrl + '/api/v4/listMain';
  // static String getLisyMainTow = baseUrl + '/api/v4/listMain/';
  // mainList 主体责任清单的清单统计
  static String getListBar = baseUrl + '/api/v4/listMain/statistics';
  // 岗位责任清单 根据用户id查看该用户的角色 mypostList postCommon
  static String getUserRoles = baseUrl + '/api/v4/listJob/rolesListByUserId';
  // postListDeails 岗位责任清单根据角色id和该用户id查看该用户在该角色下的责任清单
  static String getPostList =
      baseUrl + '/api/v4/listJob/dutyListByRolesIdAndUserId';
  // 岗位责任清单根据责任id 人管人责任标题 查看报表或管理角色责任 postListReportPToThing postListReprotPTop postListThreeType postGuard
  static String getPostReport = baseUrl + '/api/v4/listJob/getReportByDutyId';
  // 岗位责任清单查看报表 PostListReportPToP CheckPostGuard
  static String getCheckPostReport =
      baseUrl + '/api/v4/listJob/myReportByDutyId';
  // 岗位责任清单确认报表 PostListReportPToP CheckPostGuard
  static String postConfirmReport = baseUrl + '/api/v4/listJob/confirmReport';
  // overview 作业总览 各属地单位特殊作业统计
  static String getWorkTerriorialUnit =
      baseUrl + '/api/v4/workStatistics/workSpecialByTerritorialUnit';
  // 作业类型下拉选 WorkRiskIdentification WorkSafeList histroy
  static String getWorkType =
      baseUrl + '/api/v4/workPublic/workTypeBySpecialList';
  // 作业计划详情
  static String getWorkDetail = baseUrl + '/api/v4/workPlan/planDetails/';
  // waitWork 代办项作业 变更监护人确认
  static String putWorkGuardian =
      baseUrl + '/api/v4/workPendingItems/confirmWorkChangeGuardian';
  // workClose 作业关闭 根据流程id查看作业小票完成进度
  static String getWrokClosePeople =
      baseUrl + '/api/v4/workShutDown/getWorkShutDownPeople/';
  // 作业主流程 interruptWork 中断作业
  static String putInterrupWork =
      baseUrl + '/api/v4/workMainRoute/interruptWork';
  // 作业主流程 interruptWork 中断作业小票
  static String putInterrupReceipt =
      baseUrl + '/api/v4/workMainRoute/interruptWorkReceipt';
  // 作业属地单位下拉选 history workList apply
  static String dropTerritorialUnitList =
      baseUrl + '/api/v4/workPublic/territorialUnitList';
  // overview 作业总览作业来源
  static String getWrokSource = baseUrl + '/api/v4/workStatistics/workSource';
  // 风险一级项下拉 hiddenSpecificItem inspecion risklist worklist controlIndex
  static String getCheckOneListAll = baseUrl + '/api/v4/riskControl/oneListAll';
  // 风险二级项下拉 hiddenSpecificItem inspecion risklist worklist
  static String getCheckTwoListAll = baseUrl + '/api/v4/riskControl/twoListAll';
  // 风险三级项下拉 hiddenSpecificItem inspecion
  static String getCHeckThreeListAll =
      baseUrl + '/api/v4/riskControl/threeListAll';
  // 我的清单巡检点检列表 hiddenSpecificItem inspecion
  static String getCHeckRiskControlList =
      baseUrl + '/api/v4/riskControl/myRiskControlList';
  // 根据三级项id批量管控当前四级项 hiddenSpecificItem inspecion
  static String postCheckBatchControl =
      baseUrl + '/api/v4/hiddenDangereCheckControl/batchControl';
  // 我管理的岗位责任清单 postIdentify
  static String getRoleReportList =
      baseUrl + '/api/v4/listJob/myListJobRolesDuty';
  // 企业合规性
  // 企业基本信息 basicMessage
  static String basicMessage = baseUrl + '/api/v4/coInfo/getCoInfo';
  // 安全管理机构 safetyManagement
  static String safetyManagement =
      baseUrl + '/api/v4/coMechanism/coMechanismList';
  // licencetype 查看证书已分配的树状结构  0为企业,1为人员,2为设备
  static String licenceTree =
      baseUrl + '/api/v4/certificate/getCoCertificateTypeTree';
  // CheckedLicence 根据证书类型查看证书列表
  static String licenceList =
      baseUrl + '/api/v4/certificate/getCoCertificateListByTypeId/';
  // LicenseDetails 查看证书详情
  static String getLicenseDetails =
      baseUrl + '/api/v4/certificate/getCoCertificateById/';
  // ProjectCompliance 项目合规列表
  static String projectComplianceLsit =
      baseUrl + '/api/v4/coProjectCompliance/coProjectComplianceLsit';
  // legislation 法律法规列表
  static String legislation =
      baseUrl + '/api/v4/lawsRegulations/lawsRegulationsLsit';
  // lawDetails 法律法规详情
  static String lawDetails =
      baseUrl + '/api/v4/lawsRegulations/getLawsRegulationsById/';
  // 今日作业统计(饼状图) home overview
  static String workTypeToday =
      baseUrl + '/api/v4/workStatistics/workStatusStatistics';
  // 八大特殊作业的占比 home overview
  static String getWorkPercen =
      baseUrl + '/api/v4/workStatistics/workSpecialProportion';
  // overview 作业总览历史趋势
  static String getWorkHisoryTrend =
      baseUrl + '/api/v4/workStatistics/historicalTrend';
  // 风险管控 巡检点检一级列表 riskhome spotCheck
  static String getRiskUnitList =
      baseUrl + "/api/v4/riskControl/riskControlPointList";
  // 风险管控 巡检点检二级列表 riskControl spotCheckControl
  static String getriskControlUnitList =
      baseUrl + "/api/v4/riskControl/riskControlUnitList";
  // 风险管控 巡检点检三级列表 riskcount spotCheckCount
  static String getriskControlItemList =
      baseUrl + "/api/v4/riskControl/riskControlItemList";
  //  风险统计(风险管控) riskcount risk riskControl
  static String getRiskStatistics =
      baseUrl + "/api/v4/riskControlStatistics/riskStatistics";
  //  按风险点统计风险(风险管控)  risk
  static String getRiskPoint =
      baseUrl + "/api/v4/riskControlStatistics/riskStatisticsByRiskPoint";
  //  风险项详情
  static String getThreeDetails = baseUrl + "/api/v4/riskControl/threeDetails";
  // 风险管控四级项列表（风险管控条目） riskFour
  static String getSpotFourList =
      baseUrl + "/api/v4/riskControl/riskControlEntryList";
  // 巡检点检四级项列表（巡检条目） spotCheckFour
  static String getRiskFourList =
      baseUrl + '/api/v4/riskControl/inspectionControlEntryList';
  // 日常工作清单三级项列表 workList
  static String getListDayWorkThree =
      baseUrl + "/api/v4/listDayWork/listDayWorkThree";
  // 日常工作清单四级项列表 workListCommon
  static String getListDayWorkFour =
      baseUrl + "/api/v4/listDayWork/listDayWorkFour";
  // 修改头像 avatar myMessage
  static String amendAvatar = baseUrl + '/updateUrl';
  //  风险管控 管控分类统计图(每级列表上方统计图) riskcount risk riskControl
  static String getControlClassificationStatistics =
      baseUrl + '/api/v4/riskControlStatistics/controlClassificationStatistics';
  //  巡检点检|隐患排查 排查或巡检落实进度统计  home hiddenDanger picture spotcheckCount spotControl spotCheck
  static String getImplementationStatistics =
      baseUrl + '/api/v4/riskControlStatistics/implementationStatistics';
  //  巡检点检|隐患排查 排查或巡检异常处置情况统计 home hiddenDanger pictrue spotcheckCount spotControl spotCheck
  static String getDisposalDiddenDangersStatistics =
      baseUrl + '/api/v4/riskControlStatistics/disposalDiddenDangersStatistics';
  //  巡检点检|隐患排查 排查或巡检结果实时统计 hiddenDanger spotCheck
  static String getRealTimeHiddenDangerStatistics =
      baseUrl + '/api/v4/riskControlStatistics/realTimeHiddenDangerStatistics';
  //  风险管控分类列表 riskFilterFour
  static String getRiskControlListClassification =
      baseUrl + '/api/v4/riskControl/riskControlListClassification';
  //  根据教材id打分 educationGradeDialog
  static String postScoreByResourcesId =
      baseUrl + '/api/v4/educationTrainingResources/scoreByResourcesId';
  //  教育培训知识库查询 educationDatabaseList
  static String getKnowledgeBase =
      baseUrl + '/api/v4/knowledgeBase/knowledgeBase';
  //  教育培训知识库详情 educationDatabase educationDatabaseMSDS
  static String getKnowledgeBaseDetails =
      baseUrl + '/api/v4/knowledgeBase/knowledgeBaseDetails';
  //  重大风险|消防|应急清单 三级项列表 risklist
  static String getListMajorFireEmergencyThree =
      baseUrl + '/api/v4/listMajorRisk/listMajorRiskThree';
  //  重大风险|消防|应急清单 四级项列表 emergencyCommon riskCommon
  static String getListMajorFireEmergencyFour =
      baseUrl + '/api/v4/listMajorRisk/listMajorRiskFour';
  // buildBaseInfo 涉及建筑物的风险点集合
  static String getRiskListBuildBaseInfo =
      baseUrl + '/api/v2/flpBuildingInformation/riskList';
  // buildBaseInfoDetail 根据风险点查看建筑物
  static String getBuildBaseInfoDetail =
      baseUrl + '/api/v2/flpBuildingInformation/flpBuildingInformationList';
  //  educationSignIn 教育培训计划签到
  static String postSignin = baseUrl + '/api/v4/educationTrainingPlan/signin';
  /*
   * 企业合规性列表
   * 1：企业基本信息  basicMessage
   * 2：安全生产管理机构  fileMansgement
   * 5: 设备证照  licenseType
   * 6：项目合规性  fileProject
   * 7：管理制度和操作规程  legitmateSystem
   * 8：生产设施及工艺安全  legitmateCraft
   */
  static String getFileListAll = baseUrl + '/api/v4/fixedFile/listAll';
  /*
   * 文件类型 查看该企业已分配文件类型树状结构
   * 1：企业基本信息  fileManagement
   * 2：安全生产管理机构  fileProject
   * 3: 管理制度和操作规程  legitmateSystem
   * 4: 生产设施及工艺安全  legitmateCraft
   */
  static String getFileTypeTree = baseUrl + '/api/v4/fileType/getFileTypeTree';
  // 企业合规性 根据类型id查看文件列表 fileList
  static String getFileListByTypeId =
      baseUrl + '/api/v4/fileType/getFileListByTypeId/';
  // PostWorkDetail 岗位责任清单 根据报表数据查看详情
  static String postPostWorkDetail =
      baseUrl + '/api/v4/listJob/detailsByReport';
  // 修改用户在线状态 faceLogin login index person
  static String putAmendChatStatus = baseUrl + '/updateOnlineStatus';
  // 查询用户在线状态 chat 聊天
  static String getChatStatus = baseUrl + '/updateOnlineStatus';
  // 主动消息推送 chat callview 聊天
  static String postActivePush = baseUrl + '/api/v4/coInfo/activeMessagePush';
  // home 安全生产清单
  static String getIndexResopnSafeLIst =
      baseUrl + '/api/v4/listStatistics/homePageResponsibilityList';
  // 企业合规性 更新证书文件 LicenseUpDate
  static String putUpdateCoCertificateFileById =
      baseUrl + '/api/v4/certificate/updateCoCertificateFileById/';
  // EmergencyRescueFirmFile 应急【预案文件】查看
  static String getPlanFile = baseUrl + '/api/v2/ERPlan/planFile';
  // EmergencyRescueFirmPlan 应急【预案信息】列表不分页
  static String getPlanFirm = baseUrl + '/api/v2/ERPlan/all';
  // 应急【预案历史】下拉选列表 emergencyRescueFirmHis emergencyRescueAdmin
  static String getOption = baseUrl + '/api/v4/emergencyRescue/getOption';
  // 应急【预案历史】预案修订历史记录列表 emergencyRescueFirmHis
  static String getErPlanRecordList =
      baseUrl + '/api/v2/HistoricalRevisionRecord/erPlanRecordList';
  // 应急【预案历史】预案文件修订历史记录列表 emergencyRescueFirmHis
  static String getErPlanFileRecordList =
      baseUrl + '/api/v2/HistoricalRevisionRecord/erPlanFileRecordList';
  // 应急【应急指挥】指挥部及办公室 EmergencyRescueHeadDetails EmergencyRescueOfficeDetails EmergencyRescueConduct
  static String getEREmergencyHeadquarters =
      baseUrl + '/api/v4/EREmergencyHeadquarters';
  // EmergencyRescueConduct 应急【应急指挥】救援队伍
  static String getERHeadquartersRescueTeam =
      baseUrl + '/api/v4/ERHeadquartersRescueTeam';
  // EmergencyRescueTeamDetails 应急【应急指挥】救援队伍详情
  static String getERHeadquartersRescueTeamDetails =
      baseUrl + '/api/v4/ERHeadquartersRescueTeam/';
  // EmergencyRescueAdmin 应急【应急事故列表】
  static String getERAccident = baseUrl + '/api/v4/ERAccident';
  // EmergencyRescueResponse 应急【应急响应详情】
  static String getEREesponse = baseUrl + '/api/v4/EREesponse';
  // EmergencyRescueSingleTeam 应急【救援队列表】
  static String getERRescueTeam = baseUrl + '/api/v4/ERRescueTeam';
  // EmergencyRescueSingleTeamDetails 应急【救援队详情】
  static String getERRescueTeamDetails = baseUrl + '/api/v4/ERRescueTeam/';
  // EmergencyRescueExpert 应急【签约救援专家列表】
  static String getErExpertsListBySigning =
      baseUrl + '/api/v4/ERExperts/erExpertsListBySigning';
  // EmergencyRescueExpertInfo 应急【查看救援专家信息】
  static String getERExperts = baseUrl + '/api/v4/ERExperts/';
  // EmergencyRescueInsideMaterials 应急【救援物资一级列表】
  static String getErEquipmentMaterialList =
      baseUrl + '/api/v4/EREquipmentMaterial/erEquipmentMaterialList';
  // EmergencyRescueInsideMaterialsTow 应急【救援物资二级列表】
  static String getErEquipmentMaterialLibraryList =
      baseUrl + '/api/v4/EREquipmentMaterial/erEquipmentMaterialLibraryList';
  // EmergencyRescueInsideMaterialsDetails 应急【救援物资详情】
  static String getShowErEquipmentMaterialLibrary =
      baseUrl + '/api/v4/EREquipmentMaterial/showErEquipmentMaterialLibrary/';
  // EmergencyRescueCardDetails 应急【处置卡列表】
  static String getSelectCardsByStructureId =
      baseUrl + '/api/v4/ERDisposalCard/selectCardsByStructureId';
  // EmergencyRescueCardDetails 应急【处置卡详情】
  static String getShowCardById =
      baseUrl + '/api/v4/ERDisposalCard/showCardById';
  // EmergencyRescueAdminDetails 应急【事故详情】
  static String getERAccidentById = baseUrl + '/api/v4/ERAccident/';
  // basicMessage 企业合规性 基础信息化工工艺列表
  static String getChemicalsProcessList =
      baseUrl + '/api/v4/coInfo/regulatoryChemicalProcessList';
  // 重大危险源列表 DangerWord basicMessage
  static String getMajorHazardList = baseUrl + '/api/v4/coInfo/majorHazardList';
  // 危险化学品列表 basicMessage dangerList
  static String getChemicalList = baseUrl + '/api/v4/coInfo/chemicalList';

  // 获取所有操作卡
  static String getOperationCard =
      baseUrl + '/api/v4/fileType/getOperationCard';
  // 口诀图片
  static String getTwoCards = baseUrl + '/api/v4/fileType/getTwoCards';
  // 两单两卡 风险清单
  static String getTwoCardsRiskList =
      baseUrl + '/api/v4/riskControl/getTwoCardsRiskList';

  static String getChemiclById = baseUrl + '/api/v4/coInfo/chemicalById/';
  static String getBaseList =
      baseUrl + '/api/v4/majorHazard/coBasicFeaturesLsit';
  static String getCurrenOnDuty = baseUrl + '/api/v2/ErOnDuty/currentlyOnDuty';
  static String putChangeDutyReport = baseUrl + '/api/v2/ErOnDuty/dutyReport';
  static String getEronDuty = baseUrl + '/api/v2/ErOnDuty';
  static String getDutySign = baseUrl + '/api/v2/ErOnDuty/onDutySignIn';
  static String putSignIn = baseUrl + '/api/v2/ErOnDuty/signIn';
  static String getFireFightRisk =
      baseUrl + '/api/v4/FireFightingEquipment/fireFightingRiskList';
  static String getFireRiskThreeList =
      baseUrl + '/api/v4/FireFightingEquipment/fireFightingRiskThreeList';
  static String getFireRiskFour =
      baseUrl + '/api/v4/FireFightingEquipment/fireFightingRiskFourList';
  static String getFireStatistics =
      baseUrl + '/api/v4/FireFightingStatistics/fireFightingStatistics';
  static String getFireStatisticsRisk = baseUrl +
      '/api/v4/FireFightingStatistics/fireFightingStatisticsByTypeAndRisk';
  static String getCoMajorHazardFileList =
      baseUrl + '/api/v4/majorHazard/coMajorHazardFileLsit';
  static String getFlpsystemList = baseUrl + '/api/v2/flpsystem/flpsystemList';

  static String getEnterpriseLearning =
      baseUrl + '/api/v4/educationOverview/enterpriseLearning';
  static String getEnterpriseTrain =
      baseUrl + '/api/v4/educationOverview/trainingSituation';
  static String getEnterpriseTrends =
      baseUrl + '/api/v4/educationOverview/learningTrends';
  static String getEnterpriseRank =
      baseUrl + '/api/v4/educationOverview/learningRanking';
  static String getMaterStatic =
      baseUrl + '/api/v4/educationOverview/teachingMaterialStatistics';

  static String getConotice = baseUrl + '/api/v4/coNotice/getCoNotice';
  static String putPromiseNotice = baseUrl + '/api/v4/coNotice/promiseNotice/';

  static String getWorkDepartmentList =
      baseUrl + '/api/v4/workApplication/getWorkDepartmentList';
  static String getWorkDepartmentUserList =
      baseUrl + '/api/v4/workApplication/getWorkDepartmentUserList';
  static String getWorkRoleUserList =
      baseUrl + '/api/v4/workApplication/getWorkRoleUserList';

  static String getWorkCrowdReceipyid =
      baseUrl + "/api/v4/workMainRoute/getworkCrowdByReceiptId";

  static String getUserByControlAuthority =
      baseUrl + '/api/v4/workApplication/getUserByControlAuthority';

  static String getWorkLevel =
      baseUrl + "/api/v4/workApplication/workLevelByWorkType";

  static String putStartWorkById =
      baseUrl + '/api/v4/workChecklist/startWorkById/';

  static String operateWorkByid =
      baseUrl + '/api/v4/workChecklist/operateScheduleWorkById/';

  // face regon
  static String postFaceFeature =
      baseUrl + '/api/v4/faceRecognition/addFaceRecognition';

  static String getFaceFeature =
      baseUrl + '/api/v4/faceRecognition/getFaceRecognition';
  static String postFaceLogin =
      baseUrl + '/api/v4/faceRecognition/faceRecognitionLogin';

  // 手段为数据录入历史
  static String getMeterDataHistory =
      baseUrl + '/api/v4/riskControl/meterDataHistory';

  static String getApprovalNode =
      baseUrl + "/api/v4/workChecklist/getApprovalNode";

  static String getControlStatus =
      baseUrl + "/api/v4/riskControl/getControlStatus";

  static String putControlStatus = baseUrl + "/api/v4/riskControl/workVacation";

  static String addListJobCarriedOut =
      baseUrl + '/api/v4/listJob/addListJobCarriedOut';

  static String getListJobCarriedOut =
      baseUrl + "/api/v4/listJob/getListJobCarriedOut";

  // 所有模块台账列表接口
  static String getControlBook = baseUrl + "/api/v4/riskControl/getControlBook";
  // 隐患排查治理台账
  static String getListHiddenHistory =
      baseUrl + "/api/v4/hiddenDangereCheckControl/listHiddenHistory";
  // 隐患治理台账一级页面统计
  static String getTotalStatistics =
      baseUrl + "/api/v4/hiddenDangereCheckControl/totalStatistics";

  static String getTerritorialUnitAll =
      baseUrl + "/api/v4/hiddenDangereCheckControl/territorialUnitAll";

  static String getRiskOneListAllByterritorialUnit = baseUrl +
      "/api/v4/hiddenDangereCheckControl/riskOneListAllByterritorialUnit";

  //  清单预警轮播信息
  static String getListWarningInformation =
      baseUrl + "/api/v4/listStatistics/listWarningInformation";

  static String getResponsibilityList =
      baseUrl + "/api/v4/listStatistics/responsibilityList";

  // 主体责任清单统计图
  static String getMainStatistics =
      baseUrl + "/api/v4/listStatistics/listMainStatistics";

  static String getJobResponsibilitiesNum =
      baseUrl + "/api/v4/listStatistics/jobResponsibilitiesNum";

  // 日常巡检点检隐患排查安全作业统计
  static String getCheckHiddenWorkStatistics =
      baseUrl + "/api/v4/listStatistics/checkHiddenWorkStatistics";

  // 重大风险管控清单环状图
  static String getMajorRiskControlRing =
      baseUrl + "/api/v4/listStatistics/majorRiskControlRing";

  // 日常安全工作可控程度总计
  static String getDailySafetyControllableDegreeTotal =
      baseUrl + "/api/v4/listStatistics/dailySafetyControllableDegreeTotal";

  // 重大风险管控清单实时可控程度
  static String getMajorRiskControlControllableDegree =
      baseUrl + "/api/v4/listStatistics/majorRiskControlControllableDegree";

  // 重大风险管控清单实时可控程度
  static String getDailySafetyControllableDegree =
      baseUrl + "/api/v4/listStatistics/dailySafetyControllableDegree";

  // 清单履职天数
  static String getPerformDuties =
      baseUrl + "/api/v4/listStatistics/performDuties";

  static String getUncontrolledAll =
      baseUrl + "/api/v4/riskControl/uncontrolledAll";

  static String getUncontrolledFourList =
      baseUrl + "/api/v4/riskControl/uncontrolledFourList";

  // edu
  static String getResourcesTypeLeveLOne =
      eduBaseUrl + "/api/v4/resourcesType/getResourcesTypeLeveLOne";

  static String getResourcesTypeSubordinate =
      eduBaseUrl + "/api/v4/resourcesType/getResourcesTypeSubordinate";

  static String getEducationTrainingResourcesList =
      eduBaseUrl + "/api/v4/resources/educationTrainingResourcesListByCompany";

  static String getNewEducationTrainingResourcesList =
      eduBaseUrl + "/api/v4/resources/getEducationTrainingResourcesById/";

  static String getEducationQuestionLibraryByresourcesId = eduBaseUrl +
      "/api/v4/educationQuestionLibrary/getEducationQuestionLibraryByresourcesId/";

  static String getPrincipalListAll =
      eduBaseUrl + "/api/v4/educationTrainingResearch/principalListAll";

  static String postAddEducationTrainingResearch = eduBaseUrl +
      "/api/v4/educationTrainingResearch/addEducationTrainingResearch";

  static String getEducationTrainingResearchSponsorList = eduBaseUrl +
      "/api/v4/educationTrainingResearch/educationTrainingResearchSponsorList";

  // static String getEducationTrainingResearchById = eduBaseUrl +
  //     "/api/v4/educationTrainingResearch/getEducationTrainingResearchById/";

  static String postFavoritesResources =
      eduBaseUrl + "/api/v4/resources/favoritesResources";

  static String postDeleteFavoritesResources =
      eduBaseUrl + "/api/v4/resources/deleteFavoritesResources";

  static String getEducationTrainingResearchProcessingList = eduBaseUrl +
      "/api/v4/educationList/educationTrainingResearchProcessingList";

  static String postVotingOrPicking =
      eduBaseUrl + "/api/v4/educationList/votingOrPicking";

  static String getEducationTrainingPlanProcessingList =
      eduBaseUrl + "/api/v4/educationList/educationTrainingPlanProcessingList";

  static String getMyListPlanById =
      eduBaseUrl + "/api/v4/educationList/myListPlanById";

  static String getMyFavoritesResourcesList =
      eduBaseUrl + "/api/v4/resources/myFavoritesResourcesList";

  static String getMyResourcesCompletionStatistics = eduBaseUrl +
      "/api/v4/educationTrainingPlan/myResourcesCompletionStatistics";

  static String getMyPlanResourcesBookList =
      eduBaseUrl + "/api/v4/educationTrainingPlan/myPlanResourcesBookList";

  static String getMyResourcesBookListByPlanId =
      eduBaseUrl + "/api/v4/educationTrainingPlan/myResourcesBookListByPlanId";
  static String getExamList = eduBaseUrl +
      "/api/v4/educationList/myEducationTrainingPlanExaminationList";

  static String getLibraryListByid =
      eduBaseUrl + '/api/v4/educationList/getLibraryListById';
  static String postScoring = eduBaseUrl + '/api/v4/educationList/scoring';

  static String getEducationTrainingPlanSponsorList = eduBaseUrl +
      "/api/v4/educationTrainingPlan/educationTrainingPlanSponsorList";

  static String getEducationTrainingOfflinePlanSponsorList = eduBaseUrl +
      "/api/v4/educationTrainingOfflinePlan/educationTrainingOfflinePlanSponsorList";

  static String getViewPlanDetails =
      eduBaseUrl + "/api/v4/educationTrainingPlan/viewPlanDetails";

  static String getResearchDetailsById =
      eduBaseUrl + "/api/v4/educationTrainingPlan/getResearchDetailsById";

  static String getPlanDetailsById =
      eduBaseUrl + "/api/v4/educationTrainingPlan/getPlanDetailsById";

  static String getExaminationDetailsByPlanId = eduBaseUrl +
      "/api/v4/educationTrainingPlan/getExaminationDetailsByPlanId";

  static String getExaminationDetailsById =
      eduBaseUrl + "/api/v4/educationTrainingPlan/getExaminationDetailsById";

  static String getMyPlanExaminationBookList =
      eduBaseUrl + "/api/v4/educationTrainingPlan/myPlanExaminationBookList";

  static String getMyExaminationBookListByPlanId = eduBaseUrl +
      "/api/v4/educationTrainingPlan/myExaminationBookListByPlanId";

  static String getMyExaminationById =
      eduBaseUrl + "/api/v4/educationTrainingPlan/myExaminationById";

  static String getOverallRating =
      eduBaseUrl + "/api/v4/overview/overallRating";

  static String getPassRate = eduBaseUrl + "/api/v4/overview/passRate";

  static String getPlanProcessingStatistics =
      eduBaseUrl + "/api/v4/overview/planProcessingStatistics";

  static String getLearningTrends =
      eduBaseUrl + "/api/v4/overview/learningTrends";

  static String getStatisticsLearningMaterials =
      eduBaseUrl + "/api/v4/homepage/statisticsLearningMaterials";

  static String getExamRanking = eduBaseUrl + "/api/v4/homepage/examRanking";

  static String getLearnRanking = eduBaseUrl + "/api/v4/homepage/learnRanking";

  static String getEducationTrainingOfflinePlanListByUserId = eduBaseUrl +
      "/api/v4/educationList/educationTrainingOfflinePlanListByUserId";

  static String getMyLibraryScoreAndRanking =
      eduBaseUrl + "/api/v4/educationList/myLibraryScoreAndRanking";

  static String getMyPlanNum = eduBaseUrl + "/api/v4/educationList/myPlanNum";

  static String getMyEducationTrainingTaskStatistics =
      eduBaseUrl + "/api/v4/educationList/myEducationTrainingTaskStatistics";

  static String postSubmitStudyRecords =
      eduBaseUrl + "/api/v4/educationList/submitStudyRecords";

  static String deleteEducationTrainingResearch = eduBaseUrl +
      "/api/v4/educationTrainingResearch/deleteEducationTrainingResearch";

  static String getEduQuestionByresourcesId = eduBaseUrl +
      "/api/v4/educationQuestionLibrary/getEducationQuestionLibraryByresourcesId/";

  static String postAssignableLibraryNum =
      eduBaseUrl + "/api/v4/educationTrainingPlan/assignableLibraryNum";

  static String postAddEducationTrainingPlan =
      eduBaseUrl + "/api/v4/educationTrainingPlan/addEducationTrainingPlan";

  static String getPersonalFile =
      eduBaseUrl + "/api/v4/educationList/personalFile";

  //  教育培训年度总体评估
  static String getOverallAssessment =
      eduBaseUrl + "/api/v4/homepage/overallAssessment";

  //  所有计划总列表
  static String getEducationTrainingPlanList =
      eduBaseUrl + "/api/v4/educationTrainingPlan/educationTrainingPlanList";
  static String getEducationTrainingOfflinePlanList = eduBaseUrl +
      "/api/v4/educationTrainingOfflinePlan/educationTrainingOfflinePlanList";
  // 扫码签到
  static String postOfflinePlanSignIn =
      eduBaseUrl + "/api/v4/educationList/offlinePlanSignIn";

  // 根据用户id 计划id 阶段 查看教材培训完成度
  static String getEduSchedule =
      eduBaseUrl + "/api/v4/educationTrainingPlan/getEduSchedule/";

  // 根据userId查看试卷详情
  static String getExaminationPaper =
      eduBaseUrl + "/api/v4/educationList/getExaminationPaper/";

  // 调研列表部门下拉列表
  static String getTrainMyDepartment =
      eduBaseUrl + "/api/v4/educationTrainingResearch/myDepartmentApp";

  // 计划列表线上部门下拉列表
  static String getPlanMyDepartment =
      eduBaseUrl + "/api/v4/educationTrainingPlan/myDepartmentApp";

  // 计划列表线下部门下拉列表
  static String getMyDepartmentOfflineApp =
      eduBaseUrl + "/api/v4/educationTrainingPlan/myDepartmentOfflineApp";

  // 线下计划详情
  static String getEducationTrainingOfflinePlanDetails = eduBaseUrl +
      "/api/v4/educationTrainingOfflinePlan/getEducationTrainingOfflinePlanDetails/";

  // 年度教育培训计划年度列表（一）
  static String getPlanYearList =
      eduBaseUrl + "/api/v4/educationTrainingPlanYear/getPlanYearList";

  // 年度教育培训计划年度列表（二）
  static String getPlanYearSublist =
      eduBaseUrl + "/api/v4/educationTrainingPlanYear/getPlanYearSublist";

  // 年度教育培训计划年度列表（三）线上
  static String getPlanYearSubDetailsList = eduBaseUrl +
      "/api/v4/educationTrainingPlanYear/getPlanYearSubDetailsList/";

  // 年度教育培训计划年度列表（三）线下
  static String getOfflineYearList = eduBaseUrl +
      "/api/v4/educationOfflineTrainingPlanYear/getOfflineYearList/";

  // 年度教育培训计划 线下详情
  static String getOfflineYearDetails = eduBaseUrl +
      "/api/v4/educationOfflineTrainingPlanYear/getOfflineYearDetails/";

  // 年度教育培训计划 线上详情
  static String getPlanDetailed =
      eduBaseUrl + "/api/v4/educationTrainingPlanYear/getPlanDetailed/";

  // 年度人员列表考试详情
  static String getYearExaminationPaper =
      eduBaseUrl + "/api/v4/educationTrainingPlanYear/getExaminationPaper/";

  // 总览权限列表
  static String getJurisdiction =
      eduBaseUrl + "/api/v4/homepage/getJurisdiction";

  // 总览三个卡片
  static String getOverview = eduBaseUrl + "/api/v4/homepage/overview";

  // 总览 个人权限 个人培训考核排名
  static String getMyExamRanking =
      eduBaseUrl + "/api/v4/homepage/myExamRanking";

  // 教育培训达标情况 分类列表
  static String getQualificationList =
      eduBaseUrl + "/api/v4/homepage/getQualificationList";

  // 我的清单 调研详情
  static String getEducationTrainingResearchByIdTwo = eduBaseUrl +
      "/api/v4/educationTrainingResearch/getEducationTrainingResearchByIdTwo";

  // 我的清单 查看计划阶段必修教材
  static String getMyListPlanStageById =
      eduBaseUrl + "/api/v4/educationList/myListPlanStageById";

  // 个人安全培训信息档案
  static String getPersonalTrainingFile =
      eduBaseUrl + "/api/v4/educationList/personalTrainingFile";

  // 培训考试评测情况
  static String getpersonalTrainingDetails =
      eduBaseUrl + "/api/v4/educationList/getPersonalTrainingDetails";

  // 培训学时明细
  static String getPersonalTrainingFileDetails =
      eduBaseUrl + "/api/v4/educationList/personalTrainingFileDetails";

  static String getClassHours =
      eduBaseUrl + "/api/v4/educationList/getClassHours";

  static String getYearClassHours =
      eduBaseUrl + "/api/v4/educationTrainingPlan/getYearClassHours";

  // 图片题列表
  static String getPicQuestionList =
      eduBaseUrl + "/api/v4/educationList/picQuestionList";

  static String addPicQuestion =
      eduBaseUrl + "/api/v4/educationList/addPicQuestion";

  // 获取档案图片 base64 编码
  static String getBase64 = eduBaseUrl + "/api/v4/educationList/getBase64";

  /*
   * 产品出入库
   */
  static String getWarehousingProductList =
      baseUrl + "/api/v4/warehousingProduct/warehousingProductList";

  static String getWarehousingProductById =
      baseUrl + "/api/v4/warehousingProduct/getWarehousingProductById";

  static String getProductLibraryById =
      baseUrl + "/api/v4/warehousingProduct/getProductLibraryById";

  static String getWarehousingWarehouseList =
      baseUrl + "/api/v4/warehousingWarehouse/warehousingWarehouseList";

  static String getInStock =
      baseUrl + "/api/v4/warehousingWarehouse/getInStock";

  static String getWarehousingProductByBarCode =
      baseUrl + "/api/v4/warehousingProduct/getWarehousingProductByBarCode";

  static String postDelivery =
      baseUrl + "/api/v4/warehousingWarehouse/delivery";

  static String getWarehousingShippmentRecordById =
      baseUrl + "/api/v4/warehousingProduct/getWarehousingShippmentRecordById";

  static String getWarehousingShippmentRecordByWarehouseId = baseUrl +
      "/api/v4/warehousingWarehouse/getWarehousingShippmentRecordByWarehouseId";

  static String getWarehousingProductListByWarehouseId = baseUrl +
      "/api/v4/warehousingWarehouse/warehousingProductListByWarehouseId";

  static String getSupplierList =
      baseUrl + "/api/v4/warehousingSupplier/supplierList";

  static String getCustomerList =
      baseUrl + "/api/v4/warehousingShippmentRecord/customerList";

  static String getByRecordId =
      baseUrl + "/api/v4/warehousingShippmentRecord/getByRecordId/";

  // 人脸录入
  static String uploadUrlTwo = baseUrl + '/uploadTwo';
  // 录制人脸数据
  static String addFaceRecognition = baseUrl + '/addFaceRecognition';

  // 获取直播回放视频
  static String getPlaybackVideo = eduBaseUrl + '/api/v4/video/getVideo';

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
          XgFlutterPlugin().cleanAccounts();
          XgFlutterPlugin().stopXg();
          isLogin = true;
          String _accout = myprefs.getString('account');
          String _company = myprefs.getString('enterpriseName');
          XgFlutterPlugin().unbindWithIdentifier(
              identify: _accout, bindType: XGBindType.account);
          XgFlutterPlugin().cleanAccounts();
          XgFlutterPlugin().stopXg();
          MethodChannel _channel = MethodChannel("messagePushChannel");
          _channel.invokeMethod("logout").then((value) => print(value));
          myDio.request(
              type: 'put',
              url: Interface.putAmendChatStatus,
              data: {"onlineStatus": "0"}).then((value) {});

          await myprefs.clear();
          await myprefs.setString('account', _accout ?? '');
          await myprefs.setString('SavedenterpriseName', _company ?? '');

          Navigator.pushNamed(context, '/login');
        }
      }
    }
  }
}
