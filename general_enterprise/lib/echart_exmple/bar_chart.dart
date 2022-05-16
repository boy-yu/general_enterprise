import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xffcee8e8);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
//              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BarChart(
                      mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    double width = 15,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          borderRadius: BorderRadius.only(
              bottomLeft: new Radius.circular(0),
              bottomRight: new Radius.circular(0),
              topRight: new Radius.circular(20.0),
              topLeft: new Radius.circular(20.0)),
          y: isTouched ? y + 1 : y,
          //color: isTouched ? Colors.yellow : Color(0xff59aad1),
          color: isTouched ? Color(0xffcee8e8) : Color(0xff5aceb8),
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(4, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 46, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 71, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 12, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 32, isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: Color(0xff737b9a),
              // fontWeight: FontWeight.bold,
              fontSize: 12),
          margin: 5,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '全公司\n作业数量';
              case 1:
                return '涉及\n区域数量';
              case 2:
                return '特殊作业';
              case 3:
                return '一般作业';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: const Color(0xff7589a2),
              // fontWeight: FontWeight.bold,
              fontSize: 12),
          margin: 20,
          reservedSize: 10,
          getTitles: (value) {
            if (value == 0) {
              return '0';
            } else if (value == 19) {
              return '20';
            } else if (value == 39) {
              return '40';
            } else if (value == 59) {
              return '60';
            } else if (value == 79) {
              return '80';
            } else if (value == 99) {
              return '100';
            } else {
              return '';
            }
          },
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  Future<dynamic> refreshState() async {
    if (mounted) {
      setState(() {});
    }
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}
