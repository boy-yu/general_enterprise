import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/echart_exmple/pie.dart';
import 'package:enterprise/pages/home/work/history.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Overview extends StatefulWidget {
  Overview({this.title = ''});
  final title;
  @override
  _OverviewState createState() => _OverviewState();
}

Map statistics = {
  'completeNum': 0,
  'planNum': 0,
  'waitNum': 0,
  'areDoingNum': 0,
  'temporaryNum': 0,
  'cancelWorkNum': 0
};
List statisticsType = [
  {'name': '暂无数据', 'num': 0}
];
List<double> dataList = [];
List<String> bottomTextList = [];
double maxYAxis = 10.0;
List<XAxisSturct> columnDataList = [];

class _OverviewState extends State<Overview> {
  List _widget = [
    WorkOverState(),
    SizedBox(
      height: size.width * 10,
    ),
    WorkOverSpecil(),
    TerritoryUi(),
    TrendUi(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        padding: EdgeInsets.all(size.width * 20),
        itemCount: _widget.length,
        itemBuilder: (context, index) => _widget[index],
      ),
    );
  }
}

class WorkOverState extends StatefulWidget {
  @override
  _WorkOverStateState createState() => _WorkOverStateState();
}

class _WorkOverStateState extends State<WorkOverState> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  List<XAxisSturct> workState = [];
  double workStateTotal = 0.0;
  _getData() {
    myDio
        .request(type: 'get', url: Interface.workTypeToday)
        .then((value) async {
      workState.clear();
      if (value is Map) {
        value.forEach((key, value) {
          workStateTotal += value;
          if (key == 'undoneNum') {
            workState.add(XAxisSturct(
                names: '未进行', color: Color(0xff596BFF), nums: value * 1.0));
          } else if (key == 'completedNum') {
            workState.add(XAxisSturct(
                names: '已完成', color: Color(0xff24ABFD), nums: value * 1.0));
          } else if (key == 'processingNum') {
            workState.add(XAxisSturct(
                names: '进行中', color: Color(0xff40E8FE), nums: value * 1.0));
          } else if (key == 'interruptNum') {
            workState.add(XAxisSturct(
                names: '已中断', color: Colors.grey, nums: value * 1.0));
          }
        });

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 5,
      margin: EdgeInsets.symmetric(vertical: size.width * 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow( 
                color: Colors.black12,
                offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                blurRadius: 3.0, //阴影模糊程度
                spreadRadius: 2.0 //阴影扩散程度
                ),
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: size.width * 30),
              padding: EdgeInsets.symmetric(vertical: size.width * 20),
              child: Text(
                '作业状态',
                style: TextStyle(
                    fontSize: size.width * 28, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Color(0xffF7F7F7),
              height: size.width * 2,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.width * 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 200,
                    child: PieChartSample2(
                      roundUi: workState,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: workState
                        .map((e) => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.width * 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width * 18,
                                    height: size.width * 18,
                                    decoration: BoxDecoration(
                                        color: e.color,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1.0))),
                                  ),
                                  SizedBox(
                                    width: size.width * 40,
                                  ),
                                  Container(
                                    child: Text(
                                      e.names,
                                      style: TextStyle(
                                          color: Color(0xff656565),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 45,
                                  ),
                                  Container(
                                    child: Text(
                                      e.nums.toString(),
                                      style: TextStyle(
                                          color: Color(0xffA4A4A4),
                                          fontSize: size.width * 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkOverSpecil extends StatefulWidget {
  @override
  _WorkOverSpecilState createState() => _WorkOverSpecilState();
}

class _WorkOverSpecilState extends State<WorkOverSpecil> {
  List<TogglePicType> titleBar = [
    TogglePicType(title: "8大特殊作业的占比", data: []),
    TogglePicType(title: "作业来源统计", data: [], totalNum: 0),
  ];
  int choosed = 0;
  dynamic titleBarQueryParameters;
  Counter _counter = Provider.of(myContext);
  @override
  void initState() {
    super.initState();
    _getWorkPercen();
  }

  _getWorkPercen() {
    myDio
        .request(
            type: 'get',
            url: Interface.getWorkPercen,
            queryParameters: titleBarQueryParameters)
        .then((value) {
      if (value is List) {
        titleBar[0].data = [];
        titleBar[0].totalNum = 0;
        value.forEach((ele) {
          titleBar[0].totalNum += ele['value'];
          switch (ele['workName']) {
            case '临时用电':
              titleBar[0].data.add(XAxisSturct(
                  color: Color(0xffFAF16A),
                  names: '临时用电',
                  nums: ele['value'] * 1.0));
              break;
            case '盲板抽堵':
              titleBar[0].data.add(XAxisSturct(
                  color: Color(0xffFEB46E),
                  names: '盲板抽堵',
                  nums: ele['value'] * 1.0));
              break;
            case '受限空间':
              titleBar[0].data.add(XAxisSturct(
                  color: Color(0xffAEF850),
                  names: '受限空间',
                  nums: ele['value'] * 1.0));
              break;
            case '吊装作业':
              titleBar[0].data.add(XAxisSturct(
                  color: Color(0xff74E887),
                  names: '吊装作业',
                  nums: ele['value'] * 1.0));
              break;
            case '高处作业':
              titleBar[0].data.add(XAxisSturct(
                  color: Color(0xff6E95F1),
                  names: '高处作业',
                  nums: ele['value'] * 1.0));
              break;
            case '断路作业':
              titleBar[0].data.add(XAxisSturct(
                  color: Color(0xff24ABFD),
                  names: '断路作业',
                  nums: ele['value'] * 1.0));
              break;
            case '动土作业':
              titleBar[0].data.add(XAxisSturct(
                  color: Color(0xff40E8FE),
                  names: '动土作业',
                  nums: ele['value'] * 1.0));
              break;
            case '动火作业':
              titleBar[0].data.add(XAxisSturct(
                  color: Color(0xff596BFF),
                  names: '动火作业',
                  nums: ele['value'] * 1.0));
              break;
            default:
              titleBar[0].data.add(XAxisSturct(
                  color: Color(0xff596BFF),
                  names: '其他作业',
                  nums: ele['value'] * 1.0));
          }
        });

        setState(() {});
      }
    });
  }

  _getWorkSource() {
    myDio
        .request(
            type: 'get',
            url: Interface.getWrokSource,
            queryParameters: titleBarQueryParameters)
        .then((value) {
      if (value is Map) {
        titleBar[1].data = [];
        titleBar[1].totalNum = 0;
        value.forEach((key, value) {
          titleBar[1].totalNum += value;
          switch (key) {
            case 'inspectionNum':
              titleBar[1].data.add(XAxisSturct(
                  names: '检查', color: Color(0xff596BFF), nums: value * 1.0));
              break;
            case 'hiddenNum':
              titleBar[1].data.add(XAxisSturct(
                  names: '隐患', color: Color(0xff24ABFD), nums: value * 1.0));
              break;
            default:
              titleBar[1].data.add(XAxisSturct(
                  names: '计划', color: Color(0xff40E8FE), nums: value * 1.0));
          }
        });
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.width * 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                blurRadius: 3.0, //阴影模糊程度
                spreadRadius: 2.0 //阴影扩散程度
                ),
          ]),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: titleBar
                  .asMap()
                  .keys
                  .map((index) => Expanded(
                          child: CustomPaint(
                        painter: SliverStyle(choosed, index, titleBar.length),
                        child: InkWell(
                          onTap: () {
                            titleBarQueryParameters = null;
                            _counter.changeDateStyle(false);
                            choosed = index;
                            if (choosed == 0) {
                              if (titleBar[0].data.length == 0) {
                                _getWorkPercen();
                              }
                            } else {
                              if (titleBar[1].data.length == 0) {
                                _getWorkSource();
                              }
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: size.width * 20, bottom: size.width * 20),
                            child: Text(
                              titleBar[index].title.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size.width * 28,
                                  color: index == choosed
                                      ? Color(0xff306CFD)
                                      : placeHolder,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )))
                  .toList(),
            ),
            SizedBox(
              height: size.width * 40,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(size.width * 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(.1))),
                      child: DateStyle(
                        title: '开始时间',
                        callback: (msg) {
                          if (titleBarQueryParameters == null) {
                            titleBarQueryParameters = {'startDate': msg};
                          } else {
                            titleBarQueryParameters['startDate'] = msg;
                          }
                          titleBarQueryParameters['startDate'] = msg;
                        },
                      )),
                ),
                SizedBox(
                  width: size.width * 20,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(size.width * 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(.1))),
                      child: DateStyle(
                        title: '结束时间',
                        callback: (msg) {
                          if (titleBarQueryParameters == null ||
                              titleBarQueryParameters['startDate'] == null) {
                            Fluttertoast.showToast(msg: '请选择开始时间');
                            return;
                          }

                          if (DateTime.parse(
                                  titleBarQueryParameters['startDate'])
                              .isAfter(DateTime.parse(msg))) {
                            Fluttertoast.showToast(msg: '开始时间不能大于结束时间');
                            return;
                          }
                          titleBarQueryParameters['endDate'] = msg;
                          if (choosed == 1) {
                            _getWorkSource();
                          } else {
                            _getWorkPercen();
                          }
                        },
                      )),
                ),
              ],
            ),
            SizedBox(
              height: size.width * 20,
            ),
            titleBar[choosed].data.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: PieChartSample2(
                          centerChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '作业数量',
                                style: TextStyle(fontSize: size.width * 24),
                              ),
                              Text(
                                titleBar[choosed].totalNum.toString(),
                                style: TextStyle(fontSize: size.width * 24),
                              )
                            ],
                          ),
                          roundUi: titleBar[choosed].data,
                        ),
                      ),
                      Column(
                        children: titleBar[choosed]
                            .data
                            .map<Widget>((e) => Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: size.width * 10),
                                        width: size.width * 18,
                                        height: size.width * 18,
                                        color: e.color),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Container(
                                      child: Text(
                                        e.names.toString(),
                                        style: TextStyle(
                                            color: Color(0xff656565),
                                            fontSize: size.width * 22),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.width * 20),
                                    ),
                                    SizedBox(
                                      width: size.width * 10,
                                    ),
                                    Container(
                                      child: Text(
                                        e.nums.toString(),
                                        style: TextStyle(
                                            color: Color(0xffA4A4A4),
                                            fontSize: size.width * 22),
                                      ),
                                    )
                                  ],
                                ))
                            .toList(),
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  )
                : Center(
                    child: Text('暂无数据'), //StaticLoding()
                  ),
            SizedBox(
              height: size.width * 20,
            ),
          ],
        ),
      ),
    );
  }
}

