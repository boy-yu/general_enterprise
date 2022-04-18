import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EduCollectList extends StatefulWidget {
  @override
  _EduCollectListState createState() => _EduCollectListState();
}

class _EduCollectListState extends State<EduCollectList> {
  ThrowFunc _throwFunc = ThrowFunc();

  // 取消收藏
  _deleteFavoritesResources(int resourcesId) {
    myDio.request(
        type: "delete",
        url: Interface.postDeleteFavoritesResources,
        data: {'resourcesId': resourcesId}).then((value) {
      Fluttertoast.showToast(msg: '取消收藏');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('我的收藏'),
      child: MyRefres(
          child: (index, list) => Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 20, vertical: size.width * 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1.0,
                        spreadRadius: 1.0),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/home/education/study', arguments: {
                          'id': list[index]['id'],
                        }).then((value) {
                          // 返回值
                        });
                      },
                      child: Container(
                        height: size.width * 166,
                        width: size.width * 277,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(size.width * 10)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              list[index]['coverUrl'],
                            ),
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: size.width * 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(size.width * 10)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '开始学习',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 20,
                          vertical: size.width * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: size.width * 325,
                                  child: Text(list[index]['title'],
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(
                                  width: size.width * 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // 取消收藏
                                    _deleteFavoritesResources(list[index]['id']);
                                    _throwFunc.run();
                                  },
                                  child: Image.asset(
                                    'assets/images/icon_edu_shoucang_isxx@2x.png',
                                    width: size.width * 34,
                                    height: size.width * 34,
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: size.width * 300,
                                child: Text(list[index]['introduction'],
                                    style: TextStyle(
                                      fontSize: size.width * 22,
                                      color: Color(0xff666666),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(
                                width: size.width * 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return ShowDialog(
                                            child: Center(
                                          child: Container(
                                            height: size.width * 500,
                                            width: size.width * 690,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 10))),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * 20,
                                                  vertical: size.width * 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Icon(
                                                          Icons.clear,
                                                          size: size.width * 40,
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    list[index]['title'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 36,
                                                        color:
                                                            Color(0xff0059FF),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: size.width * 30,
                                                  ),
                                                  Text(
                                                    list[index]['introduction']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 30,
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
                                      color: Color(0xff3869FC),
                                      fontSize: size.width * 24),
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
          // Container(
          //       padding: EdgeInsets.symmetric(horizontal: size.width * 15, vertical: size.width * 10),
          //       margin: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 15),
          //       decoration: BoxDecoration(
          //         borderRadius:
          //             BorderRadius.all(Radius.circular(size.width * 20)),
          //         color: Colors.white
          //       ),
          //       child: Row(
          //         children: [
          //           Image.network(
          //             list[index]['coverUrl'],
          //             height: size.width * 128,
          //             width: size.width * 180,
          //           ),
          //           SizedBox(
          //             width: size.width * 20,
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 list[index]['title'],
          //                 style: TextStyle(
          //                     color: Color(0xff333333),
          //                     fontSize: size.width * 24,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //               SizedBox(
          //                 height: size.width * 10,
          //               ),
          //               Row(
          //                 crossAxisAlignment: CrossAxisAlignment.end,
          //                 children: [
          //                   Container(
          //                     width: size.width * 230,
          //                     child: Text(list[index]['introduction'],
          //                         style: TextStyle(
          //                             fontSize: size.width * 20,
          //                             color: Color(0xff666666)),
          //                         maxLines: 2,
          //                         overflow: TextOverflow.ellipsis),
          //                   ),
          //                   SizedBox(
          //                     width: size.width * 10,
          //                   ),
          //                   InkWell(
          //                     onTap: () {
          //                       showDialog(
          //                           context: context,
          //                           barrierDismissible: true,
          //                           builder: (BuildContext context) {
          //                             return ShowDialog(
          //                                 child: Center(
          //                               child: Container(
          //                                 height: size.width * 500,
          //                                 width: size.width * 690,
          //                                 decoration: BoxDecoration(
          //                                     color: Colors.white,
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(
          //                                             size.width * 10))),
          //                                 child: Padding(
          //                                   padding: EdgeInsets.symmetric(
          //                                       horizontal: size.width * 20,
          //                                       vertical: size.width * 10),
          //                                   child: Column(
          //                                     children: [
          //                                       Row(
          //                                         children: [
          //                                           Spacer(),
          //                                           InkWell(
          //                                             onTap: () {
          //                                               Navigator.of(context)
          //                                                   .pop();
          //                                             },
          //                                             child: Icon(
          //                                               Icons.clear,
          //                                               size: size.width * 40,
          //                                               color: Colors.black,
          //                                             ),
          //                                           )
          //                                         ],
          //                                       ),
          //                                       Text(
          //                                         list[index]['title'],
          //                                         style: TextStyle(
          //                                             fontSize: size.width * 36,
          //                                             color: Color(0xff0059FF),
          //                                             fontWeight:
          //                                                 FontWeight.bold),
          //                                       ),
          //                                       SizedBox(
          //                                         height: size.width * 30,
          //                                       ),
          //                                       Text(
          //                                         list[index]['introduction'],
          //                                         style: TextStyle(
          //                                             fontSize: size.width * 30,
          //                                             color: Color(0xff9D9D9D)),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             ));
          //                           });
          //                     },
          //                     child: Text(
          //                       '[详情]',
          //                       style: TextStyle(
          //                           fontSize: size.width * 20,
          //                           color: Color(0xff1D3DEB)),
          //                     ),
          //                   ),
          //                 ],
          //               )
          //             ],
          //           ),
          //           Spacer(),
          //           InkWell(
          //             onTap: () {
          //               // 取消收藏
          //               _deleteFavoritesResources(list[index]['id']);
          //               _throwFunc.run();
          //               // setState(() {});
          //               // _getmyCollectData();
          //             },
          //             child: Container(
          //               height: size.width * 32,
          //               width: size.width * 106,
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius:
          //                     BorderRadius.all(Radius.circular(size.width * 8)),
          //                 border: Border.all(
          //                     width: size.width * 1, color: Color(0xff666666)),
          //               ),
          //               alignment: Alignment.center,
          //               child: Text(
          //                 '取消收藏',
          //                 style: TextStyle(
          //                     color: Color(0xff666666),
          //                     fontSize: size.width * 18),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          // data: data,
          // type: '风险不受控',
          listParam: "records",
          throwFunc: _throwFunc,
          page: true,
          url: Interface.getMyFavoritesResourcesList,
          // queryParameters: {
          //   "typeId": widget.id,
          //   // 'current': 1,
          //   // 'size': 30,
          // },
          method: 'get'),
    );
  }
}
