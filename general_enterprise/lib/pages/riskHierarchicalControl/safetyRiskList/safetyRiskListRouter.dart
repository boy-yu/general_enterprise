import 'package:enterprise/pages/riskHierarchicalControl/safetyRiskList/_controlSituation.dart';
import 'package:enterprise/pages/riskHierarchicalControl/safetyRiskList/_details.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    safetyRiskListRouter = [
  {
    '/safetyRiskList/controlSituation': (context, {arguments}) =>
        ControlSituation(
            id: arguments['id']
        )
  },
  {
    '/safetyRiskList/details': (context, {arguments}) =>
        Details(
            id: arguments['id']
        )
  },
];