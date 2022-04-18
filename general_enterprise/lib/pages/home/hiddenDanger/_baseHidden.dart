import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/hiddenDanger/picture.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class BaseHidden extends StatefulWidget {
  BaseHidden({this.leftBar, this.title});
  final String title;
  final List<HiddenDangerInterface> leftBar;
  @override
  _BaseHiddenState createState() => _BaseHiddenState();
}

class _BaseHiddenState extends State<BaseHidden> {
  List<HiddenDangerInterface> iconList = [];
  String title;
  bool isOpen = false;
  ThrowFunc _throwFunc = ThrowFunc();
  int type = 1;
  bool show = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    title = widget.title;
    commonTitle = title;
    iconList = widget.leftBar ?? [];
    for (var i = 0; i < iconList.length; i++) {
      if (iconList[i].title == title) {
        iconList[i].color = Colors.white;
        type = i + 1;
      } else {
        iconList[i].color = Colors.transparent;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      elevation: 0,
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
          // right
          Container(
              margin: EdgeInsets.only(
                left: size.width * 80,
              ),
              child: MyRefres(
                  child: (index, list) {
                    if (index == 0)
                      return Column(
                        children: [
                          HiddenPicture(
                            queryParameters: {
                              "mainType": type,
                            },
                          ),
                          Center(
                            child: BaseHiddenItem(
                              baseHiddenItem: list[index],
                              callback: () {
                                List<HiddenDangerInterface> _iconList = [];
                                _iconList = _iconList
                                    .changeHiddenDangerInterfaceType(list,
                                        title: 'hiddenType',
                                        id: "id",
                                        icon: null,
                                        iconWidget: null);
                                Navigator.pushNamed(
                                    context, '/home/hiddenDepartment',
                                    arguments: {
                                      'title': list[index]['hiddenType'].toString(),
                                      "leftBar": _iconList,
                                      "id": list[index]['id']
                                    });
                              },
                            ),
                          )
                        ],
                      );
                    return Center(
                      child: BaseHiddenItem(
                        baseHiddenItem: list[index],
                        callback: () {
                          List<HiddenDangerInterface> _iconList = [];
                          _iconList = _iconList.changeHiddenDangerInterfaceType(
                              list,
                              title: 'hiddenType',
                              id: "id",
                              icon: null,
                              iconWidget: null);

                          Navigator.pushNamed(context, '/home/hiddenDepartment',
                              arguments: {
                                'title': list[index]['hiddenType'].toString(),
                                "leftBar": _iconList,
                                "id": list[index]['id']
                              });
                        },
                      ),
                    );
                  },
                  throwFunc: _throwFunc,
                  queryParameters: {"type": type},
                  url: Interface.getHiddenDangerList,
                  method: 'get')),
          // left
          LeftBar(
            iconList: iconList,
            callback: (int index) {
              iconList.forEach((element) {
                element.color = Color(0xffEAEDF2);
              });
              iconList[index].color = Colors.white;
              type = index + 1;
              title = iconList[index].title;
              commonTitle = iconList[index].title;
              setState(() {});
              _throwFunc.run(argument: {"type": type});
            },
          ),
        ],
      ),
    );
  }
}

class BaseHiddenItem extends StatefulWidget {
  BaseHiddenItem({this.baseHiddenItem, @required this.callback});
  final Map baseHiddenItem;
  final Function callback;
  @override
  _BaseHiddenItemState createState() => _BaseHiddenItemState();
}

class _BaseHiddenItemState extends State<BaseHiddenItem> {
  String hiddenType = '';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 10),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.baseHiddenItem['hiddenType'].toString(),
                      style: TextStyle(
                          fontSize: size.width * 26,
                          color: Color(0xff343434),
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        hiddenType = widget.baseHiddenItem['hiddenType'];
                        Navigator.pushNamed(context, '/home/myLedger', arguments: {
                          'hiddenType': hiddenType,
                          'controlType': 1,
                        });
                      },
                      child: Icon(
                        Icons.query_builder,
                        color: themeColor,
                        size: size.width * 50,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '说明：',
                        style: TextStyle(
                          fontSize: size.width * 24,
                          color: Color(0xff666666),
                        ),
                      ),
                      Text(
                        widget.baseHiddenItem['description'].toString(),
                        style: TextStyle(
                          fontSize: size.width * 24,
                          color: Color(0xff666666),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '涉及隐患排查项共',
                        style: TextStyle(
                          fontSize: size.width * 24,
                          color: Color(0xff3074FE),
                        ),
                      ),
                      Text(
                        widget.baseHiddenItem['totalNum'].toString(),
                        style: TextStyle(
                          fontSize: size.width * 24,
                          color: Color(0xff3074FE),
                        ),
                      ),
                      Text(
                        '条',
                        style: TextStyle(
                          fontSize: size.width * 24,
                          color: Color(0xff3074FE),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            // width: size.width * 34,
                            constraints:
                                BoxConstraints(minWidth: size.width * 34),
                            height: size.width * 34,
                            padding: EdgeInsets.all(size.width * 2),
                            decoration: BoxDecoration(
                              color: Color(0xffFF4040),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Center(
                              child: Text(
                                widget.baseHiddenItem['totalNum'].toString(),
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: size.width * 22),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '排查项',
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            constraints:
                                BoxConstraints(minWidth: size.width * 34),
                            height: size.width * 34,
                            padding: EdgeInsets.all(size.width * 2),
                            decoration: BoxDecoration(
                              color: Color(0xff00C621),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Center(
                              child: Text(
                                (widget.baseHiddenItem['totalNum'] -
                                        widget.baseHiddenItem['unCheckNum'])
                                    .toString(),
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: size.width * 22),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '受控项',
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            // 0xffFAD400
                            constraints:
                                BoxConstraints(minWidth: size.width * 34),
                            height: size.width * 34,
                            padding: EdgeInsets.all(size.width * 2),
                            decoration: BoxDecoration(
                              color: Color(0xffFAD400),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Center(
                              child: Text(
                                widget.baseHiddenItem['unCheckNum'].toString(),
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: size.width * 22),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '不受控',
                              style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: size.width * 20),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
