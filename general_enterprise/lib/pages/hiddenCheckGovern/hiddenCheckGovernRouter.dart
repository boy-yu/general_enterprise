import 'package:enterprise/pages/hiddenCheckGovern/_hiddenCheckRecordDetails.dart';
import 'package:enterprise/pages/hiddenCheckGovern/_hiddenGovernRecordDetails.dart';
import 'package:enterprise/pages/hiddenCheckGovern/hiddenCheckRecord.dart';
import 'package:enterprise/pages/hiddenCheckGovern/hiddenCheckTask.dart';
import 'package:enterprise/pages/hiddenCheckGovern/hiddenGovernRecord.dart';
import 'package:enterprise/pages/hiddenCheckGovern/hiddenReportSignIn.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    hiddenCheckGovernRouter = [
  
  {
    '/hiddenCheckGovern/hiddenCheckTask': (context, {arguments}) =>
        HiddenCheckTask()
  },


  {
    '/hiddenCheckGovern/hiddenCheckRecord': (context, {arguments}) =>
        HiddenCheckRecord()
  },
  {
    '/hiddenCheckGovern/hiddenCheckRecordDetails': (context, {arguments}) =>
        HiddenCheckRecordDetails()
  },

  {
    '/hiddenCheckGovern/hiddenGovernRecord': (context, {arguments}) =>
        HiddenGovernRecord()
  },
  {
    '/hiddenCheckGovern/hiddenGovernRecordDetails': (context, {arguments}) =>
        HiddenGovernRecordDetails()
  },
  

  {
    '/hiddenCheckGovern/hiddenReportSignIn': (context, {arguments}) =>
        HiddenReportSignIn(
            // riskObjectName: arguments['riskObjectName']
        )
  },
];