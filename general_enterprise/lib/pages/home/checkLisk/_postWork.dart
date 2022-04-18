import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class PostWork extends StatefulWidget {
  @override
  _PostWorkState createState() => _PostWorkState();
}

class _PostWorkState extends State<PostWork> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('我的岗位责任清单'),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 20),
          child: MyRefres(
              child: (index, list) => Padding(
                  padding: EdgeInsets.only(top: size.width * 20),
                  child: Card(
                      elevation: 5,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 39,
                              size.width * 22,
                              size.width * 39,
                              size.width * 33),
                          child: Text((index + 1).toString() +
                              '  ' +
                              list[index]['responsibility'].toString())))),
              url: Interface.getMyCompletedListJobRolesDuty,
              method: 'get')
      ),
    );
  }
}
