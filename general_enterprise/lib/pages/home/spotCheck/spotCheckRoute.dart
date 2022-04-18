import 'package:enterprise/pages/home/spotCheck/___spotCheckFour.dart';
import 'package:enterprise/pages/home/spotCheck/__spotCheckCount.dart';
import 'package:enterprise/pages/home/spotCheck/_spotCheckCircle.dart';
import 'package:enterprise/pages/home/spotCheck/_spotCheckControl.dart';
import 'package:enterprise/pages/home/spotCheck/spotCheck.dart';
import 'package:enterprise/pages/home/spotCheck/spotCheck_dialog/_dialogSpotCheckAccount.dart';

import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    spotCheck = [
  {'/home/spotCheck': (context, {arguments}) => SpotCheck()},
  {
    '/home/spotCheck/SpotCheckDemo': (context, {arguments}) => SpotCheckCircle(
          width: arguments['width'],
        )
  },
  {
    '/home/spotCheck/spotCheckControl': (context, {arguments}) =>
        SpotCheckControl(
          index: arguments['index'],
          dropList: arguments['dropList'],
        )
  },
  {
    '/home/spotCheck/spotCheckCounts': (context, {arguments}) =>
        SpotCheckCounts(
          index: arguments['index'],
          spotCheckUnitList: arguments['spotCheckUnitList'],
        )
  },
  {
    '/home/spotCheck/spotCheckHistory': (context, {arguments}) =>
        SpotCheckAccountDialog(
          title: arguments['title'],
          layer: arguments['layer'],
          callback: arguments['callback'],
          spotCheckItemtoCallback: arguments['spotCheckItemtoCallback'],
          showSpotCheckAccountDialogDrop:
              arguments['showSpotCheckAccountDialogDrop'],
          listTitle: arguments['listTitle'],
          listTable: arguments['listTable'],
          id: arguments['id'],
          screen: arguments['screen'],
        )
  },
  {
    '/home/spotCheck/spotCheckFour': (context, {arguments}) => SpotCheckFour(
          title: arguments['title'],
          leftBar: arguments['leftBar'],
          id: arguments['id'],
        )
  }
];
