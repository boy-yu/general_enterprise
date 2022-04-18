import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/myAppbar.dart';

class NormalInformation extends StatefulWidget {
  NormalInformation({this.arguments});
  final arguments;
  @override
  _NormalInformationState createState() =>
      _NormalInformationState(arguments: arguments);
}

class _NormalInformationState extends State<NormalInformation> {
  SharedPreferences prefs;
  _NormalInformationState({this.arguments});
  final arguments;
  List msgList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(arguments);
    double width = size.width;

    return MyAppbar(
      title: Text(arguments['title'].toString()),
      child: Padding(
        padding: EdgeInsets.only(
            left: width * 30, right: width * 30, top: size.width * 40),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: size.width * 30),
                  child: Text(
                    "部门作业信息",
                    style: TextStyle(
                        color: Color(0xffFF121922), fontSize: width * 36),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffFFF8F8FF),
                        ),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text(
                        "序号",
                        style: TextStyle(color: Color(0xffFF7C838D)),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("部门"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text(
                        "申请",
                        style: TextStyle(color: Color(0xffFF121922)),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("审核"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border(
                            top: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 2,
                            ),
                            bottom: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("审批"),
                    ))
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffFFF8F8FF),
                        ),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text(
                        "1",
                        style: TextStyle(color: Color(0xff157afb)),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("精馏"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text(
                        "6",
                        style: TextStyle(color: Color(0xffFF121922)),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("6"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                            top: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 2,
                            ),
                            bottom: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("6"),
                    ))
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      bottom: size.width * 30, top: size.width * 30),
                  child: Text(
                    "人员作业信息",
                    style: TextStyle(
                        color: Color(0xffFF121922), fontSize: width * 36),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffFFF8F8FF),
                        ),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text(
                        "序号",
                        style: TextStyle(color: Color(0xffFF7C838D)),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("人员"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text(
                        "申请",
                        style: TextStyle(color: Color(0xffFF121922)),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("监护"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border(
                            top: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 2,
                            ),
                            bottom: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("审核"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE4E4EE),
                        border: Border(
                            top: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 2,
                            ),
                            bottom: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("审批"),
                    ))
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffFFF8F8FF),
                        ),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text(
                        "1",
                        style: TextStyle(color: Color(0xff157afb)),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("明勇"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text(
                        "2",
                        style: TextStyle(color: Color(0xffFF121922)),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                            top: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            bottom: BorderSide(
                              // 设置单侧边框的样式
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("3"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                            top: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 2,
                            ),
                            bottom: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("1"),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                            top: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 2,
                            ),
                            bottom: BorderSide(
                              color: Color(0xffFFF8F8FF),
                              width: 1,
                            )),
                      ),
                      alignment: Alignment.center,
                      height: size.width * 110,
                      child: Text("0"),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
