import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class TwoSingleCard extends StatefulWidget {
  @override
  _TwoSingleCardState createState() => _TwoSingleCardState();
}

class _TwoSingleCardState extends State<TwoSingleCard> {
  List twoSingleCardList = [
      {"name": "岗位风险清单", "router": "/twoSingleCard/twoSingleCardLeftList", "icon": 'assets/images/fx1@2x.png'},
      {"name": "岗位职责清单", "router": "/twoSingleCard/twoSingleCardLeftList", "icon": 'assets/images/gz1@2x.png'},
      {"name": "岗位操作卡", "router": "/twoSingleCard/twoSingleCardLeftList", "icon": 'assets/images/cz1@2x.png'},
      {"name": "岗位应急处置卡", "router": "/twoSingleCard/twoSingleCardLeftList", "icon": 'assets/images/yj1@2x.png'},
      {"name": "“两单两卡”口诀", "router": "/twoSingleCard/twoSingleCardLeftList", "icon": 'assets/images/kj1@2x.png'},
    ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MyAppbar(
      title: Text('两单两卡'),
      child: Container(
        color: Colors.white,
        height: height,
        child: ListView.builder(
          itemCount: twoSingleCardList.length,
          shrinkWrap: true,
          itemBuilder: (builder, index) {
            return Padding(
              padding: EdgeInsets.only(right: size.width * 31, left: size.width * 33, top: size.width * 35.0),
              // InkWell 添加 Material触摸水波效果
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    twoSingleCardList[index]['router'],
                    arguments: {
                      'index': index,
                    } 
                  );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          twoSingleCardList[index]['icon'],
                          height: size.width * 42,
                          width: size.width * 42,
                        ),
                        SizedBox(
                          width: size.width * 34,
                        ),
                        Text(
                          twoSingleCardList[index]['name'],
                          style: TextStyle(
                            color: Color(0xff3C3C3C),
                            fontSize: size.width * 26
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: size.width * 31,
                          width: size.width * 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Color(0xff2E6CFD),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '查看',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 20
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 35,
                    ),
                    index != twoSingleCardList.length - 1 ? Container(
                      color: Color(0xffEFEFEF),
                      height: size.width * 1,
                      width: double.infinity,
                    ) : Container(),
                  ],
                )
              ),
            );
          },
        ),
      ),
    );
  }
}