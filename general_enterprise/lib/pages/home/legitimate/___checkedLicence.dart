import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class CheckedLicence extends StatefulWidget {
  CheckedLicence({this.id, this.fixedType, this.type});
  final int id;
  final int fixedType;
  final int type;
  @override
  _CheckedLicence createState() => _CheckedLicence();
}

class _CheckedLicence extends State<CheckedLicence> {
  @override
  void initState() {
    super.initState();
    _getMsg();
  }

  List enterpriseLicenceList = [];

  _getMsg() {
    myDio.request(type: 'get', url: Interface.licenceList + widget.id.toString(),
    queryParameters: {
      'current': 1,
      'size': 1000
    }).then((value) {
      if (value is Map) {
        enterpriseLicenceList = value['records'];
        if(widget.type == 0){
          for (int i = 0; i < enterpriseLicenceList.length; i++) {
          if (enterpriseLicenceList[i]['expireDate'] != null && enterpriseLicenceList[i]['expireDate'] != '') {
            String expireDate = enterpriseLicenceList[i]['expireDate'].toString().substring(0, 10);
            DateTime dateTime = DateTime.now();
            String nowDate = dateTime.toString().substring(0, 10);
            int day = daysBetween(DateTime.parse(expireDate), DateTime.parse(nowDate), false);
            if (0 <= day) {
              if (day <= 90) {
                enterpriseLicenceList[i]['dayState'] = '临期';
              } else {
                enterpriseLicenceList[i]['dayState'] = '正常';
              }
            } else {
              enterpriseLicenceList[i]['dayState'] = '已过期';
            }
          } else {
            enterpriseLicenceList[i]['dayState'] = '';
          }
        }
        }else{
          for (int i = 0; i < enterpriseLicenceList.length; i++) {
            if (enterpriseLicenceList[i]['expireDate'] != null &&
                enterpriseLicenceList[i]['expireDate'] != '') {
              String expireDate = enterpriseLicenceList[i]['expireDate']
                  .toString()
                  .substring(0, 10);
              DateTime dateTime = DateTime.now();
              String nowDate = dateTime.toString().substring(0, 10);
              int day = daysBetween(
                  DateTime.parse(expireDate), DateTime.parse(nowDate), false);
              if (0 <= day) {
                if (day <= 29) {
                  enterpriseLicenceList[i]['dayState'] = '临期';
                } else {
                  enterpriseLicenceList[i]['dayState'] = '正常';
                }
              } else {
                enterpriseLicenceList[i]['dayState'] = '已过期';
              }
            } else {
              enterpriseLicenceList[i]['dayState'] = '';
            }
          }
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
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

  static int daysBetween(DateTime a, DateTime b, [bool ignoreTime = false]) {
    if (ignoreTime) {
      int v = a.millisecondsSinceEpoch ~/ 86400000 -
          b.millisecondsSinceEpoch ~/ 86400000;
      if (v < 0) return -v;
      return v;
    } else {
      int v = a.millisecondsSinceEpoch - b.millisecondsSinceEpoch;
      return v ~/ 86400000;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return MyAppbar(
      title: Text(
        '证书列表',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width * 36,
            color: Colors.white),
      ),
      child: enterpriseLicenceList.isNotEmpty
          ? ListView.builder(
              itemCount: enterpriseLicenceList.length,
              shrinkWrap: true,
              itemBuilder: (builder, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * 10, horizontal: size.width * 20),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/legitimate/__licenseDetails',
                              arguments: {
                                "id": enterpriseLicenceList[index]['id'],
                                'fixedType': widget.fixedType
                              }).then((value) => {
                                _getMsg(),
                              });
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
                                      width: width * 80,
                                      height: width * 80,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF1F8FF),
                                          borderRadius:
                                              BorderRadius.circular(1000)),
                                      child: Text(
                                        (index + 1).toString(),
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: width * 36,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        enterpriseLicenceList[index]['name']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: width * 24,
                                            color: Color(0xff333333)),
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Text(
                                        enterpriseLicenceList[index]
                                                ['licensedObject']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: width * 30,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.width * 10,
                                      ),
                                      Text(
                                        '到期时间：' +
                                            ((enterpriseLicenceList[index]
                                                                ['expireDate']
                                                            .toString())
                                                        .length >
                                                    11
                                                ? enterpriseLicenceList[index]
                                                        ['expireDate']
                                                    .toString()
                                                    .substring(0, 10)
                                                : '永久有效'),
                                        style: TextStyle(
                                            fontSize: width * 28,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(flex: 1),
                                FadeInImage(
                                  placeholder: AssetImage(
                                      'assets/images/image_recent_control.jpg'),
                                  image: enterpriseLicenceList[index]['frontPicture'] != null && enterpriseLicenceList[index]['frontPicture'] != ''? NetworkImage(
                                    enterpriseLicenceList[index]['frontPicture']
                                        .toString(),
                                  ) : AssetImage(
                                      'assets/images/image_recent_control.jpg'),
                                  fit: BoxFit.cover,
                                  width: width * 131,
                                  height: width * 131,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: enterpriseLicenceList[index]['dayState'] != null
                            ? _getDayStateImage(
                                enterpriseLicenceList[index]['dayState'])
                            : Container(),
                      ),
                    ],
                  ),
                );
              },
            )
          : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                      ),
                      Image.asset(
                        "assets/images/empty@2x.png",
                        height: size.width * 288,
                        width: size.width * 374,
                      ),
                      Text(
                        '暂无数据'
                      )
                    ],
                  )
    );
  }
}
