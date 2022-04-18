import 'package:flutter/material.dart';

class ClickToggle extends StatefulWidget {
  final Duration duration;
  final Widget Function(AnimationController, Animation<double>) child;
  const ClickToggle({this.duration, @required this.child});

  @override
  _ClickToggleState createState() => _ClickToggleState();
}

class _ClickToggleState extends State<ClickToggle>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _value;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: widget.duration ?? Duration(seconds: 1));
    _value = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _value,
      builder: (context, child) {
        return widget.child(_animationController, _value);
      },
    );
  }
}
