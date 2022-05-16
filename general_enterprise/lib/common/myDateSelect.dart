import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:provider/provider.dart';
import 'myCount.dart';

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
      this.icon, this.dateTime, this.hintText, this.borderColor
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
      icon,
      dateTime,
      hintText,
      borderColor;
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
      width: widget.width == null ? size.width * 328 : widget.width,
      height: widget.height == null ? size.width * 60 : widget.height,
      margin: EdgeInsets.symmetric(vertical: size.width * 12),
      padding: EdgeInsets.symmetric(horizontal: size.width * 16, vertical: size.width * 12),
      decoration: BoxDecoration(
        border: Border.all(
          width: size.width * 2,
          color: widget.borderColor == null ? Color(0xffF2F2F2) : widget.borderColor,
        ),
        borderRadius: BorderRadius.circular(size.width * 8),
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
              Text(
                  msg == ''
                      ? widget.placeholder == null
                          ? widget.hintText == null ? '请选择时间' : widget.hintText
                          : widget.placeholder.toString()
                      : msg,
                  style: TextStyle(
                    fontSize: size.width * 24,
                    fontWeight: FontWeight.w400,
                      color: msg == ''
                          ? widget.placeholder == null
                              ? Color(0xff7F8A9C)
                              : Colors.black
                          : Colors.black),
                ),
                widget.icon == 1 ? Container() :
                  widget.icon == null ? Image.asset(
                "assets/images/icon_risk_date.png",
                width: size.width * 49,
                height: size.width * 43,
              ) 
              : widget.icon,
            ],
          )),
    );
  }
}
