import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/checkLisk/__inspection.dart';
import 'package:enterprise/service/context.dart';
// import 'package:enterprise/tool/dio.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class CheckPostGuard extends StatefulWidget {
  CheckPostGuard(
      {this.title, this.status, this.type, this.rolesId, this.userId});
  final String title;
  final int status, type, rolesId, userId;
  @override
  _CheckPostGuardState createState() => _CheckPostGuardState();
}

class _CheckPostGuardState extends State<CheckPostGuard> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    if (widget.userId == null) {
      _getHiddenList();
    } else {
      _getdata();
    }
  }

  Widget child(int index, List list) {
    Widget _widget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
              margin: EdgeInsets.only(left: size.width * 30),
              color: themeColor,
              padding: EdgeInsets.only(
                  left: size.width * 20, right: size.width * 40),
              child: Text(
                list[index]['keyParameterIndex'].toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 32,
                    fontWeight: FontWeight.bold),
              )),
        ),
        ChecklistInspection(
          dataMap: list[index],
          callback: () {
            // Navigator.pushNamed(
            //     context, '/home/hiddenScreening',
            //     arguments: {
            //       "id": data[index]['bookId'],
            //       "type": data[index]['status'],
            //       "title": data[index]['keyParameterIndex']
            //           .toString(),
            //       'authority': data[index]
            //           ['controlOperable'],
            //       'data': data[index]
            //     }).then((value) {
            //   _getData();
            // });
          },
        )
      ],
    );
    return _widget;
  }

  List<Map> data = [
    {
      "type": 1,
      'value': ['清单签收人', '暂未签收', '时间', '']
    },
    {
      "type": 1,
      'value': [
        '',
      ],
    },
    {
      "type": 2,
      'value': [],
    },
    {"type": 3, 'value': '签字：', 'image': ''},
  ];
  _getdata() {
    myDio.request(type: 'get', url: Interface.getPostReport, queryParameters: {
      "status": widget.status,
      "type": widget.type,
      "rolesId": widget.rolesId,
      "userId": widget.userId,
      "title": widget.title,
    }).then((value) {
      if (value is Map) {
        if (value['nickname'] == null || value['nickname'] == '') {
          data[0]['value'][1] = '暂未签收';
        } else {
          data[0]['value'][1] = value['nickname'];
        }
        // data[0]['value'][1] = value['nickname'];
        data[0]['value'][3] = value['time'] ?? '';
        data[1]['value'][0] = widget.title;
        data[2]['value'] = value['reportData'];
        data[3]['image'] = value['sign'];
        if (data[0]['value'][3].toString().length > 16) {
          data[0]['value'][3] = data[0]['value'][3].toString().substring(0, 16);
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getHiddenList() {
    data.removeAt(3);
    show = true;
    myDio.request(
        type: 'get',
        url: Interface.getCheckPostReport,
        queryParameters: {
          "type": widget.type,
          "rolesId": widget.rolesId,
          "title": widget.title
        }).then((value) {
      if (value is Map) {
        print(value);
        if (value['nickname'] == null || value['nickname'] == '') {
          data[0]['value'][1] = '暂未签收';
        } else {
          data[0]['value'][1] = value['nickname'];
        }
        data[1]['value'][0] = widget.title;
        data[2]['value'] = value['reportData'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _sumbitData() {
    myDio.request(type: 'post', url: Interface.postConfirmReport, data: {
      "rolesId": widget.rolesId,
      "liabilityTitle": widget.title,
      "reportData": data[2]['value']
    }).then((value) {
      successToast('成功');
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('日常岗位清单'),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.all(size.width * 20),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(width: 1, color: placeHolder),
                  top: BorderSide(width: 1, color: placeHolder),
                  right: BorderSide(width: 1, color: placeHolder),
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.map((ele) {
                    if (ele['type'] == 1) {
                      return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: placeHolder, width: 1))),
                          child: Row(
                            children:
                                ele['value'].asMap().keys.map<Widget>((_index) {
                              if (ele['value'].length == 1) {
                                return Expanded(
                                    child: Container(
                                  padding: EdgeInsets.all(size.width * 20),
                                  child: Text(
                                    ele['value'][_index].toString(),
                                  ),
                                ));
                              }

                              if (ele['value'][_index] == '') {
                                return Container();
                              }
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: _index == ele['value'].length - 1
                                            ? BorderSide.none
                                            : BorderSide(
                                                width: 1, color: placeHolder))),
                                padding: EdgeInsets.all(size.width * 16),
                                child: Text(
                                  ele['value'][_index].toString(),
                                  style: TextStyle(fontSize: size.width * 30),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }).toList(),
                          ));
                    } else if (ele['type'] == 3) {
                      return Container(
                          padding: EdgeInsets.only(left: size.width * 20),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: placeHolder, width: 1))),
                          child: Row(children: [
                            Text(
                              ele['value'].toString(),
                              textAlign: TextAlign.center,
                            ),
                            Expanded(
                                child: Container(
                              child:
                                  ele['image'].toString().indexOf('http') > -1
                                      ? Image.network(
                                          ele['image'].toString(),
                                          height: size.width * 100,
                                        )
                                      : Container(
                                          height: size.width * 100,
                                        ),
                            ))
                          ]));
                    } else {
                      return Column(
                        children: ele['value']
                            .asMap()
                            .keys
                            .map<Widget>((_index) => Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: placeHolder))),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width * 100,
                                        alignment: Alignment.center,
                                        child: Text((_index + 1).toString()),
                                      ),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          if (ele['value'][_index]['type'] == 1)
                                            return;
                                          if (ele['value'][_index]['type'] ==
                                              5) {
                                            Navigator.pushNamed(context,
                                                '/legitimate/legitimate');
                                          } else {
                                            Navigator.pushNamed(context,
                                                '/index/productList/PostWorkDetail',
                                                arguments: {
                                                  "data": ele['value'][_index]
                                                });
                                          }
                                        },
                                        child: Container(
                                          height: ele['value'].length < 4
                                              ? (size.width * 720) /
                                                  ele['value'].length
                                              : null,
                                          padding: EdgeInsets.only(
                                              left: size.width * 20,
                                              right: size.width * 20,
                                              top: size.width * 30),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: Colors.black54,
                                                      width: 1))),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: SingleChildScrollView(
                                                child: Text(
                                                  ele['value'][_index]['report']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: placeHolder),
                                                ),
                                              )),
                                              ele['value'][_index]['type'] != 1
                                                  ? Row(
                                                      children: [
                                                        Spacer(),
                                                        Text(
                                                          '详情',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              color:
                                                                  themeColor),
                                                        )
                                                      ],
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: size.width * 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
                    }
                  }).toList(),
                ),
              ),
            )),
            widget.userId == null
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: _sumbitData,
                    child: Text(
                      '签收',
                      style: TextStyle(color: Color(0xff2D69FB)),
                    ),
                  )
                : Container()
          ],
        ));
  }
}
