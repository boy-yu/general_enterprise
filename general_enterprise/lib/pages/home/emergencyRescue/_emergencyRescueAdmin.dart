import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueAdmin extends StatefulWidget {
  @override
  _EmergencyRescueAdminState createState() => _EmergencyRescueAdminState();
}

class _EmergencyRescueAdminState extends State<EmergencyRescueAdmin> {
  List dropList = [
    {
      'title': '事故类别',
      'data': [],
      'value': '',
      "saveTitle": '事故类别',
      // 'dataUrl': Interface.dropTerritorialUnitList
      'limit': 'accidentType'
    },
    {
      'title': '事故等级',
      'data': [],
      'value': '',
      "saveTitle": '事故等级',
      // 'dataUrl': Interface.dropTerritorialUnitList,
      'limit': 'accidentLevel'
    },
  ];

  Map queryParameters = {"current": 1, "size": 1000, 'accidentType': '', 'accidentLevel': '', 'keywords': ''};
  ThrowFunc throwFunc = ThrowFunc();

  _changeDrop() {
    for (var i = 0; i < dropList.length; i++) {
      if (dropList[i]['title'] != dropList[i]['saveTitle']) {
        queryParameters[dropList[i]['limit'].toString()] = dropList[i]['title'];
      } else {
        queryParameters[dropList[i]['limit']] = null;
      }
    }
    throwFunc.run();
    _getAdminData();
  }

  List data = [];

  @override
  void initState() {
    super.initState();
    _getAdminData();
    _getTypeOption();
    _getLevelOption();
  }

