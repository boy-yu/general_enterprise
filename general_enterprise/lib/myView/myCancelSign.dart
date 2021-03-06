import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelSign extends StatefulWidget {
  CancelSign(
      {this.purview = '取消作业', this.title = '签字', this.url = '', this.widget});
  final String purview, title, url;
  final Widget widget;
  @override
  _CancelSignState createState() => _CancelSignState();
}

class _CancelSignState extends State<CancelSign> {
  String url;
  Counter _counter = Provider.of<Counter>(myContext);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.emptySubmitDates(key: widget.purview);
    });
  }

  generateImg() {
    if (_counter.submitDates[widget.purview] != null) {
      if (_counter.submitDates[widget.purview].toString().indexOf('http') >
          -1) {
        _counter.submitDates[widget.purview]?.forEach((ele) {
          if (ele['title'] == widget.title) {
            url = ele['value'];
          }
        });
      }
    }
    setState(() {});
  }

  Widget _judgeWidge() {
    Widget _widget = Container();
    if (url != null) {
      _widget = Padding(
          padding: EdgeInsets.symmetric(vertical: size.width * 10),
          child: FadeInImage(
            placeholder: AssetImage('assets/images/image_recent_control.jpg'),
            image: NetworkImage(
              url.toString().indexOf('http:') > -1
                  ? url
                  : Interface.fileUrl + url,
            ),
            height: size.width * 100,
          ));
    } else {
      if (widget.url.toString().indexOf('http') > -1) {
        _widget = Padding(
            padding: EdgeInsets.symmetric(vertical: size.width * 10),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/image_recent_control.jpg'),
              image: NetworkImage(
                widget.url.toString().indexOf('http:') > -1
                    ? widget.url
                    : Interface.fileUrl + widget.url,
              ),
              height: size.width * 100,
            ));
      }
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            widget.widget == null
                ? Expanded(
                    child: Text(
                    '签字',
                    style: TextStyle(
                        fontSize: size.width * 28, fontWeight: FontWeight.w500),
                  ))
                : Container(),
            widget.widget == null
                ? Text(
                    DateTime.now()
                        .toString()
                        .substring(0, DateTime.now().toString().length - 10),
                    style: TextStyle(
                        fontSize: size.width * 28,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7F8A9C)),
                  )
                : Container(),
          ],
        ),
        Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign', arguments: {
                  "purview": widget.purview,
                  'title': widget.title
                }).then((value) {
                  generateImg();
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: size.width * 20),
                constraints: BoxConstraints(minHeight: size.width * 240),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 8)),
                    border: widget.widget == null
                        ? Border.all(
                            width: size.width * 2, color: Color(0xffF2F2F2))
                        : Border.all(width: 0, color: Colors.transparent)),
                width: double.infinity,
                child: _judgeWidge(),
              ),
            ),
            Positioned(
              child: widget.widget == null
                  ? Icon(
                      Icons.create,
                      color: placeHolder,
                      size: size.width * 24,
                    )
                  : widget.widget,
              bottom: widget.widget == null ? size.width * 24 : 0,
              right: widget.widget == null ? size.width * 24 : size.width * 20,
            ),
          ],
        ),
      ],
    );
  }
}
