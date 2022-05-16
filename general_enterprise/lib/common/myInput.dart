import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyInput extends StatefulWidget {
  MyInput(
      {this.title,
      this.value,
      this.placeHolder,
      this.line = 3,
      this.index,
      this.contexts,
      this.purview,
      this.onChange,
      this.submitName,
      this.memo = '',
      this.name,
      this.bindKey});
  final List index;
  final purview;
  final onChange;
  final contexts;
  final String title, name, bindKey;
  final String value, memo;
  final String placeHolder, submitName;
  final int line;
  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  TextEditingController _controller = TextEditingController();
  Counter _counter = Provider.of<Counter>(myContext);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.title,
          style:
              TextStyle(fontSize: size.width * 30, fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: _controller,
            textAlign: TextAlign.right,
            onChanged: (value) {
              if (widget.purview != null) {
                _counter.changeSubmitDates(widget.purview, {
                  'title': widget.title,
                  'value': value,
                  "bindKey": widget.bindKey
                });
              }
              if (widget.index != null) {
                _counter.changeSmallTicket(widget.index, value,
                    names:
                        widget.submitName != null ? widget.submitName : null);
              }
              if (widget.onChange != null) {
                widget.onChange(value);
              }
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
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
        ),
      ],
    );
  }
}
