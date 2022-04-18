import 'package:enterprise/common/Refre.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RiskFilterFour extends StatefulWidget {
  RiskFilterFour({this.title, this.id, this.leftBar});
  final String title;
  final int id;
  final List<HiddenDangerInterface> leftBar;
  @override
  _RiskFilterFourState createState() => _RiskFilterFourState();
}

class _RiskFilterFourState extends State<RiskFilterFour> {
  String title;
  List<HiddenDangerInterface> leftBarList = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    title = widget.title;
    leftBarList = widget.leftBar ?? [];
    for (var i = 0; i < leftBarList.length; i++) {
      if (leftBarList[i].title == title) {
        leftBarList[i].color = Colors.white;
      } else {
        leftBarList[i].color = Colors.transparent;
      }
    }
    if (widget.id is int) {
      // _getRiskControlListClassification();
    } else {
      Fluttertoast.showToast(msg: "id不能为空，请联系开发人员");
    }
  }

  Future _getRiskControlListClassification({int id}) async {
    print(widget.id);
    final value = await myDio.request(
        type: 'get',
        url: Interface.getRiskControlListClassification,
        queryParameters: {
          "threeId": id ?? widget.id,
        });

    if (value != null) {
      riskFilterList = value;
      context.read<Counter>().refreshFun(false);
      if (mounted) {
        setState(() {});
      }
    }
    return Future.value(true);
  }

  _getImage(String classification) {
    if (classification != '工程技术' &&
        classification != '管理' &&
        classification != '培训教育' &&
        classification != '个体防护' &&
        classification != '应急处置') {
      return "assets/images/icon_risk_filter_engineering.png";
    } else {
      switch (classification) {
        case '工程技术':
          return "assets/images/icon_risk_filter_engineering.png";
          break;
        case '管理':
          return "assets/images/icon_risk_filter_management.png";
          break;
        case '培训教育':
          return "assets/images/icon_risk_filter_education.png";
          break;
        case '个体防护':
          return "assets/images/icon_risk_filter_individual.png";
          break;
        case '应急处置':
          return "assets/images/icon_risk_filter_emergency.png";
          break;
        default:
      }
    }
  }

  List riskFilterList = [];
  int total = 0;
  int fourId = -1;

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: Text(
        title.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 36,
            color: Colors.white),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 50),
            width: widghtSize.width - 50,
            height: widghtSize.height,
            child: Refre(
                child: (child, state, end, updata) => Column(
                      children: [
                        child,
                        Expanded(
                            child: ListView.builder(
                                itemCount: riskFilterList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      List<HiddenDangerInterface> _iconList =
                                          [];
                                      _iconList = _iconList
                                          .changeHiddenDangerInterfaceType(
                                        riskFilterList,
                                        title: 'classification',
                                        id: "threeId",
                                        icon: null,
                                        iconWidget: null,
                                      );
                                      Navigator.pushNamed(
                                          context, '/home/risk/riskFour',
                                          arguments: {
                                            'title': riskFilterList[index]
                                                    ['classification']
                                                .toString(),
                                            "leftBar": _iconList,
                                            "id": riskFilterList[index]
                                                ['threeId']
                                          });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(size.width * 20),
                                      margin: EdgeInsets.all(size.width * 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.2),
                                              offset: Offset(-1, 2),
                                              blurRadius: 1),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            _getImage(riskFilterList[index]
                                                ['classification']),
                                            height: size.width * 107,
                                            width: size.width * 107,
                                          ),
                                          SizedBox(
                                            width: size.width * 10,
                                          ),
                                          Text(
                                            riskFilterList[index]
                                                ['classification'],
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 36,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.black,
                                            size: size.width * 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }))
                      ],
                    ),
                onRefresh: _getRiskControlListClassification),
          ),
          // left
          LeftBar(
            iconList: leftBarList,
            callback: (int index) {
              _getRiskControlListClassification(id: leftBarList[index].id);
              title = leftBarList[index].title;
              context.read<Counter>().refreshFun(true);
              if (mounted) {
                setState(() {});
              }
            },
          )
        ],
      ),
    );
  }
}
