import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/workBak/_apply.dart';
import 'package:enterprise/pages/home/work/_overview.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/myAppbar.dart';

class Work extends StatefulWidget {
  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {
  @override
  void initState() {
    super.initState();
  }

  List workData = [
    {
      "title": "总览",
      "descript": "选择需要使用的",
      "img": "assets/images/look.png",
      "router": "/home/work/overview",
      "isClick": false
    },
    {
      "title": "列表",
      "descript": "选择需要使用的",
      "img": "assets/images/apply.png",
      "router": "/home/work/apply",
      "isClick": true
    },
  ];
  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return MyAppbar(
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(.2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(28))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: workData.map<Widget>((ele) {
            return GestureDetector(
              onTap: () {
                workData.forEach((element) {
                  element['isClick'] = false;
                });
                ele['isClick'] = true;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    color: ele['isClick'] ? Colors.white : null,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text(
                  ele['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ele['isClick'] ? themeColor : Colors.white,
                      fontSize: width * 35),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 40, vertical: width * 10),
              ),
            );
          }).toList(),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            child: Column(
              children: [
                for (var item in workData)
                  if (item['isClick'])
                    if (item['title'] == '总览')
                      Expanded(child: Overview())
                    else if (item['title'] == '列表')
                      Expanded(
                          child: Apply(
                        arguments: {"title": '作业申请'},
                      ))
              ],
            ),
          ),
          MyPosiIcon()
        ],
      ),
      actions: <Widget>[
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/home/work/apply',
                  arguments: {"title": '历史作业'});
            },
            child: Container(
              child: Text('历史'),
              margin: EdgeInsets.only(right: 10),
            ),
          ),
        )
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class Joiner extends StatelessWidget {
  Joiner({this.color = Colors.grey});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 5),
          width: 15,
          color: color,
          height: 2,
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: color)),
          width: 10,
          height: 10,
        ),
        Container(
          width: 15,
          color: color,
          height: 2,
          margin: EdgeInsets.only(right: 5),
        ),
      ],
    );
  }
}

class MyPosiIcon extends StatefulWidget {
  @override
  _MyPosiIconState createState() => _MyPosiIconState();
}

class _MyPosiIconState extends State<MyPosiIcon> {
  double left = 20;
  double top = 400;

  GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double width = size.width;
    Counter _context = Provider.of<Counter>(context);
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        key: _key,
        onPanUpdate: (details) {
          setState(() {
            left = details.globalPosition.dx - 30;
            top = details.globalPosition.dy - 80;
          });
        },
        onTap: () {
          RenderBox box = _key.currentContext.findRenderObject();
          Offset offset = box.localToGlobal(Offset.zero);
          Size buttonSize = box.size;
          Size sizes = Size(offset.dx, offset.dy);

          showMenu(
              context: context,
              position: RelativeRect.fromSize(
                  Rect.fromLTRB(
                      offset.dx - buttonSize.width * 2, offset.dy, 0, 0),
                  sizes),
              items: <PopupMenuEntry<dynamic>>[
                PopupMenuItem(
                    child: GestureDetector(
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.event_note,
                          color: Color.fromRGBO(101, 109, 146, 1),
                          size: width * 40,
                        ),
                        Text(
                          '计划',
                          style: TextStyle(
                            color: Color.fromRGBO(101, 109, 146, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    _context.emptySubmitDates();
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 300), () {
                      Navigator.pushNamed(context, '/home/work/plan',
                          arguments: {"title": "作业计划"});
                    });
                  },
                )),
                PopupMenuItem(
                    child: GestureDetector(
                  child: Center(
                      child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.event_busy,
                        color: Color.fromRGBO(101, 109, 146, 1),
                        size: width * 40,
                      ),
                      Text(
                        '计划外',
                        style: TextStyle(
                          color: Color.fromRGBO(101, 109, 146, 1),
                        ),
                      )
                    ],
                  )),
                  onTap: () {
                    _context.emptySubmitDates();
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 300), () {
                      Navigator.pushNamed(context, '/home/work/plan',
                          arguments: {"title": "作业申请"});
                    });
                  },
                )),
              ]);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: themeColor,
            //渐变颜色[始点颜色, 结束颜色]
            // gradient: LinearGradient(      //渐变位置
            //   begin: Alignment.topRight, //右上
            //   end: Alignment.bottomLeft, //左下
            //   stops: [0.0, 1.0],         //[渐变起始点, 渐变结束点]
            //   //渐变颜色[始点颜色, 结束颜色]
            //   colors: [Color.fromRGBO(63, 68, 72, 1), Color.fromRGBO(36, 41, 46, 1)]
            // )
          ),
          child: Icon(
            Icons.add,
            size: width * 60,
            color: Colors.white,
          ),
          width: width * 80,
          height: width * 80,
        ),
      ),
    );
  }
}
