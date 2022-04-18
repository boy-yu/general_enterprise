import 'package:enterprise/common/empty.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class FileList extends StatefulWidget {
  FileList({this.id});
  final int id;
  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getFileList();
  }

  _getFileList() {
    myDio
        .request(
      type: 'get',
      url: Interface.getFileListByTypeId + widget.id.toString(),
    )
        .then((value) {
      if (value is List) {
        data = value;
        for (int i = 0; i < data.length; i++) {
          if (data[i]['expireDate'] != null && data[i]['expireDate'] != '') {
            String expireDate =
                data[i]['expireDate'].toString().substring(0, 10);
            DateTime dateTime = DateTime.now();
            String nowDate = dateTime.toString().substring(0, 10);
            int day = daysBetween(
                DateTime.parse(expireDate), DateTime.parse(nowDate), false);
            if (0 <= day) {
              if (day <= 29) {
                data[i]['dayState'] = '临期';
              } else {
                data[i]['dayState'] = '正常';
              }
            } else {
              data[i]['dayState'] = '已过期';
            }
          } else {
            data[i]['dayState'] = '';
          }
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  static int daysBetween(DateTime a, DateTime b, [bool ignoreTime = false]) {
    if (ignoreTime) {
      int v = a.millisecondsSinceEpoch ~/ 86400000 -
          b.millisecondsSinceEpoch ~/ 86400000;
      if (v < 0) return -v;
      return v;
    } else {
      int v = a.millisecondsSinceEpoch - b.millisecondsSinceEpoch;
      // if (v < 0) v = -v;
      return v ~/ 86400000;
    }
  }

  _getDayStateImage(String dayState) {
    switch (dayState) {
      case '已过期':
        return Image.asset(
          'assets/images/icon_legitimate_stale.png',
          height: size.width * 100,
          width: size.width * 100,
        );
        break;
      case '正常':
        return Container(
          height: size.width * 100,
          width: size.width * 100,
        );
        break;
      case '临期':
        return Image.asset(
          'assets/images/icon_legitimate_advent.png',
          height: size.width * 100,
          width: size.width * 100,
        );
        break;
      case '':
        return Container(
          height: size.width * 100,
          width: size.width * 100,
        );
        break;
      default:
    }
  }

  _getUrl(String attachment) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(attachment), 'title': '查看文件'});
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('文件列表'),
        child: data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (builder, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 10, horizontal: size.width * 20),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            _getUrl(data[index]['fileUrl']);
                          },
                          child: Container(
                            height: size.width * 207,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 80,
                                        height: size.width * 80,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF1F8FF),
                                            borderRadius:
                                                BorderRadius.circular(1000)),
                                        child: Text(
                                          (index + 1).toString(),
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: size.width * 36,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          data[index]['name'].toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 28,
                                              color: Color(0xff333333)),
                                        ),
                                        SizedBox(
                                          height: size.width * 10,
                                        ),
                                        Text(
                                          data[index]['expireDate']
                                                      .toString()
                                                      .length >
                                                  10
                                              ? '到期时间：' +
                                                  data[index]['expireDate']
                                                      .toString()
                                                      .substring(0, 10)
                                              : "到期时间：永久",
                                          style: TextStyle(
                                              fontSize: size.width * 28,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: data[index]['dayState'] != null
                              ? _getDayStateImage(data[index]['dayState'])
                              : Container(),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Empty());
  }
}
