import 'package:enterprise/pages/home/work/Component/gasDetect.dart';
import 'package:enterprise/pages/home/work/_reNewWork.dart';
import 'package:enterprise/pages/home/work/_workTicker.dart';
import 'package:enterprise/pages/home/work/history.dart';
import 'package:enterprise/pages/home/work/work.dart';
import 'package:enterprise/pages/home/work/workAddPeople.dart';
import 'package:enterprise/pages/home/work/workControlList.dart';
import 'package:enterprise/pages/home/work/work_dilog/video_exp.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    workList = [
  {
    '/home/work': (context, {arguments}) =>
        Work(arguments: arguments['arguments'])
  },
  {
    '/home/work/WorkTicker': (context, {arguments}) {
      return WorkTicker(
          circuit: arguments['circuit'],
          id: arguments['id'],
          operable: arguments['operable'],
          bookId: arguments['bookId'],
          executionMemo: arguments['executionMemo'],
          outSide: arguments['outSide'],
          userId: arguments['userId'],
          type: arguments['type'],
          parentId: arguments['parentId'] ?? 0,
          receiptIdList: arguments['receiptIdList'] ?? [],
          parentReceiptWorkTypeAll: arguments['parentReceiptWorkTypeAll'] ?? [],
          parentReceiptInformation:
              arguments['parentReceiptInformation'] ?? []);
    }
  },
  {
    '/home/work/history': (context, {arguments}) =>
        History(arguments: arguments)
  },
  {
    '/home/work/workAddPeople': (context, {arguments}) =>
        WorkAddPeople(callback: arguments['callback'])
  },
  {
    '/home/work/workControlList': (context, {arguments}) => WorkControlList(
        callback: arguments['callback'],
        id: arguments['id'],
        plannedSpeed: arguments['plannedSpeed'],
        bookId: arguments['bookId'])
  },
  {'/home/work/video_exp': (context, {arguments}) => VideoExmple()},
  {
    '/home/work/gasDetection': (context, {arguments}) => GasDetect(
          title: arguments['title'],
          detectionSite: arguments['detectionSite'],
          id: arguments['id'],
          type: arguments['type'],
        )
  },
  {
    '/home/work/reNewWork': (context, {arguments}) =>
        ReNewWork(bookId: arguments['bookId'])
  }
];
