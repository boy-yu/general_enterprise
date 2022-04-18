import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/work/work_dilog/interruptWork.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkSafeList extends StatefulWidget {
  WorkSafeList(
      {this.sumbitWidget,
      this.circuit,
      this.id,
      this.bookId,
      this.changeTitle,
      this.operable = false,
      this.executionMemo});
  final Widget sumbitWidget;
  final int circuit, id, bookId;
  final Function changeTitle;
  final String executionMemo;
  final bool operable;
  @override
  _WorkSafeListState createState() => _WorkSafeListState();
}

class _WorkSafeListState extends State<WorkSafeList> {
  List data = [];
  Counter _counter = Provider.of<Counter>(myContext);
  int page = 0;
  List approvalProgress = [];
  int allReady = 0;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _change(int pages, List data) {
    approvalProgress = data;
    for (var i = 0; i < approvalProgress.length; i++) {
      if (approvalProgress[i]['sign'].toString().isNotEmpty) {
        allReady = i;
      }
    }
    page = pages;
    if (mounted) {
      setState(() {});
    }
  }

  _getData() {
    bool _sumbit = true;
    myDio
        .request(
      type: 'get',
      url: Interface.getReceiptPlannedSpeedList + widget.bookId.toString(),
    )
        .then((value) {
      if (value is List) {
        data = value;
        for (var i = 0; i < data.length; i++) {
          if (data[i]['plannedSpeed'] != 4) {
            _sumbit = false;
            break;
          }
        }
      }
      _counter.changeSubmitDates('作业清单', {"title": "是否可提交", "value": _sumbit});
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: page == 0
            ? Column(children: <Widget>[
                Expanded(
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SafeListItem(
                              operable: widget.operable,
                              dataMap: data[index],
                              getData: _getData,
                              bookId: widget.bookId,
                              length: data.length,
                              change: _change);
                        })),
                widget.sumbitWidget,
                SizedBox(height: size.width * 100)
              ])
            : Padding(
                padding: EdgeInsets.only(top: size.width * 40),
                child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: approvalProgress.length,
                    itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: size.width * 20),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(children: [
                                // SizedBox(height: size.width * 10),
                                index == 0
                                    ? SizedBox(height: size.width * 10)
                                    : Container(
                                        height: size.width * 10,
                                        width: 1,
                                        color: Color(0xffCCCCCC),
                                      ),
                                Container(
                                    width: size.width * 18,
                                    height: size.width * 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index > allReady
                                            ? Color(0xffCCCCCC)
                                            : index == allReady
                                                ? themeColor
                                                : Color(0xff09BA07))),
                                index != approvalProgress.length - 1
                                    ? Container(
                                        height: size.width * 160,
                                        width: 1,
                                        color: Color(0xffCCCCCC),
                                      )
                                    : Container(),
                              ]),
                              SizedBox(width: size.width * 20),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(approvalProgress[index]['opinionTitle'],
                                      style: TextStyle(
                                          color: Color(0xffCCCCCC),
                                          fontSize: size.width * 24)),
                                  index > allReady
                                      ? Container(height: size.width * 60)
                                      : index <= allReady
                                          ? Center(
                                              child: Image.network(
                                                  approvalProgress[index]
                                                          ["sign"]
                                                      .toString(),
                                                  height: size.width * 60))
                                          : Container(
                                              height: size.width * 60,
                                              alignment: Alignment.bottomCenter,
                                              child: Text("正在签名",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: themeColor,
                                                      fontSize:
                                                          size.width * 28)),
                                            ),
                                  SizedBox(height: size.width * 10),
                                  Row(
                                    children: [
                                      Text(
                                          approvalProgress[index]["user"]
                                              .toString(),
                                          style: TextStyle(
                                              color: Color(0xffCCCCCC),
                                              fontSize: size.width * 24)),
                                      InkWell(
                                        onTap: () {
                                          launch(
                                              'tel:${approvalProgress[index]["phone"]}');
                                        },
                                        child: Text(
                                          '(${approvalProgress[index]["phone"]})',
                                          style: TextStyle(
                                              color: themeColor,
                                              fontSize: size.width * 24),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: size.width * 10),
                                  index <= allReady
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/sj@2x.png',
                                              height: size.width * 25,
                                              width: size.width * 25,
                                            ),
                                            SizedBox(
                                              width: size.width * 10,
                                            ),
                                            Text(
                                              approvalProgress[index]
                                                      ["agreeTime"] ??
                                                  '',
                                              style: TextStyle(
                                                  color: Color(0xff999999),
                                                  fontSize: size.width * 24),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  index < allReady
                                      ? SizedBox(height: size.width * 10)
                                      : Container(),
                                ],
                              ))
                            ])))),
        onWillPop: () async {
          if (page > 0) {
            page--;
            setState(() {});
            return false;
          }
          return true;
        });
  }
}

