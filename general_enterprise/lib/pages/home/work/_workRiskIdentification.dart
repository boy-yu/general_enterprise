import 'dart:convert';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/myExpandableText.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WorkRiskIdentification extends StatefulWidget {
  WorkRiskIdentification(
      {this.child,
      this.type = 0,
      this.id,
      this.sumbitWidget,
      this.circuit,
      this.bookId,
      this.executionMemo,
      this.parentId = 0,
      this.parentReceiptWorkTypeAll = const []});
  final Widget child;
  final List parentReceiptWorkTypeAll;
  final int type, id, circuit, bookId, parentId;
  final Widget Function(int total) sumbitWidget;
  final String executionMemo;
  @override
  _WorkRiskIdentification createState() => _WorkRiskIdentification();
}

class _WorkRiskIdentification extends State<WorkRiskIdentification> {
  int isCurrentRisk = 1, currentId, currenIndex;
  bool isfactorRisk = false;
  List data = [], factor = [], hazardAndMeasures = [];
  List hazardIds = [];
  List<Map<String, List>> wayMap = [];
  List<Map> localRisk = [];
  Counter _counter = Provider.of<Counter>(myContext);
  List<Map> cacheFactorRisk = [];
  List<Map> cacheCurrentRisk = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getData();
    });
  }

  _getData() async {
    print(widget.bookId);
    print(widget.parentId);
    if (widget.circuit > 3 ||
        widget.executionMemo != '' ||
        widget.parentId > 0) {
      myDio.request(
          type: 'get',
          url: Interface.getIdentifyData,
          queryParameters: {
            "bookId": widget.bookId,
            "parentId": widget.parentId
          }).then((value) {
        if (value is List) {
          data = value;
          for (var i = 0; i < data.length; i++) {
            data[i]['isFinish'] = true;
            data[i]['id'] = data[i]['workTypeId'];
            factor.add(data[i]['factor']);
            hazardAndMeasures.add(data[i]['hazardAndMeasures']);
            data[i]['riskIdentify'] = data[i]['hazardNum'];
            data[i]['safetyMeaseure'] = data[i]['measuresNum'];
            wayMap.add({"id": [], "name": data[i]['workWays']});
            List tempFactor = [];
            factor.forEach((element) {
              if (element is Map) {
                element.forEach((key, _value) {
                  if (_value is List) {
                    _value.forEach((element) {
                      tempFactor.add(element['id']);
                    });
                  }
                });
              }
            });
            print(data[i]['hazardAndMeasures']);
            _counter.changeSubmitDates('风险辨识', {
              "title": i,
              "value": data[i]['hazardAndMeasures'],
              "workTypeId": data[i]['workTypeId'],
              "workWays": data[i]['workWays'],
              "hazardIds": tempFactor,
              "samplingDetection": data[i]['GasDetectionVo']
                  ['samplingDetection'],
              "portableDetectionint": data[i]['GasDetectionVo']
                  ['portableDetectionint'],
              "detectionSiteList": data[i]['GasDetectionVo']
                  ['detectionSiteList'],
              "hazardNum": data[i]['hazardNum'],
              "measuresNum": data[i]['measuresNum'],
            });
            localRisk.add({});
            cacheFactorRisk.add(null);
            cacheCurrentRisk.add({});
          }
        } else {
          Fluttertoast.showToast(msg: '数据结构已改变，请联系相关人员');
        }
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    return WillPopScope(
        child: buildListView(windowSize),
        onWillPop: () async {
          if (isCurrentRisk > 1) {
            --isCurrentRisk;
            if (mounted) {
              setState(() {});
            }
            return false;
          } else {
            return true;
          }
        });
  }

  _changeHazardIds(List ids, List list, Map data) {
    Map<String, List> _data = {};
    list.forEach((element) {
      if (_data[element['type'].toString()] == null) {
        _data[element['type'].toString()] = [];
      }
      _data.forEach((key, value) {
        if (key == element['type'].toString()) {
          value.add(element);
        }
      });
    });
    localRisk[currenIndex]['factor'] = _data;
    hazardIds = ids;
    cacheFactorRisk[currenIndex] = data;
  }

  _callback({String type, Map mapData}) {
    mapData['workTypeId'] = mapData['id'];
    data.add(mapData);
    localRisk
        .add({"name": mapData['name'], "description": mapData['description']});
    cacheFactorRisk.add({});
    cacheCurrentRisk.add({});
    if (mounted) {
      setState(() {});
    }
  }

  String _generateImage(bool isFinish, String icon) {
    String iconUrl = '';
    switch (icon) {
      case '动火作业':
        if (isFinish == true) {
          iconUrl = 'assets/images/icon_fire_check.png';
        } else {
          iconUrl = 'assets/images/icon_fire_uncheck.png';
        }
        break;
      case '临时用电':
        if (isFinish == true) {
          iconUrl = 'assets/images/icon_electric_check.png';
        } else {
          iconUrl = 'assets/images/icon_electric_uncheck.png';
        }
        break;
      case '吊装作业':
        if (isFinish == true) {
          iconUrl = 'assets/images/icon_hoisting_check.png';
        } else {
          iconUrl = 'assets/images/icon_hoisting_uncheck.png';
        }
        break;
      case '高处作业':
        if (isFinish == true) {
          iconUrl = 'assets/images/icon_height_check.png';
        } else {
          iconUrl = 'assets/images/icon_height_uncheck.png';
        }
        break;
      case '受限空间':
        if (isFinish == true) {
          iconUrl = 'assets/images/icon_limitation_check.png';
        } else {
          iconUrl = 'assets/images/icon_limitation_uncheck.png';
        }
        break;
      case '盲板抽堵':
        if (isFinish == true) {
          iconUrl = 'assets/images/icon_blind_plate_wall_check.png';
        } else {
          iconUrl = 'assets/images/icon_blind_plate_wall_uncheck.png';
        }
        break;
      case '动土作业':
        if (isFinish == true) {
          iconUrl = 'assets/images/icon_soil_check.png';
        } else {
          iconUrl = 'assets/images/icon_soil_uncheck.png';
        }
        break;
      case '断路作业':
        if (isFinish == true) {
          iconUrl = 'assets/images/icon_turnoff_check.png';
        } else {
          iconUrl = 'assets/images/icon_turnoff_uncheck.png';
        }
        break;
      default:
        if (isFinish == true) {
          iconUrl = 'assets/images/icon_hoisting_check.png';
        } else {
          iconUrl = 'assets/images/icon_hoisting_uncheck.png';
        }
    }
    return iconUrl;
  }

  //可滑动布局构建 这里是一个列表ListView
  Widget buildListView(Size windowSize) {
    Widget _widget;
    _changeIsCurrentRisk(int value,
        {bool state = false,
        int riskIdentify = 0,
        int safetyMeaseure = 0,
        Map cache}) {
      isCurrentRisk = value;
      if (widget.circuit == 3) {
        if (data[currenIndex]['isFinish'] != true) {
          data[currenIndex]['isFinish'] = state;
        }
      }
      if (state) {
        data[currenIndex]['riskIdentify'] = riskIdentify;
        data[currenIndex]['safetyMeaseure'] = safetyMeaseure;
      }
      
      if (cache != null && cacheCurrentRisk.isNotEmpty) {
        cacheCurrentRisk[currenIndex] = cache;
      }
      if (mounted) {
        setState(() {});
      }
    }

    if (isCurrentRisk == 1) {
      _widget = Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                data.length > 0
                    ? ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onLongPress: widget.parentReceiptWorkTypeAll
                                        .indexOf(data[index]['id']) ==
                                    -1
                                ? () {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) {
                                          return Center(
                                            child: Container(
                                              margin: EdgeInsets.all(
                                                  size.width * 40),
                                              padding: EdgeInsets.all(
                                                  size.width * 40),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .red)),
                                                    onPressed: () {
                                                      if (_counter.submitDates[
                                                              '风险辨识'] !=
                                                          null) {
                                                        for (var i = 0;
                                                            i <
                                                                _counter
                                                                    .submitDates[
                                                                        '风险辨识']
                                                                    .length;
                                                            i++) {
                                                          if (index ==
                                                              _counter.submitDates[
                                                                      '风险辨识'][i]
                                                                  ['title']) {
                                                            _counter.delectSubmitDates(
                                                                title: _counter
                                                                            .submitDates[
                                                                        '风险辨识'][
                                                                    i]['title'],
                                                                key: '风险辨识');
                                                          }
                                                        }
                                                      }
                                                      // localRisk[index]
                                                      data.removeAt(index);
                                                      wayMap.removeAt(index);
                                                      if (cacheCurrentRisk
                                                              .isNotEmpty &&
                                                          cacheFactorRisk
                                                              .isNotEmpty) {
                                                        cacheFactorRisk
                                                            .removeAt(index);
                                                        cacheCurrentRisk
                                                            .removeAt(index);
                                                      }

                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('删除'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                                    themeColor)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('取消'),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                : null,
                            onTap: () async {
                              List oldIds = [];
                              List listTable = [];
                              if (widget.circuit == 3) {
                                bool show = false;
                                // int workTypeId = widget.executionMemo == ''? data[index]['id'];  factor
                                final res = await myDio.request(
                                    type: 'get',
                                    url: Interface.getWorkWayList,
                                    queryParameters: {
                                      "workTypeId": data[index]['workTypeId']
                                    });
                                List dropList = [];
                                if (res is List) dropList = res;
                                dropList.forEach((element) {
                                  wayMap[index]['name'].forEach((_element) {
                                    if (element['way'] == _element) {
                                      if (!wayMap[index]['id']
                                          .contains(element['id'])) {
                                        wayMap[index]['id'].add(element['id']);
                                      }
                                      if (!oldIds.contains(element['id'])) {
                                        oldIds.add(element['id']);
                                      }
                                    }
                                  });
                                });
                                await WorkDialog.myDialog(
                                  context,
                                  () {},
                                  2,
                                  listTable: listTable,
                                  widget: StatefulBuilder(
                                      builder: (context, state) => Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    size.width * 20),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white)),
                                                      onPressed: () {
                                                        show = !show;
                                                        state(() {});
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '作业方式:   ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Text(
                                                            '   请选择作业方式',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            Icons
                                                                .keyboard_arrow_right,
                                                            color: Colors.black,
                                                          )
                                                        ],
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              show == true
                                                  ? Container(
                                                      height: size.width * 300,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            dropList.length,
                                                        itemBuilder:
                                                            (context, _index) =>
                                                                Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  size.width *
                                                                      10),
                                                          decoration: BoxDecoration(
                                                              color: wayMap[index]
                                                                              [
                                                                              'name']
                                                                          .indexOf(dropList[_index]
                                                                              [
                                                                              'way']) >
                                                                      -1
                                                                  ? themeColor
                                                                  : Colors
                                                                      .white,
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 1,
                                                                      color:
                                                                          underColor))),
                                                          child: InkWell(
                                                            onTap: () {
                                                              if (wayMap[index]
                                                                          ['id']
                                                                      .indexOf(dropList[
                                                                              _index]
                                                                          [
                                                                          'id']) ==
                                                                  -1) {
                                                                wayMap[index]
                                                                        ['id']
                                                                    .add(dropList[
                                                                            _index]
                                                                        ['id']);
                                                                wayMap[index]
                                                                        ['name']
                                                                    .add(dropList[
                                                                            _index]
                                                                        [
                                                                        'way']);
                                                              } else {
                                                                wayMap[index]
                                                                        ['id']
                                                                    .remove(dropList[
                                                                            _index]
                                                                        ['id']);
                                                                wayMap[index]
                                                                        ['name']
                                                                    .remove(dropList[
                                                                            _index]
                                                                        [
                                                                        'way']);
                                                              }

                                                              state(() {});
                                                            },
                                                            child: Text(
                                                              dropList[_index]
                                                                  ['way'],
                                                              style: TextStyle(
                                                                  color: wayMap[index]['name'].indexOf(dropList[_index]
                                                                              [
                                                                              'way']) >
                                                                          -1
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(themeColor)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('确认'),
                                              )
                                            ],
                                          )),
                                );
                              }
                              if (listTable.isNotEmpty) return;
                              currentId = data[index]['workTypeId'];

                              if (oldIds.length != wayMap[index]['id'].length) {
                                factor = [];
                                hazardAndMeasures = [];
                              }

                              for (var i = 0; i < oldIds.length; i++) {
                                if (!oldIds.contains(wayMap[index]['id'][i])) {
                                  factor = [];
                                  hazardAndMeasures = [];
                                  break;
                                }
                              }
                              isCurrentRisk = 2;
                              localRisk[index]['workWays'] =
                                  wayMap[index]['name'];
                              currenIndex = index;
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            data[index]['name'].toString(),
                                            style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: size.width * 34,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.width * 5,
                                          ),
                                          Container(
                                            width: windowSize.width -
                                                size.width * 350,
                                            child: ExpandableText(
                                              text: data[index]['description']
                                                  .toString(),
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: size.width * 24,
                                                color: Color(0xff666666),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: size.width * 10,
                                          ),
                                          Container(
                                            width: windowSize.width -
                                                size.width * 300,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      '危害识别：',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff6D9FFD),
                                                          fontSize:
                                                              size.width * 24),
                                                    ),
                                                    Text(
                                                      data[index]['riskIdentify'] ==
                                                              null
                                                          ? 0.toString()
                                                          : data[index][
                                                                      'riskIdentify']
                                                                  .toString() +
                                                              '条',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffff5555),
                                                          fontSize:
                                                              size.width * 24),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      '安全措施：',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff6D9FFD),
                                                          fontSize:
                                                              size.width * 24),
                                                    ),
                                                    Text(
                                                      data[index]['safetyMeaseure'] ==
                                                              null
                                                          ? 0.toString() + '条'
                                                          : data[index][
                                                                  'safetyMeaseure']
                                                              .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff09ba07),
                                                          fontSize:
                                                              size.width * 24),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Image(
                                          width: size.width * 75,
                                          height: size.width * 86,
                                          image: AssetImage(_generateImage(
                                              data[index]['isFinish'],
                                              data[index]['name'].toString())),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          '暂无数据，请点击添加按钮进行添加！',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                widget.circuit == 3
                    ? MyListIcon(
                        callback: _callback,
                        data: data,
                        wayMap: wayMap,
                        parentReceiptWorkTypeAll:
                            widget.parentReceiptWorkTypeAll)
                    : Container(),
              ],
            ),
          ),
          widget.sumbitWidget(data.length),
          SizedBox(
            height: size.width * 50,
          )
        ],
      );
    } else if (isCurrentRisk == 2) {
      Map factorRiskData;
      if (factor.length > currenIndex) {
        factorRiskData = factor[currenIndex];
      } else if (cacheFactorRisk[currenIndex] != null &&
          cacheFactorRisk[currenIndex].isNotEmpty) {
        factorRiskData = cacheFactorRisk[currenIndex];
      }
      _widget = FactorRisk(
          changePage: _changeIsCurrentRisk,
          workTypeId: currentId,
          workWayId: wayMap[currenIndex]['id'],
          localRisk: localRisk,
          changeIds: _changeHazardIds,
          data: factorRiskData);
    } else if (isCurrentRisk == 3) {
      Map currentRiskData;
      if (hazardAndMeasures.length > currenIndex) {
        currentRiskData = hazardAndMeasures[currenIndex];
      } else if (cacheCurrentRisk.isNotEmpty &&
          cacheCurrentRisk.length > currenIndex) {
        currentRiskData = cacheCurrentRisk[currenIndex];
      }
    
      _widget = CurrentRisk(
          isCurrentRisk: isCurrentRisk,
          changePage: _changeIsCurrentRisk,
          hazardIds: hazardIds,
          workWays: wayMap[currenIndex]['name'],
          workTypeId: currentId,
          circuit: widget.circuit,
          index: currenIndex,
          local: localRisk[currenIndex],
          workTypeName: data[currenIndex]['name'].toString(),
          hazardAndMeasures: currentRiskData);
    }
    return _widget;
  }
}

