import 'package:enterprise/pages/waitWork/_chatList.dart';
import 'package:enterprise/pages/waitWork/_commonPage.dart';
import 'package:enterprise/pages/waitWork/_emergencyOnDuty.dart';
import 'package:enterprise/pages/waitWork/_enterprisePromise.dart';
import 'package:enterprise/pages/waitWork/_riskIdentify.dart';
import 'package:enterprise/pages/waitWork/waitWork.dart';

import '_riskControl.dart';

import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    waitRouter = [
  {
    '/index/waitWork': (context, {arguments}) => WaitWork(
          way: arguments['way'],
        ),
  },
  {
    '/index/waitWork/riskControl': (context, {arguments}) => WaitRiskControl(
          arguments: arguments,
        )
  },
  {
    '/index/waitWork/riskControl/riskIdentify': (context, {arguments}) =>
        WaitWorkRiskIdentify(
          arguments: arguments,
        )
  },
  {
    '/index/waitWork/commonPage': (context, {arguments}) => WaitCommonPage(
          url: arguments['url'],
          title: arguments['title'],
          // buttonList: arguments['buttonList'],
          // dropList: arguments['dropList'],
          widget: arguments['widget'],
          name: arguments['name'],
        ),
  },
  {'/index/waitWork/chatList': (context, {arguments}) => ChatList()},
  {'/index/waitWork/promise': (context, {arguments}) => EnterprisePromise()},
  {'/index/waitWork/onDuty': (context, {arguments}) => EmergencyOnDuty()},
];
