import 'package:enterprise/common/Refre.dart';
import 'package:enterprise/common/loding.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';

// you should add to top Expanded  or  most Top
class MyRefres extends StatefulWidget {
  MyRefres(
      {Key key,
      @required this.child,
      @required this.url,
      @required this.method,
      this.padding,
      this.data,
      Map queryParameters,
      this.page = false,
      this.callback,
      this.listParam = '',
      this.throwFunc, this.type})
      : queryParameters = queryParameters ?? {};
  final EdgeInsets padding;
  final Map queryParameters; // contains size
  final String url, method, listParam, type;
  final bool page;
  final ThrowFunc throwFunc;
  final List data;
  final Function(dynamic data) callback;
  final Widget Function(int index, List data) child;
  @override
  _MyRefresState createState() => _MyRefresState();
}

class _MyRefresState extends State<MyRefres> {
  List data = [];
  int page = 1;
  bool scroll = false;
  Map queryParameters;
  bool _init = true;
  Function _updata = () {};
  _setQueryParameters({Map argument}) {
    if (argument != null) {
      queryParameters = argument;
    }
    _init = true;
    _updata();
  }

  @override
  void initState() {
    super.initState();
    queryParameters = widget.queryParameters;
    widget.throwFunc?.init([_setQueryParameters]);
  }

  // ignore: missing_return
  Future<bool> _getData({bool fresh = false, bool clear = false}) async {
    if (widget.data is List) {
      data = widget.data;
      _init = false;
    } else {
      if (clear) {
        data.clear();
        setState(() {});
        return true;
      }
      if (widget.page) {
        if (queryParameters == null) {
          queryParameters = {"current": page.toString(), "size": '30'};
        } else {
          queryParameters['current'] = page.toString();
          queryParameters['size'] = 30.toString();
        }
      }
      if (!fresh) {
        page = 1;
      }
      myDio
          .request(
              type: widget.method,
              url: widget.url,
              queryParameters: widget.method == 'get'
                  ? Map<String, dynamic>.from(queryParameters)
                  : null,
              data: widget.method == 'post'
                  ? Map<String, dynamic>.from(queryParameters)
                  : null)
          .then((value) {
        if (widget.listParam != '') {
          if (value[widget.listParam] is List) {
            if (queryParameters != null && queryParameters['size'] != null) {
              if (value['total'] <= page * 30) {
                scroll = false;
              } else {
                scroll = true;
              }
            }
            if (!fresh) {
              data = value[widget.listParam];
            } else {
              data.addAll(value[widget.listParam]);
            }
          }
        } else {
          data = value;
          scroll = false;
        }

        if (widget.callback != null) {
          widget.callback(data);
        }
        _init = false;
        if (mounted) {
          setState(() {});
        }
      }).catchError((error) {
        setState(() {
          _init = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Refre(
        initRefresh: false,
        fisetRequest: true,
        child: (child, start, end, updata) {
          _updata = updata;
          return _init
              ? StaticLoding()
              : Column(
                  children: [
                    child,
                    data.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                            // physics: AlwaysScrollableScrollPhysics(),
                            padding: widget.padding ?? EdgeInsets.all(0),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              if (index == data.length - 1 && data.length > 0) {
                                if (scroll) {
                                  page++;
                                  _getData(fresh: true);
                                  scroll = false;
                                }
                              }
                              return widget.child(index, data);
                            },
                          ))
                        : Expanded(
                            child: ListView(children: [
                            SizedBox(height: 150),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/empty@2x.png",
                                  height: size.width * 288,
                                  width: size.width * 374,
                                ),
                                Text('暂无数据')
                              ],
                            ),
                          ]))
                  ],
                );
        },
        onRefresh: () async {
          page = 1;
          await _getData();
        });
  }
}
