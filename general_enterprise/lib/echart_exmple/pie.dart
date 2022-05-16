import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/loding.dart';
import 'package:enterprise/service/context.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  PieChartSample2({this.roundUi, this.centerChild});
  final List<XAxisSturct> roundUi; //XAxisSturct
  final Widget centerChild;
  @override
  _PieChartSample2State createState() => _PieChartSample2State();
}

class _PieChartSample2State extends State<PieChartSample2> {
  int touchedIndex = 0;
  Size _size = Size(0, 0);
  bool init = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _size = context.size;
      init = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.roundUi.isNotEmpty && init
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: size.width * 200,
                child: PieChart(PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  // pieTouchData: PieTouchData(
                  //     enabled: true,
                  //     touchCallback: (response) {
                  //       if (response.touchedSectionIndex != null) {
                  //         touchedIndex = response.touchedSectionIndex;
                  //       }
                  //       setState(() {});
                  //     }
                  //     ),
                  centerSpaceRadius: 30,
                  sections: showingSections(),
                )),
              ),
              Positioned(
                height: size.width * 200,
                width: _size.width,
                child: Center(
                  child: widget.centerChild ?? Container(),
                ),
              )
            ],
          )
        : StaticLoding();
  }

  List<PieChartSectionData> showingSections() {
    List<XAxisSturct> _data = widget.roundUi;
    const int colors = 0xff4Dc996;

    double max = 1;
    List<double> _list = [];
    //  sort
    for (var i = 0; i < _data.length; i++) {
      double temp = double.parse(_data[i].nums.toString());
      _list.add(temp);
      if (temp > max) max = temp;
    }

    for (var i = 0; i < _list.length; i++) {
      double temp = _list[i];
      if (temp / max < 0.03 && temp != 0) {
        _list[i] = max * 0.03;
      }
    }

    return List.generate(_data.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 15 : 10;

      return PieChartSectionData(
        color: _data[i].color ?? (colors + 100 * i),
        // 0.000000000000000000000000000001删除报错
        value: _list[i] == 0 ? 0.000000000000000000000000000001 : _list[i],
        title: '',
        radius: 10.0,
        // 10.0 + (i * 2),
        showTitle: true,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff)),
      );
    });
  }
}