class SafeListItem extends StatefulWidget {
  SafeListItem(
      {this.dataMap,
      this.getData,
      this.bookId,
      this.change,
      this.operable,
      this.length});
  final Map dataMap;
  final Function getData;
  final Function(int, List) change;
  final int bookId, length;
  final bool operable;
  @override
  _SafeListItemState createState() => _SafeListItemState();
}

class _SafeListItemState extends State<SafeListItem> {
  List<String> name = ['前', '中', '后', '结束', '等待审批'];
  Counter _counter = Provider.of<Counter>(myContext);
  List measure = [
    {
      "title": '管控',
      'show': true,
      "color": themeColor,
      "func": (context, widget) {
        Navigator.pushNamed(context, '/home/work/workControlList', arguments: {
          "bookId": widget.bookId,
          "callback": (String buttonName) {},
          "id": widget.dataMap['id'],
          "plannedSpeed": widget.dataMap['plannedSpeed']
        }).then((value) {
          widget.getData();
        });
      }
    },
  ];

  @override
  void didUpdateWidget(covariant SafeListItem oldWidget) {
    _initData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    if (widget.dataMap['plannedSpeed'] == 4) {
      measure.forEach((element) {
        element['show'] = false;
      });
    }
  }

  _getImage(String workName) {
    switch (workName) {
      case '动火作业':
        return 'assets/images/icon_fire_check.png';
        break;
      case '临时用电':
        return 'assets/images/icon_electric_check.png';
        break;
      case '吊装作业':
        return 'assets/images/icon_hoisting_check.png';
        break;
      case '高处作业':
        return 'assets/images/icon_height_check.png';
        break;
      case '受限空间':
        return 'assets/images/icon_limitation_check.png';
        break;
      case '盲板抽堵':
        return 'assets/images/icon_blind_plate_wall_check.png';
        break;
      case '动土作业':
        return 'assets/images/icon_soil_check.png';
        break;
      case '断路作业':
        return 'assets/images/icon_turnoff_check.png';
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPressStart: (details) {
          if (!widget.operable) return;
          if (widget.length < 2) {
            InterruptWork.detailInterrup(
                details, context, widget.dataMap['id'], widget.getData,
                type: InterruptWorkType.onlyChange);
            return;
          }
          InterruptWork.detailInterrup(
            details,
            context,
            widget.dataMap['id'],
            widget.getData,
          );
        },
        child: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 1.0)
              ],
              gradient: LinearGradient(
                  colors: changePross(widget.dataMap['safetyMeasuresAll'],
                      widget.dataMap['safetyMeasuresCarryOutNum']),
                  tileMode: TileMode.clamp),
            ),
            child: Padding(
                padding: EdgeInsets.all(size.width * 20),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 10, 15),
                      child: Image(
                        width: size.width * 75,
                        height: size.width * 86,
                        image: AssetImage(_getImage(widget.dataMap['name'])),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        widget.dataMap["plannedSpeed"] == 5
                            ? Text('等待行政人员审批',
                                style: TextStyle(
                                    color: Color(0xff6EA0FE),
                                    fontSize: size.width * 24))
                            : Row(
                                children: <Widget>[
                                  Text(
                                    '作业${name[widget.dataMap["plannedSpeed"] - 1]}危害识别：',
                                    style: TextStyle(
                                        color: Color(0xff6EA0FE),
                                        fontSize: size.width * 24),
                                  ),
                                  Text(
                                    '${widget.dataMap["hazardNum"]} 条',
                                    style: TextStyle(
                                        color: Color(0xffff5555),
                                        fontSize: size.width * 24),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: size.width * 10,
                        ),
                        widget.dataMap["plannedSpeed"] == 5
                            ? Container()
                            : Row(
                                children: <Widget>[
                                  Text(
                                    '作业${name[widget.dataMap["plannedSpeed"] - 1]}安全措施：',
                                    style: TextStyle(
                                        color: Color(0xff6EA0FE),
                                        fontSize: size.width * 24),
                                  ),
                                  Text(
                                    '${widget.dataMap["safetyMeasuresAll"]} 条',
                                    style: TextStyle(
                                        color: Color(0xff09ba07),
                                        fontSize: size.width * 24),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: size.width * 10,
                        ),
                        Row(children: <Widget>[
                          Text(
                            '已完成安全措施：',
                            style: TextStyle(
                                color: Color(0xff6EA0FE),
                                fontSize: size.width * 24),
                          ),
                          Text(
                              '${widget.dataMap["safetyMeasuresCarryOutNum"]} 条',
                              style: TextStyle(
                                  color: Color(0xff09ba07),
                                  fontSize: size.width * 24))
                        ])
                      ],
                    ),
                    SizedBox(
                      width: size.width * 20,
                    ),
                    widget.dataMap["plannedSpeed"] == 5
                        ? Expanded(
                            child: InkWell(
                                onTap: () {
                                  widget.dataMap['isApprovalProgress'] == 1
                                      ? myDio
                                          .request(
                                              type: 'put',
                                              url: Interface.operateWorkByid +
                                                  widget.dataMap['id']
                                                      .toString())
                                          .then((value) {
                                          widget.getData();
                                        })
                                      : myDio.request(
                                          type: 'get',
                                          url: Interface.getApprovalNode,
                                          queryParameters: {
                                              "id": widget.dataMap['id']
                                            }).then((value) {
                                          if (value is List) {
                                            widget.change(1, value);
                                          }
                                        });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: size.width * 5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: themeColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Text(
                                    widget.dataMap['isApprovalProgress'] == 1
                                        ? '开始作业'
                                        : '审批中',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 20),
                                  ),
                                )))
                        : Expanded(
                            child: Column(
                                children: measure
                                    .map<Widget>((ele) => ele['show']
                                        ? Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _counter.emptySubmitDates(
                                                      key: "清单作业");
                                                  ele['func'](context, widget);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.width * 5),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.width * 10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: ele['color'],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                  ),
                                                  child: Text(
                                                    ele['title'].toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 20),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                '作业${name[widget.dataMap["plannedSpeed"] - 1]}',
                                                style: TextStyle(
                                                    color: Color(0xff6D9FFD),
                                                    fontSize: size.width * 24),
                                              )
                                            ],
                                          )
                                        : Container())
                                    .toList()),
                          ),
                  ],
                ))));
  }
}

