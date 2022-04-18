import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/education/My/_departmentTrainDetails.dart';
import 'package:enterprise/pages/home/education/__eduMyTrainFile.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/productList/mainList/mainListCommon.dart';
import 'package:enterprise/pages/home/productList/postList/postCommon.dart';
import 'package:enterprise/pages/home/productList/riskList/riskCommon.dart';
import 'package:enterprise/pages/home/productList/workList/workListCommon.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';

class MainListCommonPage extends StatefulWidget {
  MainListCommonPage(
      {this.leftBar,
      @required this.widgetType,
      this.index,
      this.arguments,
      this.title, this.planId, this.stage});
  final List<HiddenDangerInterface> leftBar;
  final String widgetType, title;
  final int index, planId, stage;
  final Map arguments;
  @override
  _MainListCommonPageState createState() => _MainListCommonPageState();
}

class _MainListCommonPageState extends State<MainListCommonPage> {
  int choosed = -1;
  ThrowFunc throwFunc = ThrowFunc();
  List page = [];
  int containerInt = -1;
  double totalNum = 0.0;
  @override
  void initState() {
    super.initState();
    choosed = widget.index;

    if (widget.arguments != null) {
      totalNum =
          double.parse(widget.arguments['completedTotalNum'].toString()) +
              double.parse(widget.arguments['undoneTotalNum'].toString());
    }
    page = [
      {
        'type': 'MainListCommonPages',
        'widget': MainListCommonPages(
          id: widget.leftBar[widget.index].id,
          throwFunc: throwFunc,
        )
      },
      {
        'type': 'workListCommonPage',
        'widget': WorkListCommonPage(
          id: widget.leftBar[widget.index].id,
          throwFunc: throwFunc,
        )
      },
      {
        'type': 'riskListCommonPage',
        'widget': RiskCommonPage(
          id: widget.leftBar[widget.index].id,
          throwFunc: throwFunc,
        )
      },
      {
        'type': 'PostListCommonPage',
        'widget': PostListCommonPage(
          id: widget.leftBar[widget.index].id,
          throwFunc: throwFunc,
        ),
      },
      {
        'type': 'EduPersonFile',
        'widget': EduPersonFile(
          id: widget.leftBar[widget.index].id,
          throwFunc: throwFunc,
        ),
      },
      {
        'type': 'DepartmentTrainDetails',
        'widget': DepartmentTrainDetails(
          id: widget.leftBar[widget.index].id,
          throwFunc: throwFunc,
          planId: widget.planId,
          stage: widget.stage,
        ),
      },
    ];

    titleWidget();
    // print(containerInt);
    if (containerInt == 0) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        throwFunc.detail(argument: {
          "id": widget.leftBar[widget.index].id,
          "children": widget.leftBar[widget.index].children,
          "icon": widget.leftBar[widget.index].icon,
          "data": widget.leftBar[widget.index].data[widget.index]
        });
      });
    }
  }

  void titleWidget() {
    List temppage = page.map((e) => e['type']).toList();
    containerInt = temppage.indexOf(widget.widgetType);
  }

  String percentage(data) {
    String answer = '';
    if (totalNum == 0)
      answer = '0';
    else {
      double _answer = data / totalNum;
      if (_answer.toString().length > 5) {
        _answer = _answer + 0.01;
        answer = _answer.toString().substring(0, 4);
      } else {
        answer = _answer.toString();
      }
    }
    return answer + '%';
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      elevation: 0,
      title: Text(
          widget.title != null ? widget.title : widget.leftBar[choosed].title),
      child: Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(left: size.width * 100),
                  child: containerInt > -1
                      ? page[containerInt]['widget']
                      : Text(widget.leftBar[choosed].title.toString())),
              LeftBar(
                iconList: widget.leftBar,
                callback: (int index) {
                  setState(() {
                    choosed = index;
                  });
        
                  throwFunc.detail(argument: {
                    "id": widget.leftBar[index].id,
                    "children": widget.leftBar[index].children,
                    "icon": widget.leftBar[index].icon,
                    "data": widget.leftBar[index].data[index]
                  });
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
