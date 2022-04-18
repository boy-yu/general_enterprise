import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class StudyPlan extends StatefulWidget {
  StudyPlan({this.type});
  final int type;
  @override
  _StudyPlanState createState() => _StudyPlanState();
}

class _StudyPlanState extends State<StudyPlan> {
  ThrowFunc _throwFunc = new ThrowFunc();

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('在线学习计划'),
      child: Container(
        color: Colors.white,
        child: MyRefres(
            child: (index, list) => InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        '/checkList/studyPlanTextbookStageList',
                        arguments: {
                          'title': list[index]['name'],
                          'id': list[index]['id'],
                          'type': widget.type
                        }).then((value) {
                          _throwFunc.run();
                      // 返回值
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 30, vertical: size.width * 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.width * 8)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1.0,
                              blurRadius: 1.0)
                        ]),
                    child: Column(
                      children: [
                        Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: size.width * 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 20),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/icon_mylist_edu_twolist.png',
                                        width: size.width * 90,
                                        height: size.width * 90,
                                      ),
                                      SizedBox(
                                        width: size.width * 25,
                                      ),
                                      Container(
                                        width: size.width * 350,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              list[index]['name'],
                                              style: TextStyle(
                                                  color: Color(0xff404040),
                                                  fontSize: size.width * 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: size.width * 15,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 22),
                                                  children: [
                                                    TextSpan(
                                                        text: "发起人： ",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff404040))),
                                                    TextSpan(
                                                        text: list[index]
                                                            ['sponsorName'],
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff3074FF))),
                                                  ]),
                                              textDirection: TextDirection.ltr,
                                            )
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        height: size.width * 40,
                                        width: size.width * 119,
                                        decoration: BoxDecoration(
                                          color: Color(0xff3869FC),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(size.width * 4)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '学习教材',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '学习计划内容：' + list[index]['theme'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * 20),
                                          maxLines:
                                              list[index]['unfold'] == null
                                                  ? 2
                                                  : 10,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (list[index]['unfold'] == null) {
                                            list[index]['unfold'] = 1;
                                          } else {
                                            list[index]['unfold'] = null;
                                          }
                                          setState(() {});
                                        },
                                        child: Text(
                                          list[index]['unfold'] == null
                                              ? '[展开]'
                                              : '[收起]',
                                          style: TextStyle(
                                              color: Color(0xff3074FF),
                                              fontSize: size.width * 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: size.width * 1,
                                  color: Color(0xffE8E8E8),
                                  margin: EdgeInsets.symmetric(
                                      vertical: size.width * 12),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 25),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: size.width * 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                children: [
                                                  TextSpan(
                                                      text: "包含",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff404040))),
                                                  TextSpan(
                                                      text: list[index]
                                                              ['resourcesNum']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff3074FF))),
                                                  TextSpan(
                                                      text: "本教材",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff404040))),
                                                ]),
                                          ),
                                          Spacer(),
                                          Text(
                                            '总学时：${list[index]['resourcesClassHours']}学时',
                                            style: TextStyle(
                                                color: Color(0xff3074ff),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 20),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: size.width * 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                children: [
                                                  TextSpan(
                                                      text: "您学习完成",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff404040))),
                                                  TextSpan(
                                                      text: list[index]
                                                              ['haveLearnedNum']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff3074FF))),
                                                  TextSpan(
                                                      text: "本教材",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff404040))),
                                                ]),
                                          ),
                                          Spacer(),
                                          Text(
                                            '总学时：${list[index]['haveLearnedClassHours']}学时',
                                            style: TextStyle(
                                                color: Color(0xff3074ff),
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width * 20),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
            // data: data,
            // type: '风险不受控',
            // listParam: "records",
            throwFunc: _throwFunc,
            page: true,
            url: Interface.getEducationTrainingPlanProcessingList,
            queryParameters: {
              "isYear": widget.type,
            },
            method: 'get'),
      ),
    );
  }
}
