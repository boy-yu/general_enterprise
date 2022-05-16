import 'package:enterprise/common/myCustomColor.dart';
import 'package:flutter/material.dart';

class ExpanSionText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const ExpanSionText(this.text, {Key key, this.style}) : super(key: key);

  @override
  _ExpanSionTextState createState() => _ExpanSionTextState();
}

class _ExpanSionTextState extends State<ExpanSionText>
    with TickerProviderStateMixin {
  bool show = false;
  String replaceStr = "";
  TextStyle style;
  int maxlines = 3;
  @override
  void initState() {
    super.initState();
    if (widget.style == null) {
      style = TextStyle(fontSize: 20);
    } else {
      if (widget.style.fontSize == null) {
        style = TextStyle(color: widget.style.color, fontSize: 20);
      } else {
        style = widget.style;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(widget.text,
            maxLines: maxlines, overflow: TextOverflow.fade, style: style),
        Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
                onTap: () {
                  setState(() {
                    maxlines = maxlines == null ? 3 : null;
                  });
                },
                child: Container(
                  color: Colors.white,
                  child: Text(
                    maxlines == null ? "[收起]" : "[展开]",
                    style:
                        TextStyle(color: themeColor, fontSize: style.fontSize),
                  ),
                )))
      ],
    );
  }
}

/* 

 
*/