class FactorRisk extends StatefulWidget {
  FactorRisk(
      {this.changePage,
      this.workTypeId,
      this.changeIds,
      this.data,
      this.localRisk,
      @required this.workWayId});
  final Function changePage, changeIds;
  final int workTypeId;
  final Map data;
  final List workWayId, localRisk;
  @override
  _FactorRiskState createState() => _FactorRiskState();
}

class _FactorRiskState extends State<FactorRisk>
    with AutomaticKeepAliveClientMixin {
  List data = [];
  List<List> chooseList = [];
  List<String> page = ['风险因素', '事故后果'];
  int choosed = 0;
  List<int> sumIds = [];
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _getDate();
    _pageController.addListener(() {
      if (_pageController.page.toString().substring(2, 3) == '0') {
        choosed = _pageController.page.toInt();
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getDate() {
    data = [];
    List<String> title = ['人物因素', '物体因素', '管理因素', '环境因素', '事故危害'];
    if (widget.data != null) {
      widget.data.forEach((key, value) {
        data.add({
          'title': title[int.parse(key.toString()) - 1],
          "children": value,
          'value': [],
          'isClick': false,
          'type': key
        });
        chooseList.add([]);
      });
      for (var i = 0; i < data.length; i++) {
        data[i]['children'].forEach((ele) {
          chooseList[i].add(ele['content']);
        });
      }
    } else {
      // queryParameters: {
      //   "workTypeId": widget.id,
      //   "workWayIds": widget.workWayId,
      // }
      String workWayIds = '';
      for (var i = 0; i < widget.workWayId.length; i++) {
        if (i == 0)
          workWayIds += widget.workWayId[i].toString();
        else
          workWayIds += '%2c' + widget.workWayId[i].toString();
      }

      myDio
          .request(
        type: 'get',
        url: Interface.getFactor +
            '?workTypeId=${widget.workTypeId}&workWayIds=$workWayIds',
      )
          .then((value) {
        if (value is Map) {
          value.forEach((key, value) {
            data.add({
              'title': title[int.parse(key) - 1],
              "children": value,
              'value': [],
              'isClick': false,
              "type": key
            });
            chooseList.add([]);
          });
          for (var i = 0; i < data.length; i++) {
            data[i]['children'].forEach((ele) {
              chooseList[i].add(ele['content']);
            });
          }
        }
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        SizedBox(height: size.width * 60),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: page
                .asMap()
                .keys
                .map((index) => InkWell(
                      onTap: () {
                        choosed = index;
                        _pageController.animateToPage(choosed,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: index == choosed
                                ? Border(
                                    bottom: BorderSide(
                                        width: 2, color: Color(0xff67DB7F)))
                                : null),
                        child: Text(
                          page[index],
                          style: TextStyle(
                              color: index == choosed
                                  ? Color(0xff67DB7F)
                                  : Colors.black),
                        ),
                      ),
                    ))
                .toList()),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, indexs) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                if (indexs == 0 && data[index]['type'].toString() == '5')
                  return Container();

                if (indexs == 1 &&
                    int.parse(data[index]['type'].toString()) < 5)
                  return Container();
                return Container(
                  margin: EdgeInsets.all(size.width * 20),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.all(size.width * 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                data[index]['title'],
                                style: TextStyle(
                                  color: Color(0xff6D9FFD),
                                  fontSize: size.width * 32,
                                ),
                              ),
                              Text(
                                '（已辨识',
                                style: TextStyle(
                                    color: Color(0xffBCBCBC),
                                    fontSize: size.width * 18),
                              ),
                              Text(
                                chooseList[index].length.toString(),
                                style: TextStyle(
                                    color: Color(0xff09BA07),
                                    fontSize: size.width * 18),
                              ),
                              Text(
                                '条风险）',
                                style: TextStyle(
                                    color: Color(0xffBCBCBC),
                                    fontSize: size.width * 18),
                              ),
                              Spacer(),
                              InkWell(
                                // style: ButtonStyle(
                                //     backgroundColor: MaterialStateProperty.all(
                                //         Colors.white)),
                                onTap: () {
                                  data[index]['isClick'] =
                                      !data[index]['isClick'];
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(size.width * 20),
                                  child: Icon(
                                    data[index]['isClick']
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                          data[index]['isClick']
                              ? CustomWiget(
                                  datas: chooseList[index],
                                  callback: (String content) {
                                    for (var i = chooseList[index].length - 1;
                                        i >= 0;
                                        i--) {
                                      if (chooseList[index][i] == content) {
                                        chooseList[index].removeAt(i);
                                      }
                                    }
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  },
                                  funcWidget: GestureDetector(
                                    onTap: () async {
                                      Map tempDate =
                                          jsonDecode(jsonEncode(data[index]));

                                      if (data[index]['request'] == null) {
                                        final value = await myDio.request(
                                            type: 'get',
                                            url: Interface.getWorkRiskDrop,
                                            queryParameters: {
                                              "type": data[index]['type'],
                                              "workTypeId": widget.workTypeId
                                            });
                                        if (value is List) {
                                          tempDate['children'].addAll(value);
                                          List _data = tempDate['children'];
                                          List temp = [];
                                          for (var i = _data.length - 1;
                                              i > -1;
                                              i--) {
                                            if (temp.contains(_data[i]['id'])) {
                                              _data.removeAt(i);
                                            } else {
                                              temp.add(_data[i]['id']);
                                            }
                                          }
                                          tempDate['request'] = true;
                                        }
                                      }

                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return Environment(
                                              title: tempDate['title'],
                                              data: tempDate['children'],
                                              readyChoose: chooseList[index],
                                              callback: () {
                                                chooseList[index] = [];
                                                data[index] = tempDate;
                                                data[index]['children']
                                                    .forEach((ele) {
                                                  if (ele['isChoose'] == true) {
                                                    chooseList[index]
                                                        .add(ele['content']);
                                                  }
                                                });

                                                Navigator.pop(context);
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                              },
                                            );
                                          }).then((value) {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 10,
                                          vertical: size.width * 8),
                                      margin:
                                          EdgeInsets.only(top: size.width * 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xff6D9FFD))),
                                      child: Text(
                                        '+新增',
                                        style: TextStyle(
                                            color: Color(0xff6D9FFD),
                                            fontSize: size.width * 20),
                                      ),
                                    ),
                                  ),
                                  funcData: '+新增')
                              : Container()
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            itemCount: 2,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xff005AFF))),
              onPressed: () {
                widget.changePage(1);
              },
              child: Text('上一步'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xff0ABA08))),
              onPressed: () {
                List ids = [];
                List _list = [];
                Map cache = {};
                for (var i = 0; i < data.length; i++) {
                  List cureenList = [];
                  data[i]['children'].forEach((ele) {
                    if (chooseList[i].indexOf(ele['content']) > -1) {
                      ids.add(ele['id']);
                      _list.add(ele);
                      cureenList.add(ele);
                    }
                  });
                  cache.addAll({i + 1: cureenList});
                }

                widget.changeIds(ids, _list, cache);
                widget.changePage(3);
              },
              child: Text('下一步'),
            ),
          ],
        ),
        SizedBox(
          height: size.width * 50,
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// callback return string
class CustomWiget extends StatefulWidget {
  CustomWiget({
    this.fontSize = 20,
    this.margin = 3,
    this.padding = 10,
    this.datas,
    this.callback,
    this.funcWidget,
    this.funcData,
  });
  final double fontSize, margin, padding;
  final List datas;
  final Function callback;
  final Widget funcWidget;
  final String funcData;
  @override
  _CustomWigetState createState() => _CustomWigetState();
}

class _CustomWigetState extends State<CustomWiget> {
  List datas = [];
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    datas = [];
    List tempdatas = jsonDecode(jsonEncode(widget.datas));
    tempdatas.forEach((element) {
      datas.add(element);
    });
    if (widget.funcData != null) {
      datas.add(widget.funcData);
    }
  }

  @override
  void didUpdateWidget(CustomWiget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: datas
          .asMap()
          .keys
          .map<Widget>((index) => datas[index] == widget.funcData
              ? widget.funcWidget
              : GestureDetector(
                  onTap: () {
                    if (widget.callback != null) {
                      widget.callback(datas[index]);
                    }
                    datas.removeAt(index);
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff6D9FFD),
                        borderRadius: BorderRadius.circular(24)),
                    margin: EdgeInsets.all(widget.margin),
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.padding,
                        vertical: widget.padding / 2),
                    child: Text(
                      datas[index].toString(),
                      style: TextStyle(
                          fontSize: size.width * widget.fontSize,
                          color: Colors.white),
                    ),
                  ),
                ))
          .toList(),
    );
  }
}

