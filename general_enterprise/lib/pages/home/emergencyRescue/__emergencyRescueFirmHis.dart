import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueFirmHis extends StatefulWidget {
  @override
  _EmergencyRescueFirmHisState createState() => _EmergencyRescueFirmHisState();
}

class _EmergencyRescueFirmHisState extends State<EmergencyRescueFirmHis> {
  List firmHisData = [
    {
      "index": 0,
      "title": "预案",
      "descript": "选择需要使用的",
      "img": "assets/images/look.png",
      "isClick": false
    },
    {
      "index": 1,
      "title": "文件",
      "descript": "选择需要使用的",
      "img": "assets/images/apply.png",
      "isClick": true
    },
  ];
  PageController _controller;
  int choosed = 1;
  int oldPage = 1;

  void initState() {
    super.initState();
    _controller = PageController(initialPage: choosed);
    _controller.addListener(() {
      if (oldPage != _controller.page.toInt()) {
        choosed = _controller.page.toInt();
        oldPage = choosed;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Widget _changeTitle(width, item) {
    Widget _widget;
    if (item['title'] == '预案')
      _widget = FirmType();
    else if (item['title'] == '文件') _widget = FileType();
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(.2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(28))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: firmHisData.map<Widget>((ele) {
            return GestureDetector(
              onTap: () {
                choosed = ele['index'];
                _controller.animateToPage(choosed,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: choosed == ele['index'] ? Colors.white : null,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text(
                  ele['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          choosed == ele['index'] ? themeColor : Colors.white,
                      fontSize: size.width * 35),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 40, vertical: size.width * 10),
              ),
            );
          }).toList(),
        ),
      ),
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (context, index) =>
            _changeTitle(size.width, firmHisData[index]),
        itemCount: firmHisData.length,
      ),
    );
  }
}

class FirmType extends StatefulWidget {
  @override
  _FirmTypeState createState() => _FirmTypeState();
}

class _FirmTypeState extends State<FirmType> {
  List data = [];

  getTextColor(String type) {
    switch (type) {
      case '待备案':
        return Color(0xff306DFF);
        break;
      case '无效':
        return Color(0xff7772FF);
        break;
      default:
    }
  }

  List dropList = [
    {
      'title': '预案类型',
      'data': [],
      'value': '',
      "saveTitle": '预案类型',
      // 'dataUrl': Interface.dropTerritorialUnitList
      'limit': 'type'
    },
  ];

  String planType = '';
  ThrowFunc throwFunc = ThrowFunc();

  _changeDrop() {
    for (var i = 0; i < dropList.length; i++) {
      if (dropList[i]['title'] != dropList[i]['saveTitle']) {
        planType = dropList[i]['title'];
      } else {
        planType = '';
      }
    }
    throwFunc.run();
    _getFirmTypeData();
  }

  @override
  void initState() {
    super.initState();
    _getDropListData();
    _getFirmTypeData();
  }

