import 'package:flutter/material.dart';
import './myCustomColor.dart';

// custom Appbar

class MyAppbar extends StatefulWidget {
  MyAppbar({
    Key key,
    this.title = const Text('标题'),
    @required this.child,
    this.backgroundColor = backgroundBg,
    this.floatingActionButton,
    this.actions,
    this.drawerWidget,
    this.elevation = 5,
    this.lineGradColor,
  }) : super(key: key);
  final Widget child;
  final Widget title;
  final List<Widget> actions;
  final Color backgroundColor;
  final Widget floatingActionButton;
  final Widget drawerWidget;
  final double elevation;
  final List<Color> lineGradColor;
  @override
  _MyAppbarState createState() => _MyAppbarState();
}

class _MyAppbarState extends State<MyAppbar> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacity;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool scroll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: AppBar(
        elevation: widget.elevation,
        centerTitle: true,
        title: widget.title,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color(0xff3074FF)
            // gradient: LinearGradient(
            //   colors: widget.lineGradColor ?? lineGradBlue,
            // ),
          ),
        ),
        actions: widget.actions,
      ),
      body: FadeTransition(opacity: _opacity, child: widget.child),
      backgroundColor: widget.backgroundColor,
      floatingActionButton: widget.floatingActionButton,
      drawer: widget.drawerWidget,
    );
  }
}