class CurrentRisk extends StatefulWidget {
  CurrentRisk(
      {this.isCurrentRisk,
      this.changePage,
      this.hazardIds,
      this.workTypeId,
      this.index,
      this.hazardAndMeasures,
      this.circuit,
      @required this.workWays,
      this.local,
      @required this.workTypeName});
  final int isCurrentRisk, workTypeId, index, circuit;
  final Function changePage;
  final List hazardIds, workWays;
  final Map hazardAndMeasures, local;
  final String workTypeName;
  @override
  _CurrentRiskState createState() => _CurrentRiskState();
}

class _CurrentRiskState extends State<CurrentRisk> {
  List data = [];
  bool _checkValue = false; //总的复选框控制开关
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    data = [];
    myDio.request(type: 'post', url: Interface.postHazardAndMeasure, data: {
      "workTypeId": widget.workTypeId,
      "factors": widget.hazardIds
    }).then((value) {
    
      if (value is Map) {
        value.forEach((key, value) {
          data.add({"title": key, "children": value != null ? value : []});
        });

        if (widget.hazardAndMeasures != null) {
          widget.hazardAndMeasures.forEach((key, value) {
            data.forEach((element) {
              if (element['title'] == key) {
                element['children'].forEach((_element) {
                  value.forEach((ele) {
                    if (ele['measures'] == _element['measures']) {
                      _element['isChoose'] = true;
                    }
                  });
                });
              }
            });
          });
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              InkWell(
                // style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(Colors.white)),
                onTap: () {
                  _checkValue = !_checkValue;
                  for (var i = 0; i < data.length; i++) {
                    data[i]['isChoose'] = _checkValue;
                    data[i]['children'].forEach((ele) {
                      ele['isChoose'] = _checkValue;
                    });
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(size.width * 20),
                  child: Row(
                    children: [
                      Icon(
                        _checkValue
                            ? Icons.check_circle
                            : Icons.panorama_fish_eye,
                        color: _checkValue ? themeColor : placeHolder,
                        size: size.width * 40,
                      ),
                      SizedBox(
                        width: size.width * 20,
                      ),
                      Text(
                        '全选',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(size.width * 10),
                  child: Column(
                    children: [
                      InkWell(
                          // style: ButtonStyle(
                          //     backgroundColor:
                          //         MaterialStateProperty.all(Colors.white)),
                          onTap: () {
                            if (data[index]['isChoose'] != true) {
                              data[index]['isChoose'] = true;
                              data[index]['children'].forEach((ele) {
                                ele['isChoose'] = true;
                              });
                            } else {
                              data[index]['isChoose'] = false;
                              data[index]['children'].forEach((ele) {
                                ele['isChoose'] = false;
                              });
                              _checkValue = false;
                            }
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 20),
                            child: Row(
                              children: [
                                Icon(
                                  data[index]['isChoose'] == true
                                      ? Icons.check_circle
                                      : Icons.panorama_fish_eye,
                                  color: data[index]['isChoose'] == true
                                      ? themeColor
                                      : placeHolder,
                                  size: size.width * 40,
                                ),
                                SizedBox(
                                  width: size.width * 20,
                                ),
                                Expanded(
                                  child: Text(
                                    data[index]['title'].toString(),
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.all(size.width * 20),
                        child: Column(
                          children: data[index]['children'].map<Widget>((ele) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 1, color: underColor))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (ele['isChoose'] != true) {
                                            ele['isChoose'] = true;
                                          } else {
                                            ele['isChoose'] = false;
                                            data[index]['isChoose'] = false;
                                            _checkValue = false;
                                          }
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 20,
                                              vertical: size.width * 10),
                                          child: Icon(
                                            ele['isChoose'] == true
                                                ? Icons.check_circle
                                                : Icons.panorama_fish_eye,
                                            color: ele['isChoose'] == true
                                                ? themeColor
                                                : placeHolder,
                                            size: size.width * 40,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.only(top: 4),
                                              child:
                                                  Text.rich(TextSpan(children: [
                                                WidgetSpan(
                                                    alignment:
                                                        PlaceholderAlignment
                                                            .middle,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0, right: 5),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                                  0xff285BF6)
                                                              .withOpacity(.2)),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: size
                                                                      .width *
                                                                  5,
                                                              vertical:
                                                                  size.width *
                                                                      2),
                                                      child: Text(
                                                          ele['controlAuthority'] ??
                                                              '',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff285BF6))),
                                                    )),
                                                TextSpan(
                                                    text: ele['measures']
                                                        .toString()),
                                              ])))),
                                      InkWell(
                                        onTap: () async {
                                          await WorkDialog.myDialog(
                                              context, () {}, 2,
                                              widget: AmendSafeMeasure(
                                                text:
                                                    ele['measures'].toString(),
                                                callback: (
                                                    {String text,
                                                    String controlMeasures}) {
                                                  ele['measures'] = text;
                                                  ele['controlMeasures'] =
                                                      controlMeasures;
                                                },
                                              ));
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 20,
                                              vertical: size.width * 10),
                                          child: Icon(
                                            Icons.launch,
                                            size: size.width * 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Text(
                                      ele['controlMeasures'].toString(),
                                      style: TextStyle(color: themeColor),
                                    ),
                                    margin:
                                        EdgeInsets.only(right: size.width * 20),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: data.length,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff005AFF))),
                onPressed: () {
                  widget.changePage(2);
                },
                child: Text('上一步'),
              ),
              widget.circuit == 3
                  ? ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff0ABA08))),
                      onPressed: () async {
                        bool showModeal = false;
                        if (widget.workTypeName == '动火作业' ||
                            widget.workTypeName == '受限空间') {
                          showModeal = true;
                        }
                        Map chooseItem = {};
                        int riskIdentify = data.length;
                        int safetyMeaseure = 0;
                        data.forEach((element) {
                          List tempIschoose = [];
                          element['children'].forEach((_element) {
                            if (_element['isChoose'] == true) {
                              // if (_element['controlMeasures'] == '气体检测') {
                              //   showModeal = true;
                              // }
                              tempIschoose.add(_element);
                              ++safetyMeaseure;
                            }
                          });
                          if (tempIschoose.length > 0) {
                            chooseItem[element['title']] = tempIschoose;
                          }
                        });
                        int samplingDetection = 0,
                            portableDetectionint = 0,
                            // ignore: unused_local_variable
                            viewInformation = 0;
                        List detectionSiteList = [];
                        bool next = true;
                        if (showModeal) {
                          await WorkDialog.myDialog(context, () {}, 2,
                              widget: Column(
                                children: [
                                  Text('是否进行气体检测'),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      themeColor)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('是'),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () {
                                            showModeal = false;
                                            Navigator.pop(context);
                                          },
                                          child: Text('否'),
                                        ),
                                      ])
                                ],
                              ));
                        }
                        if (showModeal) {
                          await WorkDialog.myDialog(context, () {}, 2,
                              cancel: () {
                            next = false;
                          }, widget: ChooseSiteConfirm(
                            callback: (
                                {List<String> detect,
                                List<String> detectLocation}) {
                              detectionSiteList = detectLocation;
                              detect.forEach((element) {
                                if (element == '取样检测') {
                                  samplingDetection = 1;
                                } else if (element == '便携式检测') {
                                  portableDetectionint = 1;
                                } else if (element == '信息查看') {
                                  viewInformation = 1;
                                }
                              });
                            },
                          ));
                        }

