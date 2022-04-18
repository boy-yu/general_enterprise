import 'package:enterprise/pages/home/risk/_riskCircle.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

/// otherPage use this commonTitle
String commonTitle = '';

class HiddenDangerInterface {
  final String title, name, details, icon, context;
  final List<String> contexts;
  final String image, bgicon;
  Color color;
  final List children, data;
  final int id, type;
  final Widget iconWidget, titleWidget;
  HiddenDangerInterface(
      {this.contexts,
      this.titleWidget,
      this.type = -1,
      this.context,
      this.icon,
      this.bgicon = 'assets/images/bg_hidden_icon.png',
      this.image = 'assets/images/bg_hidden_icon.png',
      this.title = '',
      this.name,
      this.id = -1,
      this.data,
      this.iconWidget,
      this.children,
      this.color = Colors.transparent,
      this.details = ''});
}

extension ExList on List {
  List<HiddenDangerInterface> changeHiddenDangerInterfaceType(List list,
      {@required String title,
      @required String icon, // ':' spilt   static:iconName
      String id,
      String name,
      String children,
      bool data,
      int type,
      Widget iconWidget}) {
    List<HiddenDangerInterface> _list = [];

    getValue(element) {
      int value;
      if (element['totalNum'] == 0 ||
          element['totalNum'] == null ||
          element['uncontrolledNum'] == null) {
        value = 10;
      } else {
        value = 10 -
            (((element['totalNum'] - element['uncontrolledNum']) /
                    element['totalNum'] *
                    10)
                .toInt()
                .abs());
      }
      return value;
    }

    list.forEach((element) {
      String circleText = '';
      int level = 0;
      int initialRiskLevel = 0;
      int value = 0;
      if (type == 0) {
        circleText = element["riskItem"].toString().length > 2 ? element["riskItem"].toString().substring(0, 2) : element["riskItem"].toString();
        value = getValue(element);
        level = element['riskLevel'];
        initialRiskLevel = element['initialRiskLevel'];
      }

      String text = '';
      if (element[title].toString().length > 2) {
        text = element[title].toString().substring(0, 2);
      } else {
        text = element[title].toString();
      }
      _list.add(HiddenDangerInterface(
          children: element[children] ?? [],
          title: element[title],
          icon: icon != null && icon.indexOf('static') > -1
              ? element[icon.split(':')[1]] == ''
                  ? 'assets/images/icon_home_Standardization.png'
                  : element[icon.split(':')[1]]
              : icon,
          id: element[id],
          name: element[name],
          data: data ?? list,
          type: type ?? -1,
          iconWidget: iconWidget == null && type != 0
              ? Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 18),
                  ),
                )
              : RiskCircle(
                  width: size.width * 40,
                  radius: 15,
                  text: circleText,
                  level: level,
                  initialRiskLevel: initialRiskLevel,
                  value: value,
                )
          // : iconWidget,
          // titleWidget: type == 0 ? RiskCircle(
          //                           width: size.width * 40,
          //                           radius: 15,
          //                           text: circleText,
          //                           level: level,
          //                           initialRiskLevel: initialRiskLevel,
          //                           value: value,
          //                         ) : titleWidget
          ));
    });
    return _list;
  }
}
