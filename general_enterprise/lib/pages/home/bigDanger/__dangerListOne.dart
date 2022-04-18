import 'package:enterprise/common/MyWebView.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/education/___educationDatabaseMSDS.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class DangerListOne extends StatefulWidget {
  final int id;
  final String url;
  const DangerListOne({Key key, @required this.id, this.url}) : super(key: key);
  @override
  _DangerListOneState createState() => _DangerListOneState();
}

class _DangerListOneState extends State<DangerListOne> {
  List workData = [];
  _init() {
    workData = [
      {
        "index": 0,
        "title": "一书",
        "descript": "选择需要使用的",
        "img": "assets/images/look.png",
        "widget": EducationDatabaseMSDS(
          callback: _getData,
          quote: true,
        )
      },
      {
        "index": 1,
        "title": "一签",
        "descript": "选择需要使用的",
        "img": "assets/images/apply.png",
        "widget": widget.url == null || widget.url == ''
            ? Center(
                child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 300,
                    ),
                    Image.asset(
                      "assets/images/empty@2x.png",
                      height: size.width * 288,
                      width: size.width * 374,
                    ),
                    Text('暂无一签'),
                  ],
                ),
              ),
              )
            : WebViewExample(url: Interface.online(widget.url))
      },
    ];
  }

  Future<List> _getData() async {
    List reList = [];
    final _data = await myDio.request(
        type: 'get', url: Interface.getChemiclById + widget.id.toString());
    if (_data is List) {
      reList = _data;
    }
    return Future.value(reList);
  }

  int choosed = 0;
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

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        elevation: 0,
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
                        fontSize: size.width * 35),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 40, vertical: size.width * 10),
                ),
              );
            }).toList(),
          ),
        ),
        child: PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Column(
            children: [
              Expanded(child: workData[index]['widget']),
            ],
          ),
          itemCount: workData.length,
        ));
  }
}
