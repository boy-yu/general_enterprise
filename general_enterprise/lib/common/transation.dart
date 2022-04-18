import 'package:enterprise/common/loding.dart';
import 'package:flutter/material.dart';

class Transtion extends StatefulWidget {
  final Widget child;
  final bool show;
  final Widget addtion;
  Transtion(this.child, this.show, {this.addtion});
  @override
  _TranstionState createState() => _TranstionState();
}

class _TranstionState extends State<Transtion> with TickerProviderStateMixin {
  double opacity = 1.0;
  @override
  void initState() {
    super.initState();
  }

  _init() {
    setState(() {
      opacity = 0.0;
    });
  }

  @override
  void didUpdateWidget(covariant Transtion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        opacity == 0
            ? Container()
            : Expanded(
                child: Center(
                child: AnimatedSize(
                  curve: Curves.easeIn,
                  duration: Duration(seconds: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.addtion ?? Container(),
                      SizedBox(
                        height: opacity * 60,
                        width: opacity * 60,
                        child: StaticLoding(),
                      )
                    ],
                  ),
                ),
              )),
        Expanded(
            child: AnimatedOpacity(
                opacity: 1 - opacity,
                duration: Duration(seconds: 1),
                child: opacity == 0 ? widget.child : Container())),
      ],
    );
  }
}

class TranstionNoExpand extends StatefulWidget {
  final Widget child;
  final bool show;
  final Widget addtion;
  TranstionNoExpand(this.child, this.show, {this.addtion});
  @override
  _TranstionNoExpandState createState() => _TranstionNoExpandState();
}

class _TranstionNoExpandState extends State<TranstionNoExpand>
    with TickerProviderStateMixin {
  double opacity = 1.0;
  @override
  void initState() {
    super.initState();
  }

  _init() {
    setState(() {
      opacity = 0.0;
    });
  }

  @override
  void didUpdateWidget(covariant TranstionNoExpand oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        opacity == 0
            ? Container()
            : Center(
                child: AnimatedSize(
                  curve: Curves.easeIn,
                  duration: Duration(seconds: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.addtion ?? Container(),
                      SizedBox(
                        height: opacity * 60,
                        width: opacity * 60,
                        child: StaticLoding(),
                      )
                    ],
                  ),
                ),
              ),
        AnimatedOpacity(
            opacity: 1 - opacity,
            duration: Duration(seconds: 1),
            child: opacity == 0 ? widget.child : Container()),
      ],
    );
  }
}
