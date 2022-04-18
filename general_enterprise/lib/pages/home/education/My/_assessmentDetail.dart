import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class AssessmentDetail extends StatefulWidget {
  AssessmentDetail({this.name, this.data});
  final String name;
  final List data;
  @override
  _AssessmentDetailState createState() => _AssessmentDetailState();
}

class _AssessmentDetailState extends State<AssessmentDetail> {
  @override
  void initState() {
    super.initState();
    name = widget.name ?? '';
    _init();
  }

  String name = "";
  List data = [];

  _init() {
    for (int i = 0; i < widget.data.length; i++) {
      if (widget.name == widget.data[i]['name']) {
        data = widget.data[i]['list'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text("考核"),
        child: Column(
          children: [
            // Container(
            //   color: Colors.white,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 10),
            //     child: PageDrop(
            //       callSetstate: (value) {
            //         data = value['list'];
            //         setState(() {});
            //       },
            //       data: widget.data,
            //       title: "部门",
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Column(
                    children: widget.data
                        .map((e) => InkWell(
                              onTap: () {
                                setState(() {
                                  name = e['name'] ?? '';
                                  data = e['list'];
                                  
                                });
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(e['name']),
                                  ),
                                  Divider()
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(name), Icon(Icons.arrow_drop_down)],
              ),
            ),

            Container(
              color: Color(0xffF7F7F7),
              height: size.width * 68,
              child: Row(
                children: [
                  Container(
                    width: size.width * 100,
                    alignment: Alignment.center,
                    child: Text(
                      '排名',
                      style: TextStyle(
                          fontSize: size.width * 24, color: Color(0xffA8A8A8)),
                    ),
                  ),
                  Container(
                    width: size.width * 120,
                    alignment: Alignment.center,
                    child: Text(
                      '姓名',
                      style: TextStyle(
                          fontSize: size.width * 24, color: Color(0xffA8A8A8)),
                    ),
                  ),
                  Container(
                    width: size.width * 120,
                    alignment: Alignment.center,
                    child: Text(
                      '分数',
                      style: TextStyle(
                          fontSize: size.width * 24, color: Color(0xffA8A8A8)),
                    ),
                  ),
                  Container(
                    width: size.width * 230,
                    alignment: Alignment.center,
                    child: Text(
                      '部门',
                      style: TextStyle(
                          fontSize: size.width * 24, color: Color(0xffA8A8A8)),
                    ),
                  ),
                  Container(
                    width: size.width * 170,
                    alignment: Alignment.center,
                    child: Text(
                      '职务',
                      style: TextStyle(
                          fontSize: size.width * 24, color: Color(0xffA8A8A8)),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: data.isNotEmpty
                  ? Container(
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width * 100,
                                    alignment: Alignment.center,
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          color: Color(0xffFC7E21)),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      data[index]['nickname'],
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          color: Color(0xff414040)),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      data[index]['score'].toString(),
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          color: Color(0xff414040)),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 230,
                                    alignment: Alignment.center,
                                    child: Text(
                                      data[index]['department'],
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          color: Color(0xff414040)),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 170,
                                    alignment: Alignment.center,
                                    child: Text(
                                      data[index]['position'],
                                      style: TextStyle(
                                          fontSize: size.width * 24,
                                          color: Color(0xff414040)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  : Container(),
            ),
          ],
        ));
  }
}
