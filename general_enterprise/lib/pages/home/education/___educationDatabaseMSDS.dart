import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EducationDatabaseMSDS extends StatefulWidget {
  EducationDatabaseMSDS(
      {this.name, this.kBIndex, this.callback, this.quote = false});
  final String name;
  final int kBIndex;
  final bool quote;
  final Function callback;
  @override
  _EducationDatabaseMSDSState createState() => _EducationDatabaseMSDSState();
}

class _EducationDatabaseMSDSState extends State<EducationDatabaseMSDS> {
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
    _getKnowledgeBaseDetails();
  }

  _getKnowledgeBaseDetails() async {
    if (widget.callback != null) {
      data = await widget.callback();
      if (mounted) {
        setState(() {});
      }
    } else {
      myDio.request(
          type: 'get',
          url: Interface.getKnowledgeBaseDetails,
          queryParameters: {
            "kBIndex": widget.kBIndex,
            "name": widget.name,
          }).then((value) {
        if (value != null) {
          data = value;
        }
        if (mounted) {
          setState(() {});
        }
      });
    }
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

  Widget body() {
    return ListView.builder(
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return widget.quote
        ? body()
        : MyAppbar(title: Text('安全技术说明书'), child: body());
  }
}
