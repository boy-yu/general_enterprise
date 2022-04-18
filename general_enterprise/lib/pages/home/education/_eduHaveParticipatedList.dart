import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class EduHaveParticipatedList extends StatefulWidget {
  EduHaveParticipatedList({this.haveParticipatedList, this.planType});
  final List haveParticipatedList;
  final int planType;
  @override
  _EduHaveParticipatedListState createState() =>
      _EduHaveParticipatedListState();
}

class _EduHaveParticipatedListState extends State<EduHaveParticipatedList> {
  int choosed = 0;
  List leftBar = [
    {'name': '线上计划'},
    {'name': '现场计划'},
  ];

  TextEditingController _editingController = TextEditingController();

  List personnelList = [];

  _secher(String keys) {
    personnelList = [];
    for (int i = 0; i < widget.haveParticipatedList.length; i++) {
      if (widget.haveParticipatedList[i]['nickname'].toString().indexOf(keys) !=
          -1) {
        personnelList.add(widget.haveParticipatedList[i]);
      }
    }
    perSelect = 0;
    if (personnelList.isNotEmpty) {
      _getData(personnelList);
      nameSelect = personnelList[perSelect]['nickname'];
    } else {
      _getData(widget.haveParticipatedList);
      nameSelect = widget.haveParticipatedList[perSelect]['nickname'];
    }
    setState(() {});
  }

  int perSelect = 0;

  String nameSelect = '';

  @override
  void initState() {
    super.initState();
    if (widget.haveParticipatedList.isNotEmpty) {
      nameSelect = widget.haveParticipatedList[0]['nickname'];
      _getData(widget.haveParticipatedList);
    }
  }

  _getNum(List list) {
    if (choosed == 0) {
      return list[perSelect]['onLineTrainingSituationList'].length.toString();
    } else if (choosed == 1) {
      return list[perSelect]['offlineTrainingSituationList'].length.toString();
    }
  }

  List data = [];

