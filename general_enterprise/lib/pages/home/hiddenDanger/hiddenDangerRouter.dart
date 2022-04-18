import 'package:enterprise/pages/home/hiddenDanger/_baseHidden.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenConfirm.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenDanger.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenDangerAccount.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenDangerGovernLedger.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenReview.dart';
import 'package:enterprise/pages/home/hiddenDanger/hiddenScreening.dart';
import 'package:enterprise/pages/home/hiddenDanger/___hiddenSpecific.dart';
import 'package:enterprise/pages/home/hiddenDanger/hidden_dialog/_dailogWorkPlan.dart';
// import 'package:enterprise/pages/home/risk/risk_dialog/_dialogRiskAccount.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    hiddenDanger = [
  {'/home/hiddenDanger': (context, {arguments}) => HiddenDanger()},
  {
    '/home/baseHidden': (context, {arguments}) =>
        BaseHidden(leftBar: arguments['leftBar'], title: arguments['title'])
  },
  {
    '/hiddenDanger/hiddenDangerGovernLedger': (context, {arguments}) =>
        HiddenDangerGovernLedger()
  },
  {
    '/home/hiddenDepartment': (context, {arguments}) => HiddenDepartment(
        title: arguments['title'],
        leftBar: arguments['leftBar'],
        id: arguments['id'])
  },
  {
    '/home/hiddenSpecific': (context, {arguments}) => HiddenSpecific(
        title: arguments['title'],
        id: arguments['id'],
        leftBar: arguments['leftBar'],
        hiddenType: arguments['hiddenType'])
  },
  {
    '/home/hiddenDangerAccount': (context, {arguments}) => HiddenDangerAccount()
  },
  {
    '/home/hiddenReview': (context, {arguments}) =>
        HiddenReview(title: arguments['title'], id: arguments['id'])
  },
  {
    '/home/hiddenConfirm': (context, {arguments}) => HiddenConfirm(
          id: arguments['id'],
          data: arguments['data'],
          fourId: arguments["fourId"],
        )
  },
  {
    '/home/hiddenScreening': (context, {arguments}) => HiddenScreening(
          data: arguments['data'],
          id: arguments['id'],
          fourId: arguments['fourId'],
          type: arguments['type'],
          title: arguments['title'],
          authority: arguments['authority'],
          controlType: arguments['controlType'],
          genre: arguments['genre'],
        ),
  },
  {
    '/home/workPlan': (context, {arguments}) =>
        WorkPlanDialog(callback: arguments['callback'], data: arguments['data'])
  },
  // {
  //   '/home/Queryhistory': (context, {arguments}) => RiskAccountDialog(
  //       callback: arguments['callback'],
  //       title: arguments['title'],
  //       showRiskAccountDialogDrop: arguments['showRiskAccountDialogDrop'],
  //       listTable: arguments['listTable'],
  //       layer: arguments['layer'],
  //       listTitle: arguments['listTitle'],
  //       dropList: arguments['dropList'],
  //       noTime: arguments['noTime'])
  // }
];
