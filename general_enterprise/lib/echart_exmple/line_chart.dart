import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  LineChartSample2({this.data});
  final List data;
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff5E9BFF),
    const Color(0xff5E9BFF),
  ];
  bool showAvg = false;
  List dateData = [];
  List numData = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 0.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
                swapAnimationDuration: Duration(seconds: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _geneareList() {
    List<FlSpot> _spot = [];
    for (var i = 0; i < widget.data.length; i++) {
      _spot.add(
          FlSpot(i.toDouble(), double.parse(widget.data[i]['num'].toString())));
    }
    return _spot;
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          //表格呈现x
          return FlLine(
            color: const Color(0xfff5f7fa),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          //表格呈现y
          return FlLine(
            color: const Color(0xfff5f7fa),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff68737d),
              fontSize: 8),
          getTitles: (value) {
            return widget.data[value.toInt()]['date']
                .toString();
                // .substring(8, 10);
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 20:
                return '20';
              case 40:
                return '40';
              case 60:
                return '60';
              case 80:
                return '80';
              case 100:
                return '100';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: widget.data.length.toDouble()-1,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: _geneareList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
