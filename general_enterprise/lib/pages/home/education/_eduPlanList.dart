import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class EduPlanList extends StatefulWidget {
  @override
  _EduPlanListState createState() => _EduPlanListState();
}

class _EduPlanListState extends State<EduPlanList> {
  bool unfold = false;
  List planData = [
    // 开始学习
    {
      'name': '计划名称',
      'initiator': '张三',
      'type': 1,
      'unfold': false,
      'content': [
        {'name': '学习计划内容', 'value': '学习计划内容学习计划内容学习计划内容学习计划内容学习计划内容'},
        {'name': '学习计划内容', 'value': '学习计划内容学习计划内容学习计划内容学习计划内容学习计划内容'},
        {'name': '学习计划内容', 'value': '学习计划内容学习计划内容学习计划内容学习计划内容学习计划内容'},
      ],
      'totalTextbook': 10,
      'totalPeriod': 50,
      'finishedTextbook': 9,
      'finishedPeriod': 50
    },
    // 扫码签到
    {
      'name': '计划名称',
      'initiator': '张三',
      'type': 2,
      'trainingPlace': '办公室二楼',
      'unfold': false,
      'content': [
        {'name': '学习计划内容', 'value': '学习计划内容学习计划内容学习计划内容学习计划内容学习计划内容'},
        {'name': '学习计划内容', 'value': '学习计划内容学习计划内容学习计划内容学习计划内容学习计划内容'},
        {'name': '学习计划内容', 'value': '学习计划内容学习计划内容学习计划内容学习计划内容学习计划内容'},
      ],
      'startTime': '2021.01.11  12:00',
      'endTime': '2021.01.12  12:00',
    },
    // 签到二维码
    {
      'name': '计划名称',
      'type': 3,
      'trainingPlace': '办公室二楼',
      'unfold': false,
      'content': [
        {'name': '学习计划内容', 'value': '学习计划内容学习计划内容学习计划内容学习计划内容学习计划内容'},
        {'name': '学习计划内容', 'value': '学习计划内容学习计划内容学习计划内容学习计划内容学习计划内容'},
        {'name': '学习计划内容', 'value': '学习计划内容学习计划内容学习计划内容学习计划内容学习计划内容'},
      ],
      'startTime': '2021.01.11  12:00',
      'endTime': '2021.01.12  12:00',
    },
  ];

  _getButton(int type) {
    switch (type) {
      case 1:
        return InkWell(
          onTap: () {},
          child: Container(
            width: size.width * 130,
            height: size.width * 50,
            decoration: BoxDecoration(
              color: Color(0xff3869FC),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
            ),
            alignment: Alignment.center,
            child: Text(
              '开始学习',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
        break;
      case 2:
        return InkWell(
          onTap: () {},
          child: Container(
            width: size.width * 130,
            height: size.width * 50,
            decoration: BoxDecoration(
              color: Color(0xff3869FC),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
            ),
            alignment: Alignment.center,
            child: Text(
              '扫码签到',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
        break;
      case 3:
        return InkWell(
          onTap: () {},
          child: Container(
            width: size.width * 130,
            height: size.width * 50,
            decoration: BoxDecoration(
              color: Color(0xff3869FC),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 8)),
            ),
            alignment: Alignment.center,
            child: Text(
              '签到二维码',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('安全教育培训学习计划'),
      child: MyRefres(
          child: (index, list) => Container(
                margin: EdgeInsets.symmetric(
                    vertical: size.width * 10, horizontal: size.width * 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                          blurRadius: 2.0, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                          )
                    ]),
                child: Column(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 20),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/icon_new_sign_in.png',
                                    width: size.width * 90,
                                    height: size.width * 89,
                                  ),
                                  SizedBox(
                                    width: size.width * 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list[index]['name'],
                                        style: TextStyle(
                                            fontSize: size.width * 30,
                                            color: Color(0xff333333),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      list[index]['type'] != 3
                                          ? RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 26),
                                                  children: [
                                                    TextSpan(
                                                        text: "发起人： ",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff333333))),
                                                    TextSpan(
                                                        text: list[index]
                                                            ['initiator'],
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff3869FC))),
                                                  ]),
                                              textDirection: TextDirection.ltr,
                                            )
                                          : Container(),
                                      list[index]['type'] != 1
                                          ? RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 26),
                                                  children: [
                                                    TextSpan(
                                                        text: "培训地点： ",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff666666))),
                                                    TextSpan(
                                                        text: list[index]
                                                            ['trainingPlace'],
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff333333))),
                                                  ]),
                                              textDirection: TextDirection.ltr,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Spacer(),
                                  _getButton(list[index]['type']),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: list[index]['unfold']
                                            ? list[index]['content'].length
                                            : 1,
                                        shrinkWrap:
                                            true, //为true可以解决子控件必须设置高度的问题
                                        physics:
                                            NeverScrollableScrollPhysics(), //禁用滑动事件
                                        itemBuilder: (context, _index) {
                                          return Text(
                                            '${list[index]['content'][_index]['name']}: ${list[index]['content'][_index]['value']}',
                                            style: TextStyle(
                                                color: Color(0xff8E8D92),
                                                fontSize: size.width * 24),
                                          );
                                        }),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      list[index]['unfold'] =
                                          !list[index]['unfold'];
                                      setState(() {});
                                    },
                                    child: Text(
                                      !list[index]['unfold'] ? '[展开]' : '[收起]',
                                      style: TextStyle(
                                          color: Color(0xff3869FC),
                                          fontSize: size.width * 24),
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
                                  vertical: size.width * 10),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 30),
                              child: list[index]['type'] == 1
                                  ? RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 22),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "包含${list[index]['totalTextbook']}本教材               ",
                                                style: TextStyle(
                                                    color: Color(0xff666666))),
                                            TextSpan(
                                                text:
                                                    '总学时：${list[index]['totalPeriod']}',
                                                style: TextStyle(
                                                    color: Color(0xff3869FC))),
                                          ]),
                                      textDirection: TextDirection.ltr,
                                    )
                                  : Text(
                                      '培训开始时间：${list[index]['startTime']}',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 22),
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 30),
                              child: list[index]['type'] == 1
                                  ? RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 22),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "您学习完成${list[index]['finishedTextbook']}本教材     ",
                                                style: TextStyle(
                                                    color: Color(0xff666666))),
                                            TextSpan(
                                                text:
                                                    '总学时：${list[index]['finishedPeriod']}',
                                                style: TextStyle(
                                                    color: Color(0xff3869FC))),
                                          ]),
                                      textDirection: TextDirection.ltr,
                                    )
                                  : Text(
                                      '培训结束时间：${list[index]['endTime']}',
                                      style: TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: size.width * 22),
                                    ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
          data: planData,
          // listParam: "",
          // page: true,
          url: '',
          method: 'get'),
    );
  }
}
