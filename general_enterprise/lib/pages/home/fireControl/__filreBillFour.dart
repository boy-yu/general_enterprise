import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class FileBillFour extends StatefulWidget {
  FileBillFour({this.leftBar});
  final List<HiddenDangerInterface> leftBar;
  @override
  _FileBillFourState createState() => _FileBillFourState();
}

class _FileBillFourState extends State<FileBillFour> {
  Widget common(Widget child) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 20),
        child: child);
  }

  Widget title(String text) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 10, vertical: size.width * 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xff3073FE),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: size.width * 20),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('上级传下来的标题'),
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: size.width * 90),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        size.width * 10, size.width * 20, size.width * 10, 0),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.width * 20,
                          ),
                          common(Row(
                            children: [
                              title('隐患排查'),
                              SizedBox(
                                width: size.width * 20,
                              ),
                              Text('XXXXXX四级项')
                            ],
                          )),
                          Divider(),
                          common(Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: '排查措施:',
                                      style: TextStyle(
                                          color: themeColor,
                                          fontSize: size.width * 20),
                                    ),
                                    TextSpan(
                                      text:
                                          '危险性的作业场所，必须设计防火墙和安全通道，出入口不应少于两个，门窗应向外开启，通道和出入口应保持畅通。',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.6),
                                          fontSize: size.width * 20),
                                    )
                                  ]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 30),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 20,
                                        vertical: size.width * 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: themeColor, width: 1),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text('台账',
                                        style: TextStyle(
                                            color: themeColor,
                                            fontSize: size.width * 18)),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          SizedBox(
                            height: size.width * 20,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            LeftBar(
              iconList: widget.leftBar,
              callback: (index) {},
            )
          ],
        ));
  }
}
