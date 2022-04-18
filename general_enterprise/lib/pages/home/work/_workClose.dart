import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkClose extends StatefulWidget {
  WorkClose({
    this.sumbitWidget,
    this.circuit,
    this.id,
    this.bookId,
    @required this.operable, this.parentId,
  });
  final bool operable;
  final Widget sumbitWidget;
  final int circuit, id, bookId,parentId;

  @override
  _WorkCloseState createState() => _WorkCloseState();
}

class _WorkCloseState extends State<WorkClose> {
  bool isDetails = false;
  List data = [];
  Counter _counter = Provider.of<Counter>(myContext);
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    myDio
        .request(
            type: "get", url: Interface.getApplyData,queryParameters: {
              "bookId":widget.bookId,
              "parentBookId":widget.parentId
            })
        .then((value) {
      if (value is List) {
        data = value;
        for (var i = 0; i < data.length; i++) {
          _counter.changeSubmitDates("作业申请", {"title": i, "value": {}});
          data[i]['inner'] = data[i]['thisCompany'];
          List tempId = [];
          int guarDianId = -1;
          List tempWorkContractorsVoList = [];
          if (data[i]['inner'] is List) {
            for (var _i = 0; _i < data[i]['inner'].length; _i++) {
              if (data[i]['inner'][_i]['guardian'] == 1) {
                guarDianId = data[i]['inner'][_i]['userId'];
                data[i]['inner'][_i]['guarDian'] = true;
              }
              tempId.add(data[i]['inner'][_i]['userId']);
            }

            if (data[i]['contractorsMap'] is Map) {
              data[i]['contractorsMap'].forEach((key, _value) {
                List contractorsStaffVoList = [];
                if (_value is List) {
                  _value.forEach((element) {
                    contractorsStaffVoList.add({
                      "name": element['name'],
                      "certificateName": element['relatedCertificate']
                          ['certificateName'],
                      "frontPicture": element['relatedCertificate']
                          ['frontPicture']
                    });
                  });
                }
                tempWorkContractorsVoList.add({
                  "name": key,
                  "contractorsStaffVoList": contractorsStaffVoList
                });
              });
            }
            _counter.changeSubmitDates("作业申请", {
              "title": i,
              "value": {
                "id": data[i]['id'],
                "userIds": tempId,
                "guardianId": guarDianId,
                "workContractorsVoList": tempWorkContractorsVoList
              }
            });
          }
          if (data[i]['contractorsMap'] is Map) {
            data[i]['outer'] = [];
            List temps = List.generate(
                data[i]['contractorsMap'].length, (index) => index.toString());
            data[i]['contractorsMap'].forEach((key, values) {
              data[i]['outer']
                  .add({"name": key, "type": "contractors", "names": temps});
            });
          }
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  //  widget.sumbitWidget != null ? widget.sumbitWidget : Container(),
  //       SizedBox(
  //         height: size.width * 100,
  //       )
  @override
  Widget build(BuildContext context) {
    return WorkApplyFirst(
        sumbitWidget: widget.sumbitWidget,
        data: data,
        bookId: widget.bookId,
        operable: widget.operable);
  }
}

class WorkApplyFirst extends StatefulWidget {
  final Widget sumbitWidget;
  final List data;
  final int bookId;
  final bool operable;
  final ReturnIntStringCallback callback;
  final ReturnIntStringCallback changeIndex;
  const WorkApplyFirst(
      {Key key,
      this.sumbitWidget,
      this.data,
      this.callback,
      this.changeIndex,
      this.bookId,
      this.operable})
      : super(key: key);
  @override
  _WorkApplyFirstState createState() => _WorkApplyFirstState();
}

class _WorkApplyFirstState extends State<WorkApplyFirst> {
  List _data = [];
  @override
  void initState() {
    super.initState();
    if (!widget.operable) {
      _getState();
    }
  }

// 超
  _getState() {
    myDio
        .request(
            type: 'get',
            url: Interface.getWrokClosePeople + widget.bookId.toString())
        .then((value) {
      if (value is Map) {
        _data = value['workShutDownPeopleList'];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              itemCount: widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ApplyItem(
                  dataMap: widget.data[index],
                  index: index,
                );
              }),
        ),
        Wrap(
          children: _data
              .map((e) => Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text('作业关闭人：${e['name']}'),
                  ))
              .toList(),
        ),
        widget.sumbitWidget,
        SizedBox(
          height: size.width * 50,
        )
      ],
    );
  }
}

class ApplyItem extends StatefulWidget {
  ApplyItem({@required this.dataMap, this.index, this.callback});
  final Map dataMap;
  final int index;
  final Function callback;
  @override
  _ApplyItemState createState() => _ApplyItemState();
}

class _ApplyItemState extends State<ApplyItem> {
  List inner = [];
  List outer = [];

