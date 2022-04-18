import 'package:enterprise/pages/home/bigDanger/__dangerListOne.dart';
import 'package:enterprise/pages/home/bigDanger/_dangerEquimentDetail.dart';
import 'package:enterprise/pages/home/bigDanger/_dangerSource.dart';
import 'package:enterprise/pages/home/bigDanger/bigDanger.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    bigDangerRouter = [
  {'/index/bigDanger': (context, {arguments}) => BigDanger()},
  {
    '/index/dangerSource': (context, {arguments}) => DangerSourece(
          leftbar: arguments['leftbar'],
          id: arguments['id'],
          index: arguments['index'],
        )
  },
  {
    '/index/dangerListOne': (context, {arguments}) => DangerListOne(
          id: arguments['id'],
          url: arguments['url'],
        )
  },
  {
    '/index/dangerEquimentDetail': (context, {arguments}) =>
        DangerEquimentDetail()
  },
];
