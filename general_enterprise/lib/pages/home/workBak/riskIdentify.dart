import 'dart:convert';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class RiskIdentify extends StatefulWidget {
  RiskIdentify({@required this.arguments});
  final arguments;
  @override
  _RiskIdentifyState createState() => _RiskIdentifyState();
}

class _RiskIdentifyState extends State<RiskIdentify> {
  List<String> title = [];
  List<String> smallTitle = ['危害识别', '安全措施'];
  List<List> hazardIdentification = [];
  List<List> safetyMeasures = [];
  int smallTitleIndex = 0;
  int chooseIndex = 0;
  PageController _controller;
  _changePage(value) {
    smallTitleIndex = value;
    setState(() {});
  }

  _getData() {
    title = [];
    hazardIdentification = [];
    safetyMeasures = [];
    // print(widget.arguments['id'].toString());
    myDio
        .request(
            type: 'get',
            url: Interface.getWorkRiskIdentify +
                widget.arguments['id'].toString())
        .then((value) {
      if (value is List) {
        for (var i = 0; i < value.length; i++) {
          title.add(value[i]['workName']);
          hazardIdentification.add([]);
          safetyMeasures.add([]);
          hazardIdentification[i] =
              jsonDecode(value[i]['hazardIdentification']);
          safetyMeasures[i] = jsonDecode(value[i]['safetyMeasures']);
        }
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: smallTitleIndex);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: title.length > 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PopupMenuButton(
                    onSelected: (value) {
                      chooseIndex = value;
                      setState(() {});
                    },
                    itemBuilder: (context) => title
                        .asMap()
                        .keys
                        .map<PopupMenuItem>((index) => PopupMenuItem(
                              value: index,
                              child: Text(
                                title[index].toString(),
                                style: TextStyle(
                                    color: index == chooseIndex
                                        ? themeColor
                                        : Colors.black),
                              ),
                            ))
                        .toList(),
                    child: Text(
                      title[chooseIndex],
                      style: TextStyle(
                          fontSize: size.width * 30, color: Colors.white),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: size.width * 30,
                    color: Color(0xffD4DCEF),
                  ),
                ],
              )
            : Text('风险辨识'),
        child: Container(
            margin: EdgeInsets.all(size.width * 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: smallTitle
                      .asMap()
                      .keys
                      .map<Widget>(
                        (index) => ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundBg)),
                          onPressed: () {
                            _controller.animateToPage(index,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                            child: Text(
                              smallTitle[index].toString(),
                              style: TextStyle(
                                  fontSize: size.width * 28,
                                  color: smallTitleIndex == index
                                      ? themeColor
                                      : Colors.black.withOpacity(0.4)),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: smallTitleIndex == index
                                        ? BorderSide(
                                            width: 2, color: themeColor)
                                        : BorderSide.none)),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Expanded(
                    child: PageView.builder(
                  controller: _controller,
                  onPageChanged: _changePage,
                  itemBuilder: (context, index) {
                    return title.length > 0
                        ? ListView.builder(
                            itemBuilder: (context, _index) {
                              return Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(top: size.width * 10),
                                padding: EdgeInsets.all(size.width * 20),
                                child: Text(
                                  index == 0
                                      ? hazardIdentification[chooseIndex]
                                              [_index]['content']
                                          .toString()
                                      : safetyMeasures[chooseIndex][_index]
                                              ['content']
                                          .toString(),
                                ),
                              );
                            },
                            itemCount: index == 0
                                ? hazardIdentification[chooseIndex].length
                                : safetyMeasures[chooseIndex].length,
                          )
                        : Container();
                  },
                  itemCount: smallTitle.length,
                ))
              ],
            )));
  }
}
