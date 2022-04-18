import 'package:enterprise/common/Refre.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/pages/home/hiddenDanger/picture.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HiddenDepartment extends StatefulWidget {
  HiddenDepartment({this.title, this.leftBar, this.id});
  final String title;
  final int id;
  final List<HiddenDangerInterface> leftBar;
  @override
  _HiddenDepartmentState createState() => _HiddenDepartmentState();
}

class _HiddenDepartmentState extends State<HiddenDepartment> {
  List<HiddenDangerInterface> iconList = [];
  int type = 1;
  String title;
  List hiddenDepartmentList = [];
  bool show = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    title = widget.title;
    iconList = widget.leftBar ?? [];
    for (var i = 0; i < iconList.length; i++) {
      if (iconList[i].title == title) {
        iconList[i].color = Colors.white;
        type = i + 1;
      } else {
        iconList[i].color = Colors.transparent;
      }
    }
    if (widget.id is int) {
      // _getData();
    } else {
      Fluttertoast.showToast(msg: "id不能为空，请联系开发人员");
    }
  }

  Future _getData() async {
    final value = await myDio.request(
        type: 'get',
        url: Interface.getHiddenDeparmentList,
        queryParameters: {"hiddenType": title});
    show = true;
    if (value is List) {
      hiddenDepartmentList = value;
    }

    if (mounted) {
      setState(() {});
    }
    return Future.value(true);
  }

  Function _updata;
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
          Container(
            margin: EdgeInsets.only(
              left: size.width * 80,
            ),
            child: Refre(
                child: (child, state, end, updata) {
                  _updata = updata;
                  return Column(
                    children: [
                      child,
                      Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: hiddenDepartmentList.length,
                              itemBuilder: (context, index) {
                                if (index == 0)
                                  return Column(
                                    children: [
                                      HiddenPicture(
                                        queryParameters: {
                                          "type": iconList[type - 1].title,
                                          // hiddenDepartmentList[
                                          //     index]['id']
                                        },
                                      ),
                                      HiddenDepartmentItem(
                                          hiddenDepartmentItem:
                                              hiddenDepartmentList[index],
                                          callback: () {
                                            List<HiddenDangerInterface> list =
                                                [];
                                            list = list
                                                .changeHiddenDangerInterfaceType(
                                                    hiddenDepartmentList,
                                                    title: 'name',
                                                    icon: null,
                                                    iconWidget: null,
                                                    id: "id");
                                            Navigator.pushNamed(
                                                context, '/home/hiddenSpecific',
                                                arguments: {
                                                  'title': hiddenDepartmentList[
                                                      index]['name'],
                                                  'id': hiddenDepartmentList[
                                                      index]['id'],
                                                  'leftBar': list,
                                                  'hiddenType': title,
                                                });
                                          })
                                    ],
                                  );
                                return HiddenDepartmentItem(
                                    hiddenDepartmentItem:
                                        hiddenDepartmentList[index],
                                    callback: () {
                                      List<HiddenDangerInterface> list = [];
                                      list =
                                          list.changeHiddenDangerInterfaceType(
                                              hiddenDepartmentList,
                                              title: 'name',
                                              icon: null,
                                              iconWidget: null,
                                              id: "id");
                                      Navigator.pushNamed(
                                          context, '/home/hiddenSpecific',
                                          arguments: {
                                            'title': hiddenDepartmentList[index]
                                                ['name'],
                                            'id': hiddenDepartmentList[index]
                                                ['id'],
                                            'leftBar': list,
                                            'hiddenType': title,
                                          });
                                    });
                              }))
                    ],
                  );
                },
                onRefresh: _getData),
          ),
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
              // _getData(iconList[index].id);
              _updata();
            },
          )
        ],
      ),
    );
  }
}

class HiddenDepartmentItem extends StatefulWidget {
  HiddenDepartmentItem({this.hiddenDepartmentItem, this.callback});
  final Map hiddenDepartmentItem;
  final Function callback;
  @override
  _HiddenDepartmentItemState createState() => _HiddenDepartmentItemState();
}