class MyListIcon extends StatefulWidget {
  MyListIcon({this.callback});
  final Function callback;
  @override
  _MyListIconState createState() => _MyListIconState();
}

class _MyListIconState extends State<MyListIcon> {
  double right = 50;
  double top = 300;
  int ischecked = 0;
  List data = [];
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    myDio.request(type: 'get', url: Interface.getWorkType).then((value) {
      if (value is List) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return Positioned(
      right: right,
      top: top,
      child: GestureDetector(
        key: _key,
        onPanUpdate: (details) {
          setState(() {
            right -= details.delta.dx;
            top += details.delta.dy;
          });
        },
        onTap: () {
          RenderBox box = _key.currentContext.findRenderObject();
          Offset offset = box.localToGlobal(Offset.zero);
          Size buttonSize = box.size;
          Size sizes = Size(offset.dx, offset.dy);
          showMenu(
              context: context,
              position: RelativeRect.fromSize(
                  Rect.fromLTRB(
                      offset.dx - buttonSize.width * 2, offset.dy, 0, 0),
                  sizes),
              items: data
                  .map<PopupMenuEntry>(
                    (ele) => PopupMenuItem(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          widget.callback(type: 'add', mapData: ele);
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            ele['name'],
                            style: TextStyle(
                                color: Color(0xff343434),
                                fontSize: size.width * 24),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList());
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff1B39E9),
                    Color(0xff3173FF),
                  ]),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff3173FF).withOpacity(.3),
                    offset: Offset(-2, 1),
                    blurRadius: 3.0,
                    spreadRadius: 3.0),
                BoxShadow(
                    color: Color(0xff3173FF).withOpacity(.3),
                    offset: Offset(-5, 2),
                    blurRadius: 3.0,
                    spreadRadius: 3.0),
              ]),
          child: Icon(
            Icons.add,
            size: width * 60,
            color: Colors.white,
          ),
          width: width * 80,
          height: width * 80,
        ),
      ),
    );
  }
}
