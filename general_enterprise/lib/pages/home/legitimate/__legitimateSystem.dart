import 'package:enterprise/common/CustomTree.dart';
import 'package:enterprise/pages/home/legitimate/__fileManagement.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LegitimateSystem extends StatefulWidget {
  @override
  _LegitimateSystemState createState() => _LegitimateSystemState();
}

class _LegitimateSystemState extends State<LegitimateSystem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SystemTitleCard(),
        Expanded(
          child: SystemList(),
        )
      ],
    );
  }
}

class SystemTitleCard extends StatefulWidget {
  @override
  _SystemTitleCardState createState() => _SystemTitleCardState();
}

class _SystemTitleCardState extends State<SystemTitleCard> {
  List menuList = [];
  @override
  void initState() {
    super.initState();
    _getTitleFile();
  }

  _getTitleFile() {
    myDio.request(
        type: 'get',
        url: Interface.getFileListAll,
        queryParameters: {"type": 7}).then((value) {
      if (value != null) {
        if (value is List && value.isNotEmpty) {
          menuList = value;
          for (int i = 0; i < menuList.length; i++) {
            if (menuList[i]['expireDate'] != null &&
                menuList[i]['expireDate'] != '') {
              String expireDate =
                  menuList[i]['expireDate'].toString().substring(0, 10);
              DateTime dateTime = DateTime.now();
              String nowDate = dateTime.toString().substring(0, 10);
              int day = daysBetween(
                  DateTime.parse(expireDate), DateTime.parse(nowDate), false);
              if (0 <= day) {
                if (day <= 29) {
                  menuList[i]['dayState'] = '临期';
                } else {
                  menuList[i]['dayState'] = '正常';
                }
              } else {
                menuList[i]['dayState'] = '已过期';
              }
            } else {
              menuList[i]['dayState'] = '';
            }
          }
          if (menuList.length == 1) {
            menuList.add(
              {
                "id": -1,
                "name": "待添加文件",
                "companyId": -1,
                "type": -1,
                "needUpdated": -1,
                "fileValue": null,
                "expireDate": null,
                "createDate": "",
                "modifyDate": ""
              },
            );
            menuList.add(
              {
                "id": -1,
                "name": "待添加文件",
                "companyId": -1,
                "type": -1,
                "needUpdated": -1,
                "fileValue": null,
                "expireDate": null,
                "createDate": "",
                "modifyDate": ""
              },
            );
          } else if (menuList.length == 2) {
            menuList.add(
              {
                "id": -1,
                "name": "待添加文件",
                "companyId": -1,
                "type": -1,
                "needUpdated": -1,
                "fileValue": null,
                "expireDate": null,
                "createDate": "",
                "modifyDate": ""
              },
            );
          }
          if (mounted) {
            setState(() {});
          }
        } else {
          menuList.add(
            {
              "id": -1,
              "name": "待添加文件",
              "companyId": -1,
              "type": -1,
              "needUpdated": -1,
              "fileValue": null,
              "expireDate": null,
              "createDate": "",
              "modifyDate": ""
            },
          );
          menuList.add(
            {
              "id": -1,
              "name": "待添加文件",
              "companyId": -1,
              "type": -1,
              "needUpdated": -1,
              "fileValue": null,
              "expireDate": null,
              "createDate": "",
              "modifyDate": ""
            },
          );
          menuList.add(
            {
              "id": -1,
              "name": "待添加文件",
              "companyId": -1,
              "type": -1,
              "needUpdated": -1,
              "fileValue": null,
              "expireDate": null,
              "createDate": "",
              "modifyDate": ""
            },
          );
          if (mounted) {
            setState(() {});
          }
        }
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
      case '临期':
        return Image.asset(
          'assets/images/icon_legitimate_advent.png',
          height: size.width * 60,
          width: size.width * 60,
        );
        break;
      case '正常':
        return Container(
          height: size.width * 60,
          width: size.width * 60,
        );
        break;
      case '已过期':
        return Image.asset(
          'assets/images/icon_legitimate_stale.png',
          height: size.width * 60,
          width: size.width * 60,
        );
        break;
      case '':
        return Container(
          height: size.width * 60,
          width: size.width * 60,
        );
        break;
      default:
    }
  }

  _getUrl(String attachment) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(attachment), 'title': '查看文件'});
    // Navigator.pushNamed(context, '/webview', arguments: {
    //   'url': '${Interface.onlineWork}$attachment',
    //   'title': '查看文件'
    // });
  }

  //构建数据
  List<Widget> _buildChildren() {
    List<Widget> list = [];
    for (int i = 0; i < menuList.length; i++) {
      list.add(
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (menuList[i]['fileValue'] != null &&
                    menuList[i]['fileValue'] != '') {
                  _getUrl(menuList[i]['fileValue']);
                } else {
                  Fluttertoast.showToast(msg: '暂无文件');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xff9EE9FF),
                        Color(0xff80C1FF),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 20))),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 5),
                      child: Text(
                        menuList[i]['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 24,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Image.asset(
                      'assets/images/bg_file_title_card_ikon.png',
                      height: size.width * 143,
                      width: size.width * 140,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: menuList[i]['dayState'] != null
                  ? _getDayStateImage(menuList[i]['dayState'])
                  : Container(),
            ),
          ],
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.width * 412,
      // width: double.infinity,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/bg_file_title_card.png'),
      //     fit: BoxFit.cover
      //   ),
      // ),
      child: menuList.isNotEmpty
          ? FileTitleCardGridPage(
              children: _buildChildren(),
              column: 3,
              row: 1,
              columnSpacing: size.width * 20, //列间隔
              rowSpacing: 0, //行间隔
              itemRatio: 0.75, //每个item的宽高比，默认正方形
            )
          : Container(
              width: double.infinity,
              height: size.width * 324,
            ),
    );
  }
}

class SystemList extends StatefulWidget {
  @override
  _SystemListState createState() => _SystemListState();
}

class _SystemListState extends State<SystemList> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  @override
  void didUpdateWidget(SystemList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getDate();
  }

  _getDate() {
    myDio.request(
        type: 'get',
        url: Interface.getFileTypeTree,
        queryParameters: {"type": 3}).then((value) {
      if (value is List) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  _lookLicense(int id) {
    print(id);
    Navigator.pushNamed(context, '/legitimate/___fileList',
        arguments: {"id": id});
  }

  @override
  Widget build(BuildContext context) {
    return CoutomTree(
      treeData: data.isNotEmpty ? data : [],
      fuc: _lookLicense,
      file: 'file',
    );
  }
}
