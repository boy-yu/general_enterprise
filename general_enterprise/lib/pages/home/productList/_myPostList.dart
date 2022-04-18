import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class CheckMyPostList extends StatefulWidget {
  @override
  _CheckMyPostListState createState() => _CheckMyPostListState();
}

class _CheckMyPostListState extends State<CheckMyPostList>
    with TickerProviderStateMixin {
  List data = [];
  @override
  void initState() {
    super.initState();
    PeopleStructure.getAccountPeople(myprefs.getString('account'))
        .then((value) {
      _getData(value.id);
    });
  }

  _getData(int id) {
    myDio.request(
        type: 'get',
        url: Interface.getUserRoles,
        queryParameters: {"userId": id}).then((value) {
      if (value is List) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

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
                  left: size.width * 30,
                  right: size.width * 10),
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
                                  '待签收：${data[index]['undoneNum']}',
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