class TerritoryUi extends StatefulWidget {
  @override
  _TerritoryUiState createState() => _TerritoryUiState();
}

class _TerritoryUiState extends State<TerritoryUi> {
  dynamic queryParameters;
  double yAxis = 0.0;
  List workType = [
    {'workName': '动火作业', 'color': Color(0xff596BFF)},
    {'workName': '动土作业', 'color': Color(0xff40E8FE)},
    {'workName': '断路作业', 'color': Color(0xff24ABFD)},
    {'workName': '高处作业', 'color': Color(0xff6E95F1)},
    {'workName': '吊装作业', 'color': Color(0xff74E887)},
    {'workName': '受限空间', 'color': Color(0xffAEF850)},
    {'workName': '盲板抽堵', 'color': Color(0xffFEB46E)},
    {'workName': '临时用电', 'color': Color(0xffFAF16A)},
  ];
  List<MutipleXAxisSturct> xAxisList = [];
  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() {
    xAxisList = [];
    myDio
        .request(
            type: 'get',
            url: Interface.getWorkTerriorialUnit,
            queryParameters: queryParameters)
        .then((value) {
      if (value is Map) {
        value.forEach((key, value) {
          xAxisList.add(MutipleXAxisSturct(names: key, color: [], nums: []));
          value.forEach((ele) {
            xAxisList[xAxisList.length - 1]
                .nums
                .add(double.parse(ele['num'].toString()));
            workType.forEach((element) {
              if (ele['workName'] == element['workName']) {
                xAxisList[xAxisList.length - 1].color.add(element['color']);
              }
            });
            if (ele['num'] + 20.0 > yAxis) {
              yAxis = ele['num'] + 20.0;
            }
          });
        });
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.width * 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                blurRadius: 5.0, //阴影模糊程度
                spreadRadius: 0.0 //阴影扩散程度
                ),
          ]),
      child: Padding(
        padding: EdgeInsets.all(size.width * 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: size.width * 20),
              padding: EdgeInsets.symmetric(vertical: size.width * 20),
              child: Text(
                '各属地单位特殊作业的统计',
                style: TextStyle(
                    fontSize: size.width * 28, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: underColor.withOpacity(.3), width: 1))),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(size.width * 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(.1))),
                      child: DateStyle(
                        title: '开始时间',
                        callback: (msg) {
                          if (queryParameters == null) {
                            queryParameters = {'startDate': msg};
                          } else {
                            queryParameters['startDate'] = msg;
                          }
                          queryParameters['startDate'] = msg;
                        },
                      )),
                ),
                SizedBox(
                  width: size.width * 20,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(size.width * 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(.1))),
                      child: DateStyle(
                        title: '结束时间',
                        callback: (msg) {
                          if (queryParameters == null ||
                              queryParameters['startDate'] == null) {
                            Fluttertoast.showToast(msg: '请选择开始时间');
                            return;
                          }

                          if (DateTime.parse(queryParameters['startDate'])
                              .isAfter(DateTime.parse(msg))) {
                            Fluttertoast.showToast(msg: '开始时间不能大于结束时间');
                            return;
                          }

                          queryParameters['endDate'] = msg;
                          _getDate();
                        },
                      )),
                ),
              ],
            ),
            Container(
              margin:
                  EdgeInsets.only(left: size.width * 245, top: size.width * 10),
              child: Wrap(
                children: workType
                    .map((e) => Container(
                        width: size.width * 100,
                        child: Center(
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 10,
                                height: size.width * 10,
                                color: e['color'],
                              ),
                              SizedBox(
                                width: size.width * 10,
                              ),
                              Text(
                                e['workName'],
                                style: TextStyle(fontSize: size.width * 16),
                              )
                            ],
                          ),
                        )))
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.width * 20),
              child: CustomEchart().mutipleBar(
                yAxis: yAxis,
                xAxisList: xAxisList,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TrendUi extends StatefulWidget {
  @override
  _TrendUiState createState() => _TrendUiState();
}

class _TrendUiState extends State<TrendUi> {
  dynamic queryParameters;
  List workType = [
    {'name': '动火作业', 'color': Color(0xff596BFF), 'data': []},
    {'name': '动土作业', 'color': Color(0xff40E8FE), 'data': []},
    {'name': '断路作业', 'color': Color(0xff24ABFD), 'data': []},
    {'name': '高处作业', 'color': Color(0xff6E95F1), 'data': []},
    {'name': '吊装作业', 'color': Color(0xff74E887), 'data': []},
    {'name': '受限空间', 'color': Color(0xffAEF850), 'data': []},
    {'name': '盲板抽堵', 'color': Color(0xffFEB46E), 'data': []},
    {'name': '临时用电', 'color': Color(0xffFAF16A), 'data': []},
  ];
  List<TrendBarItemYAxis> yAixs = [];
  List<String> xAixs = [];
  _getDate() {
    myDio
        .request(
            type: 'get',
            url: Interface.getWorkHisoryTrend,
            queryParameters: queryParameters)
        .then((value) {
      if (value is List) {
        xAixs = [];
        yAixs.forEach((element) {
          element.data.clear();
        });
        value.forEach((element) {
          xAixs.add(element['date']);
          element['workTypeList'].forEach((_element) {
            yAixs.forEach((_workType) {
              if (_workType.name == _element['name']) {
                _workType.data.add(double.parse(_element['num'].toString()));
              }
            });
          });
        });
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    workType.forEach((element) {
      yAixs.add(TrendBarItemYAxis(
          name: element['name'].toString(), color: element['color'], data: []));
    });
    _getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.width * 20, bottom: size.width * 80),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                blurRadius: 5.0, //阴影模糊程度
                spreadRadius: 0.0 //阴影扩散程度
                ),
          ]),
      child: Container(
        padding: EdgeInsets.all(size.width * 20),
        margin: EdgeInsets.only(bottom: size.width * 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: size.width * 20),
              padding: EdgeInsets.symmetric(vertical: size.width * 20),
              child: Text(
                '历史趋势',
                style: TextStyle(
                    fontSize: size.width * 28, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: underColor.withOpacity(.3), width: 1))),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(size.width * 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(.1))),
                      child: DateStyle(
                        title: '开始时间',
                        callback: (msg) {
                          if (queryParameters == null) {
                            queryParameters = {'startDate': msg};
                          } else {
                            queryParameters['startDate'] = msg;
                          }
                          queryParameters['startDate'] = msg;
                        },
                      )),
                ),
                SizedBox(
                  width: size.width * 20,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(size.width * 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(.1))),
                      child: DateStyle(
                        title: '结束时间',
                        callback: (msg) {
                          if (queryParameters == null ||
                              queryParameters['startDate'] == null) {
                            Fluttertoast.showToast(msg: '请选择开始时间');
                            return;
                          }

                          if (DateTime.parse(queryParameters['startDate'])
                              .isAfter(DateTime.parse(msg))) {
                            Fluttertoast.showToast(msg: '开始时间不能大于结束时间');
                            return;
                          }

                          queryParameters['endDate'] = msg;
                          _getDate();
                        },
                      )),
                ),
              ],
            ),
            Container(
              margin:
                  EdgeInsets.only(left: size.width * 245, top: size.width * 10),
              child: Wrap(
                children: workType
                    .map((e) => Container(
                        width: size.width * 100,
                        child: Center(
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 10,
                                height: size.width * 10,
                                color: e['color'],
                              ),
                              SizedBox(
                                width: size.width * 10,
                              ),
                              Text(
                                e['name'],
                                style: TextStyle(fontSize: size.width * 16),
                              )
                            ],
                          ),
                        )))
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.width * 20),
              child: CustomEchart().trendBar(yAxis: yAixs, xAixs: xAixs),
            )
          ],
        ),
      ),
    );
  }
}
