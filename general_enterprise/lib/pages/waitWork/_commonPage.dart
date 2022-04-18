import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WaitCommonPage extends StatefulWidget {
  WaitCommonPage({
    this.url,
    this.title,
    // this.buttonList,
    // this.dropList,
    this.widget,
    this.name,
  });
  final String url, title, name;
  // final List buttonList, dropList;
  final Widget Function(dynamic value, Function fun) widget;
  @override
  _WaitCommonPageState createState() => _WaitCommonPageState();
}

class _WaitCommonPageState extends State<WaitCommonPage> {
  List data = [];
  ScrollController _controller = ScrollController();
  int page = 1;
  List dropList = [];
  bool scroll = true;
  @override
  void initState() {
    super.initState();
    // if (widget.dropList is List) {
    //   dropList = widget.dropList;
    //   _getDropList();
    // }
    // dropList.forEach((element) {
    //   element['title'] = element['saveTitle'];
    // });
    _getData();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (scroll) {
          ++page;
          _getData();
        }
      }
    });
  }

  Map<String, dynamic> queryParameters = {"current": 1, 'size': 30};

  _getData() {
    if (widget.url == '' || null == widget.url) return;
    queryParameters['current'] = page;
    // data = [];
    myDio
        .request(type: 'get', url: widget.url, queryParameters: queryParameters)
        .then((value) {
      if (value is List) {
        data = value;
        scroll = false;
      } else if (value is Map) {}
      if (mounted) {
        setState(() {});
      }
    });
  }

  // ignore: unused_element
  _getDropList() {
    for (var i = 0; i < dropList.length; i++) {
      myDio.request(type: 'get', url: dropList[i]['dataUrl']).then((value) {
        dropList[i]['data'] = value;
        dropList[i]['data'].insert(0, {"name": "查看全部"});
      });
    }
  }

  //filter illegal ele
  filterData(List data) {
    for (var i = 0; i < data.length; i++) {
      Map it = data[i];
      if (!it.containsKey("workUnit")) {
        data.removeAt(i--);
      }
    }
  }

  _getDataList({int index, String msg}) {
    dropList.forEach((element) {
      if (element['value'] != '' && element['value'] != '查看全部') {
        queryParameters[element['limit']] = element['value'];
      } else {
        queryParameters[element['limit']] = null;
      }
    });

    page = 1;
    data = [];
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.title),
      child: Column(
        children: [
          TitleChoose(
            list: dropList,
            getDataList: _getDataList,
          ),
          Expanded(
            child: RefreshIndicator(
              child: data.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.all(size.width * 30),
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 20,
                                vertical: size.width * 30),
                            margin: EdgeInsets.only(bottom: size.width * 30),
                            decoration: BoxDecoration(color: Colors.white),
                            child: widget.widget(data[index], _getData));
                      },
                      itemCount: data.length,
                      controller: _controller,
                    )
                  : Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: size.width * 300),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/empty@2x.png",
                            height: size.width * 288,
                            width: size.width * 374,
                          ),
                          Text('暂无数据'),
                        ],
                      )),
              onRefresh: () async {
                page = 1;
                _getData();
              },
            ),
          )
        ],
      ),
    );
  }
}

// {
//       'title': '相关作业',
//       'data': [
//         // 1 与我相关
//         {'name': '所有作业'},
//         {'name': '与我相关'},
//       ],
//       'value': '',
//       "saveTitle": '相关作业',
//       // 'dataUrl': Interface.dropTerritorialUnitList
//       'limit': 'type'
//     },
class TitleChoose extends StatefulWidget {
  TitleChoose({this.list, this.getDataList});
  final List list;
  final ReturnIntStringCallback getDataList;
  @override
  _TitleChooseState createState() => _TitleChooseState();
}

