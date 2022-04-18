import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduTextbookList extends StatefulWidget {
  final int id;
  const EduTextbookList({Key key, @required this.id}) : super(key: key);
  @override
  _EduTextbookListState createState() => _EduTextbookListState();
}

class _EduTextbookListState extends State<EduTextbookList> {
  List data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('培训教材'),
      child: Container(
        color: Colors.white,
        child: MyRefres(
          child: (index, list) => Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 30, vertical: size.width * 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 1.0,
                          spreadRadius: 1.0),
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.width * 20),
                      child: Row(
                        children: [
                          Container(
                            height: size.width * 125,
                            width: size.width * 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
                              image: DecorationImage(
                                image: NetworkImage(list[index]['coverUrl']),
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 23,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index]['title'],
                                style: TextStyle(
                                    fontSize: size.width * 24,
                                    color: Color(0xff404040),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: size.width * 330,
                                    child: Text(
                                        list[index]['introduction'].toString(),
                                        style: TextStyle(
                                          fontSize: size.width * 20,
                                          color: Color(0xff404040),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  InkWell(
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
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            size.width * 10))),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 20,
                                                      vertical:
                                                          size.width * 10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Icon(
                                                              Icons.clear,
                                                              size: size.width *
                                                                  40,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        list[index]['title'],
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width * 36,
                                                            color: Color(
                                                                0xff0059FF),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: size.width * 30,
                                                      ),
                                                      Text(
                                                        list[index]['introduction'].toString(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                size.width * 30,
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
                                      '【简介】',
                                      style: TextStyle(
                                          fontSize: size.width * 20,
                                          color: Color(0xff3074FF)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Text(
                                '${list[index]['classHours']}学时',
                                style: TextStyle(
                                    color: Color(0xff3074FF),
                                    fontSize: size.width * 20),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: size.width * 1,
                      width: double.infinity,
                      color: Color(0xffEEEEEE),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size.width * 10, horizontal: size.width * 26),
                      child: Row(
                        children: [
                          Text(
                            DateTime.fromMillisecondsSinceEpoch(list[index]['createDate']).toString().substring(0, 19) + '上线',
                            style: TextStyle(
                                fontSize: size.width * 20,
                                color: Color(0xff404040)),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                            .pushNamed(
                                          '/home/education/study',
                                          arguments: {
                                            'id': list[index]['id'],
                                          }
                                        ).then((value) {
                                          // 返回值
                                        });
                            },
                            child: Container(
                              height: size.width * 40,
                              width: size.width * 131,
                              decoration: BoxDecoration(
                                  color: Color(0xff3074FF),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 23.5))),
                              alignment: Alignment.center,
                              child: Text(
                                '开始学习',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
          // data: data,
          // type: '风险不受控',
          listParam: "records",
          // throwFunc: _throwFunc,
          page: true,
          url: Interface.getEducationTrainingResourcesList,
          queryParameters: {
            "typeId": widget.id,
            // 'current': 1,
            // 'size': 30,
          },
          method: 'get'),
      ),
    );
  }
}
