import 'package:enterprise/pages/home/checkLisk/_____examFaceVerify.dart';
import 'package:enterprise/pages/home/checkLisk/_____studyPlanTextbookLedgerList.dart';
import 'package:enterprise/pages/home/checkLisk/_____studyPlanTextbookStageList.dart';
import 'package:enterprise/pages/home/checkLisk/____examList.dart';
import 'package:enterprise/pages/home/checkLisk/____offlineStudyPlan.dart';
import 'package:enterprise/pages/home/checkLisk/____researchListDetails.dart';
import 'package:enterprise/pages/home/checkLisk/____studyPlan.dart';
import 'package:enterprise/pages/home/checkLisk/___appendUnplannedRisk.dart';
import 'package:enterprise/pages/home/checkLisk/___researchList.dart';
import 'package:enterprise/pages/home/checkLisk/__selectRiskObject.dart';
import 'package:enterprise/pages/home/checkLisk/_checkListToday.dart';
import 'package:enterprise/pages/home/checkLisk/_postWork.dart';
import 'package:enterprise/pages/home/checkLisk/_unplanned.dart';
import 'package:enterprise/pages/home/checkLisk/checkList.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    checkList = [
  {
    '/index/checkList': (context, {arguments}) => CheckList(
          way: arguments['way'],
          qrMessage: arguments['qrMessage'],
        )
  },
  {
    '/index/checkList/today': (context, {arguments}) => TodayList(
          leftBar: arguments['leftBar'],
          title: arguments['title'],
          qrMessage: arguments['qrMessage'],
          choosed: arguments['choosed'],
        )
  },
  {'/index/checkList/postWork': (context, {arguments}) => PostWork()},
  {'/index/checkList/unplanned': (context, {arguments}) => Unplanned()},
  {
    '/index/checkList/__selectRiskObject': (context, {arguments}) =>
        SelectRiskObject()
  },
  {
    '/index/checkList/___appendUnplannedRisk': (context, {arguments}) =>
        AppendUnplannedRisk()
  },

  // edu
  {
    '/checkList/researchList': (context, {arguments}) =>
        ResearchList()
  },
  {
    '/checkList/researchListDetails': (context, {arguments}) =>
        ResearchListDetails(
          isPrincipal: arguments['isPrincipal'],
          name: arguments['name'],
          id: arguments['id']
        )
  },
  {
    '/checkList/studyPlan': (context, {arguments}) =>
        StudyPlan(
          type: arguments['type']
        )
  },

  {
    '/checkList/examList': (context, {arguments}) =>
        ExamList(
          type: arguments['type']
        )
  },

  {
    '/checkList/studyPlanTextbookLedgerList': (context, {arguments}) =>
        StudyPlanTextbookLedgerList(
          title: arguments['title'],
          id: arguments['id']
        )
  },

  {
    '/checkList/studyPlanTextbookStageList': (context, {arguments}) =>
        StudyPlanTextbookStageList(
          title: arguments['title'],
          id: arguments['id'],
          type: arguments['type']
        )
  },

  {
    '/checkList/offlineStudyPlan': (context, {arguments}) =>
        OfflineStudyPlan(
          type: arguments['type']
        )
  },

  {
    '/checkList/examFaceVerify': (context, {arguments}) =>
        ExamFaceVerify(
          id: arguments['id'],
          title: arguments['title'],
          duration: arguments['duration'],
          stage: arguments['stage'],
          type: arguments['type'],
          isHave: arguments['isHave'],
          passLine: arguments['passLine'],
        )
  },

];
