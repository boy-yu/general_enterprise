import 'package:enterprise/common/CustomTree.dart';
import 'package:enterprise/pages/home/legitimate/__fileManagement.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LicenseType extends StatefulWidget {
  LicenseType({this.arguments});
  final arguments;
  @override
  _LicenseTypeState createState() => _LicenseTypeState();
}

class _LicenseTypeState extends State<LicenseType> {
  List licenseData = [];
  @override
  void initState() {
    super.initState();
    _getTitleFile();
    _getTreeDate();
  }

  @override
  void didUpdateWidget(LicenseType oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getTreeDate();
  }

  _getTreeDate() {
    myDio.request(
        type: 'get',
        url: Interface.licenceTree,
        queryParameters: {"type": widget.arguments['type']}).then((value) {
      if (value != null) {
        licenseData = value;
      }
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  _lookLicense(int id, int fixedType) {
    Navigator.pushNamed(context, '/legitimate/_checkedLicence', arguments: {
      "id": id,
      "fixedType": fixedType,
      'type': widget.arguments['type'],
    });
  }

  List menuList = [];

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

  _getTitleFile() {
    myDio.request(
        type: 'get',
        url: Interface.getFileListAll,
        queryParameters: {"type": 5}).then((value) {
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

  _getUrl(String attachment) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(attachment), 'title': '查看文件'});
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        menuList.isNotEmpty && widget.arguments['type'] == 2
            ? FileTitleCardGridPage(
                children: _buildChildren(),
                column: 3,
                row: 1,
                columnSpacing: size.width * 20, //列间隔
                rowSpacing: 0, //行间隔
                itemRatio: 0.75, //每个item的宽高比，默认正方形
              )
            : Container(),
        CoutomTree(
          treeData: licenseData,
          fuc: _lookLicense,
        ),
      ],
    );
  }
}
