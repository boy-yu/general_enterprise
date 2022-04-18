import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduMyHistoryTextbook extends StatefulWidget {
  @override
  _EduMyHistoryTextbookState createState() => _EduMyHistoryTextbookState();
}

class _EduMyHistoryTextbookState extends State<EduMyHistoryTextbook> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('历史学习教材'),
      child: MyRefres(
          child: (index, list) => Container(
                margin: EdgeInsets.symmetric(
                    vertical: size.width * 20, horizontal: size.width * 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1.0,
                          blurRadius: 1.0),
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 30,
                          vertical: size.width * 20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/icon_new_sign_in.png',
                            width: size.width * 90,
                            height: size.width * 89,
                          ),
                          SizedBox(
                            width: size.width * 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index]['name'],
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: size.width * 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: size.width * 22),
                                    children: [
                                      TextSpan(
                                          text:
                                              "包含${list[index]['resourcesNum']}本教材               ",
                                          style: TextStyle(
                                              color: Color(0xff666666))),
                                      TextSpan(
                                          text:
                                              '总学时：${list[index]['resourcesClassHours']}',
                                          style: TextStyle(
                                              color: Color(0xff3869FC))),
                                    ]),
                                textDirection: TextDirection.ltr,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: size.width * 22),
                                    children: [
                                      TextSpan(
                                          text:
                                              "您学习完成${list[index]['haveLearnedNum']}本教材     ",
                                          style: TextStyle(
                                              color: Color(0xff666666))),
                                      TextSpan(
                                          text:
                                              '总学时：${list[index]['haveLearnedClassHours']}',
                                          style: TextStyle(
                                              color: Color(0xff3869FC))),
                                    ]),
                                textDirection: TextDirection.ltr,
                              )
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(
                                '/home/education/eduMyHistoryPlanList',
                                arguments: {
                                  'planId': list[index]['id'],
                                  'title': list[index]['name']
                                }
                              ).then((value) {
                                // 返回值
                              });
                            },
                            child: Container(
                              height: size.width * 50,
                              width: size.width * 130,
                              decoration: BoxDecoration(
                                  color: Color(0xff3869FC),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 8))),
                              alignment: Alignment.center,
                              child: Text(
                                '详情',
                                style: TextStyle(
                                    fontSize: size.width * 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.width * 1,
                      width: double.infinity,
                      color: Color(0xffE8E8E8),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 30,
                            vertical: size.width * 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(list[index]['theme'],
                                  style: TextStyle(
                                      fontSize: size.width * 24,
                                      color: Color(0xff8E8D92),
                                      fontWeight: FontWeight.bold),
                                  maxLines:
                                      list[index]['unfold'] == 1 ? 10 : 3,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            InkWell(
                              onTap: () {
                                if(list[index]['unfold'] == null){
                                  list[index]['unfold']  = 1;
                                }else{
                                  list[index]['unfold'] = null;
                                }
                                setState(() {});
                              },
                              child: Text(
                                '[展开]',
                                style: TextStyle(
                                    color: Color(0xff3869FC),
                                    fontSize: size.width * 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
          // data: textBookHistory,
          listParam: "records",
          page: true,
          url: Interface.getMyPlanResourcesBookList,
          method: 'get'),
    );
  }
}
