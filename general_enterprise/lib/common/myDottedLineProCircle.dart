import 'package:enterprise/service/context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*
 *  环形百分比虚线进度组件
 *  author: lwk
 *  time: 2020.11.2
 *  value : 进度值
 */
class DottedLineProCircle extends StatefulWidget {
  final double width;
  final double sizes;
  final double radius;
  final int value;

  const DottedLineProCircle({
    Key key,
    @required this.width,
    this.sizes,
    this.value,
    this.radius,
  }) : super(key: key);
  @override
  _DottedLineProCircleState createState() => _DottedLineProCircleState();
}

class _DottedLineProCircleState extends State<DottedLineProCircle> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (100 - widget.value).toString(),
              style: TextStyle(
                color: Color(0xff222222),
                fontSize: size.width * 30
              ),
            ),
            Container(
              width: size.width * 34,
              height: size.width * 1,
              color: Color(0xffDBDBDB),
            ),
            Text(
              '100',
              style: TextStyle(
                color: Color(0xff999999),
                fontSize: size.width * 30
              ),
            )
          ],
        ),
      ),
      painter: MyPainterCircles(
          widget.width, widget.value, widget.radius),
    );
  }
}

class MyPainterCircles extends CustomPainter {
  final double sizes;
  final int value;
  final double radius;
  MyPainterCircles(this.sizes, this.value, this.radius);
  @override
  void paint(Canvas canvas, Size size) {
    final Offset offsetCenter = Offset(sizes / 2, sizes / 2);
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color(0xffffffff)
      ..strokeWidth = 1.0;
    canvas.drawCircle(offsetCenter, radius ?? 25, ringPaint);
    final Rect arcRect = Rect.fromCircle(center: offsetCenter, radius: radius ?? 25);
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    for (double i = 1.0; i <= 100; ++i) {
      value < i ? progressPaint.color = Color(0xff3368FA) : progressPaint.color = Color(0xff206FFF).withOpacity(0.2);
      canvas.drawArc(arcRect, 3.1415926 / 50 * i + .1, 3.1415926 / 50 - .1, false, progressPaint);
    }
  }
  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
