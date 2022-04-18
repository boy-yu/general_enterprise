import 'package:enterprise/pages/home/legitimate/_____licenseHistory.dart';
import 'package:enterprise/pages/home/legitimate/_____licenseUpDate.dart';
import 'package:enterprise/pages/home/legitimate/___chemicalsDetails.dart';
import 'package:enterprise/pages/home/legitimate/___fileList.dart';
import 'package:enterprise/pages/home/legitimate/___lawDetails.dart';
import 'package:enterprise/pages/home/legitimate/____licenseDetails.dart';
import 'package:enterprise/pages/home/legitimate/___checkedLicence.dart';
import 'package:enterprise/pages/home/legitimate/___processesDetails.dart';
import 'package:enterprise/pages/home/legitimate/_legitimateLeftList.dart';
import 'package:enterprise/pages/home/legitimate/legitimate.dart';

import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    legitimateRouter = [
  {'/legitimate/legitimate': (context, {arguments}) => Legitimate()},
  {
    '/legitimate/_legitimateLeftList': (context, {arguments}) =>
        LegitimateLeftList(
          index: arguments['index'],
        )
  },
  {
    '/legitimate/_checkedLicence': (context, {arguments}) => CheckedLicence(
          id: arguments['id'],
          fixedType: arguments['fixedType'],
          type: arguments['type'],
        )
  },
  {
    '/legitimate/__licenseDetails': (context, {arguments}) => LicenseDetails(
          id: arguments['id'],
          fixedType: arguments['fixedType'],
          type: arguments['type']
        )
  },
  {
    '/legitimate/___fileList': (context, {arguments}) => FileList(
          id: arguments['id'],
        )
  },
  {
    '/legitimate/_____licenseHistory': (context, {arguments}) => LicenseHistory(
          fileList: arguments['fileList'],
        )
  },
  {
    '/legitimate/_____licenseUpDate': (context, {arguments}) => LicenseUpDate(
          id: arguments['id'],
          fixedType: arguments['fixedType'],
        )
  },
  {
    '/legitimate/___chemicalsDetails': (context, {arguments}) =>
        ChemicalsDetails(
          msdsId: arguments['msdsId'],
          labelUrl: arguments['labelUrl'],
        )
  },
  {
    '/legitimate/___processesDetails': (context, {arguments}) =>
        ProcessesDetails(
          id: arguments['id'],
        )
  },
  {
    '/legitimate/__lawDetails': (context, {arguments}) =>
        LawDetails(arguments: arguments)
  },
];
