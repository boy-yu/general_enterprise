import 'package:enterprise/pages/waitWork/_cancelWorkApply.dart';
import 'package:flutter/material.dart';

class RiskCircle extends StatefulWidget {
  final double width;
  final double sizes;
  final double radius;
  final double fontsize;

  final int initialRiskLevel;
  final int value;
  final int level;
  final String text;
  const RiskCircle(
      {Key key,
      @required this.width,
      this.sizes,
      this.value,
      this.level,
      this.radius,
      this.fontsize,
      this.initialRiskLevel,
      this.text})
      : super(key: key);
  @override
  _RiskCircleState createState() => _RiskCircleState();
}

_getColor(int initialLevel) {
  Color color;
  switch (initialLevel) {
    case 1:
      color = Color(0xffFF1E1C);
      break;
    case 2:
      color = Color(0xffFF9C00);
      break;
    case 3:
      color = Color(0xffFFDE00);
      break;
    case 4:
      color = Color(0xff206FFF);
      break;
    default:
  }
  return color;
}

class _RiskCircleState extends State<RiskCircle> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
          width: widget.width,
          height: widget.width,
          decoration: BoxDecoration(
            color: _getColor(widget.initialRiskLevel),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.text == null ? '' : widget.text.toString(),
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color(0xffffffff),
                      fontSize: widget.fontsize ?? 8)),
            ],
          )),
      painter: MyPainterCircles(
          widget.width, widget.value, widget.level, widget.radius),
    );
  }
}

class MyPainterCircles extends CustomPainter {
  final double sizes;
  final int value;
  final int level;
  final double radius;
  MyPainterCircles(this.sizes, this.value, this.level, this.radius);
  @override
  void paint(Canvas canvas, Size size) {
    final Offset offsetCenter = Offset(sizes / 2, sizes / 2);
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.transparent
      ..strokeWidth = 5.0;
    canvas.drawCircle(offsetCenter, radius ?? 25, ringPaint);
    final Rect arcRect =
        Rect.fromCircle(center: offsetCenter, radius: radius ?? 25);
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    for (double i = 1.0; i <= 10; ++i) {
      switch (level) {
        case 1:
          value < i
              ? progressPaint.color = Color(0xffFF1E1C)
              : progressPaint.color = Color(0xffFF1E1C).withOpacity(0.2);
          break;
        case 2:
          value < i
              ? progressPaint.color = Color(0xffFF9C00)
              : progressPaint.color = Color(0xffFF9C00).withOpacity(0.2);
          break;
        case 3:
          value < i
              ? progressPaint.color = Color(0xffFFDE00)
              : progressPaint.color = Color(0xffFFDE00).withOpacity(0.2);
          break;
        case 4:
          value < i
              ? progressPaint.color = Color(0xff206FFF)
              : progressPaint.color = Color(0xff206FFF).withOpacity(0.2);
          break;
      }
      canvas.drawArc(
          arcRect, PI / 5 * i + .1, PI / 5 - .1, false, progressPaint);
    }
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