class _HiddenDepartmentItemState extends State<HiddenDepartmentItem> {
  int coDepartmentId = -1;

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
                      Text(widget.hiddenDepartmentItem['name'].toString(),
                          style: TextStyle(
                              fontSize: size.width * 26,
                              color: Color(0xff343434),
                              fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () {
                          coDepartmentId = widget.hiddenDepartmentItem['id'];
                          Navigator.pushNamed(context, '/home/myLedger', arguments: {
                            'coDepartmentId': coDepartmentId,
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
                  Container(
                    height: size.width * 1,
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    width: double.infinity,
                    color: Color(0xffEFEFEF),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '部门负责人：',
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 22),
                      ),
                      Text(
                        widget.hiddenDepartmentItem['departmentPrincipal']
                            .toString(),
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 22),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
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
                                color: Color(0xffFF4040),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                              ),
                              child: Center(
                                child: Text(
                                  widget.hiddenDepartmentItem['totalNum']
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
                                  (widget.hiddenDepartmentItem['totalNum'] -
                                          widget.hiddenDepartmentItem[
                                              'unCheckNum'])
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
                                  widget.hiddenDepartmentItem['unCheckNum']
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
        ));
  }
}

typedef LeftBarCallback = void Function(int index);

class LeftBar extends StatefulWidget {
  LeftBar({@required this.iconList, this.callback});
  final List<HiddenDangerInterface> iconList;
  final LeftBarCallback callback;
  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> with SingleTickerProviderStateMixin {
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
    _animation = Tween(begin: size.width * 90, end: size.width * 270)
        .animate(_animation);
    super.initState();
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
                                  padding: EdgeInsets.all(size.width * 20),
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
                        itemCount: widget.iconList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (isOpen) {
                                isOpen = false;
                                _animationController.reverse();
                              }
                              widget.iconList.forEach((element) {
                                element.color = Colors.transparent;
                              });
                              widget.iconList[index].color = Colors.white;
                              if (mounted) {
                                setState(() {});
                              }

                              widget.callback(index);
                            },
                            child: Container(
                                color: widget.iconList[index].color,
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
                                                    bottom: size.width * 10,
                                                    top: size.width * 10)
                                                : EdgeInsets.only(
                                                    bottom: size.width * 10,
                                                    top: size.width * 10,
                                                    left: size.width * 10),
                                            constraints: BoxConstraints.expand(
                                                height: size.width * 63.0,
                                                width: size.width * 62.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              image: widget.iconList[index]
                                                          .type ==
                                                      -1
                                                  ? DecorationImage(
                                                      image: AssetImage(widget
                                                          .iconList[index]
                                                          .bgicon),
                                                      centerSlice:
                                                          Rect.fromLTRB(
                                                        270.0,
                                                        180.0,
                                                        1360.0,
                                                        730.0,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                            child: widget
                                                        .iconList[index].icon !=
                                                    null
                                                ? widget.iconList[index].icon
                                                            .indexOf('http') >
                                                        -1
                                                    ? Container(
                                                        width: size.width * 30,
                                                        height: size.width * 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        50.0)),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    widget
                                                                        .iconList[
                                                                            index]
                                                                        .icon),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      )
                                                    : Image.asset(
                                                        widget.iconList[index]
                                                            .icon,
                                                        width: size.width * 25,
                                                        height: size.width * 25,
                                                      )
                                                : widget.iconList[index]
                                                    .iconWidget),
                                        !isOpen
                                            ? Container()
                                            : Expanded(
                                                child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  widget.iconList[index].title,
                                                  style: TextStyle(
                                                      color: Color(0xff343434),
                                                      fontSize: size.width * 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ))
                                      ],
                                    ),
                                    widget.iconList[index].name == null ||
                                            isOpen
                                        ? Container()
                                        : Text(
                                            widget.iconList[index].name
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: size.width * 20),
                                          ),
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
