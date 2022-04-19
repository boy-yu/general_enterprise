// import 'dart:convert';
import 'dart:math';

import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class XAxisSturct {
  XAxisSturct({String names, Color color, double otherNum, double nums})
      : names = names ?? '',
        nums = nums ?? 0.0,
        color = color ?? Color(0xff44D360),
        otherNum = otherNum ?? 0.0;

  String names;
  double nums;
  double otherNum;
  Color color;
}

class TogglePicType {
  TogglePicType({this.title = '', this.totalNum = 0, this.data});
  String title;
  int totalNum;
  List<XAxisSturct> data;
}

class TogglePicTypedata {
  TogglePicTypedata({this.totalNum = 0, @required this.data});
  int totalNum;
  List<XAxisSturct> data;
}

class MutipleXAxisSturct {
  MutipleXAxisSturct({String names, List<double> nums, List<Color> color})
      : names = names ?? '',
        color = color ?? [],
        nums = nums ?? [];
  final String names;
  final List<double> nums;
  final List<Color> color;
}

class PieSturct {
  Color color;
  double nums;
  String title;
  PieSturct({this.color, this.nums, this.title});
}

class Pie extends StatefulWidget {
  final double width;
  final List<PieSturct> data;
  final double total, strokeWidth, radius;
  final Widget child;
  final bool state;
  final bool Function() callback;
  const Pie(
      {Key key,
      this.width = 200,
      this.data,
      this.total = 1,
      this.child,
      this.radius,
      this.strokeWidth,
      this.callback,
      this.state = false})
      : super(key: key);
  @override
  _PieState createState() => _PieState();
}

class _PieState extends State<Pie> {
  bool showState = false;

  @override
  void initState() {
    super.initState();
    showState = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.callback != null
            ? () {
                setState(() {
                  showState = widget.callback();
                });
              }
            : null,
        child: SizedBox(
          width: widget.width,
          height: widget.width,
          child: CustomPaint(
            painter: PiePaint(widget.data, widget.total,
                showState: showState,
                radius: widget.radius,
                strokeWidth: widget.strokeWidth),
            child: Center(child: widget.child),
          ),
        ));
  }
}

class PiePaint extends CustomPainter {
  final List<PieSturct> data;
  final double total, strokeWidth, radius;
  final bool showState;
  PiePaint(this.data, this.total,
      {this.strokeWidth = 10, this.radius = 40, @required this.showState});
  Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.red;

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = 0;
    double radian = 0;
    _paint..strokeWidth = strokeWidth;

