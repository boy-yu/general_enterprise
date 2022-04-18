import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class PostListReportPToThing extends StatefulWidget {
  PostListReportPToThing({this.type, this.title, this.dutyId});
  final int type;
  final String title;
  final int dutyId;
  @override
  _PostListReportPToThingState createState() => _PostListReportPToThingState();
}

class _PostListReportPToThingState extends State<PostListReportPToThing> {
  Map data = {};
  List listJobUserAndReport = [];
  List reportData = [];

  @override
  void initState() {
    super.initState();
    _getData(widget.type, widget.title, widget.dutyId);
  }

  _getData(int type, String title, int dutyId) {
    myDio.request(type: 'get', url: Interface.getPostReport, queryParameters: {
      "type": type,
      "title": title,
      'dutyId': dutyId,
    }).then((value) {
      if (value is Map) {
        data = value;
        reportData = value['reportData'];
        listJobUserAndReport = value['listJobUserAndReport'];
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  _getText(String text) {
    List strings;
    List strings2;
    String str = '';
    String string = '';
    strings = text.split('<span class=\"contolr-number\">');
    strings.forEach((f) {
      if (str == '') {
        str = "$f";
      } else {
        str = "$str$f";
      }
    });
    strings2 = str.split('</span>');
    strings2.forEach((f) {
      if (string == '') {
        string = "$f";
      } else {
        string = "$string$f";
      }
    });
    return string;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_post_list_report.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: data.isNotEmpty
            ? Container(
                margin: EdgeInsets.symmetric(
                    vertical: size.width * 120, horizontal: size.width * 50),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 30,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.clear,
                            color: Color(0xff9C9C9C),
                            size: size.width * 67,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Color(0xff3072FE),
                          height: size.width * 2,
                          width: size.width * 67,
                        ),
                        SizedBox(
                          width: size.width * 28,
                        ),
                        Text(
                          '岗位责任清单报表',
                          style: TextStyle(
                              color: Color(0xff3776FE),
                              fontSize: size.width * 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.width * 28,
                        ),
                        Container(
                          color: Color(0xff3072FE),
                          height: size.width * 2,
                          width: size.width * 67,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Center(
                          child: Text(
                            data['liabilityTitle'].toString(),
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: size.width * 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: size.width * 40,
                    ),
                    Container(
                        width: double.infinity,
                        height: size.width * 300,
                        color: Color(0xffF6F6F6),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 20,
                            vertical: size.width * 25),
                        child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: reportData.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _getText(reportData[index]['report']),
                                    style: TextStyle(
                                        color: Color(0xff373636),
                                        fontSize: size.width * 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (reportData[index]['type'] == 1) {
                                        return;
                                      }
                                      if (reportData[index]['type'] == 5) {
                                        Navigator.pushNamed(
                                            context, '/legitimate/legitimate');
                                      } else {
                                        Navigator.pushNamed(context,
                                            '/index/productList/PostWorkDetail',
                                            arguments: {
                                              "data": reportData[index]
                                            });
                                      }
                                    },
                                    child: Text(
                                      '详细',
                                      style: TextStyle(
                                          color: Color(0xff408CE2),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              );
                            })),
                    SizedBox(
                      height: size.width * 30,
                    ),
                    listJobUserAndReport.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                itemCount: listJobUserAndReport.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: size.width * 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: size.width * 240,
                                              height: size.width * 58,
                                              decoration: BoxDecoration(
                                                color: Color(0xffF6F6F6),
                                                border: Border.all(
                                                    width: size.width * 2,
                                                    color: Color(0xff999999)),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '清单签收人：${listJobUserAndReport[index]['nickname']}',
                                                style: TextStyle(
                                                    color: Color(0xff666666),
                                                    fontSize: size.width * 22),
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 360,
                                              height: size.width * 58,
                                              decoration: BoxDecoration(
                                                color: Color(0xffF6F6F6),
                                                border: Border(
                                                  top: BorderSide(
                                                    width: size.width * 2,
                                                    color: Color(0xff999999),
                                                  ),
                                                  bottom: BorderSide(
                                                    width: size.width * 2,
                                                    color: Color(0xff999999),
                                                  ),
                                                  right: BorderSide(
                                                    width: size.width * 2,
                                                    color: Color(0xff999999),
                                                  ),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '签收时间：${listJobUserAndReport[index]['createDate']}',
                                                style: TextStyle(
                                                    color: Color(0xff666666),
                                                    fontSize: size.width * 22),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: size.width * 600,
                                          height: size.width * 58,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              left: BorderSide(
                                                width: size.width * 2,
                                                color: Color(0xff999999),
                                              ),
                                              bottom: BorderSide(
                                                width: size.width * 2,
                                                color: Color(0xff999999),
                                              ),
                                              right: BorderSide(
                                                width: size.width * 2,
                                                color: Color(0xff999999),
                                              ),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Image.network(
                                              listJobUserAndReport[index]
                                                  ['sign']),
                                        ),
                                      ],
                                    ),
                                  );
                                }))
                        : Text(
                            '未签收',
                            style: TextStyle(
                                fontSize: size.width * 26,
                                color: Color(0xff408CE2),
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
