import 'package:enterprise/pages/home/risk/____riskFour.dart';
import 'package:enterprise/pages/home/risk/___riskFilterFour.dart';
import 'package:enterprise/pages/home/risk/__controlIndexDetails.dart';
import 'package:enterprise/pages/home/risk/__riskcount.dart';
import 'package:enterprise/pages/home/risk/_controlIndex.dart';
import 'package:enterprise/pages/home/risk/_riskCircle.dart';
import 'package:enterprise/pages/home/risk/_riskHome.dart';
import 'package:enterprise/pages/home/risk/_riskUncontrollable.dart';
import 'package:enterprise/pages/home/risk/risk.dart';
import 'package:enterprise/pages/home/risk/riskControl.dart';
// import 'package:enterprise/pages/home/risk/risk_dialog/_dialogRiskAccount.dart';
import 'package:enterprise/pages/home/risk/risk_dialog/_riskDetails.dart';

import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    riskRouter = [
  {'/home/risk': (context, {arguments}) => Risk()},
  {'/home/risk/riskHome': (context, {arguments}) => RiskHome()},
  {'/home/risk/controlIndex': (context, {arguments}) => ControlIndex()},
  {
    '/home/risk/controlIndex/details': (context, {arguments}) =>
        ControlIndexDetails(
          data: arguments['data'],
          oneId: arguments['oneId'],
          index: arguments['index'],
        )
  },
  {
    '/home/risk/RikeDemo': (context, {arguments}) => RiskCircle(
          width: arguments['width'],
        )
  },
  {
    '/home/risk/riskControl': (context, {arguments}) => RiskControl(
          index: arguments['index'],
          dropList: arguments['dropList'],
          // level: arguments['level'],
          // initialRiskLevel: arguments['initialRiskLevel'],
          // value: arguments['value'],
        )
  },
  {
    '/home/risk/RiskCounts': (context, {arguments}) => RiskCounts(
          index: arguments['index'],
          riskunitList: arguments['riskunitList'],
        )
  },
  {
    '/home/risk/riskUncontrollable': (context, {arguments}) => RiskUncontrollable(
          // index: arguments['index'],
          // riskunitList: arguments['riskunitList'],
        )
  },
  
  // {
  //   '/home/risk/riskHistory': (context, {arguments}) => RiskAccountDialog(
  //       title: arguments['title'],
  //       layer: arguments['layer'],
  //       callback: arguments['callback'],
  //       riskItemtoCallback: arguments['riskItemtoCallback'],
  //       showRiskAccountDialogDrop: arguments['showRiskAccountDialogDrop'],
  //       listTitle: arguments['listTitle'],
  //       listTable: arguments['listTable'],
  //       id: arguments['id'],
  //       screen: arguments['screen'],
  //       noTime: arguments['notime'])
  // },
  {
    '/home/risk/riskFour': (context, {arguments}) => RiskFour(
          title: arguments['title'],
          leftBar: arguments['leftBar'],
          id: arguments['id'],
          qrMessage: arguments['qrMessage'],
        )
  },
  {
    '/home/risk/riskFilterFour': (context, {arguments}) => RiskFilterFour(
          title: arguments['title'],
          leftBar: arguments['leftBar'],
          id: arguments['id'],
        )
  },
  {
    '/home/risk/riskDetails': (context, {arguments}) => RiskDetails(
          accDataMap: arguments['accDataMap'],
          strStartDateTime: arguments['strStartDateTime'],
          endDates: arguments['endDates'],
          investigationResults: arguments['investigationResults'],
          status: arguments['status'],
          sign: arguments['sign'],
          qrMessage: arguments['qrMessage'],
        )
  }
];
