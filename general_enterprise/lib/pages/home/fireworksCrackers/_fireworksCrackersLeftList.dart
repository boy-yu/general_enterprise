import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/fireworksCrackers/__productsInAndOut.dart';
import 'package:enterprise/pages/home/fireworksCrackers/_customerOrderRecord.dart';
import 'package:enterprise/pages/home/fireworksCrackers/_productManagement.dart';
import 'package:enterprise/pages/home/fireworksCrackers/_productOutbound.dart';
import 'package:enterprise/pages/home/fireworksCrackers/_supplierManagement.dart';
import 'package:enterprise/pages/home/fireworksCrackers/_warehouseManagement.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

GlobalKey<_FireworksCrackersLeftListState> _fireworksCrackersLeftglobalKey = GlobalKey();

class FireworksCrackersLeftList extends StatefulWidget {
  FireworksCrackersLeftList({this.index}): super(key: _fireworksCrackersLeftglobalKey);
  final int index;
  @override
  _FireworksCrackersLeftListState createState() => _FireworksCrackersLeftListState();
}

class _FireworksCrackersLeftListState extends State<FireworksCrackersLeftList> {
  List leftBar = [
    {
      "name": "产品出入库",
      'title': '产品出入库',
      'icon': "assets/images/fireworks_cracker_ex_warehouse_checked.png",
      'unIcon': 'assets/images/fireworks_cracker_ex_warehouse_unchecked.png',
      "widget": ProductsInAndOut()
    },
    {
      "name": "产品出库",
      'title': '产品出库',
      'icon': "assets/images/fireworks_cracker_ex_warehouse_checked.png",
      'unIcon': 'assets/images/fireworks_cracker_ex_warehouse_unchecked.png',
      "widget": ProductOutbound()
    },
    {
      "name": "产品管理",
      'title': '产品管理',
      'icon': "assets/images/fireworks_cracker_product_checked.png",
      'unIcon': 'assets/images/fireworks_cracker_product_unchecked.png',
      "widget": ProductManagement()
    },
    {
      "name": "仓库管理",
      'title': '仓库管理',
      'icon': "assets/images/fireworks_cracker_warehouse_checked.png",
      'unIcon': 'assets/images/fireworks_cracker_warehouse_unchecked.png',
      "widget": WarehouseManagement()
    },
    {
      "name": "客户订单",
      'title': '客户订单记录',
      'icon': "assets/images/fireworks_cracker_indent_checked.png",
      'unIcon': 'assets/images/fireworks_cracker_indent_unchecked.png',
      "widget": CustomerOrderRecord()
    },
    {
      "name": "供应商",
      'title': '供应商管理',
      'icon': "assets/images/fireworks_cracker_supplier_checked.png",
      'unIcon': 'assets/images/fireworks_cracker_supplier_unchecked.png',
      "widget": SupplierManagement()
    },
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
      title: Text(leftBar[choosed]['title']),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 53),
            height: widghtSize.height,
            color: Color(0xffF6F9FF),
            child: leftBar[choosed]['widget'],
          ),
          FireworksCrackersLeftBar(
            leftBar: leftBar,
            callback: (int index) {
              choosed = index;
              if (mounted) {
                setState(() {});
              }
            },
            choosed: choosed
          ),
        ],
      ),
    );
  }
}

typedef LeftBarCallback = void Function(int index);

class FireworksCrackersLeftBar extends StatefulWidget {
  FireworksCrackersLeftBar({this.leftBar, this.callback, this.choosed});
  final List leftBar;
  final LeftBarCallback callback;
  final int choosed;
  @override
  _FireworksCrackersLeftBarState createState() => _FireworksCrackersLeftBarState();
}

class _FireworksCrackersLeftBarState extends State<FireworksCrackersLeftBar> with SingleTickerProviderStateMixin{
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
                                        ? EdgeInsets.only( bottom: 10, top: 10)
                                        : EdgeInsets.only( bottom: 10, top: 10, left: 10),
                                        height: size.width * 60,
                                        width: size.width * 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                                        ),
                                        child: Image.asset(
                                          _getIcon(index),
                                          width: size.width * 50,
                                          height: size.width * 50,
                                        )
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