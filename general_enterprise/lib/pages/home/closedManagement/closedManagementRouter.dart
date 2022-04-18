import 'package:enterprise/pages/home/closedManagement/_appointment.dart';
import 'package:enterprise/pages/home/closedManagement/___appointmentManagementAudit.dart';
import 'package:enterprise/pages/home/closedManagement/___appointmentRecordReview.dart';
import 'package:enterprise/pages/home/closedManagement/___particularsVehicleRecords.dart';
import 'package:enterprise/pages/home/closedManagement/_closedManagementLeftList.dart';
import 'package:enterprise/pages/home/closedManagement/closedManagement.dart';
import 'package:flutter/material.dart';

List<Map<String, Widget Function(BuildContext context, {dynamic arguments})>>
    closedManagementRouter = [
  {
    '/home/closedManagement/closedManagement': (context, {arguments}) =>
        ClosedManagement()
  },
  {
    '/closedManagement/_closedManagementLeftList': (context, {arguments}) =>
        ClosedManagementLeftList(
          index: arguments['index'],
        )
  },
  {
    '/home/closedManagement/appointment': (context, {arguments}) => Appointment(
          data: arguments['data'],
          type: arguments['type']
        )
  },
  {
    '/closedManagement/particularsVehicleRecords': (context, {arguments}) =>
        ParticularsVehicleRecords(data: arguments['data'])
  },
  {
    '/closedManagement/appointmentManagementAudit': (context, {arguments}) =>
        AppointmentManagementAudit(type: arguments['type'], data: arguments['data'], gateList: arguments['gateList'])
  },
  {
    '/closedManagement/appointmentRecordReview': (context, {arguments}) =>
        AppointmentRecordReview(
            type: arguments['type'], data: arguments['data']
        )
  },
];
