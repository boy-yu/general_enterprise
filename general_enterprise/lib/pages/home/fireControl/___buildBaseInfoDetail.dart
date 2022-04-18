import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class BuildDetail extends StatefulWidget {
  final List<HiddenDangerInterface> iconList;
  final int choosed;
  final String title;
  final Map queryParameters;

  const BuildDetail(
      {Key key, this.iconList, this.choosed, this.title, this.queryParameters})
      : super(key: key);
  @override
  _BuildDetailState createState() => _BuildDetailState();
}

class _BuildDetailState extends State<BuildDetail> {
  int choose = 0;

  @override
  void initState() {
    super.initState();
    choose = widget.choosed ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(widget.title),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: size.width * 90),
              child: MyRefres(
                child: (index, list) => Container(
                  margin: EdgeInsets.only(
                      top: size.width * 20,
                      left: size.width * 20,
                      right: size.width * 20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2), blurRadius: 2)
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(list[index]['name']),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Color(0xff3174FF).withOpacity(.2),
                                  borderRadius: BorderRadius.circular(34)),
                              child: Text(
                                list[index]['type'],
                                style: TextStyle(
                                    fontSize: size.width * 20,
                                    color: Color(0xff3174FF)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(height: 2),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text('建筑物类型：'),
                            Text(list[index]['buildingType'].toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text('建筑物结构：'),
                            Text(list[index]['structure'].toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text('防火等级：'),
                            Text(list[index]['fireRating'].toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text('施工单位：'),
                            Text(list[index]['constructionUnit'].toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text('维保单位：'),
                            Text(list[index]['maintenanceUnit'].toString()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                url: Interface.getBuildBaseInfoDetail,
                method: 'get',
                queryParameters: {"oneId": widget.iconList[choose].id},
              ),
            ),
            LeftBar(
              iconList: widget.iconList,
              callback: (index) {
                choose = index;
                setState(() {});
              },
            )
          ],
        ));
  }
}