                        widget.local['GasDetectionVo'] = {
                          "samplingDetection": samplingDetection,
                          "portableDetectionint": portableDetectionint,
                          "detectionSiteList": detectionSiteList
                        };
                        widget.local['workTypeId'] = widget.workTypeId;
                        widget.local['hazardNum'] = riskIdentify;
                        widget.local['measuresNum'] = safetyMeaseure;
                        widget.local['hazardAndMeasures'] = chooseItem;
                        widget.local["title"] = widget.index;
                        if (next) {
                          context.read<Counter>().changeSubmitDates('风险辨识', {
                            "title": widget.index,
                            "value": chooseItem,
                            "workTypeId": widget.workTypeId,
                            "hazardIds": widget.hazardIds,
                            "workWays": widget.workWays,
                            "samplingDetection": samplingDetection,
                            "portableDetectionint": portableDetectionint,
                            "detectionSiteList": detectionSiteList,
                            "hazardNum": riskIdentify,
                            "measuresNum": safetyMeaseure
                          });
                          context
                              .read<Counter>()
                              .changeSubmitDates('localRisk', widget.local);
                          widget.changePage(1,
                              state: true,
                              riskIdentify: riskIdentify,
                              safetyMeaseure: safetyMeaseure,
                              cache: chooseItem);
                        }
                      },
                      child: Text('保存'),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: size.width * 50,
          ),
        ],
      ),
    );
  }
}