    data.forEach((element) {
      double sweepAngle = element.nums / total;
      _paint..color = element.color;
      Rect rect = Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius);
      canvas.drawArc(rect, startAngle, 3.14 * 2 * sweepAngle, false, _paint);
      startAngle += 3.14 * 2 * sweepAngle;
      if (showState) {
        double deg = sweepAngle * 360;
        double _currenRadian = radian + deg / 2 * 3.14 / 180;
        radian += deg * 3.14 / 180;
        double paragraphX = radius * cos(_currenRadian);
        double paragraphY = radius * sin(_currenRadian);
        TextSpan textSpan = TextSpan(
          text: ((element.nums / total * 100).toString().length > 3
                  ? (element.nums / total * 100).toString().substring(0, 2)
                  : (element.nums / total * 100).toString()) +
              '%',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
        TextPainter textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: size.width,
        );

        Offset offset = Offset(size.width / 2 + paragraphX - strokeWidth / 3,
            size.height / 2 + paragraphY - strokeWidth / 3);

        textPainter.paint(canvas, offset);
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CustomEchart {
  Widget polyline({@required List<XAxisSturct> xAxis, double height = 200}) {
    double yAxis = 0;
    xAxis.forEach((element) {
      if (element.nums > yAxis) {
        yAxis = element.nums * 2;
      }
    });
    return Polyline(xAxis: xAxis, height: height, yAxis: yAxis);
  }

  Widget horizontal({
    double height = 250,
    @required double yAxis,
    @required List<XAxisSturct> xAxisList,
  }) {
    return HorizontalBar(
      yAxis: yAxis,
      xAxisList: xAxisList,
      height: height,
    );
  }

  Widget bar(
      {height = 250.0,
      width = 30.0,
      double yAxis,
      @required List<XAxisSturct> xAxisList,
      color = themeColor,
      double yWidth = 20.0}) {
    double yAxis = 0.0;

    xAxisList.forEach((element) {
      if (element.nums > yAxis) {
        yAxis = element.nums + 20;
      }
    });

    List yAxisList = [];
    int xNum = (yAxis / 5).ceil().toInt();
    for (var i = 5; i > -1; i--) {
      yAxisList.add(xNum * i);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 20),
              constraints: BoxConstraints(minWidth: width),
              decoration: BoxDecoration(
                  border:
                      Border(right: BorderSide(color: underColor, width: 1))),
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: yAxisList
                    .map((e) => Container(
                          child: Text(e.toString()),
                        ))
                    .toList(),
              )),
          Expanded(
            child: Container(
              height: height,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ClickBar(
                    height: height,
                    yAxisList: yAxisList,
                    xAxisList: xAxisList,
                    color: color,
                    index: index,
                    yWidth: yWidth,
                  );
                },
                itemCount: xAxisList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pie(
      {@required List<PieSturct> data,
      Widget child,
      double strokeWidth = 20,
      double width = 200,
      double radius = 40,
      bool state = false,
      bool Function() callback}) {
    if (data == null) data = [];
    double total = 0;
    data.forEach((element) {
      total += element.nums;
    });
    return Pie(
      data: data,
      width: width,
      total: total,
      child: child,
      radius: radius,
      strokeWidth: strokeWidth,
      callback: callback,
      state: state,
    );
  }

  Widget round(
      {double proportion = 0.0, Widget child, Color bgColor, Color proColor}) {
    return Round(
        proportion: proportion,
        child: child,
        bgColor: bgColor,
        proColor: proColor);
  }

  Widget lineChart({
    double height = 300,
    @required double yAxis,
    @required List<double> xAxisList,
  }) {
    List yAxisList = [];
    double xNum = (yAxis / 5) + 0.01;
    for (var i = 5.0; i > -1; i--) {
      yAxisList.add(double.parse((xNum * i).toStringAsFixed(2)));
    }

    return SafeLineChart(
        yAxisList: yAxisList, xAxisList: xAxisList, height: height);
  }

  Widget mutipleBar(
      {height = 200.0,
      width = 30.0,
      @required double yAxis,
      @required List<MutipleXAxisSturct> xAxisList,
      List<Color> color,
      double yWidth = 20.0}) {
    List yAxisList = [];
    int xNum = (yAxis / 5).ceil().toInt();
    for (var i = 5; i > -1; i--) {
      yAxisList.add(xNum * i);
    }

    return EchartMutipleBar(
        width: width,
        height: height,
        yAxis: yAxis,
        xAxisList: xAxisList,
        color: color,
        yWidth: yWidth,
        yAxisList: yAxisList);
  }

  Widget trendBar(
      {height = 250.0,
      width = 30.0,
      @required List<String> xAixs,
      @required List<TrendBarItemYAxis> yAxis,
      double yWidth = 80.0}) {
    return TrendBar(
      height: height,
      width: width,
      yAxis: yAxis,
      xAixs: xAixs,
      yWidth: yWidth,
    );
  }

  Widget togglePic(
      {@required List<TogglePicType> data,
      String centerChild = '',
      @required Future<TogglePicTypedata> Function(int index) onpress}) {
    return TogglePic(
      data: data,
      callback: onpress,
      centerChild: centerChild,
    );
  }

  Widget progressComp(
      {Key key,
      double width,
      double height,
      Color bgColor,
      Color frColor,
      double borderRaius,
      double value = 1}) {
    return ProgressComp(
      width: width,
      height: height,
      bgColor: bgColor,
      frColor: frColor,
      value: value,
    );
  }

  Widget gantt(List data, int chooseDate) {
    return GanttWidget(data: data, chooseDate: chooseDate);
  }
}

/*
 * 自定义日历甘特图
 */
class GanttWidget extends StatefulWidget {
  GanttWidget({this.data, this.chooseDate});
  final List data;
  final int chooseDate;
  @override
  _GanttWidgetState createState() => _GanttWidgetState();
}

class _GanttWidgetState extends State<GanttWidget> {
  List dateList = [];

  @override
  void initState() {
    super.initState();
    _getDateList();
  }

  @override
  void didUpdateWidget(covariant GanttWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getDateList();
  }

  /*
   *  x 100 ----0       x 400 ----0 2 29
                                  !----0 2 28
         !----0       x 4 ---- 0 2 29
                              !---- 0 2 28  
      1 3 5 7 8 10 12 31
      2 4 6 9 11    30

      2419200000
      28
      2505600000
      29
      2678400000
      31
      2592000000
      30

      86400000
   */
  _getDateList() {
    dateList.clear();
    int dateLength = 0;
    if (DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 2) {
      if (DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).year % 100 ==
          0) {
        if (DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).year % 400 ==
            0) {
          dateLength = 29;
        } else {
          dateLength = 28;
        }
      } else {
        if (DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).year % 4 ==
            0) {
          dateLength = 29;
        } else {
          dateLength = 28;
        }
      }
    } else if (DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month ==
            1 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 3 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 5 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 7 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 8 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 10 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 12) {
      dateLength = 31;
    } else if (DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month ==
            2 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 4 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 6 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 9 ||
        DateTime.fromMillisecondsSinceEpoch(widget.chooseDate).month == 11) {
      dateLength = 30;
    }
    for (int i = 1; i <= dateLength; i++) {
      dateList.add(DateTime.fromMillisecondsSinceEpoch(widget.chooseDate)
              .month
              .toString() +
          "-" +
          i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            // 日期
            Column(
              children: dateList.asMap().keys.map<Widget>((index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 6.2, horizontal: size.width * 10),
                  child: Text(dateList[index].toString()),
                );
              }).toList(),
            ),
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GestureDetector(
                      onTapUp: (clickCoord) {
                        // print((clickCoord.localPosition.dx / (size.width * 100)).truncate());
                        // print(widget.data[(clickCoord.localPosition.dx / (size.width * 100)).truncate()]);
                        Map totalPlan = widget.data[
                            (clickCoord.localPosition.dx / (size.width * 100))
                                .truncate()];
                        WorkDialog.myDialog(context, () {}, 2,
                            widget: Container(
                                height: size.width * 350,
                                padding: EdgeInsets.all(size.width * 20),
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    Text(totalPlan['totalName'].toString()),
                                    SizedBox(
                                      height: size.width * 50,
                                    ),
                                    Row(
                                      children: [
                                        Text(totalPlan['researchName']
                                            .toString()),
                                        Spacer(),
                                        Text(
                                          DateTime.fromMillisecondsSinceEpoch(
                                                      totalPlan['startTime'])
                                                  .toString()
                                                  .substring(0, 11) +
                                              '~ ' +
                                              DateTime.fromMillisecondsSinceEpoch(
                                                      totalPlan['endTime'])
                                                  .toString()
                                                  .substring(0, 11),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: size.width * 30),
                                    Row(
                                      children: [
                                        Text(totalPlan['planName'].toString()),
                                        Spacer(),
                                        Text(
                                          DateTime.fromMillisecondsSinceEpoch(
                                                      totalPlan['startTimeT'])
                                                  .toString()
                                                  .substring(0, 11) +
                                              '~ ' +
                                              DateTime.fromMillisecondsSinceEpoch(
                                                      totalPlan['endTimeT'])
                                                  .toString()
                                                  .substring(0, 11),
                                        )
                                      ],
                                    ),
                                  ],
                                ))));
                      },
                      child: CustomPaint(
                          size: Size(widget.data.length * (size.width * 100),
                              dateList.length * (size.width * 50)),
                          painter: GanttChart(
                              widget.data, dateList, widget.chooseDate)),
                    )))
          ],
        ),
      ),
    );
  }
}

