import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/work/work_dilog/interruptWork.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:provider/provider.dart';

class WorkList extends StatefulWidget {
  WorkList({this.arguments});
  final arguments;
  @override
  _WorkListState createState() => _WorkListState();
}

class _WorkListState extends State<WorkList> {
  List dropList = [
    {
      'title': '相关作业',
      'data': [
        // 1 与我相关
        {'name': '所有作业'},
        {'name': '相关作业'},
        {'name': '气体检测'}
      ],
      'value': '',
      "saveTitle": '相关作业',
      // 'dataUrl': Interface.dropTerritorialUnitList
      'limit': 'type'
    },
    {
      'title': '属地单位',
      'data': [],
      'value': '',
      "saveTitle": '属地单位',
      'dataUrl': Interface.dropTerritorialUnitList,
      'limit': 'territorialUnit'
    },
  ];
  int currenPage = 1;
  List data = [];
  ThrowFunc throwFunc = ThrowFunc();
  _getDropList() {
    for (var i = 0; i < dropList.length; i++) {
      if (dropList[i]['dataUrl'] != null) {
        myDio.request(type: 'get', url: dropList[i]['dataUrl']).then((value) {
          dropList[i]['data'] = value;
          dropList[i]['data'].insert(0, {"name": "查看全部"});
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getData(init: true);

    _getDropList();
  }

  String choosedTitle = '';
  // {"size": 30, "type": 1}
  Map queryParameters = {"type": 1};

  List inspectionList = [];

  Future _getData({bool init = false}) async {
    queryParameters["current"] = currenPage.toString();
    if (widget.arguments != null) {
      queryParameters['type'] = null;
      queryParameters['userId'] = widget.arguments['userId'] == null
          ? null
          : widget.arguments['userId'].toString();
      queryParameters['workFlow'] = widget.arguments['workFlow'] == null
          ? null
          : widget.arguments['workFlow'].toString();
      queryParameters['region'] = widget.arguments['name'];
    } else {}
  }

  _changeDrop() {
    for (var i = 1; i < dropList.length; i++) {
      if (dropList[i]['title'] != dropList[i]['saveTitle']) {
        queryParameters[dropList[i]['limit'].toString()] = dropList[i]['title'];
      } else {
        queryParameters[dropList[i]['limit']] = null;
      }
    }
    if (dropList[0]['title'] == '相关作业') {
      queryParameters['type'] = "1";
    } else if (dropList[0]['title'] == '所有作业') {
      queryParameters['type'] = "0";
    } else {
      queryParameters['type'] = "3";
    }
    choosedTitle = dropList[0]['title'];
    throwFunc.run(argument: queryParameters);
  }

  List leftbar = [
    // {
    //   'icon': 'assets/images/workList/workApply1@2x.png',
    //   'name': '计划审批',
    //   'icon2': 'assets/images/workList/workApply2@2x.png'
    // },
    {
      'icon': 'assets/images/workList/workIdentify1@2x.png',
      'name': '风险辨识',
      'icon2': 'assets/images/workList/workIdentify2@2x.png',
      'flow': 3,
    },
    // {
    //   'icon': 'assets/images/workList/workIdentify1@2x.png',
    //   'name': '辨识审批',
    //   'icon2': 'assets/images/workList/workIdentify2@2x.png'
    // },
    {
      'icon': 'assets/images/workList/workSafe1@2x.png',
      'name': '安全交底',
      'icon2': 'assets/images/workList/workSafe2@2x.png',
      'flow': 5,
    },
    // {
    //   'icon': 'assets/images/workList/workBottom1@2x.png',
    //   'name': '交底审批',
    //   'icon2': 'assets/images/workList/workBottom2@2x.png'
    // },
    {
      'icon': 'assets/images/workList/workList1@2x.png',
      'name': '作业清单',
      'icon2': 'assets/images/workList/workList2@2x.png',
      'flow': 7,
    },
    {
      'icon': 'assets/images/workList/workClose1@2x.png',
      'name': '关闭',
      'icon2': 'assets/images/workList/workClose2@2x.png',
      'flow': 8,
    },
  ];
  int choose = -1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 侧边栏
        Container(
          width: size.width * 130,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemExtent: size.width * 140,
                    physics: ClampingScrollPhysics(),
                    itemCount: leftbar.length,
                    padding: EdgeInsets.only(top: size.width * 20),
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            if (choose == index) {
                              queryParameters['flow'] = null;
                              setState(() {
                                choose = -1;
                              });
                            } else {
                              queryParameters['flow'] = leftbar[index]['flow'];
                              setState(() {
                                choose = index;
                              });
                            }
                            throwFunc.run();
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: size.width * 20),
                            decoration: BoxDecoration(
                                color: choose == index ? Colors.white : null),
                            child: Column(
                              children: [
                                Container(
                                  width: size.width * 60,
                                  height: size.width * 60,
                                  // padding: EdgeInsets.all(size.width * 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: choose == index
                                          ? LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                  Color(0XFF56E0FF),
                                                  Color(0XFF2182FF),
                                                ])
                                          : LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                  Colors.white,
                                                  Colors.white,
                                                ])),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    choose == index
                                        ? leftbar[index]['icon']
                                        : leftbar[index]['icon2'],
                                    width: size.width * 40,
                                    height: size.width * 40,
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * 10,
                                ),
                                Text(
                                  leftbar[index]['name'],
                                  style: TextStyle(
                                      color: Color(0xff999999),
                                      fontSize: size.width * 26,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
              ),
              Contexts.mobile
                  ? MyPosiIcon(
                      getData: _getData,
                      throwFunc: throwFunc,
                    )
                  : Container(),
              SizedBox(
                height: size.width * 30,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              // 下拉选
              widget.arguments == null
                  ? TitleChoose(dropList, 0, _changeDrop)
                  : Container(),
              // 作业列表
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: MyRefres(
                    child: (index, list) {
                      return DetailsList(
                        choosedTitle: choosedTitle,
                        type: queryParameters['type'].toString(),
                        dataMap: list[index],
                        throwFunc: throwFunc,
                      );
                    },
                    url: Interface.workListUrl,
                    queryParameters: queryParameters,
                    method: 'get',
                    page: true,
                    listParam: 'records',
                    throwFunc: throwFunc,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TitleChoose extends StatefulWidget {
  TitleChoose(this.list, this.index, this.getDataList);
  final int index;
  final List list;
  final Function getDataList;
  @override
  _TitleChooseState createState() => _TitleChooseState();
}

class _TitleChooseState extends State<TitleChoose> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.list.asMap().keys.map((i) {
      return Expanded(
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Color _juegeColor(Map _ele) {
                  Color _color =
                      widget.list[i]['value'] == '' && _ele['name'] == '查看全部'
                          ? themeColor
                          : widget.list[i]['value'] == _ele['name']
                              ? themeColor
                              : Colors.white;
                  return _color;
                }

                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return SingleChildScrollView(
                        child: Wrap(
                          children: widget.list[i]['data'].map<Widget>((_ele) {
                            Color _conColors = _juegeColor(_ele);
                            return GestureDetector(
                              onTap: () {
                                widget.list[i]['value'] = _ele['name'];
                                if (_ele['name'] == '查看全部') {
                                  widget.list[i]['title'] =
                                      widget.list[i]['saveTitle'];
                                } else {
                                  widget.list[i]['title'] = _ele['name'];
                                }
                                if (mounted) {
                                  setState(() {});
                                }
                                widget.getDataList();
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.width * 20),
                                decoration: BoxDecoration(
                                    color: _conColors,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: underColor))),
                                child: Center(
                                  child: Text(
                                    _ele['name'],
                                    style: TextStyle(
                                        fontSize: size.width * 30,
                                        color: _conColors.toString() ==
                                                'Color(0xff2674fd)'
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    });
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                            width: 1, color: underColor.withOpacity(.2)),
                        right: BorderSide(
                            width: 1, color: underColor.withOpacity(.2)),
                      )),
                  padding: EdgeInsets.symmetric(vertical: size.width * 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.list[i]['title'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: size.width * 30,
                                color: Color(0xff646464),
                                fontWeight: FontWeight.bold)),
                        Icon(Icons.arrow_drop_down, color: Color(0xff646464))
                      ]))));
    }).toList());
  }
}