  _getTypeOption(){
    myDio.request(
      type: 'get',
      url: Interface.getOption,
      queryParameters: {
        'type': '事故类型'
      }
    ).then((value) {
      if (value is List) {
        dropList[0]['data'] = value;
        dropList[0]['data'].add(
          {
            'name': '查看全部',
          },
        );
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getLevelOption(){
    myDio.request(
      type: 'get',
      url: Interface.getOption,
      queryParameters: {
        'type': '事故级别'
      }
    ).then((value) {
      if (value is List) {
        dropList[1]['data'] = value;
        dropList[1]['data'].add(
          {
            'name': '查看全部',
          },
        );
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  String accidentType;
  String accidentLevel;

  _getAdminData(){
    myDio.request(
      type: 'get',
      url: Interface.getERAccident,
      queryParameters: Map<String, dynamic>.from(queryParameters)
    ).then((value) {
      if (value is Map) {
        data = value['records'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleChooseBar(dropList, 0, _changeDrop),
        Container(
          height: size.width * 1,
          width: double.infinity,
          color: Color(0xffEAEDF2),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: size.width * 25),
            child: data.isNotEmpty ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(
                      context, 
                      '/emergencyRescue/__emergencyRescueAdminDetails', 
                      arguments: {
                        'id': data[index]['id'],
                      }
                    );
                  },
                  child: Container(
                  margin: EdgeInsets.symmetric(vertical: size.width * 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                        blurRadius: 1.0, //阴影模糊程度
                        spreadRadius: 1.0 //阴影扩散程度
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 30),
                        child: Row(
                          children: [
                            Text(
                              data[index]['accidentName'],
                              style: TextStyle(
                                color: Color(0xff282828),
                                fontSize: size.width * 29,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              width: size.width * 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: size.width * 1, horizontal: size.width * 15),
                              decoration: BoxDecoration(
                                color: Color(0xff3174FF).withOpacity(0.14),
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                data[index]['accidentType'],
                                style: TextStyle(
                                  color: Color(0xff3174FF),
                                  fontSize: size.width * 22,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffEAEAEA),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: size.width * 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '事故损失（万元）',
                                  style: TextStyle(
                                    color: Color(0xff898989),
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * 10,
                                ),
                                Text(
                                  data[index]['economicLosses'].toString(),
                                  style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontSize: size.width * 25
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: size.width * 54,
                              width: size.width * 1.2,
                              color: Color(0xffCACACA),
                            ),
                            Column(
                              children: [
                                Text(
                                  '事故等级',
                                  style: TextStyle(
                                    color: Color(0xff898989),
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * 10,
                                ),
                                Text(
                                  data[index]['accidentLevel'].toString(),
                                  style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontSize: size.width * 25
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: size.width * 54,
                              width: size.width * 1.2,
                              color: Color(0xffCACACA),
                            ),
                            Column(
                              children: [
                                Text(
                                  '受伤人数',
                                  style: TextStyle(
                                    color: Color(0xff898989),
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * 10,
                                ),
                                Text(
                                  data[index]['injuredNum'].toString(),
                                  style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontSize: size.width * 25
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.width * 1,
                        width: double.infinity,
                        color: Color(0xffEAEAEA),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: size.width * 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width * 165,
                              child: Column(
                                children: [
                                  Text(
                                    '死亡人数',
                                    style: TextStyle(
                                      color: Color(0xff898989),
                                      fontSize: size.width * 22,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Text(
                                    data[index]['deathNum'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff4D4D4D),
                                      fontSize: size.width * 25
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: size.width * 54,
                              width: size.width * 1.2,
                              color: Color(0xffCACACA),
                            ),
                            Column(
                              children: [
                                Text(
                                  '赔偿金额',
                                  style: TextStyle(
                                    color: Color(0xff898989),
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * 10,
                                ),
                                Text(
                                  data[index]['compensationMo'].toString(),
                                  style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontSize: size.width * 25
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: size.width * 54,
                              width: size.width * 1.2,
                              color: Color(0xffCACACA),
                            ),
                            Column(
                              children: [
                                Text(
                                  '处罚金额',
                                  style: TextStyle(
                                    color: Color(0xff898989),
                                    fontSize: size.width * 22,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: size.width * 10,
                                ),
                                Text(
                                  data[index]['punishmentMo'].toString(),
                                  style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontSize: size.width * 25
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                );
              }
            ) : Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: size.width * 300),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/empty@2x.png",
                    height: size.width * 288,
                    width: size.width * 374,
                  ),
                  Text('暂无数据'),
                ],
              )),
          )
        )
      ],
    );
  }
}

class TitleChooseBar extends StatefulWidget {
  TitleChooseBar(this.list, this.index, this.getDataList);
  final int index;
  final List list;
  final Function getDataList;
  @override
  _TitleChooseBarState createState() => _TitleChooseBarState();
}

class _TitleChooseBarState extends State<TitleChooseBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.list.asMap().keys.map((i) {
      return Expanded(
          child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Color _juegeColor(Map _ele) {
            Color _color =
                widget.list[i]['value'] == '' && _ele['name'] == '查看全部'
                    ? themeColor
                    : widget.list[i]['value'] == _ele['name']
                        ? themeColor
                        : Colors.white;
            return _color;
          }
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return SingleChildScrollView(
                  child: Wrap(
                    children: widget.list[i]['data'].map<Widget>((_ele) {
                      Color _conColors = _juegeColor(_ele);
                      return GestureDetector(
                        onTap: () {
                          widget.list[i]['value'] = _ele['name'];
                          if (_ele['name'] == '查看全部') {
                            widget.list[i]['title'] =
                                widget.list[i]['saveTitle'];
                          } else {
                            widget.list[i]['title'] = _ele['name'];
                          }
                          if (mounted) {
                            setState(() {});
                          }
                          widget.getDataList();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: size.width * 20),
                          decoration: BoxDecoration(
                              color: _conColors,
                              border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: underColor))),
                          child: Center(
                            child: Text(
                              _ele['name'],
                              style: TextStyle(
                                  fontSize: size.width * 30,
                                  color: _conColors.toString() ==
                                          'Color(0xff2674fd)'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              });
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1, color: underColor.withOpacity(.2)),
                  right:
                      BorderSide(width: 1, color: underColor.withOpacity(.2)),
                )),
            padding: EdgeInsets.symmetric(vertical: size.width * 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.list[i]['title'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 30,
                    color: Color(0xff646464),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xff646464),
                )
              ],
            )),
      ));
    }).toList());
  }
}
