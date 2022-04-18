import 'package:dio/dio.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myImageCarma.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/pages/home/work/work_dilog/_getVideo.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum WorkControlItemType { onlySee, oblyDo }

class WorkControlList extends StatefulWidget {
  WorkControlList({this.callback, this.id, this.plannedSpeed, this.bookId});
  final Function callback;
  final int id, plannedSpeed, bookId;
  @override
  _WorkControlListState createState() => _WorkControlListState();
}

class _WorkControlListState extends State<WorkControlList> {
  List<String> _title = ['前', '中', '后'];
  Map data = {};
  List hazardAndMeasures = [];
  bool buttonEnable = false;
  List<Map> sumbitData = [];
  List buttonName = ['下一步', '结束作业', '关闭作业'];
  Counter _counter = Provider.of<Counter>(myContext);
  bool _buttonShow = true;
  WorkControlItemType _workControlItemType = WorkControlItemType.oblyDo;
  @override
  void initState() {
    super.initState();
    _getData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _counter.emptySubmitDates(key: '清单');
    });
  }

  _getData() {
    print(widget.id);
    myDio
        .request(
            type: 'get', url: Interface.getReceiptDetail + widget.id.toString())
        .then((value) {
      if (value is Map) {
        data = value;
        data['hazardAndMeasures'].forEach((key, ele) {
          hazardAndMeasures.add({"title": key, "children": ele});
        });
        Map map = data['hazardAndMeasures'];
        if (map.isEmpty) {
          _workControlItemType = WorkControlItemType.onlySee;
          _getNotGrantian();
        }
        if (hazardAndMeasures.length == 0) buttonEnable = true;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  _next() {
    setState(() {
      buttonEnable = false;
    });
    myDio
        .request(
            type: "put", url: Interface.operateWorkByid + widget.id.toString())
        .then((value) {
      widget.callback(buttonName[widget.plannedSpeed - 1]);
      Navigator.pop(context);
    }).catchError((onError) {
      setState(() {
        buttonEnable = true;
      });
    });
  }

  _getNotGrantian() {
    myDio
        .request(
            type: "get",
            url: Interface.getImplementerList + widget.id.toString())
        .then((value) {
      if (value is Map) {
        _buttonShow = value["isGuardian"] == 0 ? false : true;
        Map _map = value["implementerMap"];
        _map.forEach((key, value) {
          hazardAndMeasures.add({"title": key, "children": value});
        });

        setState(() {});
      }
    });
  }

  _judgeButton() {
    buttonEnable = true;
    sumbitData = [];
    for (var i = 0; i < hazardAndMeasures.length; i++) {
      if (!buttonEnable) break;
      for (var _i = 0; _i < hazardAndMeasures[i]['children'].length; _i++) {
        sumbitData.add({
          "id": hazardAndMeasures[i]['children'][_i]['id'],
          "workControlData": hazardAndMeasures[i]['children'][_i]
              ['workControlData']
        });
        if (hazardAndMeasures[i]['children'][_i]['workControlData'] == null ||
            hazardAndMeasures[i]['children'][_i]['workControlData'] == '') {
          buttonEnable = false;
          break;
        }
      }
    }
  }

  _submit(String buttonName) {
    setState(() {
      buttonEnable = false;
    });
    myDio.request(
        type: 'post',
        url: Interface.postCarryOutWorkControl,
        data: {"id": widget.id, "workControlVos": sumbitData}).then((value) {
      widget.callback(buttonName);
      Navigator.pop(context);
    }).catchError((error) {
      setState(() {
        buttonEnable = true;
      });
    });
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(
          '作业${_title[widget.plannedSpeed - 1]}安全清单',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 37,
              color: Colors.white),
        ),
        child: data.length > 0
            ? Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Card(
                        child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data['workName'].toString(),
                            style: TextStyle(
                                color: Color(0xff343434),
                                fontSize: size.width * 34,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.width * 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '风险辨识人：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 24),
                              ),
                              Expanded(
                                  child: Text.rich(TextSpan(
                                      children: data['riskIdentifierUserIds']
                                          .map<InlineSpan>((ele) => TextSpan(
                                              text: ele['nickname'].toString() +
                                                  ', ',
                                              style: TextStyle(
                                                  fontSize: size.width * 24)))
                                          .toList())))
                            ],
                          ),
                          SizedBox(
                            height: size.width * 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '风险辨识时间：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 24),
                              ),
                              Text(
                                data['identifyDate'].toString(),
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 24),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '作业时间：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 24),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data['startDate'] ?? '' + '      始',
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 24),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                  Text(
                                    data['endDate'] ?? '' + '      至',
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 24),
                                  ),
                                  SizedBox(
                                    width: size.width * 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 5,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '作业人：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 24),
                              ),
                              Text.rich(TextSpan(
                                  children: data['workPeople']
                                      .map<InlineSpan>((ele) => TextSpan(
                                          text: ele.toString() + ', ',
                                          style: TextStyle(
                                            fontSize: size.width * 24,
                                            color: Color(0xff666666),
                                          )))
                                      .toList()))
                            ],
                          ),
                          SizedBox(
                            height: size.width * 5,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '监护人：',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 24),
                              ),
                              Text(
                                data['guardian'].toString(),
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 24),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 5,
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hazardAndMeasures.length,
                          itemBuilder: (BuildContext context, int index) {
                            return WorkControlItem(
                              type: _workControlItemType,
                              counter: _counter,
                              dataMap: hazardAndMeasures[index],
                              index: index,
                              title: data['workName'].toString(),
                              callback: (int i, int _i) {
                                String condition = hazardAndMeasures[i]
                                    ['children'][_i]['measuresCode'];
                                String measure = hazardAndMeasures[i]
                                    ['children'][_i]['controlMeasures'];
                                String workControlData = hazardAndMeasures[i]
                                    ['children'][_i]['workControlData'];
                                hazardAndMeasures.forEach((element) {
                                  element['children'].forEach((_element) {
                                    if (_element['measuresCode'] == condition &&
                                        _element['controlMeasures'] ==
                                            measure) {
                                      _element['workControlData'] =
                                          workControlData;
                                    }
                                  });
                                });
                                _judgeButton();
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                            );
                          }),
                    ),
                    _buttonShow
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 220,
                                height: size.width * 60,
                                margin: EdgeInsets.only(top: size.width * 20),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xff0ABA08))),
                                  onPressed: buttonEnable
                                      ? () {
                                          _workControlItemType ==
                                                  WorkControlItemType.onlySee
                                              ? _next()
                                              : _submit(buttonName[
                                                  widget.plannedSpeed - 1]);
                                        }
                                      : null,
                                  child: Text(
                                    buttonName[widget.plannedSpeed - 1],
                                    style: TextStyle(fontSize: size.width * 30),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              )
            : Container());
  }
}

