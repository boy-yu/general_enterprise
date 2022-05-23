import 'package:enterprise/common/clickImage.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class ChoosePeople extends StatefulWidget {
  ChoosePeople({@required this.changeMsg, this.title});
  final Function(Map data) changeMsg;
  final String title;
  @override
  _ChoosePeopleState createState() => _ChoosePeopleState();
}

class _ChoosePeopleState extends State<ChoosePeople> {
  List data = [];
  Map choosePeople = {'id': ''};
  List<String> tableList = [];

  @override
  void initState() {
    super.initState();
    _getOrganization();
  }

  _getOrganization({Map map}) {
    if (map == null) {
      myDio
          .request(type: 'get', url: Interface.getDepartmentTree)
          .then((value) {
        if (value is List) {
          tableList.add('联络人');
          data = value;
        }
        if (mounted) {
          setState(() {});
        }
      });
    } else {
      data = map['children'];
      tableList.add(map['name']);
      if (mounted) {
        setState(() {});
      }
    }
  }

  List perData = [];

  _getPeople(Map map) {
    myDio.request(
        type: 'get',
        url: Interface.getCoUserByDepartment,
        queryParameters: {'id': map['id']}).then((value) {
      if (value is List) {
        for (int i = 0; i < value.length; i++) {
          perData.add(value[i]);
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(
        widget.title,
        style: TextStyle(fontSize: size.width * 32),
      ),
      child: Container(
        color: Color(0xffF8FAFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 32),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: tableList
                        .asMap()
                        .keys
                        .map((index) => InkWell(
                              onTap: () {
                                if (index == 0) {
                                  tableList.clear();
                                  perData.clear();
                                  _getOrganization();
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    tableList[index],
                                    style: TextStyle(
                                        color: Color(0xff3074FF),
                                        fontSize: size.width * 32,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 20),
                                    child: Image.asset(
                                      'assets/images/doubleRiskProjeck/icon_choose_people_right.png',
                                      height: size.width * 24,
                                      width: size.width * 12,
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList()),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  data.isNotEmpty
                      ? ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: new NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 32),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xffECECEC),
                                            width: size.width * 2))),
                                child: Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.w400),
                                          children: <InlineSpan>[
                                            TextSpan(
                                                text: data[index]['name']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color(0xff333333))),
                                            TextSpan(
                                                text: '  (共' +
                                                    (data[index]['children']
                                                            is List
                                                        ? data[index]
                                                                ['children']
                                                            .length
                                                            .toString()
                                                        : "0") +
                                                    '个部门)',
                                                style: TextStyle(
                                                    color: Color(0xff7F8A9C))),
                                          ]),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        _getPeople(data[index]);
                                        if (data[index]['children'] is List) {
                                          _getOrganization(map: data[index]);
                                        }
                                      },
                                      child: Container(
                                        width: size.width * 160,
                                        height: size.width * 104,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: size.width * 40,
                                              width: size.width * 2,
                                              color: Color(0XFFECECEC),
                                            ),
                                            SizedBox(
                                              width: size.width * 32,
                                            ),
                                            Image.asset(
                                              'assets/images/doubleRiskProjeck/icon_choose_people_next.png',
                                              height: size.width * 30,
                                              width: size.width * 30,
                                            ),
                                            Text(
                                              '下级',
                                              style: TextStyle(
                                                  color: Color(0xff3074FF),
                                                  fontSize: size.width * 28,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ));
                          },
                        )
                      : Center(
                          child: Text('该部门下无子级部门'),
                        ),
                  perData.isNotEmpty
                      ? ListView.builder(
                          itemCount: perData.length,
                          shrinkWrap: true,
                          physics: new NeverScrollableScrollPhysics(),
                          itemBuilder: (context, perIndex) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: size.width * 15),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xffECECEC),
                                            width: size.width * 2))),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {
                                        if (choosePeople['id'] ==
                                            perData[perIndex]['id']) {
                                          choosePeople = {'id': ''};
                                        } else {
                                          choosePeople = perData[perIndex];
                                        }
                                        if (mounted) {
                                          setState(() {});
                                        }
                                      },
                                      child: choosePeople['id'] ==
                                              perData[perIndex]['id'].toString()
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: size.width * 20),
                                              child: Icon(
                                                Icons.check_circle,
                                                color: themeColor,
                                                size: size.width * 35,
                                              ),
                                            )
                                          : Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: size.width * 20),
                                              width: size.width * 35,
                                              height: size.width * 35,
                                              padding: EdgeInsets.all(
                                                  size.width * 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Color(0xffC0C0C8),
                                                  )),
                                            ),
                                    ),
                                    Container(
                                        foregroundDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                width: 1, color: themeColor)),
                                        margin: EdgeInsets.only(
                                            right: size.width * 25),
                                        child: ClipOval(
                                          child: ClickImage(
                                            perData[perIndex]['avatar'],
                                            width: size.width * 60,
                                            height: size.width * 60,
                                          ),
                                        )),
                                    Expanded(
                                        child: Text(
                                      perData[perIndex]['nickname'].toString(),
                                      style: TextStyle(color: placeHolder),
                                    )),
                                  ],
                                ));
                          })
                      : Center(
                          child: Text('当前部门下无人员信息'),
                        ),
                ],
              ),
            )),
            Container(
              padding: EdgeInsets.symmetric(vertical: size.width * 30),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      widget.changeMsg(choosePeople);
                    },
                    child: Container(
                      height: size.width * 80,
                      width: size.width * 686,
                      decoration: BoxDecoration(
                          color: Color(0xff3074FF),
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 8))),
                      alignment: Alignment.center,
                      child: Text(
                        '确定',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 32,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