class GanttChart extends CustomPainter {
  GanttChart(this.data, this.dateList, this.chooseDate);
  final List data, dateList;
  final int chooseDate;
  static const double basePadding = 0; //基础边界

  double startX = 0.0, endX = 0.0; //相对于原点x轴方向最小和最大偏移量（相对于原点的偏移量）
  double startY = 0.0, endY = 0.0; //相对于原点y轴方向最大和最小偏移量（相对于原点的偏移量）
  // ignore: unused_field
  double _fixedWidth = 0.0; //x轴方向：最大偏移量-最小偏移量（相对于原点的偏移量）
  // ignore: unused_field
  double _fixedHeight = 0.0; //y轴方向：最大偏移量-最小偏移量（相对于原点的偏移量）
  Paint _paint1 = Paint()
    ..color = Colors.red
    ..strokeWidth = 3;
  Paint _paint2 = Paint()
    ..color = Colors.blue
    ..strokeWidth = 3;
  @override
  void paint(Canvas canvas, Size size) {
    _initBorder(size);
    _drawXy(canvas);
    _drawXRuler(canvas);
    _drawRects(canvas);
  }

  // 初始化边界
  void _initBorder(Size size) {
    startX = basePadding * 2;
    // endX = size.width - basePadding * 2;
    endX = size.width;
    // endX = data.length * size.width * 100 - basePadding * 2;
    startY = size.height - basePadding * 2;
    endY = basePadding * 2;
    // endY = 0;
    _fixedWidth = endX - startX;
    _fixedHeight = startY - endY;
  }

