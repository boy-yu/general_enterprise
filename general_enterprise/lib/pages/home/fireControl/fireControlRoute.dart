import 'package:enterprise/pages/home/fireControl/___buildBaseInfoDetail.dart';
import 'package:enterprise/pages/home/fireControl/___fireOLList.dart';
import 'package:enterprise/pages/home/fireControl/___lookFile.dart';
import 'package:enterprise/pages/home/fireControl/__buildBaseInfo.dart';
import 'package:enterprise/pages/home/fireControl/__filreBillFour.dart';
import 'package:enterprise/pages/home/fireControl/__fireBaseFile.dart';
import 'package:enterprise/pages/home/fireControl/__fireOverviewList.dart';
import 'package:enterprise/pages/home/fireControl/fireControlHomeLeftList.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    fireControlRoute = [
  {
    '/fireControl/fireControl': (context, {arguments}) =>
        FireControlHomeLeftList()
  },
  {
    '/fireControl/fireBillFour': (context, {arguments}) => FileBillFour(
          leftBar: arguments['leftBar'],
        )
  },
  {
    '/fireControl/fireOverviewList': (context, {arguments}) =>
        FireOverviewList()
  },
  {
    '/fireControl/fireOLLIst': (context, {arguments}) => FireOLList(
        iconList: arguments['iconList'],
        title: arguments['title'],
        queryParameters: arguments['queryParameters'],
        choosed: arguments['choosed'])
  },
  {'/fireControl/FireBaseFile': (context, {arguments}) => FireBaseFile()},
  {'/fireControl/FireBaseLookFile': (context, {arguments}) => LookFile()},
  {'/fireControl/buildBaseInfo': (context, {arguments}) => BuildBaseInfo()},
  {
    '/fireControl/buildBaseInfoDetail': (context, {arguments}) => BuildDetail(
        iconList: arguments['iconList'],
        title: arguments['title'],
        queryParameters: arguments['queryParameters'],
        choosed: arguments['choosed'])
  },
];
