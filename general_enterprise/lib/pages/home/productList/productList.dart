import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/productList/_mainList.dart';
import 'package:enterprise/pages/home/productList/_myPostList.dart';
import 'package:enterprise/pages/home/productList/_postList.dart';
import 'package:enterprise/pages/home/productList/_riskList.dart';
import 'package:enterprise/pages/home/productList/_workList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

GlobalKey<_ProductListState> _productListState = GlobalKey();

class ProductList extends StatefulWidget {
  ProductList() : super(key: _productListState);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List leftBar = [
    {
      "name": "主体责任",
      'title': '企业主体责任清单',
      'icon': "assets/images/icon_list_main_checked.png",
      'unIcon': 'assets/images/icon_list_main_unchecked.png',
      "widget": MainList()
    },
    {
      "name": "日常工作",
      'title': '企业日常工作清单',
      'icon': "assets/images/icon_list_work_checked.png",
      'unIcon': 'assets/images/icon_list_work_unchecked.png',
      "widget": CheckWorkList()
    },
    {
      "name": "岗位责任",
      'title': '企业岗位责任清单',
      'icon': "assets/images/icon_list_post_checked.png",
      'unIcon': 'assets/images/icon_list_post_unchecked.png',
      "widget1": CheckMyPostList(),
      "widget2": CheckPostList(),
    },
    {
      "name": "重大风险",
      'title': '企业重大风险清单',
      'icon': "assets/images/icon_list_control_checked.png",
      'unIcon': 'assets/images/icon_list_control_unchecked.png',
      "widget": CheckRiskList()
    },
  ];
  int choosed = 0;
  int firmTitleChoosed = 0;
  List<String> menuList;

  @override
  void initState() {
    super.initState();
    menuList = myprefs.getStringList('appFunctionMenu');
    if(!menuList.contains('风险管控')){
      leftBar[2] = {
        "name": "日常工作",
        'title': '企业日常工作清单',
        'icon': "assets/images/icon_list_work_checked.png",
        'unIcon': 'assets/images/icon_list_work_unchecked.png',
        "widget": Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/image_not_yet_module.png',
                  width: size.width * 350,
                  height: size.width * 350,
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Text(
                  '暂未购买该模块',
                  style: TextStyle(
                    fontSize: size.width * 28
                  ),
                ),
              ],
            )
          ),
      };
      leftBar[4] = {
        "name": "重大风险",
        'title': '企业重大风险清单',
        'icon': "assets/images/icon_list_control_checked.png",
        'unIcon': 'assets/images/icon_list_control_unchecked.png',
        "widget": Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/image_not_yet_module.png',
                  width: size.width * 350,
                  height: size.width * 350,
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Text(
                  '暂未购买该模块',
                  style: TextStyle(
                    fontSize: size.width * 28
                  ),
                ),
              ],
            )
          ),
      };
    }
  }

  _getWidget() {
    setState(() {});
  }

  _getTitle(String title) {
    if (title == '企业岗位责任清单') {
      return CheckPostListTitle(
          callback: _getWidget, firmTitleChoosed: firmTitleChoosed);
    } else {
      return Text(title);
    }
  }

  _getChild(String title) {
    if (title == '企业岗位责任清单') {
      if (firmTitleChoosed == 1) {
        return leftBar[choosed]['widget2'];
      } else {
        return leftBar[choosed]['widget1'];
      }
    } else {
      return leftBar[choosed]['widget'];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: _getTitle(leftBar[choosed]['title']),
      child: Stack(children: [
        Container(
          margin: EdgeInsets.only(left: size.width * 100),
          height: widghtSize.height,
          color: Color(0xffF6F9FF),
          child: _getChild(leftBar[choosed]['title']),
        ),
        ProductListHomeLeftBar(
            leftBar: leftBar,
            callback: (int index) {
              choosed = index;
              if (mounted) {
                setState(() {});
              }
            },
            choosed: choosed),
      ]),
    );
  }
}

typedef LeftBarCallback = void Function(int index);

class ProductListHomeLeftBar extends StatefulWidget {
  ProductListHomeLeftBar({this.leftBar, this.callback, this.choosed});
  final List leftBar;
  final LeftBarCallback callback;
  final int choosed;
  @override
  _ProductListHomeLeftBarState createState() => _ProductListHomeLeftBarState();
}

class _ProductListHomeLeftBarState extends State<ProductListHomeLeftBar>
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
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              size.width * 10),
                                          gradient: LinearGradient(
                                              colors: widget.choosed == index
                                                  ? [
                                                      Color(0xff56E0FF),
                                                      Color(0xff2182FF)
                                                    ]
                                                  : [
                                                      Colors.transparent,
                                                      Colors.transparent
                                                    ])),
                                      alignment: Alignment.center,
                                      margin: !isOpen
                                          ? EdgeInsets.only(bottom: 10, top: 10)
                                          : EdgeInsets.only(
                                              bottom: 10, top: 10, left: 10),
                                      constraints: BoxConstraints.expand(
                                          height: size.width * 63.0,
                                          width: size.width * 62.0),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.all(
                                      //       Radius.circular(15.0)),
                                      //   image: DecorationImage(
                                      //     image: AssetImage(widget.leftBar[index]['icon']),
                                      //     centerSlice: Rect.fromLTRB(
                                      //       270.0,
                                      //       180.0,
                                      //       1360.0,
                                      //       730.0,
                                      //     ),
                                      //   ),
                                      // ),
                                      child: Image.asset(
                                        _getIcon(index),
                                        width: size.width * 60,
                                        height: size.width * 60,
                                      ),
                                    ),
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

class CheckPostListTitle extends StatefulWidget {
  CheckPostListTitle({this.callback, this.firmTitleChoosed});
  final Function callback;
  final int firmTitleChoosed;
  @override
  _CheckPostListTitleState createState() => _CheckPostListTitleState();
}

class _CheckPostListTitleState extends State<CheckPostListTitle> {
  List<String> data = ['我的岗责', '企业岗责'];
  int choosed;

  @override
  void initState() {
    super.initState();
    if (widget.firmTitleChoosed == 0) {
      choosed = 0;
    } else {
      choosed = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: size.width * 0),
      child: Container(
        width: size.width * 420,
        height: size.width * 54,
        decoration: BoxDecoration(
          border: Border.all(width: size.width * 1, color: Colors.white),
          // borderRadius: BorderRadius.all(Radius.circular(27.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data
              .asMap()
              .keys
              .map((index) => InkWell(
                    onTap: () {
                      choosed = index;
                      _productListState.currentState.firmTitleChoosed = choosed;
                      widget.callback();
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: size.width * 54,
                      width: size.width * 209,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.all(Radius.circular(27.0)),
                          color: choosed == index
                              ? Colors.white
                              : Color(0xff295DF7)),
                      // padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                      alignment: Alignment.center,
                      child: Text(
                        data[index],
                        style: TextStyle(
                            fontSize: size.width * 30,
                            color: choosed == index
                                ? Color(0xff295DF7)
                                : Colors.white),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
