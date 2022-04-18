import 'package:enterprise/pages/home/legitimate/__fileManagement.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BasicMessage extends StatefulWidget {
  @override
  _BasicMessage createState() => _BasicMessage();
}

class _BasicMessage extends State<BasicMessage> {
  List majorHazards = [];
  List chemicals = [];
  List regulatoryChemicalProcesses = [];
  List menuList = [];

  List basicMessageList = [
    {
      "dangerousSources": "重大危险源：",
      "chemical": "重点监管危险化学品：",
      "chemicalTechnology": "重点监管危险化工工艺："
    }
  ];
  List enterpriseList = [
    {
      "name": "企业名称",
      "dataName": 'enterName',
      "value": '',
    },
    {
      "name": "企业法人",
      "value": "",
      "dataName": 'corpdeleg',
    },
    // {"name": "集团公司", "value": "", "dataName": ''},
    {"name": "行业类别", "value": "", "dataName": 'tradeType'},
    {"name": "企业类别", "value": "", "dataName": 'enterGrade'},
    {"name": "企业规模", "value": "", "dataName": 'enterpriseScale'},
    {"name": "归属地区", "value": "", "dataName": 'administrativeAreas'},
    {"name": "从业人员数量", "value": "", "dataName": 'employeeNum'},
    {"name": "占地面积", "value": "", "dataName": 'coversAnArea'},
    {"name": "经营范围", "value": "", "dataName": 'wordRange'},
  ];

  @override
  void initState() {
    super.initState();
    _getTitleFile();
    _getBasicMessage();
    _getMajorHazards();
    _getChemicals();
    _getRegulatoryChemicalProcesses();
  }

