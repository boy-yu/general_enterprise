import 'package:enterprise/common/loding.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class ControlIndex extends StatefulWidget {
  @override
  _ControlIndexState createState() => _ControlIndexState();
}

class _ControlIndexState extends State<ControlIndex> {
  List leftBar = [];
  int choosed = 0;
  List data = [];

  @override
  void initState() {
    super.initState();
    _getLeftBar();
  }

  _getLeftBar() {
    myDio.request(
        type: 'get',
        url: Interface.getCheckOneListAll,
        queryParameters: {'type': 3}).then((value) {
      if (value != null) {
        leftBar = value;
        _getData(leftBar[choosed]['id']);
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getData(int oneId) {
    DateTime dateTime = DateTime.now();
    String month;
    if (dateTime.month < 10) {
      month = '0' + dateTime.month.toString();
    } else {
      month = dateTime.month.toString();
    }
    String day;
    if (dateTime.month < 10) {
      day = '0' + dateTime.day.toString();
    } else {
      day = dateTime.day.toString();
    }

    String date = dateTime.year.toString() + "-" + month + "-" + day;

    myDio.request(
        type: 'get',
        url: Interface.getMeterDataHistory,
        queryParameters: {'oneId': oneId, 'date': date}).then((value) {
      if (value is List) {
        data = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: Text('控制指标历史数据'),
      child: Stack(children: [
        Container(
          margin: EdgeInsets.only(left: size.width * 100),
          height: widghtSize.height,
          color: Colors.white,
          child: data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/home/risk/controlIndex/details',
                            arguments: {
                              'data': data,
                              'index': index,
                              'oneId': leftBar[choosed]['id'],
                            });
                      },
                      child: Container(
                        width: size.width * 600,
                        height: size.width * 225,
                        margin: EdgeInsets.symmetric(
                            vertical: size.width * 15,
                            horizontal: size.width * 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 20,
                                  vertical: size.width * 15),
                              child: Text(
                                "管控措施：" + data[index]['keyParameterIndex'],
                                style: TextStyle(
                                    fontSize: size.width * 26,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              color: Color(0xffEFEFEF),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 25,
                                  vertical: size.width * 15),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: '风险分析单元：',
                                            style: TextStyle(
                                                color: Color(0xff666666),
                                                fontSize: size.width * 20),
                                            children: [
                                              TextSpan(
                                                  text: data[index]['riskUnit'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize: size.width * 20,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ]),
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: '风险事件：',
                                            style: TextStyle(
                                                color: Color(0xff666666),
                                                fontSize: size.width * 20),
                                            children: [
                                              TextSpan(
                                                  text: data[index]['riskItem'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize: size.width * 20,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ]),
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Container(
                                        width: size.width * 400,
                                        child: RichText(
                                          // overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          text: TextSpan(
                                              text: '参考范围：',
                                              style: TextStyle(
                                                  color: Color(0xff3073FE),
                                                  fontSize: size.width * 20),
                                              children: [
                                                TextSpan(
                                                    text: data[index]
                                                        ['referenceRange'],
                                                    style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: size.width * 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    width: size.width * 70,
                                    height: size.width * 34,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 8.0)),
                                      border: Border.all(
                                          width: 1, color: Color(0xff3073FE)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '查看',
                                      style: TextStyle(
                                        fontSize: size.width * 20,
                                        color: Color(0xff3073FE),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : StaticLoding(),
        ),
        RiskObjectLeftBar(
            leftBar: leftBar,
            callback: (int index) {
              choosed = index;
              _getData(leftBar[choosed]['id']);
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

class RiskObjectLeftBar extends StatefulWidget {
  RiskObjectLeftBar({this.leftBar, this.callback, this.choosed});
  final List leftBar;
  final LeftBarCallback callback;
  final int choosed;
  @override
  _RiskObjectLeftBarState createState() => _RiskObjectLeftBarState();
}

class _RiskObjectLeftBarState extends State<RiskObjectLeftBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
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
                  widget.leftBar.isNotEmpty
                      ? Expanded(
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
                                      decoration: BoxDecoration(
                                        color: widget.choosed == index
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 6.0)),
                                      ),
                                      child: Row(
                                        children: [
                                          // !isOpen ?
                                          SizedBox(
                                            width: size.width * 30,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: size.width * 44,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                !isOpen
                                                    ? widget.leftBar[index]
                                                                    ['name']
                                                                .toString()
                                                                .length >
                                                            2
                                                        ? widget.leftBar[index]
                                                                ['name']
                                                            .toString()
                                                            .substring(0, 2)
                                                        : widget.leftBar[index]
                                                            ['name']
                                                    : widget.leftBar[index]
                                                        ['name'],
                                                style: TextStyle(
                                                    color:
                                                        widget.choosed == index
                                                            ? Color(0xff3073FE)
                                                            : Color(0xff959595),
                                                    fontSize: size.width * 18),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          widget.choosed == index
                                              ? Container(
                                                  height: size.width * 44,
                                                  width: size.width * 4,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff3073FE),
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            bottomRight: Radius
                                                                .circular(
                                                                    size.width *
                                                                        6.0),
                                                            topRight: Radius
                                                                .circular(
                                                                    size.width *
                                                                        6.0)),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      )),
                                );
                              }),
                        )
                      : Container(),
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
