import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  History({this.arguments});
  final arguments;
  // id prve pages id
  // type 作业详情 => detail
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int workTypeId;
  GlobalKey<_WorkHistoryRightBarState> _globalKey = GlobalKey();

  _changeType(dynamic data) {
    if (_globalKey.currentState.queryParameters == null) {
      _globalKey.currentState.queryParameters = {'workTypeId': data};
    } else {
      _globalKey.currentState.queryParameters['workTypeId'] = data;
    }

    _globalKey.currentState._changeState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        backgroundColor: Color(0xffF0F0F5),
        title: Text('作业台账'),
        child: Row(
          children: [
            WorkHistroyLeftBar(callback: _changeType),
            Expanded(
              child: WorkHistoryRightBar(
                key: _globalKey,
              ),
            )
          ],
        ));
  }
}

class WorkHistoryRightBar extends StatefulWidget {
  const WorkHistoryRightBar({
    Key key,
  }) : super(key: key);
  @override
  _WorkHistoryRightBarState createState() => _WorkHistoryRightBarState();
}

class _WorkHistoryRightBarState extends State<WorkHistoryRightBar> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  // MethodChannel _channel = MethodChannel('nativeView');
  // final _globalKey = GlobalKey();
  Map queryParameters;
  List chooseData = [
    {'title': 'startDate', 'value': ''},
    {'title': 'endDate', 'value': ''},
    {'title': 'territorialUnit', 'value': '', 'data': []},
    {'title': 'region', 'value': '', 'data': []},
  ];
  _init() async {
    myDio
        .request(
      type: 'get',
      url: Interface.dropTerritorialUnitList,
    )
        .then((value) {
      if (value is List) {
        chooseData[2]['data'] = value;
        chooseData[2]['data'].insert(0, {"name": '查看全部'});
        if (mounted) {
          setState(() {});
        }
      }
    });

    myDio.request(type: 'get', url: Interface.areaUrl).then((value) {
      if (value is List) {
        chooseData[3]['data'] = value;
        chooseData[3]['data'].insert(0, {"name": '查看全部'});
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  bool show = true;
  ThrowFunc throwFunc = ThrowFunc();
  _changeState() {
    throwFunc.run(argument: queryParameters);
  }

  Widget child(int index, List list) {
    Widget _widget;

    if (!show) return Container();
    if (list.isEmpty) return Text('error');
    if (queryParameters != null && queryParameters['workTypeId'] != null) {
      _widget = WorkGuard(list[index], () {
        String url = webUrl +
            '/work-plan-flow?workId=${list[index]["receiptBookId"]}&token=${myprefs.getString('token')}';
        Navigator.pushNamed(context, '/webview',
            arguments: {'title': '历史台账', 'url': url});
        // _channel.invokeMethod('webView', url);
      });
    } else {
      _widget = WorkItem(list[index], () {
        String url = webUrl +
            '/work-plan-flow?workId=${list[index]["standingBookId"]}&bigFlow=true&token=${myprefs.getString('token')}&data=${DateTime.now().millisecondsSinceEpoch}';
        Navigator.pushNamed(context, '/webview',
            arguments: {'title': '历史台账', 'url': url});
        // _channel.invokeMethod('webView', url);
      });
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(size.width * 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(size.width * 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Colors.black.withOpacity(.1))),
                    child: DateStyle(
                      title: '开始时间',
                      callback: (msg) {
                        if (queryParameters == null) {
                          queryParameters = {'startDate': msg};
                        } else {
                          queryParameters['startDate'] = msg;
                        }

                        // queryParameters['startDate'] = msg;
                      },
                    )),
              ),
              SizedBox(
                width: size.width * 20,
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(size.width * 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Colors.black.withOpacity(.1))),
                    child: DateStyle(
                      title: '结束时间',
                      callback: (msg) {
                        if (queryParameters == null ||
                            queryParameters['startDate'] == null) {
                          Fluttertoast.showToast(msg: '请选择开始时间');
                          return;
                        }

                        if (DateTime.parse(queryParameters['startDate'])
                            .isAfter(DateTime.parse(msg))) {
                          Fluttertoast.showToast(msg: '开始时间不能大于结束时间');
                          return;
                        }

                        queryParameters['endDate'] = msg;
                        _changeState();
                      },
                    )),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(size.width * 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Colors.black.withOpacity(.1))),
                    child: DropChoose(
                      title: '属地单位',
                      data: chooseData[2]['data'],
                      callback: (msg) {
                        if (queryParameters == null) {
                          queryParameters = {'territorialUnit': msg};
                        } else {
                          queryParameters['territorialUnit'] = msg;
                        }
                        _changeState();
                      },
                    )),
              ),
              SizedBox(
                width: size.width * 20,
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(size.width * 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Colors.black.withOpacity(.1))),
                    child: DropChoose(
                      title: '作业区域',
                      data: chooseData[3]['data'],
                      callback: (msg) {
                        // queryParameters['region'] = msg;
                        if (queryParameters == null) {
                          queryParameters = {'region': msg};
                        } else {
                          queryParameters['region'] = msg;
                        }
                        _changeState();
                      },
                    )),
              ),
            ],
          ),
          Expanded(
              child: MyRefres(
            child: child,
            throwFunc: throwFunc,
            url: Interface.getWorkHistory,
            method: 'get',
            listParam: 'records',
            page: true,
            queryParameters: queryParameters,
          ))
        ],
      ),
    );
  }
}

