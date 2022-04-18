import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myConfirmDialog.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myDrop.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CancelWork extends StatelessWidget {
  CancelWork({this.arguments});

  // id    work id
  final Map descripe = {
    'title': '申请取消原因',
    'type': 'choose',
    "data": [
      {
        "name": "恶劣天气",
      },
      {
        "name": "生产协调",
      },
      {
        "name": "其它",
        "addtion": {
          'title': '内部作业',
          'type': 'input',
          "data": [],
          // "dataUrl": 'generalUrl/internal'
        }
      }
    ]
  };
  final arguments;

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    Counter contexts = Provider.of<Counter>(context);
    return MyAppbar(
      title: Text('取消作业'),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(width * 30),
                padding: EdgeInsets.all(width * 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 20)),
                child: Column(
                  children: [
                    MyDrop(
                      title: descripe['title'],
                      data: descripe['data'],
                      purview: '取消作业',
                      callSetstate: () {},
                    ),
                    SizedBox(
                      height: width * 136,
                    ),
                    CancelSign(),
                  ],
                )),
            SizedBox(
              height: width * 200,
            ),
            Container(
              margin: EdgeInsets.all(width * 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: lineGradBlue),
                borderRadius: BorderRadius.all(Radius.circular(43)),
              ),
              height: width * 85,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(43),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Colors.transparent,
                  )),
                  onPressed: () {
                    bool next = true;
                    if (contexts.submitDates['取消作业'].length < 2) {
                      next = false;
                      Fluttertoast.showToast(
                          msg: '请填写完整', webPosition: 'center');
                    }
                    contexts.submitDates['取消作业'].forEach((ele) {
                      if (ele['value'] == '') {
                        next = false;
                        Fluttertoast.showToast(
                            msg: '请输入${ele["title"]}', webPosition: 'center');
                      }
                    });
                    if (next) {
                      showDialog(
                          context: context,
                          builder: (_) => MyDialog(
                                title: '',
                                content: '是否确定取消此次作业',
                                okCallBack: () {
                                  print(contexts.submitDates);
                                  var sign;
                                  var reason;
                                  var params = contexts.submitDates['取消作业'];
                                  for (var map in params) {
                                    var title = map["title"];
                                    if (title == "签字") {
                                      sign = map["value"];
                                    } else {
                                      reason = map["value"];
                                    }
                                  }
                                  myDio.request(
                                      type: 'post',
                                      url: Interface.postCancelWorkApply,
                                      data: {
                                        "id": arguments['id'],
                                        "applicantSignature": sign,
                                        "applicantReason": reason,
                                      }).then((value) {
                                    // print(value);
                                    Fluttertoast.showToast(
                                        msg: '取消成功', webPosition: 'center');
                                    Navigator.pop(context);
                                  }).catchError((onError) {
                                    Interface().error(onError, context);
                                  });
                                },
                                rightText: '确定',
                                leftText: '取消',
                              ));
                    }
                  },
                  child: Center(
                      child: Text(
                    '确认提交',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
            image: NetworkImage(url),
            height: size.width * 100,
          ));
    } else {
      if (widget.url.toString().indexOf('http') > -1) {
        _widget = Padding(
            padding: EdgeInsets.symmetric(vertical: size.width * 10),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/image_recent_control.jpg'),
              image: NetworkImage(widget.url),
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
                    style: TextStyle(fontSize: size.width * 30),
                  ))
                : Container(),
            widget.widget == null
                ? Text(
                    DateTime.now()
                        .toString()
                        .substring(0, DateTime.now().toString().length - 10),
                    style: TextStyle(fontSize: size.width * 24),
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
                constraints: BoxConstraints(minHeight: size.width * 160),
                decoration: BoxDecoration(
                    border: widget.widget == null
                        ? Border.all(width: 1, color: underColor)
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
                      size: size.width * 30,
                    )
                  : widget.widget,
              bottom: widget.widget == null ? 20 : 0,
              right: widget.widget == null ? 20 : size.width * 20,
            ),
          ],
        ),
      ],
    );
  }
}