  _getData(List list) {
    if (choosed == 0) {
      data = list[perSelect]['onLineTrainingSituationList'];
    } else if (choosed == 1) {
      data = list[perSelect]['offlineTrainingSituationList'];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size widghtSize = MediaQuery.of(context).size;
    print(widget.haveParticipatedList);
    return MyAppbar(
      title: Text('已计划培训人员'),
      child: Stack(children: [
        Container(
          margin: EdgeInsets.only(left: size.width * 110),
          height: widghtSize.height,
          // color: Colors.white,
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.symmetric(
                //     horizontal: size.width * 20, vertical: size.width * 30),
                    color: Colors.white,
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius:
                //         BorderRadius.all(Radius.circular(size.width * 10)),
                //     boxShadow: [
                //       BoxShadow(
                //           color: Colors.black12,
                //           blurRadius: 1.0,
                //           spreadRadius: 1.0),
                //     ]),
                child: Column(
                  children: [
                    Container(
                      height: size.width * 75,
                      margin: EdgeInsets.fromLTRB(size.width * 40,
                          size.width * 30, size.width * 40, size.width * 5),
                      decoration: BoxDecoration(
                          color: Color(0xffFAFAFB),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: placeHolder.withOpacity(.2), width: 2)),
                      child: TextField(
                        controller: _editingController,
                        textInputAction: TextInputAction.search,
                        onChanged: _secher,
                        onSubmitted: _secher,
                        maxLines: 1,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              size: size.width * 40,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(size.width * 40,
                                0, size.width * 40, size.width * 38),
                            hintText: '请输入名字',
                            hintStyle: TextStyle(
                                color: Color(0xffACACBC),
                                fontSize: size.width * 24)),
                      ),
                    ),
                    Container(
                        height: size.width * 150,
                        child: widget.haveParticipatedList.isNotEmpty
                            ? personnelList.isNotEmpty
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: personnelList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          perSelect = index;
                                          nameSelect = personnelList[perSelect]
                                              ['nickname'];
                                          _getNum(personnelList);
                                          _getData(personnelList);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: size.width * 100,
                                          padding: EdgeInsets.only(
                                              top: size.width * 30),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: size.width * 64,
                                                width: size.width * 64,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: index == perSelect
                                                          ? AssetImage(
                                                              'assets/images/dotted_line_quan_select@2x@2x.png')
                                                          : AssetImage(
                                                              'assets/images/dotted_line_quan@2x.png'),
                                                      fit: BoxFit.cover),
                                                ),
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: size.width * 44,
                                                  width: size.width * 44,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                          image: personnelList[index][
                                                                      'photoUrl'] !=
                                                                  ''
                                                              ? NetworkImage(
                                                                  personnelList[index]
                                                                      [
                                                                      'photoUrl'])
                                                              : AssetImage(
                                                                  'assets/images/image_recent_control.jpg'),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  size.width *
                                                                      50))),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Text(
                                                personnelList[index]
                                                    ['nickname'],
                                                style: TextStyle(
                                                    color: index == perSelect
                                                        ? Color(0xff3073FE)
                                                        : Color(0xff949494),
                                                    fontSize: size.width * 18),
                                                    maxLines: 1
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.haveParticipatedList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          perSelect = index;
                                          nameSelect =
                                              widget.haveParticipatedList[
                                                  perSelect]['nickname'];
                                          _getNum(widget.haveParticipatedList);
                                          _getData(widget.haveParticipatedList);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: size.width * 100,
                                          padding: EdgeInsets.only(
                                              top: size.width * 30),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: size.width * 64,
                                                width: size.width * 64,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: index == perSelect
                                                          ? AssetImage(
                                                              'assets/images/dotted_line_quan_select@2x@2x.png')
                                                          : AssetImage(
                                                              'assets/images/dotted_line_quan@2x.png'),
                                                      fit: BoxFit.cover),
                                                ),
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: size.width * 44,
                                                  width: size.width * 44,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                          image: widget.haveParticipatedList[index]
                                                                      [
                                                                      'photoUrl'] !=
                                                                  ''
                                                              ? NetworkImage(widget
                                                                      .haveParticipatedList[index]
                                                                  ['photoUrl'])
                                                              : AssetImage(
                                                                  'assets/images/image_recent_control.jpg'),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  size.width * 50))),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Text(
                                                widget.haveParticipatedList[
                                                    index]['nickname'],
                                                style: TextStyle(
                                                    color: index == perSelect
                                                        ? Color(0xff3073FE)
                                                        : Color(0xff949494),
                                                    fontSize: size.width * 18),
                                                maxLines: 1
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                            : Center(
                                child: Text('暂无人员'),
                              ))
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: size.width * 20),
                padding: EdgeInsets.all(size.width * 30),
                color: Colors.white,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(
                //             'assets/images/edu_per_plan_canja@2x.png'),
                //         fit: BoxFit.cover),
                //     borderRadius:
                //         BorderRadius.all(Radius.circular(size.width * 10)),
                //     boxShadow: [
                //       BoxShadow(
                //           blurRadius: 1.0,
                //           color: Colors.black12,
                //           spreadRadius: 1.0)
                //     ]
                // ),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '参加培训统计：',
                          style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: size.width * 24),
                        ),
                        SizedBox(
                          height: size.width * 5,
                        ),
                        Text(
                          widget.haveParticipatedList.isNotEmpty
                              ? personnelList.isNotEmpty
                                  ? _getNum(personnelList) + '次'
                                  : _getNum(widget.haveParticipatedList) + '次'
                              : '0次',
                          style: TextStyle(
                              color: Color(0xff5570FF),
                              fontSize: size.width * 52,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text(
                      nameSelect + '培训详情',
                      style: TextStyle(
                          fontSize: size.width * 28,
                          color: Color(0xff999999),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Expanded(
                child: Container(
                color: Colors.white,
                child: data.isNotEmpty
                    ? ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 20),
                            decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(size.width * 10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0),
                                  ]),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                GestureDetector(
                                  onTap: (){
                                    if (choosed == 0) {   // 线上
                                      if(widget.planType == 1){   // 普通培训
                                        Navigator.pushNamed(
                                          context, "/home/education/styduPlanDetail",
                                          arguments: {
                                            'planId': data[index]['planId'],
                                            'source': 2
                                          }
                                        );
                                      }else if(widget.planType == 2){   // 年度培训
                                        Navigator.pushNamed(
                                          context, 
                                          "/home/education/yearPlanDetails",
                                          arguments: {
                                            'id': data[index]['planId']
                                          }
                                        );
                                      }
                                    } else if (choosed == 1) {    // 线下
                                      if(widget.planType == 1){   // 普通培训
                                        Navigator.pushNamed(
                                          context, "/home/education/styduOfflinePlanDetail",
                                          arguments: {
                                            'planId': data[index]['planId'],
                                            'title': data[index]['planName']
                                          }
                                        );
                                      }else if(widget.planType == 2){   // 年度培训
                                        Navigator.pushNamed(
                                          context, 
                                          "/home/education/offLineYearPlanDetails",
                                          arguments: {
                                            'id': data[index]['planId']
                                          }
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          data[index]['planName'].toString(),
                                          style: TextStyle(
                                              color: Color(0xff4D4D4D),
                                              fontSize: size.width * 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          size: size.width * 40,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                choosed == 0 ? Container(
                                  height: size.width * 1,
                                  color: Color(0xffeeeeee),
                                  width: double.infinity,
                                ) : Container(),
                                choosed == 0 ? ListView.builder(
                                  shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                                  physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                                  itemCount: data[index]['stage'].length,
                                  itemBuilder: (context, _index){
                                    return InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(
                                          context, 
                                          "/home/education/eduCheckExamLedgerDetails", 
                                          arguments: {
                                            'examinationId': data[index]['stage'][_index]['id']
                                          }
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: size.width * 15, vertical: size.width * 20),
                                        margin: EdgeInsets.all(size.width * 24),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                                          border: Border.all(width: size.width * 2, color: Color(0xff3477FF)),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/icon_edu_overview_exam_ledger_details.png',
                                              height: size.width * 48,
                                              width: size.width * 48,
                                            ),
                                            SizedBox(
                                              width: size.width * 20,
                                            ),
                                            Text(
                                              '第' + (_index + 1).toString() + '阶段考核分数：${data[index]['stage'][_index]['score']}',
                                              style: TextStyle(
                                                color: Color(0xff404040),
                                                fontSize: size.width * 20,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '查看',
                                              style: TextStyle(
                                                color: Color(0xff3477FF),
                                                fontSize: size.width * 20
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                ) : Container()
                              // Expanded(
                              //   child: ListView.builder(
                              //     shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                              //     physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                              //     itemCount: data[index]['stage'].length,
                              //     itemBuilder: (context, _index){
                              //       return Text(
                              //         '第' + (_index + 1).toString() + '阶段考核分数：${data[index]['stage'][_index]['score']}',
                              //         style: TextStyle(
                              //           color: Color(0xff4D4D4D),
                              //           fontSize: size.width * 28,
                              //         ),
                              //       );
                              //     }
                              //   )
                              // )
                              // choosed == 0
                              //     ? Column(
                              //         children: data[index]['stage']
                              //             .asMap()
                              //             .keys
                              //             .map((_index) => Text('第' +
                              //                 (index + 1).toString() +
                              //                 '阶段考核分数：${data[index]['stage'][_index]['score']}'))
                              //             .toList(),
                              //       )
                              //     : Container(),
                            ],
                          ),
                          );
                        })
                    : Container(
                        alignment: Alignment.center,
                        child: Text('暂无数据'),
                      ),
              ))
            ],
          ),
        ),
        RiskObjectLeftBar(
            leftBar: leftBar,
            callback: (int index) {
              choosed = index;
              if (widget.haveParticipatedList.isNotEmpty) {
                if (personnelList.isNotEmpty) {
                  _getData(personnelList);
                } else {
                  _getData(widget.haveParticipatedList);
                }
              }
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
