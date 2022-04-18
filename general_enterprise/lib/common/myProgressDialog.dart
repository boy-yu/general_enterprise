import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class ProgressDialog {
  static bool _isShowing = false;
  static bool get isShowing => _isShowing;
  static set showing(bool value) => _isShowing = value;
  static void showProgress(BuildContext context,
      {Widget child =
          const Image(image: AssetImage('assets/images/loading.gif'))}) {
    if (!_isShowing) {
      _isShowing = true;
      Navigator.push(
        context,
        _PopRoute(
          child: _Progress(
            child: Container(
              height: size.width * 150,
              width: size.width * 150,
              child: child,
            ),
          ),
        ),
      );
    }
  }

  ///隐藏
  static void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}

class _Progress extends StatefulWidget {
  final Widget child;

  const _Progress({Key key, @required this.child}) : super(key: key);
  @override
  __ProgressState createState() => __ProgressState();
}

class __ProgressState extends State<_Progress> {
  @override
  void dispose() {
    ProgressDialog.showing = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black.withOpacity(.3),
        child: Center(
          child: widget.child,
        ));
  }
}

///Route
class _PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  _PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
