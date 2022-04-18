import 'package:enterprise/pages/home/productList/____postListReportPToThing.dart';
import 'package:enterprise/pages/home/productList/___postListReportPToP.dart';
import 'package:enterprise/pages/home/productList/___postListThreeType.dart';
import 'package:enterprise/pages/home/productList/__commonPage.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/pages/home/productList/postList/_postGuard.dart';
import 'package:enterprise/pages/home/productList/postList/_postWorkDetail.dart';
import 'package:enterprise/pages/home/productList/productList.dart';

import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    productList = [
  {'/index/productList': (context, {arguments}) => ProductList()},
  {
    '/index/productList/CommonPage': (context, {arguments}) =>
        MainListCommonPage(
          arguments: arguments['arguments'],
          widgetType: arguments['widgetType'],
          leftBar: arguments['leftBar'],
          index: arguments['index'],
          title: arguments['title'],
          planId: arguments['planId'],
          stage: arguments['stage']
        )
  },
  {
    '/index/productList/checkPostGuard': (context, {arguments}) =>
        CheckPostGuard(
          title: arguments['title'],
          status: arguments['status'],
          rolesId: arguments['rolesId'],
          type: arguments['type'],
          userId: arguments['userId'],
        )
  },
  {
    '/index/productList/PostWorkDetail': (context, {arguments}) =>
        PostWorkDetail(data: arguments['data'])
  },
  {
    '/index/productList/postListDetails': (context, {arguments}) =>
        PostListDetails(
          userId: arguments['userId'],
          rolesId: arguments['rolesId'],
        )
  },
  {
    '/index/productList/postListThreeType': (context, {arguments}) =>
        PostListThreeType(
          type: arguments['type'],
          rolesId: arguments['rolesId'],
          userId: arguments['userId'],
          title: arguments['title']
        )
  },
  {
    '/index/productList/postListReportPToP': (context, {arguments}) =>
        PostListReportPToP(
          type: arguments['type'],
          rolesId: arguments['rolesId'],
          userId: arguments['userId'],
          title: arguments['title'],
          dutyId: arguments['dutyId'],
          button: arguments['button'],
          id: arguments['id'],
        )
  },
  {
    '/index/productList/postListReportPToThing': (context, {arguments}) =>
        PostListReportPToThing(
          type: arguments['type'],
          title: arguments['title'],
          dutyId: arguments['dutyId'],
        )
  },
];