class WorkControlItem extends StatefulWidget {
  WorkControlItem(
      {this.dataMap,
      this.index,
      this.callback,
      this.title,
      @required this.type,
      @required this.counter});
  final WorkControlItemType type;
  final Map dataMap;
  final int index;
  final Function callback;
  final String title;
  final Counter counter;
  @override
  _WorkControlItemState createState() => _WorkControlItemState();
}

class _WorkControlItemState extends State<WorkControlItem> {
  String index = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: InkWell(
          onTap: () {
            if (widget.dataMap["children"][0]['telephone'] != null) {
              launch('tel:${widget.dataMap["children"][0]["telephone"]}');
            }
          },
          child: Text(
            '${widget.index + 1}、${widget.dataMap["title"].toString()}',
            style:
                TextStyle(color: Color(0xff000000), fontSize: size.width * 28),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: size.width * 2,
        color: Color(0xffEAEAEF),
      ),
      Column(
          children: List.generate(
              widget.dataMap['children'].length,
              (_index) => Container(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_index + 1}.${widget.dataMap["children"][_index]['measures'].toString()}',
                              style: TextStyle(
                                  color: widget.dataMap["children"][_index]
                                                  ['workControlData'] !=
                                              null &&
                                          widget.dataMap["children"][_index]
                                                      ['workControlData']
                                                  .toString() !=
                                              ''
                                      ? Colors.green
                                      : Color(0xff666666),
                                  fontSize: size.width * 24),
                            ),
                            widget.type == WorkControlItemType.oblyDo
                                ? Row(children: <Widget>[
                                    (widget.dataMap["children"][_index]
                                                        ['controlMeasures'] ==
                                                    '拍照' ||
                                                widget.dataMap["children"]
                                                            [_index]
                                                        ['controlMeasures'] ==
                                                    '热成像') &&
                                            widget.dataMap["children"][_index]
                                                ['carmaList'] is List
                                        ? Container(
                                            width: size.width * 360,
                                            height: size.width * 120,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: widget
                                                    .dataMap["children"][_index]
                                                        ['carmaList']
                                                    .length,
                                                itemBuilder: (context, __index) => InkWell(
                                                    onTap: () {
                                                      widget.dataMap["children"]
                                                              [_index]
                                                              ['carmaList']
                                                          .removeAt(__index);
                                                      // setState(() {});
                                                      if (widget
                                                          .dataMap["children"]
                                                              [_index]
                                                              ['carmaList']
                                                          .isEmpty) {
                                                        widget.dataMap["children"]
                                                                    [_index][
                                                                'workControlData'] =
                                                            null;
                                                      }
                                                      widget.callback(
                                                          widget.index, _index);
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    size.width *
                                                                        10),
                                                            child: Image.network(
                                                                widget.dataMap["children"]
                                                                            [_index]
                                                                        ['carmaList']
                                                                    [__index],
                                                                width:
                                                                    size.width *
                                                                        100,
                                                                height:
                                                                    size.width *
                                                                        100,
                                                                fit: BoxFit
                                                                    .cover)),
                                                        Positioned(
                                                            right: 0,
                                                            top: 0,
                                                            child: Icon(
                                                                Icons
                                                                    .remove_circle,
                                                                color:
                                                                    Colors.red))
                                                      ],
                                                    ))))
                                        : Spacer(),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () async {
                                          switch (widget.dataMap["children"]
                                                  [_index]['controlMeasures']
                                              .toString()) {
                                            case '拍照':
                                              List tempList = [];
                                              String _carmaPlace = '';
                                              if (widget.counter
                                                  .submitDates['清单'] is List) {
                                                widget.counter.submitDates['清单']
                                                    .forEach((ele) {
                                                  if (ele['title'] ==
                                                      '${widget.title}安全清单拍照${widget.index}$_index') {
                                                    tempList = ele['value'];
                                                  }
                                                });
                                              }
                                              for (var i = 0;
                                                  i < tempList.length;
                                                  i++) {
                                                if (i == tempList.length - 1) {
                                                  _carmaPlace += tempList[i];
                                                } else {
                                                  _carmaPlace +=
                                                      tempList[i] + "|";
                                                }
                                              }
                                              await WorkDialog.myDialog(
                                                  context, () {}, 2,
                                                  widget: Column(
                                                    children: [
                                                      MyImageCarma(
                                                        purview: '清单',
                                                        score: 3,
                                                        title:
                                                            '${widget.title}安全清单拍照${widget.index}$_index',
                                                        placeHolder:
                                                            _carmaPlace,
                                                      ),
                                                      ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                                        themeColor)),
                                                        onPressed: () {
                                                          List carmaList = [];
                                                          String
                                                              workControlData =
                                                              "";
                                                          if (widget.counter
                                                                  .submitDates[
                                                              '清单'] is List) {
                                                            widget
                                                                .counter
                                                                .submitDates[
                                                                    '清单']
                                                                .forEach((ele) {
                                                              if (ele['title'] ==
                                                                  '${widget.title}安全清单拍照${widget.index}$_index') {
                                                                carmaList = ele[
                                                                    'value'];
                                                              }
                                                            });
                                                          }
                                                          for (var i = 0;
                                                              i <
                                                                  carmaList
                                                                      .length;
                                                              i++) {
                                                            if (carmaList[i] !=
                                                                '') {
                                                              if (i ==
                                                                  carmaList
                                                                          .length -
                                                                      1) {
                                                                workControlData +=
                                                                    carmaList[
                                                                        i];
                                                              } else {
                                                                workControlData +=
                                                                    carmaList[
                                                                            i] +
                                                                        "|";
                                                              }
                                                            }
                                                          }

                                                          widget.dataMap["children"]
                                                                      [_index][
                                                                  'carmaList'] =
                                                              carmaList;
                                                          widget.dataMap["children"]
                                                                      [_index][
                                                                  'workControlData'] =
                                                              workControlData;
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('确定'),
                                                      )
                                                    ],
                                                  ));
                                              break;
                                            case '气体检测':
                                              widget.dataMap["children"][_index]
                                                  ['workControlData'] = '气体检测';
                                              break;
                                            case '告知':
                                              widget.dataMap["children"][_index]
                                                  ['workControlData'] = '已告知';
                                              break;
                                            case '摄像':
                                              await WorkDialog.myDialog(
                                                  context, () {}, 2,
                                                  widget: Column(
                                                    children: [
                                                      WorkVideo(
                                                        isUpload: true,
                                                        callbacks: (url) {
                                                          String
                                                              workControlData =
                                                              "";
                                                          for (var i = 0;
                                                              i < url.length;
                                                              i++) {
                                                            if (url[i]
                                                                    .httpurl !=
                                                                '') {
                                                              if (i ==
                                                                  url.length -
                                                                      1) {
                                                                workControlData +=
                                                                    url[i]
                                                                        .httpurl;
                                                              } else {
                                                                workControlData +=
                                                                    url[i].httpurl +
                                                                        "|";
                                                              }
                                                            }
                                                          }
                                                          if (workControlData !=
                                                              '') {
                                                            widget.dataMap["children"]
                                                                        [_index]
                                                                    [
                                                                    'workControlData'] =
                                                                workControlData;
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                              break;
                                            case '振动':
                                              final value =
                                                  await Navigator.pushNamed(
                                                      context, 'blueTooth');
                                              if (value is double) {
                                                if (value > 0) {
                                                  widget.dataMap["children"]
                                                              [_index]
                                                          ['workControlData'] =
                                                      value.toString();
                                                }
                                              }
                                              break;
                                            case '现场确认':
                                              widget.dataMap["children"][_index]
                                                  ['workControlData'] = '已确认';
                                              break;
                                            case '热成像':
                                              String image = '';
                                              MethodChannel platHot =
                                                  const MethodChannel(
                                                      'FLIRONE');
                                              widget.dataMap["children"][_index]
                                                  ['carmaList'] = [];
                                              final value = await platHot
                                                  .invokeMethod('startFlirOne');
                                              if (value is Map) {
                                                image = value['path'];
                                                final res = await Dio().post(
                                                  Interface.uploadUrl,
                                                  data: FormData.fromMap({
                                                    "file": await MultipartFile
                                                        .fromFile(image)
                                                  }),
                                                );
                                                widget.dataMap["children"]
                                                        [_index]['carmaList']
                                                    .add(res.data['message']);
                                                widget.dataMap["children"]
                                                            [_index]
                                                        ['workControlData'] =
                                                    res.data['message'];
                                              }
                                              platHot
                                                  .invokeMethod('endFlirOne');
                                              break;
                                            default:
                                              widget.dataMap["children"][_index]
                                                  ['workControlData'] = widget
                                                      .dataMap["children"]
                                                  [_index]['controlMeasures'];
                                          }
                                          widget.callback(widget.index, _index);
                                        },
                                        child: Text(
                                            widget.dataMap["children"][_index]
                                                    ['controlMeasures']
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(0xff6EA0FE),
                                                fontSize: size.width * 24)))
                                  ])
                                : Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                          widget.dataMap["children"][_index]
                                                      ['carryOut'] ==
                                                  1
                                              ? '完成'
                                              : '未完成',
                                          style: TextStyle(
                                              color: widget.dataMap["children"]
                                                              [_index]
                                                          ['carryOut'] ==
                                                      1
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: size.width * 24))
                                    ],
                                  )
                          ])))))
    ]));
  }
}
