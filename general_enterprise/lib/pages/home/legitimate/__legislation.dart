import 'package:enterprise/common/empty.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Legislation extends StatefulWidget {
  @override
  _Legislation createState() => _Legislation();
}

class _Legislation extends State<Legislation> {
  final controller = TextEditingController();
  final int id = 1;
  @override
  void initState() {
    super.initState();
    myDio.request(type: 'get', url: Interface.legislation).then((value) {
      legislationList = value['records'];
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  bool isPlan = false;

  Future<Null> _handlerRefresh() async {
    myDio.request(type: 'get', url: Interface.legislation).then((value) {
      legislationList = value['records'];
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
    return null;
  }

  List legislationList = [];

  _searchLegislation(String keywords) {
    myDio.request(
        type: 'get',
        url: Interface.legislation,
        queryParameters: {"keywords": keywords}).then((value) {
      if (value != null) {
        legislationList = value['records'];
      }
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Counter _context = Provider.of<Counter>(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            height: size.width * 130,
            child: Padding(
              padding: EdgeInsets.all(6.0),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: size.width * 20),
                      width: size.width * 350,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: '搜索您的关键字',
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          _searchLegislation(value);
                          _context.legislationSearch(value);
                        },
                        // onChanged: onSearchTextChanged,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          legislationList.isNotEmpty
              ? Expanded(
                  child: RefreshIndicator(
                    //child: Expanded(
                    child: ListView.builder(
                        itemCount: legislationList.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (builder, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            // InkWell 添加 Material 触摸水波效果
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/legitimate/_lawDetails',
                                    arguments: {
                                      'id': legislationList[index]['id'],
                                    });
                              },
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Column(
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new Text(
                                            legislationList[index]['titleName'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * 28,
                                            ),
                                          ),
                                          Spacer(flex: 1),
                                          new Text(
                                            legislationList[index]
                                                ['modifyDate'],
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: size.width * 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      new Container(
                                        height: 2,
                                        margin: EdgeInsets.only(
                                            top: size.width * 10,
                                            bottom: size.width * 13.5),
                                        decoration: BoxDecoration(
                                          color: Color(0xffF2F3F8),
                                          border: Border.all(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                255, 255, 255, .2),
                                          ),
                                        ),
                                      ),
                                      new Column(
                                        children: <Widget>[
                                          new Text(
                                            legislationList[index]['content'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                      new Container(
                                        height: 2,
                                        margin: EdgeInsets.only(
                                            top: size.width * 25,
                                            bottom: size.width * 5),
                                        decoration: BoxDecoration(
                                          color: Color(0xffF2F3F8),
                                          border: Border.all(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                255, 255, 255, .2),
                                          ),
                                        ),
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new Text(
                                            "查看详情",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: size.width * 24,
                                            ),
                                          ),
                                          Spacer(flex: 1),
                                          Icon(Icons.keyboard_arrow_down,
                                              color: placeHolder),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    // 刷新方法
                    onRefresh: () => _handlerRefresh(),
                  ),
                )
              : Empty()
                
        ],
      ),
    );
  }
}