class MyListIcon extends StatefulWidget {
  MyListIcon(
      {this.callback, this.data, this.wayMap, this.parentReceiptWorkTypeAll});
  final Function callback;
  final List data;
  final List parentReceiptWorkTypeAll;
  final List<Map<String, List>> wayMap;
  @override
  _MyListIconState createState() => _MyListIconState();
}

class _MyListIconState extends State<MyListIcon> {
  double right = 50;
  double top = size.width * 600;
  int ischecked = 0;
  List data = [];
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    myDio.request(type: 'get', url: Interface.getWorkType).then((value) {
      if (value is List) {
        if (widget.parentReceiptWorkTypeAll is List) {
          value.forEach((element) {
            if (!widget.parentReceiptWorkTypeAll.contains(element['id'])) {
              data.add(element);
            }
          });
        } else {
          data = value;
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      top: top,
      child: GestureDetector(
        key: _key,
        onPanUpdate: (details) {},
        onTap: () {
          RenderBox box = _key.currentContext.findRenderObject();
          Offset offset = box.localToGlobal(Offset.zero);
          Size buttonSize = box.size;
          Size sizes = Size(offset.dx, offset.dy);
          showMenu(
              context: context,
              position: RelativeRect.fromSize(
                  Rect.fromLTRB(
                      offset.dx - buttonSize.width * 2, offset.dy, 0, 0),
                  sizes),
              items: data
                  .map<PopupMenuEntry>(
                    (ele) => PopupMenuItem(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          bool next = true;
                          widget.data.forEach((element) {
                            if (ele['id'] == element['id']) {
                              next = false;
                            }
                          });
                          if (next) {
                            widget.callback(type: 'add', mapData: ele);
                            widget.wayMap.add({'id': [], 'name': []});
                          }
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            ele['name'],
                            style: TextStyle(
                                color: Color(0xff343434),
                                fontSize: size.width * 24),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList());
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff1B39E9),
                    Color(0xff3173FF),
                  ]),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff3173FF).withOpacity(.3),
                    offset: Offset(-2, 1),
                    blurRadius: 3.0,
                    spreadRadius: 3.0),
                BoxShadow(
                    color: Color(0xff3173FF).withOpacity(.3),
                    offset: Offset(-5, 2),
                    blurRadius: 3.0,
                    spreadRadius: 3.0),
              ]),
          child: Icon(
            Icons.add,
            size: size.width * 60,
            color: Colors.white,
          ),
          width: size.width * 80,
          height: size.width * 80,
        ),
      ),
    );
  }
}

