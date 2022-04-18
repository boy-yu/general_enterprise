import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class PostListThreeType extends StatefulWidget {
  PostListThreeType({this.type, this.rolesId, this.userId, this.title});
  final int type;
  final int rolesId;
  final int userId;
  final String title;
  @override
  _PostListThreeTypeState createState() => _PostListThreeTypeState();
}

class _PostListThreeTypeState extends State<PostListThreeType> {
  Map mapData = {};
  List data = [
    {
      'name': '',
      'value': [],
    }
  ];

  @override
  void initState() {
    super.initState();
    _getData(widget.type, widget.rolesId, widget.userId, widget.title);
  }

  _getData(int type, int rolesId, int userId, String title){
    myDio.request(
      type: 'get',
      url: Interface.getPostReport,
      queryParameters: {
        "type": type, 
        "rolesId": rolesId,
        "userId": userId, 
        "title": title,
    }).then((value) {
      if (value is Map) {
        data.clear();
        mapData = value['dutyListByRolesMap'];
        if(mapData.isNotEmpty){
          mapData.forEach((k,v){
            data.add({"name":k,"value":v});
          });
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('岗位责任清单'),
      child: data.isNotEmpty 
      ? ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          return Container(
            margin: EdgeInsets.all(size.width * 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(size.width * 5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(size.width * 20),
                  child: Row(
                    children: [
                      Container(
                        height: size.width * 20,
                        width: size.width * 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          border: Border.all(width: size.width * 5, color: Color(0xff3074FF)),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 20,
                      ),
                      Text(
                        data[index]['name'],
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 30,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: size.width * 1,
                  color: Color(0xffE5E5E5),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data[index]['value'].asMap().keys.map<Widget>((_index) => 
                    InkWell(
                      onTap: (){
                        // 人管事
                        Navigator.pushNamed(
                          context, 
                          '/index/productList/postListReportPToThing',
                          arguments: {
                            "type": data[index]['value'][_index]['type'],
                            'title': data[index]['value'][_index]['title'],
                            'dutyId': data[index]['value'][_index]['dutyId']
                          }
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width * 50, top: size.width * 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: size.width * 550,
                                  height: size.width * 80,
                                  child: Text(
                                    data[index]['value'][_index]['title'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: size.width * 26
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ),
                                Container(
                                  height: size.width * 34,
                                  width: size.width * 90,
                                  // margin: EdgeInsets.all(size.width * 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
                                    border: Border.all(width: size.width * 2, color: data[index]['value'][_index]['status'] == 0 ? Color(0xffFF6600) : Color(0xff36B334)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    data[index]['value'][_index]['status'] == 0 ? '未完成' : '完成',
                                    style: TextStyle(
                                      color: data[index]['value'][_index]['status'] == 0 ? Color(0xffFF6600) : Color(0xff36B334),
                                      fontSize: size.width * 24,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: size.width * 1,
                              color: Color(0xffE9E9EF),
                            )
                          ],
                        ),
                      )
                    )
                  ).toList(),
                )
              ],
            ),
          );
        }
      ) : Container(),
    );
  }
}