class DetailsList extends StatefulWidget {
  DetailsList(
      {@required this.dataMap, this.throwFunc, this.type, this.choosedTitle});
  final Map dataMap;
  final String type;
  final ThrowFunc throwFunc;
  final String choosedTitle;
  @override
  _DetailsListState createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  final List imageList = [
    {
      "arrive": 'assets/images/ico_plan_checked.png',
      "unArrive": 'assets/images/ico_plan_unchecked.png'
    },
    {
      "arrive": 'assets/images/ico_identification_checked.png',
      "unArrive": 'assets/images/ico_identification_unchecked.png'
    },
    {
      "arrive": 'assets/images/ico_apply_checked.png',
      "unArrive": 'assets/images/ico_apply_unchecked.png'
    },
    {
      "arrive": 'assets/images/ico_list_checked.png',
      "unArrive": 'assets/images/ico_list_unchecked.png'
    },
    {
      "arrive": 'assets/images/ico_close_checked.png',
      "unArrive": 'assets/images/ico_close_unchecked.png'
    },
  ];

  final List<String> buttonName = [
    '作业计划',
    '计划审批',
    '风险辨识',
    '风险辨识审批',
    '安全交底',
    '申请审批',
    '清单',
    '关闭'
  ];

  _jumpPage(Counter _context, {bool operable = true}) {
    _context.emptySubmitDates();
    Navigator.pushNamed(context, '/home/work/WorkTicker', arguments: {
      "circuit": widget.dataMap['executionFlow'] == 8
          ? widget.dataMap['executionFlow'] + 1
          : widget.dataMap['executionFlow'],
      "id": widget.dataMap['id'],
      "operable": operable,
      "bookId": widget.dataMap['bookId'],
      "executionMemo": widget.dataMap['executionMemo'],
      "outSide": true,
      "userId": widget.dataMap['applicantUserId'],
      "type": widget.type,
      "parentId": widget.dataMap['parentId'],
      // down for reEewTicket
      "parentReceiptWorkTypeAll":
          widget.dataMap['parentReceiptWorkTypeAll'] ?? [],
      "parentReceiptInformation": widget.dataMap['parentReceiptInformation']
    }).then((value) {
      // back refresh list
      widget.throwFunc?.run();
    });
  }

