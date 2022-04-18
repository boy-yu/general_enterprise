import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/work/workList.dart';
import 'package:enterprise/pages/home/work/_overview.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import '../../../common/myAppbar.dart';

class Work extends StatefulWidget {
  Work({this.arguments});
  final arguments;
  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {
  PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: choosed);
    _pageController.addListener(() {
      if (_pageController.page.toString().length == 3) {
        choosed = _pageController.page.toInt();
        if (mounted) {
          setState(() {});
        }
      }
    });
    _init();
  }

  List workData = [];
  _init() {
    workData = [
      {
        "index": 0,
        "title": "总览",
        "descript": "选择需要使用的",
        "img": "assets/images/look.png",
        "widget": Overview()
      },
      {
        "index": 1,
        "title": "列表",
        "descript": "选择需要使用的",
        "img": "assets/images/apply.png",
        "widget": WorkList(arguments: widget.arguments)
      },
    ];
  }

  int choosed = 1;
  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return MyAppbar(
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(.2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: workData.map<Widget>((ele) {
            return GestureDetector(
              onTap: () {
                choosed = ele['index'];
                _pageController.animateToPage(choosed,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: choosed == ele['index'] ? Colors.white : null,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text(
                  ele['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          choosed == ele['index'] ? themeColor : Colors.white,
                      fontSize: width * 35),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 40, vertical: width * 10),
              ),
            );
          }).toList(),
        ),
      ),
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) => Column(
          children: [Expanded(child: workData[index]['widget'])],
        ),
        itemCount: workData.length,
      ),
      actions: <Widget>[
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/home/work/history',
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
