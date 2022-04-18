import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainList extends StatefulWidget {
  MainList({Key key}) : super(key: key);
  @override
  _MainListState createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  String matutity = '';
  void _changeMatu(String msg) {
    matutity = msg;
    if (mounted) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin:
              EdgeInsets.only(left: size.width * 20, right: size.width * 20),
          child: Card(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(size.width * 25),
                  child: Image.asset(
                    "assets/images/icon_prodect_notice.png",
                    width: size.width * 28,
                    height: size.width * 28,
                  ),
                ),
                Container(
                  width: size.width * 1,
                  height: size.width * 43,
                  color: Color(0xffDBDBDB),
                ),
                Container(
                  margin: EdgeInsets.all(size.width * 20),
                  decoration: BoxDecoration(
                      color: Color(0xffFC5B15), shape: BoxShape.circle),
                  width: size.width * 10,
                  height: size.width * 10,
                ),
                Row(
                  children: [
                    Text(
                      matutity,
                      style: TextStyle(
                          color: Color(0xffFC5B15),
                          fontSize: size.width * 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: size.width * 5,
                    ),
                    Text(
                      '个清单项临期',
                      style: TextStyle(
                          color: Color(0xff656565),
                          fontSize: size.width * 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: size.width * 20, right: size.width * 20),
          child: MainListBar(callback: _changeMatu),
        ),
        MainListUi()
      ],
    ));
  }
}

class MainListBar extends StatefulWidget {
  final Function(String msg) callback;
  const MainListBar({Key key, this.callback}) : super(key: key);
  @override
  _MainListBarState createState() => _MainListBarState();
}

class _MainListBarState extends State<MainListBar> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  List<XAxisSturct> workState = [];
  double workStateTotal = 0.0;
  _getData() {
    myDio
        .request(type: 'get', url: Interface.getListBar, mounted: mounted)
        .then((value) {
      workState = [];
      if (value is Map) {
        value.forEach((key, value) {
          workStateTotal += value;
          if (key == 'overdue') {
            workState.add(XAxisSturct(
                names: '逾期', color: Color(0xff596BFF), nums: value * 1.0));
          } else if (key == 'completed') {
            workState.add(XAxisSturct(
                names: '已完成', color: Color(0xff24ABFD), nums: value * 1.0));
          }
        });
        widget.callback(value['advent'].toString());

        if (mounted) {
          if (mounted) {
            setState(() {});
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(size.width * 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: size.width * 20),
              padding: EdgeInsets.symmetric(vertical: size.width * 20),
              child: Text(
                '清单实时统计',
                style: TextStyle(
                    fontSize: size.width * 28, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: underColor, width: 1))),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: size.width * 20),
                  width: size.width * 250,
                  child: PieChartSample2(
                    // color: workState.map<Color>((e) => e['color']).toList(),
                    roundUi: workState,
                  ),
                ),
                Expanded(
                    child: Column(
                  children: workState
                      .map((e) => Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: size.width * 20),
                                width: size.width * 18,
                                height: size.width * 18,
                                color: e.color,
                              ),
                              Container(
                                child: Text(e.names, style: TextStyle(fontSize: size.width * 28),),
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 20),
                              ),
                              Container(
                                child: Text(
                                  e.nums.toString(),
                                  style: TextStyle(color: placeHolder, fontSize: size.width * 28),
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MainListUi extends StatefulWidget {
  @override
  _MainListUiState createState() => _MainListUiState();
}

class _MainListUiState extends State<MainListUi> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  List data = [];
  _init() {
    myDio.request(type: 'get', url: Interface.getlistMain).then((value) {
      if (value is List) {
        data = value;
        if (mounted) {
          if (mounted) {
            setState(() {});
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          data.asMap().keys.map((index) => MainItem(index, data)).toList(),
    );
  }
}

class MainItem extends StatelessWidget {
  MainItem(this.index, this.data);
  final int index;
  final List data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 20,
        right: size.width * 20,
        top: size.width * 20,
      ),
      child: InkWell(
          onTap: () {
            List<HiddenDangerInterface> _leftbar = [];
            _leftbar = _leftbar.changeHiddenDangerInterfaceType(data,
                title: 'name',
                icon: 'static:menuIcon',
                id: 'id',
                children: 'children');
            _leftbar[index].color = Colors.white;

            if (_leftbar[index].children.isNotEmpty) {
              Navigator.pushNamed(context, '/index/productList/CommonPage',
                  arguments: {
                    "leftBar": _leftbar,
                    "index": index,
                    "title": '主体责任清单',
                    "widgetType": 'MainListCommonPages',
                  });
            } else {
              Fluttertoast.showToast(msg: '已无下一级数据');
            }
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(1, 1), blurRadius: 2)
            ]),
            padding: EdgeInsets.only(
                bottom: size.width * 20,
                left: size.width * 20,
                right: size.width * 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPaint(
                    painter: CostomMainlist(index),
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(
                          vertical: size.width * 15,
                          horizontal: size.width * 12),
                      child: Text(
                        (index + 1).toString().length < 2
                            ? '0' + (index + 1).toString()
                            : (index + 1).toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(
                      top: size.width * 20, left: size.width * 20),
                  child: Text(
                    data[index]['name'].toString(),
                    style: TextStyle(fontSize: size.width * 24),
                  ),
                ))
              ],
            ),
          )),
    );
  }
}

class CostomMainlist extends CustomPainter {
  CostomMainlist(this.index);
  final int index;
  Paint _paint = Paint()
    ..color = themeColor
    ..style = PaintingStyle.fill
    ..strokeWidth = 3;
  @override
  void paint(Canvas canvas, Size sizes) {
    Path _path = Path();
    _path.moveTo(0, 0);
    _path.lineTo(0, sizes.height);
    _path.lineTo(sizes.width / 2, sizes.height - 5);
    _path.lineTo(sizes.width, sizes.height);
    _path.lineTo(sizes.width, 0);
    _path.close();

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
