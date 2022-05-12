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
        tableList.add(map['name']);
        perData = value;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(size.width * 20),
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
                                _getOrganization();
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  tableList[index],
                                  style: TextStyle(color: themeColor),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: placeHolder,
                                )
                              ],
                            ),
                          ))
                      .toList()),
            ),
          ),
          Expanded(
              child: ListView(
                children: [
                  data.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true, 
		                  physics: new NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: underColor, width: 1))),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            onPressed: () {},
                            child: Container(
                              margin: EdgeInsets.only(top: size.width * 2),
                              padding: EdgeInsets.all(size.width * 20),
                              decoration: BoxDecoration(color: Colors.white),
                              child:  Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 125,
                                        ),
                                        Text(
                                          data[index]['name'].toString() +
                                              '(共' +
                                              (data[index]['children'] is List
                                                  ? data[index]['children']
                                                      .length
                                                      .toString()
                                                  : "0") +
                                              '个部门)',
                                          style: TextStyle(color: placeHolder),
                                        ),
                                        Spacer(),
                                        ElevatedButton.icon(
                                            style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white)),
                                            onPressed: () {
                                              if (data[index]['children']is List) {
                                                _getOrganization(map: data[index]);
                                                _getPeople(data[index]);
                                              } else {
                                                _getPeople(data[index]);
                                              }
                                            },
                                            icon: Icon(
                                              Icons.playlist_play,
                                              color: themeColor,
                                            ),
                                            label: Text(
                                              '下级',
                                              style:
                                                  TextStyle(color: themeColor),
                                            ))
                                      ],
                                    )
                                 
                            ),
                          ),
                        );
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
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: underColor, width: 1))),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            onPressed: () {},
                            child: Container(
                              margin: EdgeInsets.only(top: size.width * 2),
                              padding: EdgeInsets.all(size.width * 20),
                              decoration: BoxDecoration(color: Colors.white),
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
                                            print(perData[index]);
                                            if(choosePeople['id'] == perData[index]['id']){
                                              choosePeople = {'id': ''};
                                            }else{
                                              choosePeople = perData[index];
                                            }
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          },
                                          child: choosePeople['id'] == perData[index]['id']
                                              ? Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 20),
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    color: themeColor,
                                                    size: size.width * 35,
                                                  ),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 20),
                                                  width: size.width * 35,
                                                  height: size.width * 35,
                                                  padding: EdgeInsets.all(
                                                      size.width * 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Color(0xffC0C0C8),
                                                      )),
                                                ),
                                        ),
                                        Container(
                                            foregroundDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    width: 1,
                                                    color: themeColor)),
                                            margin: EdgeInsets.only(
                                                right: size.width * 25),
                                            child: ClipOval(
                                              child: ClickImage(
                                                perData[index]['avatar'],
                                                width: size.width * 60,
                                                height: size.width * 60,
                                              ),
                                            )),
                                        Expanded(
                                            child: Text(
                                          perData[index]['nickname'].toString(),
                                          style: TextStyle(color: placeHolder),
                                        )),
                                      ],
                                    )
                            )
                          )
                        );
                      }
                  ): Center(
                      child: Text('该部门下无人员信息'),
                    ),
                ],
              )
              
              
              ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(width: 1, color: underColor))),
            padding: EdgeInsets.symmetric(horizontal: size.width * 20),
            child: Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(themeColor)),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.changeMsg(choosePeople);
                  },
                  child: Text('确定'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