  // 边框
  void _drawXy(Canvas canvas) {
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = size.width * 1
      ..strokeCap = StrokeCap.square
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(startX, endY), Offset(endX, endY), paint);
    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), paint);
    canvas.drawLine(Offset(startX, startY), Offset(endX, startY), paint);
    canvas.drawLine(Offset(endX, endY), Offset(endX, startY), paint);
  }

  // 刻度
  void _drawXRuler(Canvas canvas) {
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = size.width * 1
      ..strokeCap = StrokeCap.square
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    ///x y 刻度数量
    int xRulerCount =
        dateList.length > 0 ? dateList.length - 1 : dateList.length;
    int yRulerCount = data.length > 0 ? data.length - 1 : data.length;

    ///x、y轴方向每个刻度的间距
    double xRulerW = size.width * 100; //x方向两个点之间的距离(刻度长)
    double yRulerH = size.width * 50; //y轴方向亮点之间的距离（刻度高）
    for (int i = 1; i <= xRulerCount; i++) {
      canvas.drawLine(Offset(startX, startY - i * yRulerH),
          Offset(endX, startY - i * yRulerH), paint);
    }
    for (int i = 1; i <= yRulerCount; i++) {
      canvas.drawLine(Offset(startX + xRulerW * i, startY),
          Offset(startX + xRulerW * i, endY), paint);
    }
  }

  // 计划色块
  void _drawRects(Canvas canvas) {
    for (int i = 0; i < data.length; i++) {
      if (DateTime.fromMillisecondsSinceEpoch(chooseDate).month ==
              DateTime.fromMillisecondsSinceEpoch(data[i]['startTime']).month ||
          DateTime.fromMillisecondsSinceEpoch(chooseDate).month ==
              DateTime.fromMillisecondsSinceEpoch(data[i]['endTime']).month) {
        Rect rect = Rect.fromLTRB(
          i * (size.width * 100), // left
          DateTime.fromMillisecondsSinceEpoch(chooseDate).month >
                  DateTime.fromMillisecondsSinceEpoch(data[i]['startTime'])
                      .month
              ? size.width * 1
              : (DateTime.fromMillisecondsSinceEpoch(data[i]['startTime']).day -
                      1) *
                  (size.width * 50), // top
          (i + 1) * (size.width * 100), // right
          DateTime.fromMillisecondsSinceEpoch(chooseDate).month <
                  DateTime.fromMillisecondsSinceEpoch(data[i]['endTime']).month
              ? dateList.length * (size.width * 50)
              : DateTime.fromMillisecondsSinceEpoch(data[i]['endTime']).day *
                  (size.width * 50), // bottom
        );
        canvas.drawRect(rect, i % 2 == 0 ? _paint1 : _paint2);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/*
 * 自定义进度条
 */

class ProgressComp extends StatefulWidget {
  ProgressComp(
      {Key key,
      this.width,
      this.height,
      this.bgColor,
      this.frColor,
      this.borderRaius,
      this.value = 1})
      : super(key: key);
  // 宽度-必填
  final double width;
  // 高度-必填
  final double height;
  // 背景色
  final Color bgColor;
  // 前景色
  final Color frColor;
  // 圆角
  final double borderRaius;
  // 当前比例(当前值/总数值)-必填
  final double value;
  @override
  _ProgressCompState createState() => _ProgressCompState();
}

class _ProgressCompState extends State<ProgressComp>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _double;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _double = Tween(begin: 0.0, end: (widget.value ?? 0))
        .animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant ProgressComp oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _double = Tween(begin: 0.0, end: (widget.value ?? 0))
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width ?? size.width * 120,
        height: widget.height ?? size.width * 12,
        child: Stack(
          children: <Widget>[
            Container(
              width: widget.width ?? size.width * 120,
              height: widget.height ?? size.width * 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(widget.height ?? size.width * 6)),
                  color: widget.bgColor ?? Colors.white),
            ),
            AnimatedBuilder(
                animation: _double,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.height ?? size.width * 6)),
                        color: widget.frColor ?? Colors.white),
                    width: (widget.width ?? size.width * 120) * _double.value,
                  );
                })
          ],
        ));
  }
}

class Coordinate {
  double x;
  double y;
  Coordinate(this.x, this.y);
}

class TogglePic extends StatefulWidget {
  final List<TogglePicType> data;
  final String centerChild;
  final Future<TogglePicTypedata> Function(int index) callback;
  const TogglePic({
    Key key,
    this.data,
    this.callback,
    this.centerChild = '',
  }) : super(key: key);
  @override
  _TogglePicState createState() => _TogglePicState();
}

class _TogglePicState extends State<TogglePic> {
  int choosed = 0;
  List<TogglePicType> data = [];
  bool didData = false;
  @override
  void didUpdateWidget(covariant TogglePic oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!didData) {
      didData = true;
      _init();
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
    didData = true;
    _init();
  }

  _init() {
    if (data.isNotEmpty) {
      widget.callback(0).then((value) {
        data[0].data = value.data;
        data[0].totalNum = value.totalNum ?? 0;
        if (data[0].totalNum == 0) {
          data[0].data.forEach((element) {
            data[0].totalNum += element.nums.toInt();
          });
        }

        if (mounted) {
          setState(() {});
        }
        didData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            children: data
                .asMap()
                .keys
                .map((index) => Expanded(
                    child: CustomPaint(
                        painter: SliverStyle(choosed, index, data.length),
                        child: InkWell(
                            onTap: () async {
                              choosed = index;
                              if (data[index].totalNum == 0) {
                                TogglePicTypedata _data =
                                    await widget.callback(index);
                                data[index].data = _data.data;
                                data[index].totalNum = _data.totalNum;
                              }
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: size.width * 20,
                                  bottom: size.width * 20),
                              child: Text(
                                data[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: size.width * 28,
                                    color: index == choosed
                                        ? Color(0xff306CFD)
                                        : placeHolder,
                                    fontWeight: FontWeight.bold),
                              ),
                            )))))
                .toList()),
        Row(children: [
          Container(
              width: size.width * 320,
              child: PieChartSample2(
                  centerChild: widget.centerChild == ''
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.centerChild,
                              style: TextStyle(fontSize: size.width * 24),
                            ),
                            Text(
                              data[choosed].totalNum.toString(),
                              style: TextStyle(fontSize: size.width * 24),
                            ),
                          ],
                        ),
                  roundUi: data[choosed].data)),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: data[choosed]
                      .data
                      .map<Widget>((ele) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 18,
                                height: size.width * 18,
                                decoration: BoxDecoration(
                                  color: ele.color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                ),
                              ),
                              Text(ele.names.toString(),
                                  style: TextStyle(
                                      color: Color(0xff656565),
                                      fontSize: size.width * 22)),
                              SizedBox(
                                width: size.width * 100,
                                child: Text(
                                  ele.nums.toInt().toString(),
                                  style: TextStyle(
                                      color: placeHolder,
                                      fontSize: size.width * 22),
                                ),
                              )
                            ],
                          ))
                      .toList()))
        ])
      ],
    );
  }
}

