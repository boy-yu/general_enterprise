import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/checkLisk/__checkEduList.dart';
import 'package:enterprise/pages/home/checkLisk/__hiddenSpecificItem.dart';
import 'package:enterprise/pages/home/checkLisk/__inspection.dart';
import 'package:enterprise/pages/home/checkLisk/_postIdentify.dart';
import 'package:enterprise/pages/home/checkLisk/offLineDataList.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/work/workList.dart';
// import 'package:enterprise/pages/home/risk/_riskCircle.dart';
// import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TodayList extends StatefulWidget {
  TodayList({this.leftBar, this.title, this.qrMessage, this.choosed});
  final List<HiddenDangerInterface> leftBar;
  final String title;
  final Map qrMessage;
  final int choosed;
  @override
  _TodayListState createState() => _TodayListState();
}

class _TodayListState extends State<TodayList> {
  int choosed = 0;
  List data = [];
  int page = 1;
  ScrollController _scrollController = ScrollController();
  Size widghtSize;
  bool scroll = true;
  Widget _childWidget;
  ThrowFunc throwFunc = ThrowFunc();
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // 检测网络
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    choosed = widget.choosed ?? 0;
    if (choosed == 0) {
      _getData();
    }
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  bool network = true;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        // setState(() => _connectionStatus = result.toString());
        if (result.toString() == 'ConnectivityResult.none') {
          network = false;
          setState(() {});
        } else {
          network = true;
          // queryParameters = {"current": page, "size": 30, "controlType": 1};
          // // _getData();
          // _getDropList();
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  Future _getData({bool overflow = false}) async {
    if (!overflow) data = [];
    if (mounted) {
      setState(() {});
    }
    return Future.value(0);
  }

  Widget _judgeWidget() {
    Widget _titleWidget;
    switch (choosed) {
      case 0:
        _childWidget = Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 20),
          child: MyRefres(
            child: (index, list) {
              return Container(
                // color: Colors.white,
                child: DetailsList(
                  dataMap: list[index] as Map,
                  throwFunc: throwFunc,
                ),
              );
            },
            url: Interface.workListUrl,
            queryParameters: {"type": 1},
            method: 'get',
            page: true,
            listParam: 'records',
            throwFunc: throwFunc,
          ),
        );
        break;
      case 1:
        _childWidget = CheckHiddenPage();
        _titleWidget = network ? CheckHiddenTitle() : Text('离线隐患');
        break;
      case 2:
        _childWidget = CheckInpection(qrMessage: widget.qrMessage);
        _titleWidget = network ? CheckInpectionTitle() : Text('离线巡检');
        break;
      case 3:   // 教育培训
        _childWidget = CheckEduList();
        break;
      case 4:
        _childWidget = CheckPostList();
        break;
      case 5:   // 离线提交数据
        _childWidget = OffLineDataList();
        _titleWidget = Text('离线提交数据');
        break;
      default:
        _childWidget = Container(
          alignment: Alignment.center,
          child: Text('敬请期待'),
        );
    }
    return _titleWidget;
  }

  @override
  Widget build(BuildContext context) {
    widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: _judgeWidget() ?? Text('我的清单'),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 40),
            width: widghtSize.width - 40,
            height: widghtSize.height,
            child: _childWidget,
          ),
          LeftBar(
            iconList: widget.leftBar,
            callback: (int index) {
              choosed = index;
              widget.leftBar.forEach((element) {
                element.color = Color(0xffEAEDF2);
              });
              page = 0;
              widget.leftBar[index].color = Colors.white;
              _getData();
              context.read<Counter>().refreshFun(true);
            },
          )
        ],
      ),
    );
  }
}

class RiskItem extends StatelessWidget {
  RiskItem({this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: size.width * 20,
            right: size.width * 20,
            top: size.width * 20),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          onPressed: () {
            // WorkDialog.myDialog(context, () {}, 6,
            //     threeId: data['threeId'],
            //     riskItemtitle: data['riskItem'].toString());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 20, vertical: size.width * 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RiskCircle(
                //   width: size.width * 60,
                //   text: data['riskPoint'].toString().length > 2
                //       ? data['riskPoint'].toString().substring(0, 2)
                //       : data['riskPoint'].toString(),
                //   radius: 20,
                //   fontsize: size.width * 20,
                //   initialRiskLevel: data['initialRiskLevel'],
                //   level: 5,
                //   // value: data['totalNum'] == 0 ||
                //   //         data['totalNum'] != null ||
                //   //         data['uncontrolledNum'] != null
                //   //     ? 10
                //   //     : 10 -
                //   //         ((data['totalNum'] - data['uncontrolledNum']) /
                //   //                 data['totalNum'] *
                //   //                 10)
                //   //             .toInt()
                //   //             .abs(),
                // ),
                Row(children: [
                  Expanded(child: Text(data['riskPoint'].toString())),
                ]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '风险描述: ',
                      style: TextStyle(
                          color: placeHolder, fontSize: size.width * 24),
                    ),
                    Expanded(
                        child: Text(
                      data['riskDescription'].toString(),
                      style: TextStyle(
                          color: placeHolder, fontSize: size.width * 24),
                    )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
