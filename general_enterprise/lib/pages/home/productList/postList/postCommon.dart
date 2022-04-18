import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostListCommonPage extends StatefulWidget {
  PostListCommonPage({this.id, this.throwFunc});
  final int id;
  final ThrowFunc throwFunc;
  @override
  _PostListCommonPageState createState() => _PostListCommonPageState();
}

class _PostListCommonPageState extends State<PostListCommonPage>
    with TickerProviderStateMixin {
  List data = [];

  // int page = 0;
  @override
  void initState() {
    super.initState();

    _getdata(argument: {"id":widget.id});
    widget.throwFunc.detailInit(_getdata);
  }

  _getdata({dynamic argument}) {
    myDio.request(type: 'get', url: Interface.getUserRoles, queryParameters: {
      "userId": argument['id'],
    }).then((value) {
      if (value is List) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  // _getRolesList(int userId, int rolesId, dataMap) {
  //   myDio.request(
  //       type: 'get',
  //       url: Interface.getPostList,
  //       queryParameters: {"userId": userId, "rolesId": rolesId}).then((value) {
  //     if (value is List) {
  //       dataMap['children'] = value;
  //     }
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                      blurRadius: 3.0, //阴影模糊程度
                      spreadRadius: 1.0 //阴影扩散程度
                      )
                ],
              ),
              margin: EdgeInsets.only(
                  top: size.width * 20,
                  left: size.width * 20,
                  right: size.width * 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/index/productList/postListDetails',
                          arguments: {
                            "userId": data[index]['userId'],
                            "rolesId": data[index]['rolesId'],
                          });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: size.width * 300,
                          child: Text(data[index]['name'],
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 30,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/xl@2x.png',
                                  height: size.width * 25,
                                  width: size.width * 25,
                                ),
                                SizedBox(
                                  width: size.width * 10,
                                ),
                                Text(
                                  '已签收：${data[index]['completedNum']}',
                                  style: TextStyle(
                                      color: Color(0xff36B334),
                                      fontSize: size.width * 20),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.width * 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/kl@2x.png',
                                  height: size.width * 25,
                                  width: size.width * 25,
                                ),
                                SizedBox(
                                  width: size.width * 10,
                                ),
                                Text(
                                  '未签收：${data[index]['undoneNum']}',
                                  style: TextStyle(
                                      color: Color(0xffFF6600),
                                      fontSize: size.width * 20),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
              ),
              Image.asset(
                "assets/images/empty@2x.png",
                height: size.width * 288,
                width: size.width * 374,
              ),
              Text('暂无数据')
            ],
          );
  }
}

class MycheckWorkItem extends StatelessWidget {
  MycheckWorkItem({@required this.dataMap});
  final Map dataMap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: dataMap['children']
          .asMap()
          .keys
          .map<Widget>((_index) => InkWell(
              onTap: () {
                if (dataMap['children'][_index]['traceable'] == 1) {
                  Navigator.pushNamed(
                      context, '/index/productList/checkPostGuard',
                      arguments: {
                        "title": dataMap['children'][_index]['title'],
                        "status": dataMap['children'][_index]['status'],
                        "type": dataMap['children'][_index]['type'],
                        "rolesId": dataMap['children'][_index]['rolesId'],
                        "userId": dataMap['children'][_index]['userId'],
                      });
                } else {
                  Fluttertoast.showToast(msg: '此数据无法查看详情');
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        dataMap['children'][_index]['title'].toString(),
                        style: TextStyle(
                            fontSize: size.width * 26,
                            color: dataMap['children'][_index]['status'] == 1
                                ? placeHolder
                                : Colors.black),
                      )),
                      dataMap['children'][_index]['traceable'] == 1
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      width: 1,
                                      color: dataMap['children'][_index]
                                                  ['status'] ==
                                              1
                                          ? Color(0xff5FC754)
                                          : themeColor)),
                              padding: EdgeInsets.all(size.width * 3),
                              child: Text(
                                dataMap['children'][_index]['status'] == 1
                                    ? '已完成'
                                    : '进行中',
                                style: TextStyle(
                                    fontSize: size.width * 20,
                                    color: dataMap['children'][_index]
                                                ['status'] ==
                                            1
                                        ? Color(0xff5FC754)
                                        : themeColor),
                              ))
                          : Container(),
                    ],
                  ),
                  Divider()
                ],
              )))
          .toList(),
    );
  }
}