  _getTitleFile() {
    myDio.request(
        type: 'get',
        url: Interface.getFileListAll,
        queryParameters: {"type": 1}).then((value) {
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

  _getBasicMessage() {
    myDio.request(type: 'get', url: Interface.basicMessage).then((value) {
      Map temp = value;
      // // 重大危险源信息
      // majorHazards = value['coMajorHazards'];
      // // 企业化学品信息
      // chemicals = value['coChemicals'];
      // // 重点监管危险化工工艺
      // regulatoryChemicalProcesses = value['coRegulatoryChemicalProcesses'];
      temp.forEach((key, value) {
        for (int x = 0; x < enterpriseList.length; x++) {
          if (enterpriseList[x]['dataName'] == key) {
            enterpriseList[x]['value'] = value.toString();
          }
          if (enterpriseList[x]['value'] == '') {
            enterpriseList[x]['value'] = '未设置';
          }
        }
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  _getMajorHazards() {
    myDio.request(type: 'get', url: Interface.getMajorHazardList).then((value) {
      // 重大危险源信息
      majorHazards = value;
      // // 企业化学品信息
      // chemicals = value['coChemicals'];
      // // 重点监管危险化工工艺
      // regulatoryChemicalProcesses = value['coRegulatoryChemicalProcesses'];
      if (mounted) {
        setState(() {});
      }
    });
  }

  _getChemicals() {
    myDio.request(type: 'get', url: Interface.getChemicalList).then((value) {
      // 重大危险源信息
      // majorHazards = value;
      // // 企业化学品信息
      chemicals = value;
      // // 重点监管危险化工工艺
      // regulatoryChemicalProcesses = value['coRegulatoryChemicalProcesses'];
      if (mounted) {
        setState(() {});
      }
    });
  }

  _getRegulatoryChemicalProcesses() {
    myDio
        .request(type: 'get', url: Interface.getChemicalsProcessList)
        .then((value) {
      // 重大危险源信息
      // majorHazards = value;
      // // 企业化学品信息
      // chemicals = value;
      // // 重点监管危险化工工艺
      regulatoryChemicalProcesses = value;
      if (mounted) {
        setState(() {});
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

  _getImage(int level) {
    switch (level) {
      case 1:
        return AssetImage('assets/images/level_bg_one.png');
        break;
      case 2:
        return AssetImage('assets/images/level_bg_two.png');
        break;
      case 3:
        return AssetImage('assets/images/level_bg_three.png');
        break;
      case 4:
        return AssetImage('assets/images/level_bg_four.png');
        break;
      default:
    }
  }

  _getLevel(int level) {
    switch (level) {
      case 1:
        return '一级重大危险源';
        break;
      case 2:
        return '二级重大危险源';
        break;
      case 3:
        return '三级重大危险源';
        break;
      case 4:
        return '四级重大危险源';
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: basicMessageList.length,
        itemBuilder: (builder, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                children: <Widget>[
                  menuList.isNotEmpty
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
                  InkWell(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * 5,
                                horizontal: size.width * 10),
                            child: Text(
                              '基本信息：',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: size.width * 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          enterpriseList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: enterpriseList.length,
                                  shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                                  physics:
                                      NeverScrollableScrollPhysics(), //禁用滑动事件
                                  itemBuilder: (builder, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  enterpriseList[index]['name'],
                                                  style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: width * 30,
                                                  ),
                                                ),
                                                Spacer(flex: 1),
                                                Text(
                                                  enterpriseList[index]
                                                      ['value'],
                                                  style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: width * 30,
                                                  ),
                                                )
                                              ],
                                            ),
                                            index != enterpriseList.length - 1
                                                ? Container(
                                                    height: 2,
                                                    margin: EdgeInsets.only(
                                                        top: width * 15,
                                                        bottom: width * 5),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF2F3F8),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, .2),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ));
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            basicMessageList[index]['dangerousSources'],
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: width * 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: size.width * 240,
                          padding:
                              EdgeInsets.symmetric(vertical: size.width * 15),
                          child: majorHazards.isNotEmpty
                              ? ListView.builder(
                                  itemCount: majorHazards.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        height: size.width * 160,
                                        width: size.width * 450,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.width * 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: _getImage(
                                                  majorHazards[index]['level']),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              majorHazards[index]['status'] == 1
                                                  ? 'assets/images/icon_type_controlled.png'
                                                  : 'assets/images/icon_type_uncontrolled.png',
                                              height: size.width * 60,
                                              width: size.width * 60,
                                            ),
                                            Container(
                                              width: size.width * 350,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * 5,
                                                  vertical: size.width * 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '名称：${majorHazards[index]['name'].toString()}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 20),
                                                  ),
                                                  SizedBox(
                                                    height: size.width * 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '重大危险源等级',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    18),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        _getLevel(
                                                            majorHazards[index]
                                                                ['level']),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    18),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.width * 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '负责人',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    18),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        majorHazards[index]
                                                            ['principal'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    18),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.width * 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '危险化学品名称',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    18),
                                                      ),
                                                      Spacer(
                                                        flex: 1,
                                                      ),
                                                      Container(
                                                        width: size.width * 150,
                                                        child: Text(
                                                          majorHazards[index][
                                                                      'coChemicals'] !=
                                                                  null
                                                              ? majorHazards[
                                                                          index]
                                                                      [
                                                                      'coChemicals']
                                                                  .toString()
                                                              : '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  size.width *
                                                                      18),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            basicMessageList[index]['chemical'],
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: width * 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: size.width * 320,
                          padding:
                              EdgeInsets.symmetric(vertical: size.width * 15),
                          child: chemicals.isNotEmpty
                              ? ListView.builder(
                                  itemCount: chemicals.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            '/legitimate/___chemicalsDetails',
                                            arguments: {
                                              'msdsId': chemicals[index]
                                                  ['msdsId'],
                                              'labelUrl': chemicals[index]
                                                  ['labelUrl'],
                                            });
                                      },
                                      child: Container(
                                        // height: size.width * 300,
                                        width: size.width * 450,
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.width * 15,
                                            horizontal: size.width * 30),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.width * 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/images/bg_chemicals.png'),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '危险化学品名称',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  chemicals[index]
                                                      ['chemicalCnName'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '别名',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  chemicals[index]
                                                      ['chemicalCnNameTwo'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '危险化学品类型',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  chemicals[index]
                                                      ['chemicalsType'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '危险化学品种类',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  chemicals[index]
                                                      ['chemicalsSpecies'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'CAS号',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  chemicals[index]['casNo'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '生产能力',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  chemicals[index][
                                                      'productionCapacityYears'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '最大储存量',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  chemicals[index]
                                                      ['maxReserves'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.width * 20,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            basicMessageList[index]['chemicalTechnology'],
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: width * 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: size.width * 240,
                          padding:
                              EdgeInsets.symmetric(vertical: size.width * 15),
                          margin: EdgeInsets.only(bottom: size.width * 20),
                          child: regulatoryChemicalProcesses.isNotEmpty
                              ? ListView.builder(
                                  itemCount: regulatoryChemicalProcesses.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            '/legitimate/___processesDetails',
                                            arguments: {
                                              'id': regulatoryChemicalProcesses[
                                                  index]['id'],
                                            });
                                      },
                                      child: Container(
                                        height: size.width * 150,
                                        width: size.width * 450,
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.width * 25,
                                            horizontal: size.width * 30),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.width * 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/images/bg_regulatory_chemical.png'),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '化工工艺名称',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  regulatoryChemicalProcesses[
                                                      index]['processName'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '涉及区域/工序',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  regulatoryChemicalProcesses[
                                                      index]['areaOrProcess'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '负责人',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Text(
                                                  regulatoryChemicalProcesses[
                                                      index]['principal'],
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '自控系统',
                                                  style: TextStyle(
                                                      color: Color(0xff666666),
                                                      fontSize:
                                                          size.width * 20),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  child: Text(
                                                    regulatoryChemicalProcesses[
                                                            index]
                                                        ['autoControlSys'],
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff666666),
                                                        fontSize:
                                                            size.width * 20),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : Container(),
                        ),

                        // Container(
                        //   child: Table(
                        //     columnWidths: const {
                        //       0: FixedColumnWidth(40.0),
                        //       2: FixedColumnWidth(100.0),
                        //     },
                        //     border: TableBorder.all(
                        //       color: Colors.grey.shade300,
                        //       width: width * 1.0,
                        //     ),
                        //     children: [
                        //       TableRow(
                        //         children: [
                        //           SizedBox(
                        //             height: 25,
                        //             child: Center(
                        //               child: Text(
                        //                 "序号",
                        //                 style: TextStyle(
                        //                   color: Colors.grey,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: width * 22,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 25,
                        //             child: Center(
                        //               child: Text(
                        //                 "重点监管危险化工工艺名称",
                        //                 style: TextStyle(
                        //                   color: Colors.grey,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: width * 22,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 25,
                        //             child: Center(
                        //               child: Text(
                        //                 "涉及区域/工序",
                        //                 style: TextStyle(
                        //                   color: Colors.grey,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: width * 22,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       for (var i = 0;
                        //           i < regulatoryChemicalProcesses.length;
                        //           i++)
                        //         TableRow(
                        //           children: [
                        //             SizedBox(
                        //               height: 25,
                        //               child: Center(
                        //                 child: Text(
                        //                   (i + 1).toString(),
                        //                   style: TextStyle(
                        //                     color: Colors.grey,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: width * 22,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(
                        //               height: 25,
                        //               child: Center(
                        //                 child: Text(
                        //                   regulatoryChemicalProcesses[i]['name']
                        //                       .toString(),
                        //                   style: TextStyle(
                        //                     color: Colors.grey,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: width * 22,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(
                        //               height: 25,
                        //               child: Center(
                        //                 child: Text(
                        //                   regulatoryChemicalProcesses[i]
                        //                           ['areaOrProcess']
                        //                       .toString(),
                        //                   style: TextStyle(
                        //                     color: Colors.grey,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: width * 22,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}
