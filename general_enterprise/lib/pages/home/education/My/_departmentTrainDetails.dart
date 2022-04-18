import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class DepartmentTrainDetails extends StatefulWidget {
  DepartmentTrainDetails({this.id, this.throwFunc, this.planId, this.stage});
  final int id, planId, stage;
  final ThrowFunc throwFunc;
  @override
  _DepartmentTrainDetailsState createState() => _DepartmentTrainDetailsState();
}

class _DepartmentTrainDetailsState extends State<DepartmentTrainDetails> {
  @override
  void initState() {
    super.initState();
    widget.throwFunc.detailInit(_getdata);
  }

  _getdata({dynamic argument}) {
    // 人员id
    myDio.request(
      type: "get",
      url: Interface.getEduSchedule + argument['id'].toString(),
      queryParameters: {
        'stage': widget.stage,
        'planId': widget.planId
      }
    ).then((value) {
      if(value is Map){
        compulsoryList = value['completedStatus'];
        electiveList = value['unStatus'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  List compulsoryList = [];

  List electiveList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                vertical: size.width * 20, horizontal: size.width * 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_textbook_type.png',
                      width: size.width * 30,
                      height: size.width * 30,
                    ),
                    SizedBox(
                      width: size.width * 30,
                    ),
                    Text(
                      '已完成教材',
                      style: TextStyle(
                          fontSize: size.width * 28,
                          color: Color(0xffA3A3A3),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Column(
                    children: compulsoryList
                        .asMap()
                        .keys
                        .map((index) => Container(
                                    margin: EdgeInsets.symmetric(vertical: size.width * 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            height: size.width * 192,
                                            width: size.width * 255,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(
                                                          size.width * 10)),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  compulsoryList[index]['coverUrl'],
                                                ),
                                              ),
                                            ),
                                            // alignment: Alignment.bottomCenter,
                                            // child: Container(
                                            //   width: double.infinity,
                                            //   height: size.width * 57,
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.black
                                            //         .withOpacity(0.3),
                                            //     borderRadius: BorderRadius.only(
                                            //         bottomLeft: Radius.circular(
                                            //             size.width * 10)),
                                            //   ),
                                            //   alignment: Alignment.center,
                                            //   child: Row(
                                            //     mainAxisAlignment: MainAxisAlignment.center,
                                            //     children: [
                                            //       Image.asset(
                                            //         'assets/images/icon_star.png',
                                            //         width: size.width * 30,
                                            //         height: size.width * 30,
                                            //       ),
                                            //       SizedBox(
                                            //         width: size.width * 10,
                                            //       ),
                                            //       Text(
                                            //         compulsoryList[index]['scores'].toString() + '分',
                                            //         style: TextStyle(
                                            //           color: Color(0xffffc811),
                                            //           fontSize: size.width * 26,
                                            //           fontWeight: FontWeight.bold
                                            //         ),
                                            //       )
                                            //     ],
                                            //   )
                                            // ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 20,
                                              vertical: size.width * 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: size.width * 280,
                                                child: Text(compulsoryList[index]['title'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 26,
                                                        color:
                                                            Color(0xff333333),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Container(
                                                    width: size.width * 280,
                                                    child: Text(
                                                        compulsoryList[index]['introduction'],
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.width * 22,
                                                          color:
                                                              Color(0xff666666),
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: size.width * 230,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              true,
                                                          builder: (BuildContext
                                                              context) {
                                                            return ShowDialog(
                                                                child: Center(
                                                              child: Container(
                                                                height:
                                                                    size.width *
                                                                        500,
                                                                width:
                                                                    size.width *
                                                                        690,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(size.width *
                                                                            10))),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
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
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              size: size.width * 40,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        compulsoryList[index]['title'],
                                                                        style: TextStyle(
                                                                            fontSize: size.width *
                                                                                36,
                                                                            color:
                                                                                Color(0xff0059FF),
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            size.width *
                                                                                30,
                                                                      ),
                                                                      Text(
                                                                        compulsoryList[index]['introduction']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: size.width *
                                                                                30,
                                                                            color:
                                                                                Color(0xff9D9D9D)),
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
                                                          color:
                                                              Color(0xff3869FC),
                                                          fontSize:
                                                              size.width * 24),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                      )
                        .toList()),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                vertical: size.width * 20, horizontal: size.width * 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_textbook_type.png',
                      width: size.width * 30,
                      height: size.width * 30,
                    ),
                    SizedBox(
                      width: size.width * 30,
                    ),
                    Text(
                      '未完成教材',
                      style: TextStyle(
                          fontSize: size.width * 28,
                          color: Color(0xffA3A3A3),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 20,
                ),
                Column(
                    children: electiveList
                        .asMap()
                        .keys
                        .map((index) => Container(
                                    margin: EdgeInsets.symmetric(vertical: size.width * 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width * 10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            height: size.width * 192,
                                            width: size.width * 255,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(
                                                          size.width * 10)),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  electiveList[index]['coverUrl'],
                                                ),
                                              ),
                                            ),
                                            // alignment: Alignment.bottomCenter,
                                            // child: Container(
                                            //   width: double.infinity,
                                            //   height: size.width * 57,
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.black
                                            //         .withOpacity(0.3),
                                            //     borderRadius: BorderRadius.only(
                                            //         bottomLeft: Radius.circular(
                                            //             size.width * 10)),
                                            //   ),
                                            //   alignment: Alignment.center,
                                            //   child: Row(
                                            //     mainAxisAlignment: MainAxisAlignment.center,
                                            //     children: [
                                            //       Image.asset(
                                            //         'assets/images/icon_star.png',
                                            //         width: size.width * 30,
                                            //         height: size.width * 30,
                                            //       ),
                                            //       SizedBox(
                                            //         width: size.width * 10,
                                            //       ),
                                            //       Text(
                                            //         electiveList[index]['scores'].toString() + '分',
                                            //         style: TextStyle(
                                            //           color: Color(0xffffc811),
                                            //           fontSize: size.width * 26,
                                            //           fontWeight: FontWeight.bold
                                            //         ),
                                            //       )
                                            //     ],
                                            //   )
                                            // ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 20,
                                              vertical: size.width * 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: size.width * 280,
                                                child: Text(electiveList[index]['title'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 26,
                                                        color:
                                                            Color(0xff333333),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Container(
                                                    width: size.width * 280,
                                                    child: Text(
                                                        electiveList[index]['introduction'],
                                                        style: TextStyle(
                                                          fontSize:
                                                              size.width * 22,
                                                          color:
                                                              Color(0xff666666),
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: size.width * 230,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              true,
                                                          builder: (BuildContext
                                                              context) {
                                                            return ShowDialog(
                                                                child: Center(
                                                              child: Container(
                                                                height:
                                                                    size.width *
                                                                        500,
                                                                width:
                                                                    size.width *
                                                                        690,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(size.width *
                                                                            10))),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
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
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              size: size.width * 40,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        electiveList[index]['title'],
                                                                        style: TextStyle(
                                                                            fontSize: size.width *
                                                                                36,
                                                                            color:
                                                                                Color(0xff0059FF),
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            size.width *
                                                                                30,
                                                                      ),
                                                                      Text(
                                                                        electiveList[index]['introduction']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: size.width *
                                                                                30,
                                                                            color:
                                                                                Color(0xff9D9D9D)),
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
                                                          color:
                                                              Color(0xff3869FC),
                                                          fontSize:
                                                              size.width * 24),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          )
                        .toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