class _TitleChooseState extends State<TitleChoose> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: underColor, width: 1))),
      child: Row(
          children: widget.list.asMap().keys.map((i) {
        return Expanded(
            child: GestureDetector(
          onTap: () {
            Color _juegeColor(Map _ele) {
              if (widget.list[i]['id'] == null) {
                widget.list[i]['id'] = -1;
              }
              Color _color = Colors.white;
              if (widget.list[i]['value'] == '' && _ele['name'] == '查看全部') {
                _color = themeColor;
              } else {
                if (widget.list[i]['id'] == _ele['id']) {
                  _color = themeColor;
                } else {
                  _color = Colors.white;
                }
              }

              return _color;
            }

            if (widget.list[i]['data'].isEmpty) {
              Fluttertoast.showToast(msg: '没有数据');
              return;
            }
            showModalBottomSheet(
                context: context,
                builder: (_) {
                  return SingleChildScrollView(
                    child: Column(
                      children: widget.list[i]['data'].map<Widget>((_ele) {
                        Color _conColors = _juegeColor(_ele);
                        return GestureDetector(
                          onTap: () {
                            widget.list[i]['value'] = _ele['name'];
                            if (_ele['name'] == '查看全部') {
                              widget.list[i]['title'] =
                                  widget.list[i]['saveTitle'];
                              widget.list[i]['id'] = _ele['id'];
                            } else {
                              widget.list[i]['title'] = _ele['name'];
                              widget.list[i]['id'] = _ele['id'];
                            }

                            widget.getDataList(index: i);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: size.width * 20),
                            decoration: BoxDecoration(
                                color: _conColors,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: underColor))),
                            child: Center(
                              child: Text(
                                _ele['name'],
                                style: TextStyle(
                                    fontSize: size.width * 30,
                                    color: _conColors.toString() ==
                                            'Color(0xff2674fd)'
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );

                  // return
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.black.withOpacity(0.3),
                  //   ),
                  //   child: Column(
                  //     children: <Widget>[
                  //       Container(
                  //         constraints: BoxConstraints(
                  //             // maxHeight: showHeight / 2,
                  //             ),
                  //         child: SingleChildScrollView(
                  //           child: Column(
                  //             children: widget.list[index * 4 + _index]
                  //                     ['data']
                  //                 .map<Widget>((_ele) {
                  //               Color _juegeColor() {
                  //                 Color _color =
                  //                     widget.list[index * 4 + _index]
                  //                                     ['value'] ==
                  //                                 '' &&
                  //                             _ele['name'] == '查看全部'
                  //                         ? themeColor
                  //                         : widget.list[index * 4 + _index]
                  //                                     ['value'] ==
                  //                                 _ele['name']
                  //                             ? themeColor
                  //                             : Colors.white;
                  //                 return _color;
                  //               }

                  //               Color _conColors = _juegeColor();
                  //               return GestureDetector(
                  //                 onTap: () {
                  //                   widget.list[index * 4 + _index]
                  //                       ['value'] = _ele['name'];
                  //                   if (_ele['name'] == '查看全部') {
                  //                     widget.list[index * 4 + _index]
                  //                             ['title'] =
                  //                         widget.list[index * 4 + _index]
                  //                             ['saveTitle'];
                  //                   } else {
                  //                     widget.list[index * 4 + _index]
                  //                         ['title'] = _ele['name'];
                  //                   }
                  //                   setState(() {});
                  //                   widget.getDataList(
                  //                       index: index * 4 + _index);
                  //                   Navigator.pop(context);
                  //                 },
                  //                 child: Container(
                  //                   padding: EdgeInsets.symmetric(
                  //                       vertical: width * 32),
                  //                   decoration: BoxDecoration(
                  //                       color: _conColors,
                  //                       border: Border(
                  //                           bottom: BorderSide(
                  //                               width: 1,
                  //                               color: underColor))),
                  //                   child: Center(
                  //                     child: Text(
                  //                       _ele['name'].toString(),
                  //                       // _conColors.toString(),
                  //                       style: TextStyle(
                  //                           fontSize: width * 30,
                  //                           color: _conColors.toString() ==
                  //                                   'Color(0xff6ea3f9)'
                  //                               ? Colors.white
                  //                               : Colors.black),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //             }).toList(),
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(child: GestureDetector(
                  //         onTap: () {
                  //           Navigator.pop(context);
                  //         },
                  //       ))
                  //     ],
                  //   ),
                  // );
                });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top:
                        BorderSide(width: 1, color: underColor.withOpacity(.2)),
                    right:
                        BorderSide(width: 1, color: underColor.withOpacity(.2)),
                  )),
              padding: EdgeInsets.all(size.width * 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.list[i]['title'].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: size.width * 30),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right)
                ],
              )),
        ));
      }).toList()),
    );
  }
}