class SliverStyle extends CustomPainter {
  SliverStyle(this.currenIndex, this.index, this.totleLength);
  final int currenIndex, totleLength, index;

  Paint _paint = Paint()
    ..color = Color(0xff3265FD)
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size sizes) {
    if (index == currenIndex) {
      for (int x = 0; x < totleLength; x++) {
        if (x == currenIndex) {
          Path _path = Path();
          Rect _oval = Rect.fromCircle(
              center: Offset(
                15,
                0,
              ),
              radius: 6);
          _path.addArc(_oval, pi / 2, pi / 2);
          canvas.drawPath(_path, _paint);

          _path.moveTo(9, 0);
          _path.lineTo(15, 6);
          _path.lineTo(sizes.width - 15, 6);
          _path.lineTo(sizes.width - 9, 0);
          canvas.drawPath(_path, _paint);

          Rect _oval2 = Rect.fromCircle(
              center: Offset(
                sizes.width - 15,
                0,
              ),
              radius: 6);
          _path.addArc(_oval2, 0, pi / 2);
          canvas.drawPath(_path, _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TrendBarItemYAxis {
  final String name;
  final Color color;
  final List<double> data;
  TrendBarItemYAxis(
      {@required this.name, @required this.color, @required this.data});
}

class TrendBar extends StatefulWidget {
  TrendBar({this.height, this.width, this.yAxis, this.yWidth, this.xAixs});
  final double height, width, yWidth;
  final List<TrendBarItemYAxis> yAxis;
  final List<String> xAixs;
  @override
  _TrendBarState createState() => _TrendBarState();
}

class _TrendBarState extends State<TrendBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: widget.yAxis
              .map((e) => Container(
                    height: size.width * 35,
                    child: Center(
                      child: Text(
                        e.name,
                        style: TextStyle(fontSize: size.width * 14),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(width: size.width * 5),
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.xAixs
                .asMap()
                .keys
                .map<Widget>((index) => TrendBarItem(
                    yAxis: widget.yAxis,
                    yWidth: widget.yWidth,
                    index: index,
                    xAixs: widget.xAixs))
                .toList(),
          ),
        ))
      ],
    ));
  }
}

class TrendBarItem extends StatefulWidget {
  TrendBarItem({this.yAxis, this.yWidth, this.index, this.xAixs});
  final List<TrendBarItemYAxis> yAxis;
  final List<String> xAixs;
  final double yWidth;
  final int index;
  @override
  _TrendBarItemState createState() => _TrendBarItemState();
}

class _TrendBarItemState extends State<TrendBarItem> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        show = !show;
        if (mounted) {
          setState(() {});
        }
      },
      child: Column(
        children: widget.yAxis.asMap().keys.map((_index) {
          return Column(
            children: [
              Container(
                width: widget.yWidth * size.width,
                height: size.width * 35,
                decoration: BoxDecoration(
                    color: widget.yAxis[_index].color.withOpacity(
                        widget.yAxis[_index].data[widget.index] / 10 > 1
                            ? 1
                            : widget.yAxis[_index].data[widget.index] / 10 <= 0
                                ? 0.1
                                : widget.yAxis[_index].data[widget.index] / 10 +
                                    0.1),
                    border: Border(
                        left: BorderSide(
                          width: 2,
                          color: Color(0xffEEF3F8),
                        ),
                        top: BorderSide(
                          width: 2,
                          color: Color(0xffEEF3F8),
                        ),
                        bottom: widget.index == widget.yAxis.length - 1
                            ? BorderSide(
                                width: 2,
                                color: Color(0xffEEF3F8),
                              )
                            : BorderSide(width: 0, color: Colors.white))),
                child: show
                    ? Center(
                        child: Text(
                          widget.yAxis[_index].data[widget.index].toString(),
                          style: TextStyle(fontSize: size.width * 16),
                        ),
                      )
                    : Container(),
              ),
              _index == widget.yAxis.length - 1
                  ? Transform.rotate(
                      angle: 3.14 / 12,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: size.width * 20, bottom: size.width * 20),
                        child: Text(
                          widget.xAixs[widget.index],
                          style: TextStyle(fontSize: size.width * 16),
                        ),
                      ),
                    )
                  : Container()
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SafeLineChart extends StatefulWidget {
  SafeLineChart(
      {@required this.yAxisList,
      @required this.xAxisList,
      @required this.height});
  final List yAxisList;
  final List<double> xAxisList;
  final double height;
  @override
  _SafeLineChartState createState() => _SafeLineChartState();
}

class _SafeLineChartState extends State<SafeLineChart> {
  Size currenWindow = Size(0, 0);
  ScrollController _scrollController = ScrollController();
  List<Offset> points = [];
  int oldLength = 0;
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _generatePoint();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currenWindow = context.size;
      showGetSize = true;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(SafeLineChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.xAxisList.length > 1) {
      _generatePoint();
      if (!(points.length * 30 < currenWindow.width)) {
        _scrollController.animateTo(
            (points.length * 30).toDouble() - currenWindow.width,
            duration: Duration(milliseconds: 600),
            curve: Curves.easeIn);
      } else {
        _scrollController.animateTo(0,
            duration: Duration(milliseconds: 600), curve: Curves.easeIn);
      }
    }
  }

  _generatePoint() {
    int initTotal = widget.xAxisList.length;

    if (oldLength < initTotal) {
      for (var i = oldLength; i < initTotal; i++) {
        points.add(Offset(
            i * 30.toDouble(),
            widget.height -
                (widget.height / widget.yAxisList[0] * widget.xAxisList[i])));
      }
    } else {
      points = [];
      for (var i = 0; i < initTotal; i++) {
        points.add(Offset(
            i * 30.toDouble(),
            widget.height -
                (widget.height / widget.yAxisList[0] * widget.xAxisList[i])));
      }
    }

    oldLength = widget.xAxisList.length;
  }

  bool showGetSize = false;
  @override
  Widget build(BuildContext context) {
    return showGetSize
        ? Container(
            width: currenWindow.width,
            height: 300,
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1, color: Colors.black))),
                    height: 300,
                    padding: EdgeInsets.only(right: size.width * 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: widget.yAxisList
                          .map((e) => Text(e.toString()))
                          .toList(),
                    )),
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Container(
                    constraints: BoxConstraints(minWidth: size.width * 700),
                    height: 300,
                    width: (points.length > 0 ? points.length - 1 : 0) *
                        30.toDouble(),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black)),
                    ),
                    child: CustomPaint(painter: LinePaint(points)),
                  ),
                ))
              ],
            ),
          )
        : Container();
  }
}