class WorkGuard extends StatelessWidget {
  WorkGuard(this.dataMap, this.callback);
  final Function callback;
  final Map dataMap;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(size.width * 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('风险辨识人:'),
                Expanded(child: Text(dataMap['workRiskIdentify'].toString()))
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '监护人：',
                          style: TextStyle(
                              fontSize: size.width * 24, color: placeHolder)),
                      TextSpan(
                          text: dataMap['guardian'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 25,
                          ))
                    ])),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '涉及特殊作业：',
                          style: TextStyle(
                              fontSize: size.width * 24, color: placeHolder)),
                      TextSpan(
                          text: dataMap['involvingWork'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 25,
                          ))
                    ])),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '作业开始时间：',
                          style: TextStyle(
                              fontSize: size.width * 24, color: placeHolder)),
                      TextSpan(
                          text: dataMap['startDate'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 25,
                          ))
                    ])),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '作业结束时间：',
                          style: TextStyle(
                              fontSize: size.width * 24, color: placeHolder)),
                      TextSpan(
                          text: dataMap['endDate'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 25,
                          ))
                    ])),
                  ],
                )),
                SizedBox(
                  width: size.width * 20,
                ),
                InkWell(
                  onTap: callback,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 30, vertical: size.width * 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: themeColor),
                    child: Text(
                      '查看',
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 24),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WorkItem extends StatelessWidget {
  WorkItem(this.dataMap, this.callback);
  final Function callback;
  final Map dataMap;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(size.width * 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('作业名称:'),
                Expanded(child: Text(dataMap['workName'].toString()))
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '属地单位：',
                          style: TextStyle(
                              fontSize: size.width * 24, color: placeHolder)),
                      TextSpan(
                          text: dataMap['territorialUnit'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 25,
                          ))
                    ])),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '作业区域：',
                          style: TextStyle(
                              fontSize: size.width * 24, color: placeHolder)),
                      TextSpan(
                          text: dataMap['region'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 25,
                          ))
                    ])),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '作业内容：',
                          style: TextStyle(
                              fontSize: size.width * 24, color: placeHolder)),
                      TextSpan(
                          text: dataMap['description'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 25,
                          ))
                    ])),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '作业结束时间：',
                          style: TextStyle(
                              fontSize: size.width * 24, color: placeHolder)),
                      TextSpan(
                          text: dataMap['endDate'].toString(),
                          style: TextStyle(
                            fontSize: size.width * 25,
                          ))
                    ])),
                  ],
                )),
                SizedBox(
                  width: size.width * 20,
                ),
                InkWell(
                    onTap: callback,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 30,
                          vertical: size.width * 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: themeColor),
                      child: Text(
                        '查看',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 24),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DropChoose extends StatefulWidget {
  DropChoose({this.title = '', this.data, @required this.callback});
  final String title;
  final List data;
  final WillPopScopeCallBackFunc callback;
  @override
  _DropChooseState createState() => _DropChooseState();
}