  _getImage(String workName) {
    switch (workName) {
      case '动火作业':
        return 'assets/images/icon_fire_check.png';
        break;
      case '临时用电':
        return 'assets/images/icon_electric_check.png';
        break;
      case '吊装作业':
        return 'assets/images/icon_hoisting_check.png';
        break;
      case '高处作业':
        return 'assets/images/icon_height_check.png';
        break;
      case '受限空间':
        return 'assets/images/icon_limitation_check.png';
        break;
      case '盲板抽堵':
        return 'assets/images/icon_blind_plate_wall_check.png';
        break;
      case '动土作业':
        return 'assets/images/icon_soil_check.png';
        break;
      case '断路作业':
        return 'assets/images/icon_turnoff_check.png';
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    width: size.width * 75,
                    height: size.width * 86,
                    image: AssetImage(_getImage(widget.dataMap['name'])),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.dataMap['name'].toString(),
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: size.width * 34,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.width * 10,
                        ),
                        Text(
                          '已关闭',
                          style: TextStyle(fontSize: size.width * 22),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: '危害识别：',
                            style: TextStyle(
                                color: Color(0xff6D9FFD),
                                fontSize: size.width * 24),
                          ),
                          TextSpan(
                            text: widget.dataMap['hazardNum'].toString(),
                            style: TextStyle(
                                color: Color(0xffff5555),
                                fontSize: size.width * 24),
                          ),
                          TextSpan(
                            text: '条',
                            style: TextStyle(
                                color: Color(0xffff5555),
                                fontSize: size.width * 24),
                          ),
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: '安全措施：',
                            style: TextStyle(
                                color: Color(0xff6D9FFD),
                                fontSize: size.width * 24),
                          ),
                          TextSpan(
                            text: widget.dataMap['measuresNum'].toString(),
                            style: TextStyle(
                                color: Color(0xff09ba07),
                                fontSize: size.width * 24),
                          ),
                          TextSpan(
                            text: '条',
                            style: TextStyle(
                                color: Color(0xff09ba07),
                                fontSize: size.width * 24),
                          ),
                        ])),
                      ],
                    ),
                  ],
                ))
              ],
            ),
            Row(
              children: <Widget>[
                widget.dataMap['inner'] != null
                    ? Container(
                        width: size.width * 350,
                        height: size.width * 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    alignment:
                                        const FractionalOffset(1.2, -0.1),
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 59,
                                        height: size.width * 59,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xff09ba07),
                                              width: 1),
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/work_avatar.png'),
                                          ),
                                        ),
                                      ),
                                      widget.dataMap['inner'][index]
                                                  ['guarDian'] ==
                                              true
                                          ? Container(
                                              width: size.width * 26,
                                              height: size.width * 26,
                                              decoration: BoxDecoration(
                                                color: Color(0xff09ba07),
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '监',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          size.width * 16),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Text(
                                    widget.dataMap['inner'][index]['name']
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 20),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: widget.dataMap['inner'].length,
                        ),
                      )
                    : Container(),
                widget.dataMap['outer'] != null
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                            children: widget.dataMap['outer']
                                .asMap()
                                .keys
                                .map<Widget>((index) {
                          return Column(
                            children: [
                              Container(
                                width: size.width * 148,
                                height: size.width * 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff6D9FFD), width: 1),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      width: size.width * 31,
                                      height: size.width * 27,
                                      image: AssetImage(
                                          'assets/images/icon_apply_people.png'),
                                    ),
                                    Text(
                                      '人数：',
                                      style: TextStyle(
                                          color: Color(0xff6D9FFD),
                                          fontSize: size.width * 22),
                                    ),
                                    Text(
                                      widget.dataMap['outer'][index]['names']
                                          .length
                                          .toString(),
                                      style: TextStyle(
                                          color: Color(0xff6D9FFD),
                                          fontSize: size.width * 22),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.width * 10,
                              ),
                              Text(
                                widget.dataMap['outer'][index]['name']
                                    .toString(),
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: size.width * 20),
                              ),
                            ],
                          );
                        }).toList()))
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
