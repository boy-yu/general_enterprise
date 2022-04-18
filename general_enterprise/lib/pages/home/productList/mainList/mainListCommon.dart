// import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

GlobalKey<_MainListCommonPagesState> workListglobalKey = GlobalKey();

class MainListCommonPages extends StatefulWidget {
  MainListCommonPages({this.throwFunc, this.id});
  final ThrowFunc throwFunc;
  final int id;
  @override
  _MainListCommonPagesState createState() => _MainListCommonPagesState();
}

class _MainListCommonPagesState extends State<MainListCommonPages> {
  @override
  void initState() {
    super.initState();
    // widget.throwFunc.init([_getData]);
    widget.throwFunc.detailInit(_getData);
  }

  String icon = '';
  List data = [];

  _getData({dynamic argument}) {
    if (argument['children'] is List) {
      data = argument['children'];
      icon = argument['icon'];
      if (mounted) {
        setState(() {});
      }
    }
  }

  _getUrl(String mainValue) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(mainValue), 'title': '查看文档'});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return MainTowItem(
            data[index],
            callback: () {
              List<HiddenDangerInterface> _leftbar = [];
              _leftbar = _leftbar.changeHiddenDangerInterfaceType(data,
                  title: 'name', icon: icon, id: 'id', children: 'children');
              _leftbar[index].color = Colors.white;
              if (_leftbar[index].children.isNotEmpty) {
                Navigator.pushNamed(context, '/index/productList/CommonPage',
                    arguments: {
                      "leftBar": _leftbar,
                      "index": index,
                      "widgetType": 'MainListCommonPages',
                    });
              } else {
                if (data[index]['isFinal'] == 1) {
                  _getUrl(data[index]['mainValue']);
                } else {
                  Fluttertoast.showToast(msg: '数据不完整');
                }
                // Fluttertoast.showToast(msg: '已无下一级数据');
              }
            },
          );
        });
  }
}

class MainTowItem extends StatelessWidget {
  MainTowItem(this.dataMap, {this.callback});
  final Map dataMap;
  final Function callback;

  Widget _juegeData() {
    Widget _widget = Container();
    if (dataMap['expiration'] != null) {
      DateTime now = DateTime.now().toLocal();
      DateTime finalData = DateTime.parse(dataMap['expiration'].toString());

      if (finalData.difference(now).compareTo(Duration(days: 7)) == -1) {
        _widget = Image.asset(
          'assets/images/icon_count_down.png',
          width: size.width * 26,
          height: size.width * 30,
        );
      }

      if (finalData.difference(now).compareTo(Duration(days: 0)) == -1) {
        _widget = Container(
          child: Text(
            '已过期',
            style: TextStyle(color: Colors.red),
          ),
        );
      }
    }

    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.width * 10, horizontal: size.width * 10),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: callback,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(size.width * 30, size.width * 20,
                    size.width * 30, size.width * 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        dataMap['name'].toString(),
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _juegeData(),
                    SizedBox(
                      width: size.width * 20,
                    ),
                    // Text(
                    //   dataMap['countDown'] ?? '',
                    //   style: TextStyle(
                    //       color: Color(0xff3073FE), fontSize: size.width * 28),
                    // )
                  ],
                ),
              ),
              // Divider(),
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: size.width * 30, top: size.width * 20),
              //   child: Row(
              //     children: [
              //       Text(
              //         '管理部门：',
              //         style: TextStyle(
              //             color: Color(0xff666666), fontSize: size.width * 20),
              //       ),
              //       Text(
              //         dataMap['management'] ?? '',
              //         style: TextStyle(
              //             color: Color(0xff666666), fontSize: size.width * 20),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: size.width * 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 30, bottom: size.width * 20),
                child: Row(
                  children: [
                    Text(
                      '有效日期：',
                      style: TextStyle(
                          color: Color(0xff666666), fontSize: size.width * 20),
                    ),
                    Text(
                      dataMap['expiration'] == null
                          ? '永久'
                          : dataMap['expiration'].toString().split(' ')[0],
                      style: TextStyle(
                          color: Color(0xff666666), fontSize: size.width * 20),
                    ),
                  ],
                ),
              )
            ],
          ),
          padding: EdgeInsets.only(top: size.width * 20),
        ),
      ),
    );
  }
}
