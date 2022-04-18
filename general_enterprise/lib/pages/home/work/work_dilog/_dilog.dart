import 'package:enterprise/pages/home/checkLisk/dialog/appendEventDialog.dart';
import 'package:enterprise/pages/home/checkLisk/dialog/appendUnplannedDialog.dart';
import 'package:enterprise/pages/home/education/education_dialog/_educationGradeDialog.dart';
import 'package:enterprise/pages/home/hiddenDanger/hidden_dialog/_dailogWorkPlan.dart';
import 'package:enterprise/pages/home/hiddenDanger/hidden_dialog/_dialogIsWork.dart';
import 'package:enterprise/pages/home/hiddenDanger/hidden_dialog/_dialogRectificationFinish.dart';
import 'package:enterprise/pages/home/hiddenDanger/hidden_dialog/_dialogSign.dart';
// import 'package:enterprise/pages/home/risk/risk_dialog/_dialogRiskAccount.dart';
import 'package:enterprise/pages/home/risk/risk_dialog/_riskDilog.dart';
import 'package:enterprise/pages/home/work/work_dilog/_approval.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dialogAddPeople.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dialogConfirm.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilogContent.dart';
import 'package:enterprise/pages/home/work/work_dilog/video_exp.dart';
// import 'package:enterprise/pages/home/hiddenDanger/hidden_dialog/_dialogRegulationsHidden.dart';
import 'package:flutter/material.dart';
import 'package:enterprise/pages/home/spotCheck/spotCheck_dialog/_dialogSpotCheckAccount.dart';
import 'package:enterprise/pages/home/spotCheck/spotCheck_dialog/_spotCheckDilog.dart';

class WorkDialog {
  static Future myDialog(
    context,
    callback,
    type, {
    Function cancel,
    Widget widget,
    String way,
    int id,
    int threeId,
    layer,
    title,
    hiddenData,
    List listTable,
    Function riskItemcallback,
    riskItemtoCallback,
    bool showRiskAccountDialogDrop = true,
    List listTitle,
    String riskItemtitle,
    bool operable,
    Function spotCheckItemcallback,
    spotCheckItemtoCallback,
    String spotCheckItemtitle,
    bool showSpotCheckAccountDialogDrop = true,
    Map accDataMap,
    String sign,
    int interfaceId,
    int resourcesId,
    int typeId,
    int fourId,
  }) {
    // way  驳回 or 通过
    // print(type);
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        switch (type) {
          case 1:
            return DilagContent();
            break;
          case 2:
            return Approval(
                cancel: cancel,
                callback: callback,
                widget: widget,
                type: way,
                callState: listTable);
            break;
          case 3:
            return DialogAddPeople();
            break;
          case 4:
            return DialogConfirm();
            break;
          case 5:
            return VideoExmple();
            break;
          case 6:
            return RiskDilog(
              threeId: threeId,
              callback: callback,
              riskItemtitle: riskItemtitle,
              operable: operable,
            );
            break;
          // case 7:
          //   return HiddenRegulationsDialog(id: id, fourId: fourId);
          //   break;
          case 8:
            return FinishRectificationDialog(
              callback: callback,
            );
            break;
          case 9:
            return IsWorkDialog(
              callback: callback,
              data: hiddenData,
              fourId: fourId
            );
            break;
          case 10:
            return WorkPlanDialog(
              callback: callback,
              data: hiddenData,
            );
            break;
          case 11:
            return SignDialog(
              callback: callback,
              widget: widget,
              type: way,
            );
            break;
          // case 12:
          //   return RiskAccountDialog(
          //     title: title,
          //     layer: layer,
          //     callback: riskItemcallback,
          //     riskItemtoCallback: riskItemtoCallback,
          //     showRiskAccountDialogDrop: showRiskAccountDialogDrop,
          //     listTitle: listTitle,
          //     listTable: listTable,
          //     id: id,
          //     accDataMap: accDataMap,
          //     sign: sign,
          //     noTime: false,
          //   );
          //   break;
          case 13:
            return SpotCheckDialog(
              threeId: threeId,
              callback: callback,
              operable: operable,
              spotCheckItemtitle: spotCheckItemtitle,
            );
            break;
          case 14:
            return SpotCheckAccountDialog(
              title: title,
              layer: layer,
              callback: spotCheckItemcallback,
              spotCheckItemtoCallback: spotCheckItemtoCallback,
              showSpotCheckAccountDialogDrop: showSpotCheckAccountDialogDrop,
              listTitle: listTitle,
              listTable: listTable,
              id: id,
            );
            break;
          case 15:
            return EducationGradeDialog(
              interfaceId: interfaceId,
              resourcesId: resourcesId,
              typeId: typeId,
              callback: callback,
            );
            break;
          case 16:
            return AppendUnplannedDialog(callback: callback);
            break;
          case 17:
            return AppendEventDialog(callback: callback);
            break;
          default:
            return DilagContent();
        }
      },
    );
  }
}
