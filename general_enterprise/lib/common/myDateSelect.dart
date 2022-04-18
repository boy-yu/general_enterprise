import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:provider/provider.dart';
import 'myCount.dart';
import 'myCustomColor.dart';

typedef Callback = void Function(String msg);

class MyDateSelect extends StatefulWidget {
  MyDateSelect(
      {this.title,
      this.purview,
      this.value,
      this.numer = 1,
      this.name,
      this.placeholder,
      this.type,
      this.memo = '',
      this.tableIndex,
      this.showTitle = true,
      this.index,
      this.callback,
      this.width,
      this.height,
      this.isShowIcon, this.dateTime
  });
  final title,
      purview,
      value,
      numer,
      name,
      index,
      placeholder,
      type,
      showTitle,
      memo,
      tableIndex,
      width,
      height,
      isShowIcon,
      dateTime;
  final Callback callback; // return msg
  @override
  _MyDateSelectState createState() => _MyDateSelectState();
}

class _MyDateSelectState extends State<MyDateSelect> {
  String msg = '';
  int clickNum = 0;
  String place;
  DateTime dateTime;
  _pop(_context) async {
    ++clickNum;
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (_) => Container(
            height: size.width * 550,
            child: DateTimePickerWidget(
                initDateTime: DateTime.parse(
                    DateTime.now().toLocal().toString().split(' ')[0]),
                dateFormat: 'yyyy-MM-dd',
                locale: DateTimePickerLocale.zh_cn,
                onCancel: () {
                  clickNum = 0;
                },
                onConfirm: (dateTime, selectedIndex) {
                  msg += dateTime.toString().split(' ')[0] +
                      (clickNum < widget.numer ? ' - ' : '');
                  dateTime = dateTime;
                  if (mounted) {
                    setState(() {});
                  }
                  _context.changeSubmitDates(widget.purview, {
                    "title": widget.title,
                    "value": msg,
                  });
                  if (clickNum < widget.numer) {
                    _pop(_context);
                  } else {
                    if (widget.index != null) {
                      _context.changeSmallTicket(
                          widget.index, msg.replaceAll(RegExp(' - '), '|'),
                          type: widget.type == 'table'
                              ? 'table|' + widget.tableIndex.toString()
                              : null);
                    }
                    if (widget.callback != null) {
                      if(widget.dateTime != null){
                        widget.callback(dateTime.toString());
                      }else{
                        widget.callback(msg);
                      }
                    }
                    clickNum = 0;
                  }
                })));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Counter _context = Provider.of<Counter>(context);
    return Container(
      width: widget.width == null ? size.width * 292 : widget.width,
      height: widget.height == null ? size.width * 84 : widget.height,
      margin: EdgeInsets.only(right: 5.0, top: 10.0, left: 5.0),
      padding: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Color(0xffD2D2D2),
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            msg = '';
            _pop(_context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 30, vertical: size.width * 20),
                child: Text(
                  msg == ''
                      ? widget.placeholder == null
                          ? '请选择时间'
                          : widget.placeholder.toString()
                      : msg,
                  style: TextStyle(
                      color: msg == ''
                          ? widget.placeholder == null
                              ? placeHolder
                              : Colors.black
                          : Colors.black),
                ),
              ),
              widget.isShowIcon == null ? Image.asset(
                "assets/images/icon_risk_date.png",
                width: size.width * 49,
                height: size.width * 43,
              ) : Container(),
            ],
          )),
    );
  }
}