  _getFirmTypeData() {
    myDio.request(
        type: 'get',
        url: Interface.getErPlanRecordList,
        queryParameters: {
          "planType": planType,
          "current": 1,
          "size": 1000
        }).then((value) {
      if (value is Map) {
        data = value['records'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getDropListData() {
    myDio.request(
        type: 'get',
        url: Interface.getOption,
        queryParameters: {"type": '预案类型'}).then((value) {
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

  _getUrl(String attachment, String title) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(attachment), 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? ListView(
            children: [
              TitleChooseBar(dropList, 0, _changeDrop),
              SizedBox(
                height: size.width * 20,
              ),
              ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                  physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                  itemBuilder: (context, index) {
                    return data.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              if (data[index]['attachment'] != '') {
                                _getUrl(data[index]['attachment'],
                                    data[index]['planName']);
                              } else {
                                // Fluttertoast.showToast(msg: '')
                              }
                            },
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 25),
                              margin: EdgeInsets.only(bottom: size.width * 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: size.width * 30,
                                        width: size.width * 6,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.width * 20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [
                                                  0.0,
                                                  1.0
                                                ], //[渐变起始点, 渐变结束点]
                                                colors: [
                                                  Color(0xff2AC79B),
                                                  Color(0xff3174FF),
                                                ])),
                                      ),
                                      SizedBox(
                                        width: size.width * 20,
                                      ),
                                      Text(
                                        data[index]['planName'],
                                        style: TextStyle(
                                            color: Color(0xff1C1C1D),
                                            fontSize: size.width * 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: size.width * 1,
                                    width: double.infinity,
                                    color: Color(0xffDCDCDC),
                                    margin: EdgeInsets.only(
                                        bottom: size.width * 10),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '修订人：',
                                        style: TextStyle(
                                            color: Color(0xff858888),
                                            fontSize: size.width * 26),
                                      ),
                                      Text(
                                        data[index]['revisionPeople'],
                                        style: TextStyle(
                                          color: Color(0xff1C1C1D),
                                          fontSize: size.width * 26,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      // Spacer(),
                                      // Text(
                                      //   '联系方式：',
                                      //   style: TextStyle(
                                      //     color: Color(0xff858888),
                                      //     fontSize: size.width * 26
                                      //   ),
                                      // ),
                                      // Text(
                                      //   data[index]['planType'],
                                      //   style: TextStyle(
                                      //     color: Color(0xff1C1C1D),
                                      //     fontSize: size.width * 26,
                                      //     // fontWeight: FontWeight.bold
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '修订原因：',
                                        style: TextStyle(
                                            color: Color(0xff858888),
                                            fontSize: size.width * 26),
                                      ),
                                      Expanded(
                                        child: Text(
                                          data[index]['revisionWhy'],
                                          style: TextStyle(
                                            color: Color(0xff1C1C1D),
                                            fontSize: size.width * 26,
                                            // fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: size.width * 50,
                                    width: double.infinity,
                                    color: Color(0xffF4F8FF),
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(left: size.width * 15),
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.width * 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '修订内容：',
                                          style: TextStyle(
                                              color: Color(0xff858888),
                                              fontSize: size.width * 26),
                                        ),
                                        Expanded(
                                            child: Text(
                                          data[index]['revisionContent'],
                                          style: TextStyle(
                                            color: Color(0xff1C1C1D),
                                            fontSize: size.width * 26,
                                            // fontWeight: FontWeight.bold
                                          ),
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container();
                  }),
            ],
          )
        : Container(
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
                Text('暂无预案')
              ],
            ));
  }
}

class FileType extends StatefulWidget {
  @override
  _FileTypeState createState() => _FileTypeState();
}

class _FileTypeState extends State<FileType> {
  List data = [];

  List dropList = [
    {
      'title': '预案文件类型',
      'data': [
        {
          'name': '事故风险辨识评估结论',
        },
        {
          'name': '应急资源调查',
        },
        {
          'name': '应急预案评估纪要',
        },
        {
          'name': '应急预案备案表',
        },
        {
          'name': '查看全部',
        },
      ],
      'value': '',
      "saveTitle": '预案文件类型',
      // 'dataUrl': Interface.dropTerritorialUnitList
      'limit': 'type'
    },
  ];

  ThrowFunc throwFunc = ThrowFunc();
  int serialNumber;

  _changeDrop() {
    for (var i = 0; i < dropList.length; i++) {
      if (dropList[i]['title'] != dropList[i]['saveTitle']) {
        switch (dropList[i]['title']) {
          case '事故风险辨识评估结论':
            serialNumber = 1;
            break;
          case '应急资源调查':
            serialNumber = 2;
            break;
          case '应急预案评估纪要':
            serialNumber = 3;
            break;
          case '应急预案备案表':
            serialNumber = 4;
            break;
          case '查看全部':
            serialNumber = null;
            break;
          default:
        }
      } else {
        serialNumber = null;
      }
    }
    throwFunc.run();
    _getFileTypeData();
  }

  @override
  void initState() {
    super.initState();
    _getFileTypeData();
  }

  _getFileTypeData() {
    myDio.request(
        type: 'get',
        url: Interface.getErPlanFileRecordList,
        queryParameters: {
          "serialNumber": serialNumber,
          "current": 1,
          "size": 1000
        }).then((value) {
      if (value is Map) {
        data = value['records'];
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getUrl(String attachment, String title) {
    Navigator.pushNamed(context, '/webview',
        arguments: {'url': Interface.online(attachment), 'title': title});
  }

  _getName(int serialNumber) {
    switch (serialNumber) {
      case 1:
        return '事故风险辨识评估结论';
        break;
      case 2:
        return '应急资源调查';
        break;
      case 3:
        return '应急预案评估纪要';
        break;
      case 4:
        return '应急预案备案表';
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? ListView(
            children: [
              TitleChooseBar(dropList, 0, _changeDrop),
              SizedBox(
                height: size.width * 20,
              ),
              ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                  physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                  itemBuilder: (context, index) {
                    return data.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              if (data[index]['attachment'] != '') {
                                _getUrl(data[index]['attachment'],
                                    _getName(data[index]['serialNumber']));
                              } else {
                                // Fluttertoast.showToast(msg: '')
                              }
                            },
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 25),
                              margin: EdgeInsets.only(bottom: size.width * 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: size.width * 30,
                                        width: size.width * 6,
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.width * 20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [
                                                  0.0,
                                                  1.0
                                                ], //[渐变起始点, 渐变结束点]
                                                colors: [
                                                  Color(0xff2AC79B),
                                                  Color(0xff3174FF),
                                                ])),
                                      ),
                                      SizedBox(
                                        width: size.width * 20,
                                      ),
                                      Text(
                                        data[index]['serialNumber'] != null &&
                                                data[index]['serialNumber'] !=
                                                    ''
                                            ? _getName(
                                                data[index]['serialNumber'])
                                            : '',
                                        style: TextStyle(
                                            color: Color(0xff1C1C1D),
                                            fontSize: size.width * 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: size.width * 1,
                                    width: double.infinity,
                                    color: Color(0xffDCDCDC),
                                    margin: EdgeInsets.only(
                                        bottom: size.width * 10),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '修订人：',
                                        style: TextStyle(
                                            color: Color(0xff858888),
                                            fontSize: size.width * 26),
                                      ),
                                      Text(
                                        data[index]['revisionPeople']
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0xff1C1C1D),
                                          fontSize: size.width * 26,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      // Spacer(),
                                      // Text(
                                      //   '联系方式：',
                                      //   style: TextStyle(
                                      //     color: Color(0xff858888),
                                      //     fontSize: size.width * 26
                                      //   ),
                                      // ),
                                      // Text(
                                      //   data[index]['planType'],
                                      //   style: TextStyle(
                                      //     color: Color(0xff1C1C1D),
                                      //     fontSize: size.width * 26,
                                      //     // fontWeight: FontWeight.bold
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '修订原因：',
                                        style: TextStyle(
                                            color: Color(0xff858888),
                                            fontSize: size.width * 26),
                                      ),
                                      Expanded(
                                        child: Text(
                                          data[index]['revisionWhy'].toString(),
                                          style: TextStyle(
                                            color: Color(0xff1C1C1D),
                                            fontSize: size.width * 26,
                                            // fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: size.width * 50,
                                    width: double.infinity,
                                    color: Color(0xffF4F8FF),
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(left: size.width * 15),
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.width * 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '修订内容：',
                                          style: TextStyle(
                                              color: Color(0xff858888),
                                              fontSize: size.width * 26),
                                        ),
                                        Expanded(
                                            child: Text(
                                          data[index]['revisionContent']
                                              .toString(),
                                          style: TextStyle(
                                            color: Color(0xff1C1C1D),
                                            fontSize: size.width * 26,
                                            // fontWeight: FontWeight.bold
                                          ),
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container();
                  }),
            ],
          )
        : Container(
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
                Text('暂无文件')
              ],
            ));
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
            padding: EdgeInsets.symmetric(vertical: size.width * 10),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: size.width * 150,
                ),
                Text(
                  widget.list[i]['title'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 28,
                    color: Color(0xff3173FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Container(
                  height: size.width * 41,
                  width: size.width * 1,
                  color: Color(0xffA4A4A4),
                ),
                SizedBox(
                  width: size.width * 45,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff646464),
                ),
                SizedBox(
                  width: size.width * 100,
                )
              ],
            )),
      ));
    }).toList());
  }
}
