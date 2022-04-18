import 'dart:convert';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class PostWorkDetail extends StatefulWidget {
  PostWorkDetail({this.data});
  final Map data;
  @override
  _PostWorkDetailState createState() => _PostWorkDetailState();
}

class _PostWorkDetailState extends State<PostWorkDetail>
    with TickerProviderStateMixin {
  TabController _tabController;
  int way = -1;
  List<String> titleList = [];
  List data = [];
  @override
  void initState() {
    super.initState();

    way = widget.data['type'];

    List interactiveData = widget.data['interactiveData'];
    // way 2 隐患排查 3巡检点检 4作业 5企业合规性
    if (way == 4) {
      for (int i = 0; i < interactiveData.length; i++) {
        if (interactiveData[i]['type'] == 1) {
          titleList.add('作业计划');
        }
        if (interactiveData[i]['type'] == 3) {
          titleList.add('风险辨识');
        }
        if (interactiveData[i]['type'] == 5) {
          titleList.add('安全交底');
        }
        if (interactiveData[i]['type'] == 8) {
          titleList.add('作业关闭');
        }
      }
    } else {
      for (int i = 0; i < interactiveData.length; i++) {
        if (interactiveData[i]['type'] == 1) {
          titleList.add('措施已落实');
        }
        if (interactiveData[i]['type'] == 2) {
          titleList.add('确认隐患');
        }
        if (interactiveData[i]['type'] == 3) {
          titleList.add('整改隐患');
        }
        if (interactiveData[i]['type'] == 4) {
          titleList.add('整改审批');
        }
        if (interactiveData[i]['type'] == 5) {
          titleList.add('措施未落实');
        }
      }
    }
    _tabController = TabController(vsync: this, length: titleList.length);
    _getData(way);
  }

  _getData(int way) {
    myDio
        .request(
            type: 'post',
            url: Interface.postPostWorkDetail,
            data: jsonEncode(widget.data))
        .then((value) async {
      if (value is List) {
        data = value;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Widget _getWidget(Map dataMap) {
    List listData = dataMap['list'];
    if (way == 4) {
      // 作业
      return Column(
          children: listData
              .asMap()
              .keys
              .map((index) => Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: size.width * 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 35),
                              child: Text(
                                listData[index]['workName'],
                                style: TextStyle(
                                    fontSize: size.width * 30,
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: size.width * 1,
                              color: Color(0xffE5E5E5),
                              margin: EdgeInsets.symmetric(
                                  vertical: size.width * 15),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '属地单位：${listData[index]['territorialUnit']}',
                                    style: TextStyle(
                                        fontSize: size.width * 26,
                                        color: Color(0xff333333)),
                                  ),
                                  Text(
                                    '执行人：${listData[index]['executionName']}',
                                    style: TextStyle(
                                        fontSize: size.width * 26,
                                        color: Color(0xff333333)),
                                  ),
                                  Text(
                                    '执行时间：${listData[index]['executionTime']}',
                                    style: TextStyle(
                                        fontSize: size.width * 26,
                                        color: Color(0xff333333)),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ))
              .toList());
    } else {
      // 隐患排查 巡检点检 页面一样
      if (dataMap['type'] == 1 || dataMap['type'] == 5) {
        // type = 1措施已落实 5措施未落实
        return Column(
            children: listData
                .asMap()
                .keys
                .map((index) => Card(
                      elevation: 5,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 35),
                                child: Text(
                                  listData[index]['riskPoint'],
                                  style: TextStyle(
                                      fontSize: size.width * 30,
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: size.width * 1,
                                color: Color(0xffE5E5E5),
                                margin: EdgeInsets.symmetric(
                                    vertical: size.width * 15),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '风险分析单元：${listData[index]['riskUnit']}',
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Color(0xff333333)),
                                    ),
                                    Text(
                                      '风险事件：${listData[index]['riskItem']}',
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Color(0xff333333)),
                                    ),
                                    Text(
                                      '管控措施：${listData[index]['controlMeasures']}',
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Color(0xff333333)),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ))
                .toList());
      } else {
        // type = 2确认隐患 3整改隐患 4整改审批
        return Column(
            children: listData
                .asMap()
                .keys
                .map((index) => Card(
                      elevation: 5,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 35),
                                child: Text(
                                  listData[index]['riskPoint'],
                                  style: TextStyle(
                                      fontSize: size.width * 30,
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: size.width * 1,
                                color: Color(0xffE5E5E5),
                                margin: EdgeInsets.symmetric(
                                    vertical: size.width * 15),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '风险分析单元：${listData[index]['riskUnit']}',
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Color(0xff333333)),
                                    ),
                                    Text(
                                      '风险事件：${listData[index]['riskItem']}',
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Color(0xff333333)),
                                    ),
                                    Text(
                                      _getText(
                                          dataMap['type'], listData[index]),
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Color(0xff333333)),
                                    ),
                                    Text(
                                      _getTimeText(
                                          dataMap['type'], listData[index]),
                                      style: TextStyle(
                                          fontSize: size.width * 26,
                                          color: Color(0xff333333)),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ))
                .toList());
      }
    }
  }

  String _getText(int type, Map map) {
    // type = 2确认隐患 3整改隐患 4整改审批
    switch (type) {
      case 2:
        return '确认人：${map['confirmUser']}';
        break;
      case 3:
        return '整改人：${map['rectificationPersonnel']}';
        break;
      case 4:
        return '审批人：${map['rectificationConfirmUser']}';
        break;
      default:
        return '';
    }
  }

  String _getTimeText(int type, Map map) {
    // type = 2确认隐患 3整改隐患 4整改审批
    switch (type) {
      case 2:
        return '确认时间：${map['confirmTime']}';
        break;
      case 3:
        return '整改时间：${map['rectificationCompletedTime']}';
        break;
      case 4:
        return '审批时间：${map['rectificationConfirmTime']}';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('工作详情'),
      child: Column(
        children: [
          Center(
            child: TabBar(
              tabs: titleList
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
              controller: _tabController,
              isScrollable: true,
              indicatorColor: themeColor,
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.only(bottom: 10.0),
              labelColor: themeColor,
              labelStyle: TextStyle(
                fontSize: size.width * 32,
              ),
              unselectedLabelColor: Color(0xff999999),
              unselectedLabelStyle: TextStyle(
                fontSize: size.width * 32,
              ),
            ),
          ),
          data.isNotEmpty
              ? Expanded(
                  child: TabBarView(
                    children: data
                        .asMap()
                        .keys
                        .map(
                          (index) => SingleChildScrollView(
                            padding: EdgeInsets.all(size.width * 20),
                            child: data[index].isNotEmpty
                                ? _getWidget(data[index])
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(top: size.width * 300),
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
                          ),
                        )
                        .toList(),
                    controller: _tabController,
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
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
        ],
      ),
    );
  }
}
