import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({this.data});
  final List data;
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color leftBarColor = const Color(0xff47d096);
  final Color rightBarColor = const Color(0xff69b3f0);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    // final barGroup1 = makeGroupData(0, 5, 12);
    // final barGroup2 = makeGroupData(1, 16, 12);
    // final barGroup3 = makeGroupData(2, 18, 5);
    // final barGroup4 = makeGroupData(3, 20, 16);
    // final barGroup5 = makeGroupData(4, 17, 6);
    // final barGroup6 = makeGroupData(5, 19, 1.5);
    // final barGroup7 = makeGroupData(6, 10, 1.5);

    // final items = [
    //   barGroup1,
    //   barGroup2,
    //   barGroup3,
    //   barGroup4,
    //   barGroup5,
    //   barGroup6,
    //   barGroup7,
    // ];
    // showingBarGroups = items;
    List<BarChartGroupData> tempData = [];
    for (var i = 0; i < widget.data.length; i++) {
      tempData.add(makeGroupData(
          i,
          double.parse(widget.data[i]['workNum'].toString()),
          double.parse(widget.data[i]['specialWorkNum'].toString())));
    }
    showingBarGroups = tempData;
  }

  @override
  void didUpdateWidget(BarChartSample2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    // print(widget.data);
    List<BarChartGroupData> tempData = [];
    for (var i = 0; i < widget.data.length; i++) {
      tempData.add(makeGroupData(
          i,
          double.parse(widget.data[i]['workNum'].toString()),
          double.parse(widget.data[i]['specialWorkNum'].toString())));
    }
    showingBarGroups = tempData;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xffffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: BarChart(
                  BarChartData(
                    maxY: 150,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
                        getTooltipItem: (_a, _b, _c, _d) => null,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        textStyle: TextStyle(
                            color: const Color(0xff7589a2),
                            // fontWeight: FontWeight.bold,
                            fontSize: 8),
                        margin: 5,
                        getTitles: (double value) {
                          return widget.data[value.toInt()]['name'].toString().substring(0,2) + '\n' + widget.data[value.toInt()]['name'].toString().substring(2);
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        textStyle: TextStyle(
                            color: const Color(0xff7589a2), fontSize: 12),
                        margin: 12,
                        reservedSize: 12,
                        getTitles: (value) {
                          return value % 20 == 0
                              ? value.toInt().toString()
                              : '';
                        },
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0)),
        y: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0)),
        y: y2,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }
}
