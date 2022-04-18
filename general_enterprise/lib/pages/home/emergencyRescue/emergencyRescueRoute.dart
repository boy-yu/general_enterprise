import 'package:enterprise/pages/home/emergencyRescue/_____emergencyRescueInsideMaterialsDetails.dart';
import 'package:enterprise/pages/home/emergencyRescue/____emergencyRescueSingleTeamDetails.dart';
import 'package:enterprise/pages/home/emergencyRescue/___emergencyRescueExpertInfo.dart';
import 'package:enterprise/pages/home/emergencyRescue/___emergencyRescueInsideMaterials.dart';
import 'package:enterprise/pages/home/emergencyRescue/____emergencyRescueInsideMaterialsTow.dart';
import 'package:enterprise/pages/home/emergencyRescue/___emergencyRescueSingleTeam.dart';
import 'package:enterprise/pages/home/emergencyRescue/___picNext.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescue3D.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueAdminDetails.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueCardDetails.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueEvacuate.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueExpert.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueFirmHis.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueHeadDetails.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueOfficeDetails.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescuePic.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueResponsePic.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueRim.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueRiskPic.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueTeamDetails.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueTeamList.dart';
import 'package:enterprise/pages/home/emergencyRescue/_emergencyRescueLeftList.dart';
import 'package:enterprise/pages/home/emergencyRescue/emergencyRescueHome.dart';
import 'package:enterprise/pages/home/emergencyRescue/testMap.dart';

import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    emergencyRescueRoute = [
  {
    '/emergencyRescue/emergencyRescueHome': (context, {arguments}) =>
        EmergencyRescueHome()
  },
  {
    '/emergencyRescue/__emergencyRescuePic': (context, {arguments}) =>
        EmergencyRescuePic()
  },
  {'/emergencyRescue/rescuePicNext': (context, {arguments}) => PicNext()},
  {
    '/emergencyRescue/__emergencyRescueEvacuate': (context, {arguments}) =>
        EmergencyRescueEvacuate()
  },
  {
    '/emergencyRescue/__emergencyRescueRiskPic': (context, {arguments}) =>
        EmergencyRescueRiskPic()
  },
  {
    '/emergencyRescue/__emergencyRescue3D': (context, {arguments}) =>
        EmergencyRescue3D()
  },
  {
    '/emergencyRescue/_emergencyRescueLeftList': (context, {arguments}) =>
        EmergencyRescueLeftList(
          index: arguments['index'],
        )
  },
  {
    '/emergencyRescue/__emergencyRescueCardDetails': (context, {arguments}) =>
        EmergencyRescueCardDetails(
          id: arguments['id'],
        )
  },
  {
    '/emergencyRescue/__emergencyRescueFirmHis': (context, {arguments}) =>
        EmergencyRescueFirmHis(
            // index: arguments['index'],
            )
  },
  {
    '/emergencyRescue/__emergencyRescueHeadDetails': (context, {arguments}) =>
        EmergencyRescueHeadDetails(
            // index: arguments['index'],
            )
  },
  {
    '/emergencyRescue/__emergencyRescueOfficeDetails': (context, {arguments}) =>
        EmergencyRescueOfficeDetails(
            // index: arguments['index'],
            )
  },
  {
    '/emergencyRescue/__emergencyRescueTeamDetails': (context, {arguments}) =>
        EmergencyRescueTeamDetails(
          id: arguments['id'],
        )
  },
  {
    '/emergencyRescue/__emergencyRescueTeamList': (context, {arguments}) =>
        EmergencyRescueTeamList(
            // index: arguments['index'],
            )
  },
  {
    '/emergencyRescue/___emergencyRescueSingleTeam': (context, {arguments}) =>
        EmergencyRescueSingleTeam(
          title: arguments['title'],
        )
  },
  {
    '/emergencyRescue/__emergencyRescueInsideMaterials':
        (context, {arguments}) => EmergencyRescueInsideMaterials()
  },
  {
    '/emergencyRescue/____emergencyRescueInsideMaterialsTow':
        (context, {arguments}) => EmergencyRescueInsideMaterialsTow(
              title: arguments['title'],
              id: arguments['id'],
            )
  },
  {
    '/emergencyRescue/_____emergencyRescueInsideMaterialsDetails':
        (context, {arguments}) => EmergencyRescueInsideMaterialsDetails(
              id: arguments['id'],
            )
  },
  {
    '/emergencyRescue/____emergencyRescueSingleTeamDetails':
        (context, {arguments}) => EmergencyRescueSingleTeamDetails(
              id: arguments['id'],
            )
  },
  {
    '/emergencyRescue/__emergencyRescueRim': (context, {arguments}) =>
        EmergencyRescueRim()
  },
  {
    '/emergencyRescue/__emergencyRescueExpert': (context, {arguments}) =>
        EmergencyRescueExpert()
  },
  {
    '/emergencyRescue/___emergencyRescueExpertInfo': (context, {arguments}) =>
        EmergencyRescueExpertInfo(
          id: arguments['id'],
        )
  },
  {
    '/emergencyRescue/__emergencyRescueResponsePic': (context, {arguments}) =>
        EmergencyRescueResponsePic()
  },
  {
    '/emergencyRescue/__emergencyRescueAdminDetails': (context, {arguments}) =>
        EmergencyRescueAdminDetails(
          id: arguments['id'],
        )
  },
  {'/mapTest': (context, {arguments}) => TestMap()}


];
