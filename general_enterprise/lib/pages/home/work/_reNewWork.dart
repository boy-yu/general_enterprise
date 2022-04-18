import 'dart:async';

import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/common/showDia.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReNewWork extends StatefulWidget {
  final int bookId;
  ReNewWork({@required this.bookId});
  @override
  _ReNewWorkState createState() => _ReNewWorkState();
}

class _ReNewWorkState extends State<ReNewWork> {
  String _generateImage(String icon) {
    String iconUrl = '';
    switch (icon) {
      case '动火作业':
        iconUrl = 'assets/images/workList/dongh@2x.png';

        break;
      case '临时用电':
        iconUrl = 'assets/images/icon_electric_uncheck.png';

        break;
      case '吊装作业':
        iconUrl = 'assets/images/workList/dz@2x.png';

        break;
      case '高处作业':
        iconUrl = 'assets/images/workList/lsyd@2x.png';

        break;
      case '受限空间':
        iconUrl = 'assets/images/workList/sx@2x.png';

        break;
      case '盲板抽堵':
        iconUrl = 'assets/images/workList/mb@2x.png';

        break;
      case '动土作业':
        iconUrl = 'assets/images/workList/dt@2x.png';

        break;
      case '断路作业':
        iconUrl = 'assets/images/workList/dl@2x.png';

        break;
      default:
        iconUrl = 'assets/images/workList/gc@2x.png';
    }
    return iconUrl;
  }

  ThrowFunc _throwFunc = ThrowFunc();
  List saveList = [];
  List<int> _list = [];
  Widget prompt(String number, {Color color, double width}) {
    return Container(
      margin: EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: color ?? Color(0xff1F44ED)),
      width: width ?? 16,
      height: width ?? 16,
      alignment: Alignment.center,
      child: Text(number, style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.bookId);
    return MyAppbar(
        actions: [
          TextButton(
              onPressed: () {
                showDia(context, [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text('续票规则'),
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      prompt('1'),
                      SizedBox(width: 5),
                      Expanded(
                          child: Text(
                        '根据GB30871-2014中规定，需进行时间限制的作业有特级动火作业（8小时）、一级动火作业（8小时）、二级动火作业（72小时）、受限空间作业（24小时）、临时用电作业（720小时）。',
                        style: TextStyle(fontSize: size.width * 24),
                      ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      prompt('2'),
                      SizedBox(width: 5),
                      Expanded(
                          child: Text(
                        '可进行续票的作业即有时间限制的特级动火作业、一级动火作业、二级动火作业、受限空间作业、临时用电作业。',
                        style: TextStyle(fontSize: size.width * 24),
                      ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      prompt('3'),
                      SizedBox(width: 5),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '       续票需满足的条件：',
                            style: TextStyle(fontSize: size.width * 24),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              prompt('a', color: Color(0xff3C7FFC)),
                              SizedBox(width: 5),
                              Expanded(
                                  child: Text(
                                '已作业时间距离允许最长作业时间小于等于1小时。（例：一级动火作业最大允许8小时，已作业时间大于等于7小时后可开始续票）',
                                style: TextStyle(fontSize: size.width * 24),
                              ))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              prompt('b', color: Color(0xff3C7FFC)),
                              SizedBox(width: 5),
                              Expanded(
                                  child: Text(
                                '作业中安全措施需全部落实，若没有作业中安全措施则默认完成。',
                                style: TextStyle(fontSize: size.width * 24),
                              ))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              prompt('c', color: Color(0xff3C7FFC)),
                              SizedBox(width: 5),
                              Expanded(
                                  child: Text(
                                '操作账号为当前作业监护人。',
                                style: TextStyle(fontSize: size.width * 24),
                              ))
                            ],
                          ),
                        ],
                      ))
                    ],
                  ),
                ]);
              },
              child: Text(
                '续票规则',
                style: TextStyle(color: Colors.white),
              ))
        ],
        title: Text('续票选择'),
        child: Column(
          children: [
            Expanded(
                child: MyRefres(
                    throwFunc: _throwFunc,
                    padding: EdgeInsets.all(20),
                    child: (index, list) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/workList/reNew@2x.png'))),
                        child: Row(
                          children: [
                            Image.asset(_generateImage(list[index]['workName']),
                                width: size.width * 47,
                                height: size.width * 54),
                            SizedBox(width: 10),
                            Text(list[index]['workName'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 30)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('作业已进行',
                                      style: TextStyle(
                                          color: Color(0xff3C7FFC),
                                          fontSize: 12)),
                                  TimeCounter(
                                      list[index]['startDate'].toString())
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                                child: Icon(
                                    _list.contains(list[index]['receiptId'])
                                        ? Icons.check_circle
                                        : Icons.panorama_fish_eye,
                                    color:
                                        _list.contains(list[index]['receiptId'])
                                            ? Color(0xff445CFE)
                                            : Color(0xff445CFE)),
                                onTap: list[index]['status'] == 1
                                    ? () {
                                        if (!_list.contains(
                                            list[index]['receiptId'])) {
                                          _list.add(list[index]['receiptId']);
                                          saveList.add(list[index]);
                                        } else {
                                          saveList.removeAt(_list.indexOf(
                                              list[index]['receiptId']));
                                          _list
                                              .remove(list[index]['receiptId']);
                                        }
                                        setState(() {});
                                      }
                                    : () {
                                        successToast('未满足续票要求');
                                      })
                          ],
                        ),
                      );
                    },
                    url: Interface.getReceiptBookList,
                    queryParameters: {"bookId": widget.bookId},
                    method: 'get')),
            _list.isNotEmpty
                ? TextButton(
                    onPressed: () {
                      context.read<Counter>().emptySubmitDates();
                      Navigator.pushNamed(context, '/home/work/WorkTicker',
                          arguments: {
                            'circuit': 1,
                            "operable": true,
                            "executionMemo": '',
                            "outSide": true,
                            "parentId": widget.bookId,
                            "receiptIdList": _list,
                            "bookId": widget.bookId
                          }).then((value) {
                        _list.clear();
                        // _list = [];
                        _throwFunc.run(argument: {"bookId": widget.bookId});
                        setState(() {});
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                      decoration: BoxDecoration(
                          color: Color(0xff09BA07),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text('续票', style: TextStyle(color: Colors.white)),
                    ))
                : Container(),
          ],
        ));
  }
}

class TimeCounter extends StatefulWidget {
  final String time;
  const TimeCounter(this.time, {Key key}) : super(key: key);

  @override
  _TimeCounterState createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  Duration time = Duration();
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    DateTime _start = DateTime.parse(widget.time);
    time = DateTime.now().toLocal().difference(_start);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time = Duration(seconds: time.inSeconds + 1);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(time.toString().split('.')[0],
          style: TextStyle(color: Color(0xff3C7FFC))),
    );
  }
}