  Widget _geneWidget(String name, String value) {
    return Row(
      children: <Widget>[
        Text(
          '$name：',
          style: TextStyle(fontSize: size.width * 24, color: Color(0xff666666)),
        ),
        Text(
          value,
          style: TextStyle(fontSize: size.width * 24, color: Color(0xff666666)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Counter _context = Provider.of<Counter>(context);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 20, vertical: size.width * 10),
      child: GestureDetector(
        onLongPressStart: (details) {
          if (widget.choosedTitle == '气体检测') if (widget.dataMap['operable'] !=
              1) return;
          InterruptWork.detailInterrup(
              details, context, widget.dataMap['bookId'], widget.throwFunc?.run,
              type: widget.dataMap['executionFlow'] == 7
                  ? InterruptWorkType.add
                  : InterruptWorkType.terminationBig);
        },
        onTap: () {
          widget.dataMap['operable'] == 1
              ? _jumpPage(_context)
              : _jumpPage(_context, operable: false);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 5.0),
            ],
          ),
          padding: EdgeInsets.all(size.width * 10),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: size.width * 10,
                          ),
                          _geneWidget('作业名称', widget.dataMap['workName'] ?? ''),
                          SizedBox(
                            height: size.width * 5,
                          ),
                          _geneWidget('作业区域', widget.dataMap['region'] ?? ''),
                          SizedBox(height: size.width * 5),
                          _geneWidget(
                              '属地单位', widget.dataMap['territorialUnit'] ?? ''),
                          SizedBox(height: size.width * 5),
                          _geneWidget('计划时间', widget.dataMap['planDate'] ?? ''),
                        ]),
                    Spacer(),
                    Column(
                      children: [
                        widget.dataMap['parentId'] != 0
                            ? Container(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    widget.dataMap['parentReceiptInformation']
                                            .isNotEmpty
                                        ? '续'
                                        : '增',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container(),
                        widget.dataMap['operable'] == 1
                            ? InkWell(
                                onTap: () {
                                  _jumpPage(_context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 30,
                                      vertical: size.width * 10),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(stops: [
                                        0.0,
                                        1.0
                                      ], colors: [
                                        Color(0xff2F6BFF),
                                        Color(0xff7572FD)
                                      ]),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    widget.type == '3'
                                        ? '气体检测'
                                        : buttonName[widget
                                                    .dataMap['executionFlow'] -
                                                1]
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    )
                  ]),
              SizedBox(height: size.width * 20),
            ],
          ),
        ),
      ),
    );
  }
}

