
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class ChemicalsDetails extends StatefulWidget {
  ChemicalsDetails({this.labelUrl, this.msdsId});
  final String labelUrl;
  final int msdsId;
  @override
  _ChemicalsDetailsState createState() => _ChemicalsDetailsState();
}

class _ChemicalsDetailsState extends State<ChemicalsDetails> {
  PageController _controller;
  int choosed = 0;
  int oldPage = 0;

  List chemicalsData = [
    {
      "index": 0,
      "title": "说明",
      "descript": "选择需要使用的",
      "img": "assets/images/look.png",
      "isClick": false
    },
    {
      "index": 1,
      "title": "标签",
      "descript": "选择需要使用的",
      "img": "assets/images/apply.png",
      "isClick": true
    },
  ];

  Widget _changeTitle(width, item) {
    Widget _widget;
    if (item['title'] == '说明')
      _widget = Specification(msdsId: widget.msdsId);
    else if (item['title'] == '标签')
      _widget = Label(labelUrl: widget.labelUrl);
    return _widget;
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: choosed);
    _controller.addListener(() {
      if (oldPage != _controller.page.toInt()) {
        choosed = _controller.page.toInt();
        oldPage = choosed;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(.2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(28))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: chemicalsData.map<Widget>((ele) {
            return GestureDetector(
              onTap: () {
                choosed = ele['index'];
                _controller.animateToPage(choosed,
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
        controller: _controller,
        itemBuilder: (context, index) => _changeTitle(size.width, chemicalsData[index]),
        itemCount: chemicalsData.length,
      ),
    );
  }
}

class Specification extends StatefulWidget {
  Specification({this.msdsId});
  final int msdsId;
  @override
  _SpecificationState createState() => _SpecificationState();
}

class _SpecificationState extends State<Specification> {
  List data = [
    {
      "list": [
        {
          "enKey": "",
          "modifyDate": "",
          "part": -1,
          "chKey": "",
          "id": -1,
          "value": "",
          "partName": "",
          "createDate": ""
        },
      ],
      "title": "",
    },
  ];

  @override
  void initState() {
    super.initState();
    _getSpecification();
  }

  _getSpecification() {
    myDio.request(type: 'get', url: Interface.getChemiclById + widget.msdsId.toString()).then((value) {
      data = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  List<TableRow> _getTableList(int index) {
    List<TableRow> list = [];
    for (var i = 0; i < data[index]['list'].length; i++) {
      list.add(TableRow(children: [
        Container(
          padding: EdgeInsets.all(12),
          child: Text(data[index]['list'][i]['chKey']),
        ),
        Container(
          padding: EdgeInsets.all(12),
          child: Text(data[index]['list'][i]['value']),
        )
      ]));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty ? ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: size.width * 69,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff3174FF),
                      Color(0xff1C3AEA),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  data[index]['title'].toString(),
                  style: TextStyle(
                      fontSize: size.width * 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Table(
                border: TableBorder.all(
                  color: Colors.grey.shade300,
                  width: size.width * 1.0,
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
                children: _getTableList(index),
              ),
            ],
          );
        }
      ) : Container();
  }
}

class Label extends StatefulWidget {
  Label({this.labelUrl});
  final String labelUrl;
  @override
  _LabelState createState() => _LabelState();
}

class _LabelState extends State<Label> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Image.network(
        widget.labelUrl
      ),
    );
  }
}