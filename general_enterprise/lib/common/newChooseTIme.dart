import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class NewTimeChoose extends StatefulWidget {
  final String lable;
  final Function(String value) callback;

  const NewTimeChoose({Key key, this.lable = "", @required this.callback})
      : super(key: key);
  @override
  _NewTimeChooseState createState() => _NewTimeChooseState();
}

class _NewTimeChooseState extends State<NewTimeChoose> {
  String _time = "";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: size.width * 300, child: Text(widget.lable)),
        Expanded(
            child: InkWell(
          onTap: () {
            DateTime _now = DateTime.now();
            showDatePicker(
                    context: context,
                    initialDate: _now,
                    firstDate: _now,
                    lastDate: DateTime(_now.year + 10))
                .then((value) {
              if (value != null) {
                setState(() {
                  _time = value.toString().split(" ")[0];
                });
              }
            });
          },
          child: Text(
            _time == "" ? "请选择时间" : _time,
            textAlign: TextAlign.end,
            style: TextStyle(color: _time.isEmpty ? placeHolder : null),
          ),
        )),
        Icon(Icons.keyboard_arrow_right)
      ],
    );
  }
}