// 作业新建加号icon
class MyPosiIcon extends StatefulWidget {
  MyPosiIcon({this.getData, this.throwFunc});
  final Function getData;
  final ThrowFunc throwFunc;
  @override
  _MyPosiIconState createState() => _MyPosiIconState();
}

class _MyPosiIconState extends State<MyPosiIcon> {
  GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // Size currenWindow = MediaQuery.of(context).size;
    return GestureDetector(
      key: _key,
      onPanUpdate: (details) {
        // safeArea
        // if (30 > details.globalPosition.dx ||
        //     currenWindow.width - 10 < details.globalPosition.dx) return;
        // if (100 > details.globalPosition.dy ||
        //     currenWindow.height - 50 < details.globalPosition.dy) return;
        // setState(() {
        //   left = details.globalPosition.dx - 30;
        //   top = details.globalPosition.dy - 80;
        // });
      },
      onTap: () {
        context.read<Counter>().emptySubmitDates();
        Navigator.pushNamed(context, '/home/work/WorkTicker', arguments: {
          'circuit': 1,
          "operable": true,
          "executionMemo": '',
          "outSide": true
        }).then((value) {
          Future.delayed(Duration(seconds: 2), () {
            widget.throwFunc?.run();
          });
        });
        // RenderBox box = _key.currentContext.findRenderObject();
        // Offset offset = box.localToGlobal(Offset.zero);
        // Size buttonSize = box.size;
        // Size sizes = Size(offset.dx, offset.dy);

        // showMenu(
        //     context: context,
        //     position: RelativeRect.fromSize(
        //         Rect.fromLTRB(
        //             offset.dx - buttonSize.width * 2, offset.dy, 0, 0),
        //         sizes),
        //     items: <PopupMenuEntry<dynamic>>[
        //       PopupMenuItem(
        //           child: GestureDetector(
        //         child: Center(
        //           child: Row(
        //             children: <Widget>[
        //               Icon(
        //                 Icons.event_note,
        //                 color: Color.fromRGBO(101, 109, 146, 1),
        //                 size: size.width * 40,
        //               ),
        //               Text(
        //                 '计划',
        //                 style: TextStyle(
        //                   color: Color.fromRGBO(101, 109, 146, 1),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //         onTap: () {
        //           _context.emptySubmitDates();
        //           Navigator.pop(context);
        //           Future.delayed(Duration(milliseconds: 300), () {
        //             Navigator.pushNamed(context, '/home/work/WorkTicker',
        //                 arguments: {
        //                   'circuit': 1,
        //                   "operable": true,
        //                   "executionMemo": ''
        //                 }).then((value) {
        //               if (_context.refreshStates['state']) {
        //                 Future.delayed(Duration(seconds: 1), widget.getData);
        //                 if (_context.refreshStates['callback'] != null) {
        //                   _context.refreshStates['callback']();
        //                 }
        //                 _context.changeRefreshState(
        //                     state: false, callback: null);
        //               }
        //             });
        //           });
        //         },
        //       )),
        //       PopupMenuItem(
        //           child: GestureDetector(
        //         child: Center(
        //             child: Row(
        //           children: <Widget>[
        //             Icon(
        //               Icons.event_busy,
        //               color: Color.fromRGBO(101, 109, 146, 1),
        //               size: size.width * 40,
        //             ),
        //             Text(
        //               '计划外',
        //               style: TextStyle(
        //                 color: Color.fromRGBO(101, 109, 146, 1),
        //               ),
        //             )
        //           ],
        //         )),
        //         onTap: () {
        //           _context.emptySubmitDates();
        //           Navigator.pop(context);
        //           Future.delayed(Duration(milliseconds: 300), () {
        //             Navigator.pushNamed(context, '/home/work/plan',
        //                 arguments: {"title": "作业申请"});
        //           });
        //         },
        //       )),

        // ]);
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
                color: Color(0xff1C3AEA),
                offset: Offset(0, 0),
                blurRadius: 10.0,
              ),
            ]),
        child: Icon(
          Icons.add,
          size: size.width * 60,
          color: Colors.white,
        ),
        width: size.width * 80,
        height: size.width * 80,
      ),
    );
  }
}