class LinePaint extends CustomPainter {
  LinePaint(this.points);
  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Color(0xff8ad1eb)
      ..strokeWidth = 2;

    for (var i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(LinePaint oldDelegate) => oldDelegate.points != points;
}

class ClickBar extends StatefulWidget {
  ClickBar(
      {@required this.height,
      @required this.yAxisList,
      @required this.xAxisList,
      @required this.index,
      @required this.yWidth,
      @required this.color});
  final double height, yWidth;
  final List<XAxisSturct> xAxisList;
  final List yAxisList;
  final int index;
  final Color color;
  @override
  _ClickBarState createState() => _ClickBarState();
}

class _ClickBarState extends State<ClickBar> with TickerProviderStateMixin {
  bool showsTitle = false;
  double height = 0.0;
  AnimationController _animationController;
  Animation _curve;
  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  _initDate() {
    height = (widget.height /
        widget.yAxisList[0] *
        widget.xAxisList[widget.index].nums);
  }

  @override
  void initState() {
    super.initState();
    _initDate();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _curve = Tween(begin: 0.0, end: height).animate(_animationController)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showsTitle = !showsTitle;
        if (mounted) {
          setState(() {});
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: _curve.value,
            width: widget.yWidth,
            color: widget.color,
            child: showsTitle
                ? Center(
                    child: Text(
                      widget.xAxisList[widget.index].nums.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  )
                : Container(),
          ),
          Container(
            constraints: BoxConstraints(minWidth: widget.yWidth * 2 + 20.0),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 1, color: underColor))),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Text(
                widget.xAxisList[widget.index].names.toString(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Round extends StatefulWidget {
  Round({this.proportion = 0.0, this.child, this.bgColor, this.proColor})
      : assert(proportion >= 0.0 && proportion <= 1, 'this % number');
  final double proportion;
  final Widget child;
  final Color bgColor;
  final Color proColor;
  @override
  _RoundState createState() => _RoundState();
}

class _RoundState extends State<Round> with TickerProviderStateMixin {
  bool shows = false;
  Size size = Size(0, 0);
  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      shows = true;
      Size tempSize = Size(context.size.width, context.size.width / 2);
      size = tempSize;
      if (mounted) {
        setState(() {});
      }
    });

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation =
        Tween(begin: 0.0, end: widget.proportion).animate(_animationController);
    _animationController.forward();
  }

  bool selected = false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return shows
        ? Container(
            width: size.width,
            height: size.height,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: MyPaint(
                      proportion: widget.proportion > 0.1
                          ? _animation.value
                          : widget.proportion,
                      bgColor: widget.bgColor,
                      proColor: widget.proColor),
                  size: size,
                  child: widget.child == null ? Container() : widget.child,
                );
              },
            ),
          )
        : Container();
  }
}

