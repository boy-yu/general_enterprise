import 'package:enterprise/myDialog/approval.dart';
import 'package:enterprise/myDialog/dilagContent.dart';
import 'package:flutter/material.dart';

class MyDialog {
  static Future myDialog(
    context,
    callback,
    type, {
    Function cancel,
    Widget widget,
    String way,
    List listTable,
  }) {
    // way  驳回 or 通过
    // print(type);
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        switch (type) {
          case 2:
            return Approval(
                cancel: cancel,
                callback: callback,
                widget: widget,
                type: way,
                callState: listTable);
            break;
          default:
            return DilagContent();
        }
      },
    );
  }
}