import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/common/transation.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interActiveType.dart';
import 'package:flutter/material.dart';

class EduChooseTextBook extends StatefulWidget {
  @override
  _EduChooseTextBookState createState() => _EduChooseTextBookState();
}

class _EduChooseTextBookState extends State<EduChooseTextBook> {
  List<InterActiveType> _data = [
    InterActiveType(lable: "单选题", textInputType: TextInputType.number),
    InterActiveType(lable: "多选题", textInputType: TextInputType.number),
    InterActiveType(lable: "判断题", textInputType: TextInputType.number),
    InterActiveType(lable: "填空题", textInputType: TextInputType.number),
    InterActiveType(lable: "问答题", textInputType: TextInputType.number),
  ];

  Widget juedeCounter(InterActiveType e) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: placeHolder.withOpacity(0.2), width: 1))),
      child: Row(
        children: [
          Text(e.lable + ":", style: TextStyle(fontSize: size.width * 22)),
          Container(
              height: 30,
              width: 200,
              child: TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: size.width * 26, color: themeColor),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入分配题数",
                    hintStyle: TextStyle(fontSize: size.width * 22),
                    contentPadding:
                        EdgeInsets.only(left: 10, top: 0, bottom: 14)),
              )),
          Spacer(),
          Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        width: 1, color: placeHolder.withOpacity(.2)))),
            child: Text('可分配20题', style: TextStyle(fontSize: size.width * 22)),
          )
        ],
      ),
    );
  }

  bool show = false;
  _init() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          show = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text("选择教材必考题"),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("系统分配考题"),
                    Text("本试卷还剩余24分可以让系统给员工分配不同的考题进行考核"),
                    Wrap(
                      children: [
                        Text("单选题：2分/题"),
                        Text("多选题：4分/题"),
                        Text("判断题：2分/题"),
                        Text("填空题：4分/题"),
                        Text("问答题：8分/题"),
                      ],
                    ),
                    Text("*以下为每种题型最多的分配次数"),
                    Contexts().shadowWidget(
                        Column(
                          children: _data.map((e) => juedeCounter(e)).toList(),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10)),
                    // SizedBox(height: 10),
                  ],
                ),
              ),
              TranstionNoExpand(
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "已制定比考题15共76分",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Contexts().shadowWidget(
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("动火作业作业视频教材"),
                                  Text(
                                    "共 10 题，已选择 1 题",
                                    style: TextStyle(
                                        color: Color(0xff16CAA2),
                                        fontSize: size.width * 22),
                                  ),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      "/home/education/eduChooseTextBookTopic");
                                },
                                child: Text("请选择 >",
                                    style: TextStyle(color: themeColor)),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(5),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        )
                      ],
                    ),
                  ),
                  show)
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseTextBookTopic extends StatefulWidget {
  @override
  _ChooseTextBookTopicState createState() => _ChooseTextBookTopicState();
}

class _ChooseTextBookTopicState extends State<ChooseTextBookTopic> {
  bool show = false;
  List<HiddenDangerInterface> _leftBar = [
    HiddenDangerInterface(
        title: "教材",
        name: "教材",
        // bgicon: "assets/images/adress_book.png",
        color: Colors.white,
        iconWidget: Icon(Icons.book, color: themeColor),
        type: -2),
  ];
  int choosed = 0;
  _init() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          show = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  // Widget judgetWidget(Map data) {}

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text("教材名称"),
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(left: 40),
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height,
                child: MyRefres(
                  child: (index, list) => Container(),
                  url: "url",
                  method: "method",
                  data: [
                    {"type": "1"},
                    {"type": "3"},
                    {"type": "2"},
                  ],
                )),
            LeftBar(
              iconList: _leftBar,
              callback: (int index) {
                choosed = index;
              },
            )
          ],
        ));
  }
}
