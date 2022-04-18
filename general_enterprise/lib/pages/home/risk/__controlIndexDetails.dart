import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class ControlIndexDetails extends StatefulWidget {
  ControlIndexDetails({this.data, this.oneId, this.index});
  final List data;
  final int oneId;
  final int index;
  @override
  _ControlIndexDetailsState createState() => _ControlIndexDetailsState();
}

class _ControlIndexDetailsState extends State<ControlIndexDetails> {
  List leftData = [];
  int oneId;
  int choosed;
  DateTime choiceDate;
  List data = [];

  @override
  void initState() {
    super.initState();
    leftData = widget.data;
    oneId = widget.oneId;
    choosed = widget.index;
    data = leftData[choosed]['meterDataList'];
    choiceDate = DateTime.now();
  }

  _getData() {
    myDio.request(
        type: 'get',
        url: Interface.getMeterDataHistory,
        queryParameters: {
          'oneId': oneId,
          'date': choiceDate.toString().substring(0, 10)
        }).then((value) {
      if (value != null) {
        data = value[choosed]['meterDataList'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: Text(leftData[choosed]['keyParameterIndex'].toString()),
      child: Stack(children: [
        Container(
          margin: EdgeInsets.only(left: size.width * 100),
          height: widghtSize.height,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: size.width * 600,
                height: size.width * 207,
                margin: EdgeInsets.symmetric(
                    vertical: size.width * 15, horizontal: size.width * 30),
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
                        "管控措施：" + leftData[choosed]['keyParameterIndex'],
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: '风险分析单元：',
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 20),
                                    children: [
                                      TextSpan(
                                          text: leftData[choosed]['riskUnit'],
                                          style: TextStyle(
                                              color: Color(0xff666666),
                                              fontSize: size.width * 20,
                                              fontWeight: FontWeight.bold))
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
                                          text: leftData[choosed]['riskItem'],
                                          style: TextStyle(
                                              color: Color(0xff666666),
                                              fontSize: size.width * 20,
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: '参考范围：',
                                    style: TextStyle(
                                        color: Color(0xff3073FE),
                                        fontSize: size.width * 20),
                                    children: [
                                      TextSpan(
                                          text: leftData[choosed]
                                              ['referenceRange'],
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: size.width * 20,
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 15,
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now().toLocal(),
                          firstDate:
                              DateTime(DateTime.now().toLocal().year - 30),
                          lastDate:
                              DateTime(DateTime.now().toLocal().year + 30))
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        choiceDate = value;
                        _getData();
                      });
                    }
                  });
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 30),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                    width: double.infinity,
                    height: size.width * 84,
                    decoration: BoxDecoration(
                        border: Border.all(color: underColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Row(
                      children: [
                        Text(
                          choiceDate != null
                              ? choiceDate.toString().split(' ')[0]
                              : '选择日期',
                          style: TextStyle(
                              color: Color(0xff898989),
                              fontSize: size.width * 32),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/icon_risk_date.png',
                          height: size.width * 43,
                          width: size.width * 49,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Container(
                color: Color(0xffECECEC),
                width: double.infinity,
                height: size.width * 42,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '           巡检时间',
                      style: TextStyle(
                          fontSize: size.width * 24,
                          color: Color(0xff424242),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '           巡检数值',
                      style: TextStyle(
                          fontSize: size.width * 24,
                          color: Color(0xff424242),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 15,
              ),
              Expanded(
                  child: data.isNotEmpty
                      ? ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      DateTime.fromMillisecondsSinceEpoch(data[index]['reportingTime']).toString().substring(0, 19),
                                      style: TextStyle(
                                          fontSize: size.width * 20,
                                          color: Color(0xff666666)),
                                    ),
                                    Text(
                                      data[index]['reportingData'] == ''
                                          ? "逾期"
                                          : data[index]['reportingData']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: size.width * 20,
                                          color: Color(0xff666666)),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.width * 1,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.width * 30,
                                      vertical: size.width * 15),
                                  color: Color(0xffD6D6D6),
                                ),
                              ],
                            );
                          },
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: Text(
                            '暂无数据',
                          ),
                        ))
            ],
          ),
        ),
        RiskDetailsLeftBar(
            leftBar: leftData,
            callback: (int index) {
              choosed = index;
              // _getData(leftBar[choosed]['id']);
              data = leftData[choosed]['meterDataList'];
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

class RiskDetailsLeftBar extends StatefulWidget {
  RiskDetailsLeftBar({this.leftBar, this.callback, this.choosed});
  final List leftBar;
  final LeftBarCallback callback;
  final int choosed;
  @override
  _RiskDetailsLeftBarState createState() => _RiskDetailsLeftBarState();
}

class _RiskDetailsLeftBarState extends State<RiskDetailsLeftBar>
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
                                                    !isOpen ? widget.leftBar[index]['keyParameterIndex'].toString().length > 2 ? widget.leftBar[index]['keyParameterIndex'].toString().substring(0, 2) : widget.leftBar[index]['keyParameterIndex'] : widget.leftBar[index]['keyParameterIndex'],
                                                    style: TextStyle(
                                                      color: widget.choosed == index
                                                      ? Color(0xff3073FE)
                                                      : Color(0xff959595),
                                                      fontSize: size.width * 18
                                                    ),
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