class _DropChooseState extends State<DropChoose> {
  String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            RenderBox box = context.findRenderObject();
            Offset currenBoxSize = box.localToGlobal(Offset.zero);
            showDialog(
                context: context,
                builder: (_) => Stack(
                      children: [
                        Positioned(
                          left: currenBoxSize.dx - size.width * 10,
                          top: currenBoxSize.dy + size.width * 10,
                          child: CustomPaint(
                            painter: DropChoosePaint(),
                            child: Container(
                              width: box.size.width + size.width * 20,
                              height: size.width * 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff3073FE).withOpacity(.2),
                                      offset: Offset(1, 1),
                                      spreadRadius: 4,
                                      blurRadius: 1),
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: widget.data
                                      .map(
                                        (ele) => GestureDetector(
                                          dragStartBehavior:
                                              DragStartBehavior.down,
                                          onTap: () {
                                            if (ele['name'] == '查看全部') {
                                              title = null;
                                            } else {
                                              title = ele['name'];
                                            }
                                            Navigator.pop(context);
                                            widget.callback(title);
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            width: box.size.width +
                                                size.width * 20,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 10,
                                                vertical: size.width * 20),
                                            decoration: BoxDecoration(
                                                color: title == ele['name']
                                                    ? Color(0xff3073FE)
                                                        .withOpacity(.2)
                                                    : null,
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: underColor,
                                                        width: 1))),
                                            child: Text(
                                              ele['name'].toString(),
                                              style: TextStyle(
                                                  color: title == ele['name']
                                                      ? themeColor
                                                      : placeHolder,
                                                  fontWeight: FontWeight.normal,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: size.width * 26),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ?? widget.title),
              Icon(
                Icons.keyboard_arrow_down,
                color: placeHolder,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DropChoosePaint extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;
  @override
  void paint(Canvas canvas, Size sizes) {
    Path _path = Path();
    _path.moveTo(sizes.width / 2 - 5, 0);
    _path.lineTo(sizes.width / 2, -10);
    _path.lineTo(sizes.width / 2 + 5, 0);

    canvas.drawPath(_path, _paint);
    // canvas.drawShadow(_path, Color(0xff3073FE).withOpacity(.2), 1, true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class WorkHistroyLeftBar extends StatefulWidget {
  final Function callback;
  const WorkHistroyLeftBar({Key key, this.callback}) : super(key: key);
  @override
  _WorkHistroyLeftBarState createState() => _WorkHistroyLeftBarState();
}

class _WorkHistroyLeftBarState extends State<WorkHistroyLeftBar> {
  List leftData = [];
  @override
  void initState() {
    super.initState();
    _init();
  }

  List<Map> leftImage = [
    {"name": '动土', 'image': 'assets/images/workHistory/land@2x.png'},
    {"name": '动火', 'image': 'assets/images/workHistory/fire@2x.png'},
    {"name": '受限', 'image': 'assets/images/workHistory/limit@2x.png'},
    {"name": '高处', 'image': 'assets/images/workHistory/height@2x.png'},
    {"name": '吊装', 'image': 'assets/images/workHistory/hositing@2x.png'},
    {"name": '临时', 'image': 'assets/images/workHistory/eletric@2x.png'},
    {"name": '断路', 'image': 'assets/images/workHistory/broken@2x.png'},
    {"name": '盲板', 'image': 'assets/images/workHistory/blind@2x.png'},
  ];
  int indexPage = -1;

  _init() {
    myDio.request(type: 'get', url: Interface.getWorkType).then((value) {
      if (value is List) {
        setState(() {
          leftData = value;
        });
      }
    });
  }

  Widget _generate(String name) {
    Widget _widget = Container();
    for (var i = 0; i < leftImage.length; i++) {
      if (leftImage[i]['name'] == name) {
        _widget = Image.asset(
          leftImage[i]['image'],
          width: size.width * 57,
          height: size.width * 65,
        );
        break;
      }
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.width * 40),
      width: size.width * 90,
      color: Color(0xffEAEDF2),
      child: ListView.builder(
          itemCount: leftData.length,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  if (index == indexPage) {
                    indexPage = -1;
                  } else {
                    indexPage = index;
                  }
                  widget.callback(
                      indexPage > -1 ? leftData[indexPage]['id'] : null);
                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Container(
                  color: indexPage == index ? Colors.white : Colors.transparent,
                  // margin: EdgeInsets.only(top: size.width * 20),
                  padding: EdgeInsets.symmetric(vertical: size.width * 10),
                  child: Column(
                    children: [
                      _generate(
                          leftData[index]['name'].toString().substring(0, 2)),
                      Text(
                        leftData[index]['name'].toString().substring(0, 2),
                        style: TextStyle(
                            fontSize: size.width * 26, color: placeHolder),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}

class DateStyle extends StatefulWidget {
  DateStyle({this.title, this.callback, this.upDate = true});
  final String title;
  final WillPopScopeCallBackFunc callback;
  final bool upDate;
  @override
  _DateStyleState createState() => _DateStyleState();
}

class _DateStyleState extends State<DateStyle> {
  @override
  void didUpdateWidget(covariant DateStyle oldWidget) {
    if (widget.upDate) {
      _change();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _generateDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now().toLocal(),
            firstDate: DateTime(DateTime.now().toLocal().year - 10),
            lastDate: DateTime(DateTime.now().toLocal().year + 10))
        .then((value) {
      if (value != null) {
        if (value.day < 10) {
          day = '0' + value.day.toString();
        } else {
          day = value.day.toString();
        }
        date = value.year.toString() + '-' + value.month.toString();
        if (mounted) {
          setState(() {});
        }
        if (widget.callback != null) {
          widget.callback(value.toString().split(' ')[0]);
        }
      }
    });
  }

  Counter _counter = Provider.of(myContext);
  String date;
  String day;

  _change() {
    if (_counter.dateStyle == true) {
      date = null;
      day = null;
      if (mounted) {
        setState(() {});
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _counter.changeDateStyle(true);
      });
    }
  }

  int x = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _generateDate,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          date != null
              ? Text(date)
              : Text(
                  widget.title ?? '请选择时间',
                  style: TextStyle(color: placeHolder),
                ),
          CustomPaint(
            painter: MyDateCostomPath(),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 8, vertical: size.width * 1),
              decoration: BoxDecoration(
                  border: Border.all(width: 2.5, color: Colors.black),
                  borderRadius: BorderRadius.circular(size.width * 5)),
              child: Text(
                day ?? '01',
                style: TextStyle(color: Color(0xffB6CEFF)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyDateCostomPath extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(size.width / 3, -3), Offset(size.width / 3, 3), _paint);
    canvas.drawLine(
        Offset(size.width / 3 * 2, -3), Offset(size.width / 3 * 2, 3), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
