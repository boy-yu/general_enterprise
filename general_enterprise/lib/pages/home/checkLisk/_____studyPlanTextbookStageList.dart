import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class StudyPlanTextbookStageList extends StatefulWidget {
  StudyPlanTextbookStageList({this.title, this.id, this.type});
  final String title;
  final int id, type;
  @override
  _StudyPlanTextbookStageListState createState() =>
      _StudyPlanTextbookStageListState();
}

class _StudyPlanTextbookStageListState
    extends State<StudyPlanTextbookStageList> {
  ThrowFunc _throwFunc = new ThrowFunc();

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.title.toString()),
      child: Container(
        color: Colors.white,
        child: MyRefres(
          child: (index, list) => Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                            child: Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_textbook_type.png',
                        width: size.width * 21,
                        height: size.width * 26,
                      ),
                      SizedBox(
                        width: size.width * 22,
                      ),
                      Text(
                        '第' + (index + 1).toString() + '阶段必修教材',
                        style: TextStyle(
                            fontSize: size.width * 28,
                            color: Color(0xff404040),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),),
                  list[index].isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                          physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                          itemCount: list[index].length,
                          itemBuilder: (context, _index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    '/home/education/study',
                                    arguments: {
                                      'id': list[index][_index]['resourcesId'],
                                      'submitStudyRecords': {
                                        "planId": widget.id,
                                        "resourcesId": list[index][_index]['resourcesId'],
                                        // "type": 1,
                                        "stage": index + 1
                                      }
                                    }).then((value) {
                                  _throwFunc.run();
                                  // 返回值
                                });
                              },
                              child: Container(
                                // margin: EdgeInsets.symmetric(
                                //     vertical: size.width * 15),
                                margin: EdgeInsets.symmetric(
                            vertical: size.width * 20,
                            horizontal: size.width * 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0)
                                    ]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    
                                    Container(
                                      color: Colors.black,
                                      margin: EdgeInsets.symmetric(horizontal: size.width * 28, vertical: size.width * 16),
                                      child: Image.network(
                                        list[index][_index]['coverUrl'],
                                        height: size.width * 125,
                                        width: size.width * 200,
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 300,
                                      padding: EdgeInsets.symmetric(vertical: size.width * 10),
                                      child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                                  list[index][_index]['title'],
                                                  style: TextStyle(
                                                      color: Color(0xff404040),
                                                      fontSize: size.width * 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                        SizedBox(
                                          height: size.width * 10,
                                        ),
                                        Text(
                                                  list[index][_index]
                                                      ['introduction'],
                                                  style: TextStyle(
                                                      fontSize: size.width * 20,
                                                      color: Color(0xff404040)),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                        SizedBox(
                                          height: size.width * 10,
                                        ),
                                        Text(
                                              '本教材包含${list[index][_index]['classHours']}个课时',
                                              style: TextStyle(
                                                  fontSize: size.width * 20,
                                                  color: Color(0xff3074FF)),
                                            ),
                                      ],
                                    ),
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Image.asset(
                                          // 1: 已完成
                                            list[index][_index]['status'] == 1 ? 'assets/images/e58e8165c9b4a089d9ae3fa1731b2e9.png' : 'assets/images/7a3a9e432ba3e01dd0448c12b116e0c.png',
                                            width: size.width * 75,
                                            height: size.width * 75,
                                          ),
                                          SizedBox(
                                            height: size.width * 30,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return ShowDialog(
                                                          child: Center(
                                                        child: Container(
                                                          height:
                                                              size.width * 500,
                                                          width:
                                                              size.width * 690,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(
                                                                      size.width *
                                                                          10))),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        size.width *
                                                                            20,
                                                                    vertical:
                                                                        size.width *
                                                                            10),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Spacer(),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        size: size.width *
                                                                            40,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Text(
                                                                  list[index][
                                                                          _index]
                                                                      ['title'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          size.width *
                                                                              36,
                                                                      color: Color(
                                                                          0xff0059FF),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      size.width *
                                                                          30,
                                                                ),
                                                                Text(
                                                                  '学习计划主要内容：${list[index][_index]['introduction']}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          size.width *
                                                                              30,
                                                                      color: Color(
                                                                          0xff9D9D9D)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                    });
                                              },
                                              child: Text(
                                                '[详情]',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                    color: Color(0xff1D3DEB),
                                                    fontSize: size.width * 20),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      : Container(
                          child: Text('暂无教材'),
                        ),
                ],
              ),
          throwFunc: _throwFunc,
          url: Interface.getMyListPlanStageById,
          queryParameters: {
            'planId': widget.id,
            "isYear": widget.type,
          },
          method: 'get'),
      ),
    );
  }
}
