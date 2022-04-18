import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DangerEquiment extends StatefulWidget {
  DangerEquiment({this.id, this.choose});
  final int id;
  final int choose;
  @override
  _DangerEquimentState createState() => _DangerEquimentState();
}

class _DangerEquimentState extends State<DangerEquiment> {
  Widget title(String title) {
    Widget _widget;
    _widget = Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: size.width * 20),
            width: size.width * 6,
            height: size.width * 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: LinearGradient(colors: [
                  Color(0xff2AC79B),
                  Color(0xff3174FF),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.width * 30),
          )
        ],
      ),
    );
    return _widget;
  }

  ThrowFunc _throwFunc = ThrowFunc();
  List data = [];

  @override
  void initState() {
    super.initState();
    // _getData();
  }

  // _getData() {
  //   myDio.request(type: 'get', url: Interface.getBaseList, queryParameters: {
  //     "majorId": widget.id,
  //     "type": widget.choose
  //   }).then((value) {
  //     if (value is List) {
  //       data = value;
  //       setState(() {});
  //     }
  //   });
  // }

  @override
  void didUpdateWidget(covariant DangerEquiment oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _throwFunc.run();
  }

  Widget body(Map dataMap) {
    Widget _widget = Container();
    if (widget.choose == 5) {
      _widget = Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            if (dataMap['fileUrl'] != '') {
              Navigator.pushNamed(context, '/webview', arguments: {
                'url': Interface.online(dataMap["fileUrl"]),
                'title': dataMap['name'] ?? ''
              });
            } else {
              Fluttertoast.showToast(msg: '未找到文件');
            }
          },
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 20, vertical: size.width * 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataMap['name'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: size.width * 30),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text('编制人:'),
                      Text(dataMap['editor'].toString())
                    ],
                  ),
                  Row(
                    children: [
                      Text('审核人：'),
                      Text(dataMap['reviewer']),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 22,
                            vertical: size.width * 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff3869FC),
                        ),
                        child: Text(
                          '查看',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [Text('审批人：'), Text(dataMap['approver'])],
                  ),
                  Row(
                    children: [
                      Text('审批时间：'),
                      Text(dataMap['approverTime'].toString().split('T')[0])
                    ],
                  ),
                ],
              )),
        ),
      );
    } else {
      _widget = Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            if (dataMap['fileUrl'] != '') {
              Navigator.pushNamed(context, '/webview', arguments: {
                'url': Interface.online(dataMap["fileUrl"]),
                'title': dataMap['name'] ?? ''
              });
            } else {
              Fluttertoast.showToast(msg: '未找到文件');
            }
          },
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 20, vertical: size.width * 10),
              child: Column(
                children: [
                  title(dataMap['name'].toString()),
                  Divider(),
                  Row(
                    children: [Text('数量：'), Text(dataMap['num'].toString())],
                  ),
                  Row(
                    children: [
                      Text('管控情况：'),
                      Text(dataMap['status'] == 1 ? '受控' : '不受控')
                    ],
                  ),
                  Row(
                    children: [Text('备注：'), Text(dataMap['memo'])],
                  ),
                ],
              )),
        ),
      );
    }
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return MyRefres(
      child: (index, list) => Padding(
        padding: EdgeInsets.only(
            left: size.width * 20,
            right: size.width * 10,
            top: size.width * 10),
        child: body(list[index]),
      ),
      url: Interface.getBaseList,
      method: 'get',
      throwFunc: _throwFunc,
      queryParameters: {"majorId": widget.id, "type": widget.choose},
    );

    // ListView.builder(
    //   itemBuilder: (context, index) => Padding(
    //     padding: EdgeInsets.only(
    //         left: size.width * 20,
    //         right: size.width * 10,
    //         top: size.width * 10),
    //     child: body(data[index]),
    //   ),
    //   itemCount: data.length,
    // );
  }
}
