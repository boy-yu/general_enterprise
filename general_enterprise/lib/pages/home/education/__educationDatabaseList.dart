import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
 *  知识库列表 
 */
class EducationDatabaseList extends StatefulWidget {
  EducationDatabaseList({this.title, this.kBIndex, this.callback});
  final String title;
  final int kBIndex;
  final Function callback;
  @override
  _EducationDatabaseListState createState() => _EducationDatabaseListState();
}

class _EducationDatabaseListState extends State<EducationDatabaseList> {
  final controller = TextEditingController();
  List educationDatabaseList = [];

  @override
  void initState() {
    super.initState();
    _searchEducation();
  }

  Future<Null> _handlerRefresh() async {
    myDio.request(
        type: 'get',
        url: Interface.getKnowledgeBase,
        queryParameters: {
          "kBIndex": widget.kBIndex,
          "current": 1,
          "size": 1000
        }).then((value) {
      if (value != null) {
        educationDatabaseList = value['records'];
      }
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
    return null;
  }

  _searchEducation({String keywords}) {
    myDio.request(
        type: 'get',
        url: Interface.getKnowledgeBase,
        queryParameters: {
          "kBIndex": widget.kBIndex,
          "keywords": keywords,
          "current": 1,
          "size": 1000
        }).then((value) {
      if (value != null) {
        educationDatabaseList = value['records'];
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
    return MyAppbar(
      title: Text(widget.title),
      child: Padding(
        padding: EdgeInsets.all(size.width * 10),
        child: Column(children: <Widget>[
          Container(
            height: size.width * 130,
            child: Padding(
              padding: EdgeInsets.all(size.width * 6),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: size.width * 20),
                      width: size.width * 200,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: '搜索关键字',
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          _searchEducation(keywords: value);
                          _context.educationSearch(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              '提示：请输入化学品中文名、俗名、英文名称或CAS号',
              style: TextStyle(
                  color: Color(0xff333333), fontSize: size.width * 22),
            ),
          ),
          Expanded(
              child: RefreshIndicator(
            //child: Expanded(
            child: ListView.builder(
                itemCount: educationDatabaseList.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (builder, index) {
                  return InkWell(
                    onTap: () {
                      widget.kBIndex == 3
                          ? Navigator.of(context).pushNamed(
                              '/home/education/educationDatabase',
                              arguments: {
                                  "name": educationDatabaseList[index]
                                      ['processName'],
                                  "kBIndex": widget.kBIndex
                                }).then((value) {
                              // 返回值
                            })
                          : Navigator.of(context).pushNamed(
                              '/home/education/educationDatabaseMSDS',
                              arguments: {
                                  "name": educationDatabaseList[index]
                                      ['chemicalCnName'],
                                  "kBIndex": widget.kBIndex
                                }).then((value) {
                              // 返回值
                            });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 10,
                          vertical: size.width * 5),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 30,
                              vertical: size.width * 15),
                          child: widget.kBIndex == 3
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        educationDatabaseList[index]
                                            ['processName'],
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            '反应类型：',
                                            style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: size.width * 26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            educationDatabaseList[index]
                                                ['reactionType'],
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      educationDatabaseList[index]
                                          ['chemicalCnName'],
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontSize: size.width * 36,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '俗名：',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 26),
                                        ),
                                        Text(
                                          educationDatabaseList[index]
                                              ['chemicalCnNameTwo'],
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: size.width * 26),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.width * 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '英文名称：',
                                          style: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: size.width * 26),
                                        ),
                                        Expanded(
                                          child: Text(
                                            educationDatabaseList[index]
                                                ['chemicalEnName'],
                                            style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: size.width * 26),
                                          ),
                                        )
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
          )),
        ]),
      ),
    );
  }
}
