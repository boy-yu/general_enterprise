import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'myCustomColor.dart';

typedef Callback = void Function(String msg);

class NewMychooseTime extends StatefulWidget {
  NewMychooseTime(
      {this.title,
      this.purview,
      this.numer = 1,
      this.name,
      this.placeholder,
      this.type,
      this.memo = '',
      this.tableIndex,
      this.showTitle = true,
      this.index,
      @required this.callback,
      this.bindKey});
  final title,
      purview,
      numer,
      name,
      index,
      placeholder,
      type,
      showTitle,
      memo,
      tableIndex;
  final String bindKey;
  final Callback callback; // return msg
  @override
  _NewMychooseTimeState createState() => _NewMychooseTimeState();
}

class _NewMychooseTimeState extends State<NewMychooseTime> {
  String msg = '';
  int clickNum = 0;
  String place;
  _pop() async {
    ++clickNum;
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    ).then((value) {
      if (value != null) {
        showTimePicker(context: context, initialTime: TimeOfDay.now())
            .then((time) {
          if (time != null) {
            String currenTime = value.toLocal().toString().split(' ')[0] +
                ' ' +
                (time.hour > 9
                    ? time.hour.toString()
                    : '0' + time.hour.toString()) +
                ':' +
                (time.minute > 9
                    ? time.minute.toString()
                    : '0' + time.minute.toString());

            msg += currenTime + (clickNum < widget.numer ? ' - ' : '');

            if (widget.callback != null) {
              widget.callback(msg);
            }
            if (clickNum < widget.numer) {
              _pop();
            } else {
              clickNum = 0;
            }
            setState(() {});
          } else {
            clickNum = 0;
          }
        });
      } else {
        clickNum = 0;
      }
      setState(() {});
    });

    // showModalBottomSheet(
    //     isDismissible: false,
    //     context: context,
    //     builder: (_) => Container(
    //         height: _context.heights * 550,
    //         child: DateTimePickerWidget(
    //             minDateTime:
    // DateTime.parse(DateTime.now().toLocal().toString().split(' ')[0]),
    //             dateFormat: 'yyyy-MM-dd HH:mm',
    //             locale: DateTimePickerLocale.zh_cn,
    //             onCancel: () {
    //               clickNum = 0;
    //             },
    //             onConfirm: (dateTime, selectedIndex) {
    //               msg += dateTime
    //                       .toString()
    //                       .substring(0, dateTime.toString().length - 7) +
    //                   (clickNum < widget.numer ? ' - ' : '');
    //               setState(() {});
    //               _context.changeSubmitDates(widget.purview, {
    //                 "title": widget.title,
    //                 "value": msg,
    //               });
    //               if (clickNum < widget.numer) {
    //                 _pop(_context);
    //               } else {
    //                 if (widget.index != null) {
    //                   _context.changeSmallTicket(
    //                       widget.index, msg.replaceAll(RegExp(' - '), '|'),
    //                       type: widget.type == 'table'
    //                           ? 'table|' + widget.tableIndex.toString()
    //                           : null);
    //                 }
    //                 clickNum = 0;
    //               }
    //             })));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          widget.showTitle
              ? Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: TextStyle(fontSize: size.width * 30),
                      ),
                      SizedBox(
                        width: size.width * 10,
                      ),
                    ],
                  ),
                )
              : Container(),
          Expanded(
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  msg = '';
                  _pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 30,
                          vertical: size.width * 20),
                      child: Text(
                        msg == ''
                            ? widget.placeholder == null ||
                                    widget.placeholder == ''
                                ? '请选择时间'
                                : widget.placeholder.toString()
                            : msg,
                        style: TextStyle(
                            color: msg == ''
                                ? widget.placeholder == null ||
                                        widget.placeholder == ''
                                    ? placeHolder
                                    : Colors.black
                                : Colors.black,
                            fontSize: size.width * 24),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                    ),
                  ],
                )),
          )
          // Divider()
        ]);
  }
}
