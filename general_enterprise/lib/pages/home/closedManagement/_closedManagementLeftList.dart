import 'package:enterprise/common/myAppbar.dart';
// import 'package:enterprise/pages/home/closedManagement/__closedManagementNews.dart';
import 'package:enterprise/pages/home/closedManagement/__accessrecords.dart';
import 'package:enterprise/pages/home/closedManagement/__bookingManagement.dart';
import 'package:enterprise/pages/home/closedManagement/_newReservationRecord.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

GlobalKey<_ClosedManagementLeftListState> _closedManagementLeftListKey =
    GlobalKey();

class ClosedManagementLeftList extends StatefulWidget {
  ClosedManagementLeftList({this.index})
      : super(key: _closedManagementLeftListKey);
  final int index;
  @override
  State<ClosedManagementLeftList> createState() =>
      _ClosedManagementLeftListState();
}

class _ClosedManagementLeftListState extends State<ClosedManagementLeftList> {
  List leftBar = [
    // {
    //   "name": "总览",
    //   'title': '封闭化总览',
    //   'icon': "assets/images/fengbi_overview.png",
    //   'unIcon': 'assets/images/un_fengbi_overview.png',
    //   "widget": ClosedManagementOverview()
    // },
    {
      "name": "出入记录",
      'title': '出入记录',
      'icon': "assets/images/fengbi_access.png",
      'unIcon': 'assets/images/un_fengbi_access.png',
      "widget": Accessrecords(),
    },
    {
      "name": "预约管理",
      'title': '预约管理',
      'icon': "assets/images/fengbi_order.png",
      'unIcon': 'assets/images/un_fengbi_order.png',
      "widget": BookingManagement()
    },
    {
      "name": "预约记录",
      'title': '我的预约记录',
      'icon': "assets/images/my_fengbi_record.png",
      'unIcon': 'assets/images/un_my_fengbi_record.png',
      "widget": NewReservationRecord()
    },
    // {
    //   "name": "我的消息",
    //   'title': '我的消息',
    //   'icon': "assets/images/fengbi_information.png",
    //   'unIcon': 'assets/images/un_fengbi_information.png',
    //   "widget": ClosedManagementNews()
    // },
  ];

  int choosed = 0;

  @override
  void initState() {
    super.initState();
    choosed = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: Text(leftBar[choosed]['title'].toString()),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 53),
            height: widghtSize.height,
            color: Color(0xffF6F9FF),
            child: leftBar[choosed]['widget'],
          ),
          ClosedManagementLeftBar(
              leftBar: leftBar,
              callback: (int index) {
                choosed = index;
                if (mounted) {
                  setState(() {});
                }
              },
              choosed: choosed),
        ],
      ),
    );
  }
}

typedef LeftBarCallback = void Function(int index);

class ClosedManagementLeftBar extends StatefulWidget {
  ClosedManagementLeftBar({this.leftBar, this.callback, this.choosed});
  final List leftBar;
  final LeftBarCallback callback;
  final int choosed;
  @override
  State<ClosedManagementLeftBar> createState() =>
      _ClosedManagementLeftBarState();
}

class _ClosedManagementLeftBarState extends State<ClosedManagementLeftBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool isOpen = false;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animation = Tween(begin: size.width * 110, end: size.width * 350)
        .animate(_animation);
    super.initState();
  }

  _getIcon(int index) {
    if (index == widget.choosed) {
      return widget.leftBar[index]['icon'];
    } else {
      return widget.leftBar[index]['unIcon'];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return GestureDetector(
        onPanEnd: (details) {
          if (_animationController.value.toInt() == 0 ||
              _animationController.value.toInt() == 1) {
            isOpen = !isOpen;
            if (isOpen) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          }
        },
        child: Row(
          children: [
            Container(
              width: _animation.value,
              height: widghtSize.height,
              color: Color(0xffEAEDF2),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            isOpen = !isOpen;
                            if (isOpen) {
                              _animationController.forward();
                            } else {
                              _animationController.reverse();
                            }
                          },
                          child: !isOpen
                              ? Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      size.width * 20,
                                      size.width * 40,
                                      size.width * 20),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 26,
                                        height: size.width * 22,
                                        margin: EdgeInsets.all(3),
                                        child: Image.asset(
                                            'assets/images/hidden_open.png'),
                                      ),
                                      Text(
                                        '展开',
                                        style: TextStyle(
                                            color: Color(0xff949494),
                                            fontSize: size.width * 16),
                                      )
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(size.width * 20),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 26,
                                        height: size.width * 22,
                                        margin: EdgeInsets.all(3),
                                        child: Image.asset(
                                            'assets/images/hidden_close.png'),
                                      ),
                                      Text(
                                        '收起',
                                        style: TextStyle(
                                            color: Color(0xff949494),
                                            fontSize: size.width * 16),
                                      )
                                    ],
                                  ),
                                )),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.leftBar.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (isOpen) {
                                isOpen = false;
                                _animationController.reverse();
                              }
                              widget.callback(index);
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Container(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: !isOpen
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.center,
                                        margin: !isOpen
                                            ? EdgeInsets.only(
                                                bottom: 10, top: 10)
                                            : EdgeInsets.only(
                                                bottom: 10, top: 10, left: 10),
                                        height: size.width * 60,
                                        width: size.width * 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Image.asset(
                                          _getIcon(index),
                                          width: size.width * 50,
                                          height: size.width * 50,
                                        )),
                                    !isOpen
                                        ? Container()
                                        : Expanded(
                                            child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              widget.leftBar[index]['title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color(0xff343434),
                                                  fontSize: size.width * 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ))
                                  ],
                                ),
                                !isOpen
                                    ? Text(
                                        widget.leftBar[index]['name']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: size.width * 20),
                                      )
                                    : Container(),
                              ],
                            )),
                          );
                        }),
                  )
                ],
              ),
            ),
            isOpen
                ? Expanded(
                    child: Container(
                    color: Color.fromRGBO(0, 0, 0, .3),
                  ))
                : Container()
          ],
        ));
  }
}