class MyPaint extends CustomPainter {
  MyPaint({this.proportion = 0.0, this.bgColor, this.proColor})
      : assert(proportion <= 1 && proportion >= 0, '%');
  final double proportion;
  final Color bgColor;
  final Color proColor;
  @override
  void paint(Canvas canvas, Size size) {
    const PI = 3.14;
    double radius = size.width / 4;
    if (size.width < 200) {
      radius = size.width / 3;
    }
    var paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = bgColor != null ? bgColor : Color(0xff8ad1eb)
      ..strokeWidth = 8;

    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
    canvas.drawArc(rect, 0, 2 * PI, false, paint);

    paint
      ..style = PaintingStyle.stroke
      ..color = proColor != null ? proColor : Color(0xff30c9c8)
      ..strokeWidth = 10;
    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);

    double posi = 1 / this.proportion;

    canvas.drawArc(rect, PI, 2 * PI / posi, false, paint);

    double proportions = 360 / posi;
    double radian = (180 + proportions) * (PI / 180);
    double roundX = radius * cos(radian);
    double roundY = radius * sin(radian);

    paint
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..strokeWidth = 4;
    rect = Rect.fromCircle(
        center: Offset(size.width / 2 + roundX, size.height / 2 + roundY),
        radius: 4);
    canvas.drawArc(rect, 0, 2 * PI, false, paint);
    canvas.restore();
    canvas.save();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class EchartMutipleBar extends StatefulWidget {
  EchartMutipleBar(
      {this.width = 30.0,
      this.height = 250.0,
      this.yWidth = 20.0,
      this.yAxis,
      this.color,
      this.yAxisList,
      this.xAxisList});
  final double width, height, yWidth, yAxis;
  final List<Color> color;
  final List yAxisList;
  final List<MutipleXAxisSturct> xAxisList;
  @override
  _EchartMutipleBarState createState() => _EchartMutipleBarState();
}

class _EchartMutipleBarState extends State<EchartMutipleBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 30),
              constraints: BoxConstraints(minWidth: widget.width),
              // decoration: BoxDecoration(
              //     border: Border(
              //   right: BorderSide(
              //     color: underColor,
              //     width: size.width * 1,
              //   ),
              // )),
              height: widget.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: widget.yAxisList
                    .map((e) => Container(
                          child: Text(
                            e.toString(),
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: size.width * 24,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      )
                    .toList(),
              )),
          Expanded(
            child: Container(
              height: widget.height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MutipleClickBar(
                    height: widget.height,
                    yAxisList: widget.yAxisList,
                    xAxisList: widget.xAxisList,
                    color: widget.color,
                    index: index,
                    yWidth: widget.yWidth,
                  );
                },
                itemCount: widget.xAxisList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MutipleClickBar extends StatefulWidget {
  MutipleClickBar(
      {this.height,
      this.yWidth,
      @required this.index,
      @required this.yAxisList,
      @required this.xAxisList,
      this.color});
  final double height, yWidth;
  final int index;
  final List yAxisList;
  final List<MutipleXAxisSturct> xAxisList;
  final List<Color> color;
  @override
  _MutipleClickBarState createState() => _MutipleClickBarState();
}

class _MutipleClickBarState extends State<MutipleClickBar>
    with TickerProviderStateMixin {
  bool showsTitle = false;
  List<double> height = [];
  List<AnimationController> _animationList = [];
  List<Animation> _curveList = [];
  Animation _curve;
  List<Color> color = [];
  @override
  void dispose() {
    _animationList.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  _initDate() {
    if (widget.color is List) {
      color = widget.color;
    }

    bool addtionColor = false;
    if (color.length < widget.xAxisList[widget.index].nums.length) {
      addtionColor = true;
      color = [];
    }
    widget.xAxisList[widget.index].nums.forEach((element) {
      double tempHeight = widget.yAxisList[0] == 0
          ? 0
          : widget.height / widget.yAxisList[0] * element;
      height.add(tempHeight);
      _animationList.add(
          AnimationController(vsync: this, duration: Duration(seconds: 3)));
      _curveList.add(_curve);
      if (addtionColor) {
        color.add(color.length % 2 == 0 ? themeColor : Color(0xffFFA100));
      }
    });
    for (var i = 0; i < _animationList.length; i++) {
      _curveList[i] =
          Tween(begin: 0.0, end: height[i]).animate(_animationList[i])
            ..addListener(() {
              if (mounted) {
                setState(() {});
              }
            });
      _animationList[i].forward();
    }
  }

  @override
  void initState() {
    super.initState();

    _initDate();
  }

  @override
  void didUpdateWidget(covariant MutipleClickBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initDate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children:
              widget.xAxisList[widget.index].nums.asMap().keys.map<Widget>((i) {
            return Column(
              children: [
                Center(
                  child: Text(
                    widget.xAxisList[widget.index].nums[i]
                        .truncate()
                        .toString(),
                    style: TextStyle(
                        color: Color(0xff7F8A9C), fontSize: size.width * 20),
                  ),
                ),
                Container(
                  height: _curveList[i].value,
                  width: size.width * 28,
                  margin: EdgeInsets.symmetric(horizontal: size.width * 2),
                  color: widget.xAxisList[widget.index].color.length > i
                      ? widget.xAxisList[widget.index].color[i]
                      : color[i],
                )
              ],
            );
          }).toList(),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 30),
          constraints: BoxConstraints(minWidth: widget.yWidth * 2 + 20.0),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(width: size.width * 2, color: Colors.black))),
          child: Padding(
            padding: EdgeInsets.only(top: size.width * 13),
            child: 
            Text(
                widget.xAxisList[widget.index].names.toString().length > 4 ? widget.xAxisList[widget.index].names.toString().substring(0, 5) : widget.xAxisList[widget.index].names.toString(),
                style: TextStyle(
                  fontSize: size.width * 20,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w400
                ),
              ),
          )
        )
      ],
    );
  }
}