class Environment extends StatefulWidget {
  Environment({this.data, this.callback, this.readyChoose, this.title});
  final List data, readyChoose;
  final Function callback;
  final String title;
  @override
  _EnvironmentState createState() => _EnvironmentState();
}

class _EnvironmentState extends State<Environment> {
  bool allChoose = false;
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.data.length; i++) {
      if (widget.readyChoose.indexOf(widget.data[i]['content'].toString()) >
          -1) {
        widget.data[i]['isChoose'] = true;
      } else {
        widget.data[i]['isChoose'] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size currenWindow = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: currenWindow.width - size.width * 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        constraints: BoxConstraints(maxHeight: size.width * 800),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: size.width * 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: Color(0xff0059FF),
              ),
              child: Text(
                widget.title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: size.width * 36,
                    color: Colors.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffF3F3F3),
                  borderRadius: BorderRadius.circular(24)),
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 65, vertical: size.width * 10),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 100,
                  ),
                  Icon(Icons.search, color: Color(0xffC3C3C3)),
                  Expanded(
                      child: CupertinoTextField(
                    onSubmitted: (value) {},
                    textInputAction: TextInputAction.search,
                    placeholder: '请输入搜索内容',
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0, color: Colors.transparent)),
                  )),
                  SizedBox(
                    width: size.width * 100,
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              // readyChoose
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 40,
                  ),
                  Expanded(
                      child: Text(
                    widget.data[index]['content'],
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: size.width * 26,
                        color: Colors.black),
                  )),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      if (widget.data[index]['isChoose'] == false ||
                          widget.data[index]['isChoose'] == null) {
                        widget.data[index]['isChoose'] = true;
                      } else {
                        widget.data[index]['isChoose'] = false;
                      }
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: widget.data[index]['isChoose'] == true
                              ? themeColor
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1,
                              color: widget.data[index]['isChoose'] == true
                                  ? Colors.transparent
                                  : Colors.black.withOpacity(0.3))),
                      width: size.width * 26,
                      height: size.width * 26,
                    ),
                  )
                ],
              ),
              itemCount: widget.data != null ? widget.data.length : 0,
            )),
            Divider(
              height: 1,
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    allChoose = !allChoose;
                    widget.data.forEach((element) {
                      element['isChoose'] = allChoose;
                    });
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 20),
                        decoration: BoxDecoration(
                            color: allChoose ? themeColor : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1,
                                color: allChoose
                                    ? Colors.transparent
                                    : Colors.black.withOpacity(0.3))),
                        width: size.width * 26,
                        height: size.width * 26,
                      ),
                      Text('全选', style: TextStyle(color: Colors.black)),
                      // Spacer(),
                    ],
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(themeColor)),
                  onPressed: widget.callback,
                  child: Text('确定'),
                ),
                SizedBox(
                  width: size.width * 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AmendSafeMeasure extends StatefulWidget {
  AmendSafeMeasure({
    this.text,
    this.callback,
  });
  final String text;
  final Function callback;
  @override
  _AmendSafeMeasureState createState() => _AmendSafeMeasureState();
}

class _AmendSafeMeasureState extends State<AmendSafeMeasure> {
  List way = ['拍照', '震动', '热成像', '台账', '现场确认', '摄像', '告知'];
  int choose = 0;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.width * 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('安全措施'),
          Container(
              height: size.width * 200,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: themeColor),
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: _controller,
                maxLines: 5,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(size.width * 20)),
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: size.width * 20),
            height: size.width * 255,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: size.width * 25,
                  crossAxisSpacing: size.width * 20,
                  childAspectRatio: 3),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    choose = index;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: choose == index
                            ? themeColor
                            : Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(size.width * 30)),
                    child: Center(
                      child: Text(
                        way[index],
                        style: TextStyle(
                          fontSize: size.width * 26,
                          color: choose == index
                              ? Colors.white
                              : Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: way.length,
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                widget.callback(
                    text: _controller.text, controlMeasures: way[choose]);
                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          )
        ],
      ),
    );
  }
}

