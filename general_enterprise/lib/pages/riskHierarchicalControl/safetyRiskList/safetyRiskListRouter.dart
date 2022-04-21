import 'package:enterprise/pages/riskHierarchicalControl/safetyRiskList/____safetyRiskListContent.dart';
import 'package:enterprise/pages/riskHierarchicalControl/safetyRiskList/___safetyRiskListMeasure.dart';
import 'package:enterprise/pages/riskHierarchicalControl/safetyRiskList/__safetyRiskListEvent.dart';
import 'package:enterprise/pages/riskHierarchicalControl/safetyRiskList/_safetyRiskListUnit.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    safetyRiskListRouter = [
  {
    '/safetyRiskList/safetyRiskListUnit': (context, {arguments}) =>
        SafetyRiskListUnit(
            riskObjectName: arguments['riskObjectName']
        )
  },
  {
    '/safetyRiskList/safetyRiskListEvent': (context, {arguments}) =>
        SafetyRiskListEvent(
            riskUnitName: arguments['riskUnitName']
        )
  },
  {
    '/safetyRiskList/safetyRiskListMeasure': (context, {arguments}) =>
        SafetyRiskListMeasure(
            riskEventName: arguments['riskEventName']
        )
  },
  {
    '/safetyRiskList/safetyRiskListContent': (context, {arguments}) =>
        SafetyRiskListContent(
            riskMeasureDesc: arguments['riskMeasureDesc']
        )
  },
];