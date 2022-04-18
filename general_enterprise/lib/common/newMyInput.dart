import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class NewMyInput extends StatefulWidget {
  NewMyInput(
      {@required this.title,
      this.value,
      this.placeHolder,
      this.line = 3,
      this.index,
      this.contexts,
      this.onChange,
      this.submitName,
      this.memo = '',
      this.name,
      this.bindKey,
      this.textStyle,
      this.keyboardType});
  final List index;
  final TextInputType keyboardType;
  final Function(String) onChange;
  final contexts;
  final String title, name, bindKey;
  final String value, memo;
  final String placeHolder, submitName;
  final int line;
  final TextStyle textStyle;
  @override
  _NewMyInputState createState() => _NewMyInputState();
}

class _NewMyInputState extends State<NewMyInput> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
            maxWidth: size.width * 260,
          ),
          child: Text(
            widget.title,
            style: widget.textStyle ??
                TextStyle(
                    fontSize: size.width * 30, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
            child: Container(
          color: widget.line == 4 ? Color(0xffF1F5FD) : null,
          height: widget.line == 4 ? size.width * 250 : null,
          child: TextField(
            keyboardType: widget.keyboardType,
            textInputAction: TextInputAction.next,
            controller: _controller,
            textAlign: widget.line == 4 ? TextAlign.left : TextAlign.right,
            onChanged: (value) {
              if (widget.onChange != null) {
                widget.onChange(value);
              }
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(5),
                hintStyle: widget.textStyle ??
                    TextStyle(
                        fontSize: size.width * 26,
                        color: widget.placeHolder == null
                            ? Colors.grey
                            : Colors.black),
                hintText: widget.placeHolder == null
                    ? '请输入' + widget.title
                    : widget.placeHolder),
            maxLines: widget.line,
            minLines: 1,
          ),
        )),
      ],
    );
  }
}
