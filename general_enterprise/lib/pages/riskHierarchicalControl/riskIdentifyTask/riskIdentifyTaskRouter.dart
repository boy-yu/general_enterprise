import 'package:enterprise/pages/riskHierarchicalControl/riskIdentifyTask/___addHiddenTask.dart';
import 'package:enterprise/pages/riskHierarchicalControl/riskIdentifyTask/___riskHiddenTask.dart';
import 'package:enterprise/pages/riskHierarchicalControl/riskIdentifyTask/__addControlMeasure.dart';
import 'package:enterprise/pages/riskHierarchicalControl/riskIdentifyTask/__riskIdentifyTaskMeasure.dart';
import 'package:enterprise/pages/riskHierarchicalControl/riskIdentifyTask/_addRiskEvent.dart';
import 'package:enterprise/pages/riskHierarchicalControl/riskIdentifyTask/_riskIdentifyTaskIncident.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    riskIdentifyTaskRouter = [
  {
    '/riskIdentifyTask/riskIdentifyTaskIncident': (context, {arguments}) =>
        RiskIdentifyTaskIncident(
            index: arguments['index'], leftBarList: arguments['data']
        )
  },
  {
    '/riskIdentifyTask/addRiskEvent': (context, {arguments}) =>
        AddRiskEvent()
  },

  {
    '/riskIdentifyTask/riskIdentifyTaskMeasure': (context, {arguments}) =>
        RiskIdentifyTaskMeasure(
            index: arguments['index'], leftBarList: arguments['data']
        )
  },
  {
    '/riskIdentifyTask/addControlMeasure': (context, {arguments}) =>
        AddControlMeasure()
  },
  
  {
    '/riskIdentifyTask/riskHiddenTask': (context, {arguments}) =>
        RiskHiddenTask(
            index: arguments['index'], leftBarList: arguments['data']
        )
  },
  {
    '/riskIdentifyTask/addHiddenTask': (context, {arguments}) =>
        AddHiddenTask()
  },
  
];