class ChooseSiteConfirm extends StatefulWidget {
  ChooseSiteConfirm({this.callback});
  final Function callback;
  @override
  _ChooseSiteConfirmState createState() => _ChooseSiteConfirmState();
}

class _ChooseSiteConfirmState extends State<ChooseSiteConfirm> {
  List<String> detectWay = ['取样检测', '便携式检测'];
  List<int> chooseWay = [];
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<String> data = [];
  bool showText = true;
  _rebuild() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showText = true;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.width * 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("检测方式:"),
          SizedBox(
            height: size.width * 10,
          ),
          Row(
              children: detectWay
                  .asMap()
                  .keys
                  .map((index) => Container(
                        margin: EdgeInsets.only(right: size.width * 20),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    StadiumBorder(side: BorderSide.none)),
                                backgroundColor: MaterialStateProperty.all(
                                    chooseWay.indexOf(index) > -1
                                        ? themeColor
                                        : Colors.white.withOpacity(0.8))),
                            onPressed: () {
                              if (chooseWay.indexOf(index) > -1) {
                                chooseWay.remove(index);
                              } else {
                                chooseWay.add(index);
                              }
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Text(
                              detectWay[index],
                              style: TextStyle(
                                color: chooseWay.indexOf(index) > -1
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.3),
                              ),
                            )),
                      ))
                  .toList()),
          Row(
            children: [
              Text('检测点位:'),
              Expanded(
                  child: TextField(
                style: TextStyle(fontSize: size.width * 24),
                focusNode: _focusNode,
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: size.width * 30),
                  border: InputBorder.none,
                  hintText: '请输入内容',
                  hintStyle: TextStyle(fontSize: size.width * 20),
                ),
              )),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  _focusNode.unfocus();
                  if (_controller.text == '') return;
                  data.add(_controller.text);
                  showText = false;
                  _controller.text = '';
                  if (mounted) {
                    setState(() {});
                  }
                  _rebuild();
                },
                child: Text(
                  '+添加',
                  style:
                      TextStyle(color: themeColor, fontSize: size.width * 20),
                ),
              )
            ],
          ),
          showText
              ? CustomWiget(
                  datas: data,
                  callback: (String value) {
                    data.remove(value);
                    showText = false;
                    if (mounted) {
                      setState(() {});
                    }
                    _rebuild();
                  },
                )
              : Container(),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                List<String> chooseDetect = [];
                for (var i = 0; i < chooseWay.length; i++) {
                  chooseDetect.add(detectWay[i]);
                }

                if (chooseDetect.isEmpty || data.isEmpty) {
                  Fluttertoast.showToast(msg: '请选择气体检测方式');
                } else {
                  widget.callback(detect: chooseDetect, detectLocation: data);
                  Navigator.pop(context);
                }
              },
              child: Text('确定'),
            ),
          )
        ],
      ),
    );
  }
}