class HorizontalBar extends StatefulWidget {
  HorizontalBar({
    this.height = 250,
    @required this.yAxis,
    @required this.xAxisList,
  });
  final double height;
  final double yAxis;
  final List<XAxisSturct> xAxisList;
  @override
  _HorizontalBarState createState() => _HorizontalBarState();
}

class _HorizontalBarState extends State<HorizontalBar> {
  List<int> yAxis = [];
  _generateYAxis() {
    yAxis = [];
    int divisor = widget.yAxis ~/ 5;
    for (var i = 0; i < 6; i++) {
      yAxis.add(divisor * i);
      // yAxis.add(widget.yAxis ~/ i);
    }
  }

  GlobalKey _leftKey = GlobalKey();

  bool _bool = false;
  double bottomWidget = 0.0;
  @override
  void initState() {
    super.initState();
    _generateYAxis();
    _initSize();
  }

  _initSize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bool = true;
      bottomWidget = _leftKey.currentContext.size.width;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Column(
        children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                key: _leftKey,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.xAxisList
                    .map((e) => Container(
                          child: Text(
                            e.names,
                            style: TextStyle(
                                color: Color(0xffA0A0A0),
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: underColor.withOpacity(.5), width: 1))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.xAxisList
                      .map((e) => Container(
                            margin:
                                EdgeInsets.symmetric(vertical: size.width * 10),
                            decoration: BoxDecoration(
                                color: Color(0xffF0F0F0),
                                borderRadius: BorderRadius.circular(5)),
                            width: (MediaQuery.of(context).size.width -
                                    20 -
                                    bottomWidget) *
                                (e.otherNum / widget.yAxis),
                            height: size.width * 18,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: e.color,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: size.width * 18,
                                  width: (MediaQuery.of(context).size.width -
                                          20 -
                                          bottomWidget) *
                                      (e.nums / widget.yAxis),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ))
            ],
          )),
          _bool
              ? Container(
                  margin: EdgeInsets.only(left: bottomWidget + 20),
                  padding: EdgeInsets.only(top: size.width * 5),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: underColor.withOpacity(.5), width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: yAxis.map((e) => Text(e.toString())).toList(),
                  ))
              : Container(),
        ],
      ),
    );
  }
}

class Polyline extends StatefulWidget {
  const Polyline({this.xAxis, this.height = 200, this.yAxis});
  final List<XAxisSturct> xAxis;
  final double height, yAxis;
  @override
  _PolylineState createState() => _PolylineState();
}

class _PolylineState extends State<Polyline> {
  bool showDetail = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.width * widget.height,
        child: ListView.builder(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.xAxis.length,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    showDetail = !showDetail;
                  });
                },
                child: Column(
                  children: [
                    CustomPaint(
                      painter: PolylinePainter(
                        value: widget.xAxis,
                        index: index,
                        yAxia: widget.yAxis,
                      ),
                      child: Column(
                        children: [
                          showDetail
                              ? Text(widget.xAxis[index].nums.toString())
                              : Container(),
                          Container(
                              margin: EdgeInsets.only(
                                  right: size.width * 20,
                                  top: size.width *
                                      (widget.height - (showDetail ? 80 : 40))),
                              child: Text(
                                widget.xAxis[index].names,
                              ))
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}

class PolylinePainter extends CustomPainter {
  PolylinePainter({this.value, this.yAxia, this.index});
  final List<XAxisSturct> value;
  final double yAxia;
  final int index;
  Paint _paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = .5
    ..isAntiAlias = true;
  Paint _paintCircle = Paint()
    ..color = themeColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1
    ..isAntiAlias = true;
  @override
  void paint(Canvas canvas, Size size) {
    if (index + 1 < value.length) {
      canvas.drawLine(
          Offset(0, (size.height - 40) / yAxia * value[index].nums),
          Offset(
              size.width, (size.height - 40) / yAxia * value[index + 1].nums),
          _paint);
    } else {
      canvas.drawLine(
          Offset(0, (size.height - 40) / yAxia * value[index].nums),
          Offset(size.width, (size.height - 40) / yAxia * value[index].nums),
          _paint);
    }
    canvas.drawCircle(
        Offset(size.width / 2, (size.height - 40) / yAxia * value[index].nums),
        3,
        _paintCircle);
    canvas.drawLine(Offset(0, size.height - 30),
        Offset(size.width, size.height - 30), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
