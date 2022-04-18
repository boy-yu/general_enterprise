import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dialogAddPeople.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'work_dilog/_dilog.dart';

class WorkAddPeople extends StatefulWidget {
  WorkAddPeople({this.callback});
  final Function callback;
  @override
  _WorkAddPeopleState createState() => _WorkAddPeopleState();
}

class _WorkAddPeopleState extends State<WorkAddPeople> {
  final controller = TextEditingController();
  List data = [];
  bool isExpand = false;
  List innerList = [];
  List outList = [];
  Map guarDian = {};
  // Counter _context = Provider.of<Counter>(myContext);
  _searchPeople(String keywords) {
    myDio.request(
        type: 'get',
        url: Interface.getSourchUnit,
        queryParameters: {"keywords": keywords}).then((value) {
      if (value is List) {
        data = value;
      }
      if (mounted) {
        setState(() {});
      }
    }).catchError((onError) {
      Interface().error(onError, context);
    });
  }

  _changeChoose(Map dataMap, bool addtion) {
    if (addtion) {
      for (var i = 0; i < innerList.length; i++) {
        if (innerList[i]['id'] == dataMap['id']) {
          return;
        }
      }
      if (dataMap['type'] == "personnel") {
        innerList.add(dataMap);
      } else {
        dataMap['names'] = [];
        outList.add(dataMap);
      }
    } else {
      dataMap['isChoose'] = false;
      if (dataMap['type'] == "personnel") {
        for (var i = 0; i < innerList.length; i++) {
          // innerList[i]['id'] == guarDian['id'] 帅
          if (dataMap['id'] == guarDian['id']) {
            guarDian = {};
          }
          if (innerList[i]['id'] == dataMap['id']) {
            innerList.removeAt(i);
            break;
          }
        }
      } else {
        for (var i = 0; i < outList.length; i++) {
          if (outList[i]['id'] == dataMap['id']) {
            outList.removeAt(i);
            break;
          }
        }
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  _changeGuardian(Map guar) {
    guarDian = guar;
    if (mounted) {
      setState(() {});
    }
  }

  // 聂 安
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(
        '人员结构',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 37,
            color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(size.width * 10),
              child: Text('请选择监护人以及作业人',
                  style: TextStyle(
                      color: Color(0xff999999), fontSize: size.width * 26))),
          Container(
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: size.width * 20, horizontal: size.width * 40),
              decoration: BoxDecoration(
                  color: Color(0xffFAFAFB),
                  borderRadius: BorderRadius.circular(50)),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: size.width * 60,
                        right: size.width * 40,
                        top: size.width * 16),
                    border: InputBorder.none,
                    hintText: "请输入关键词",
                    suffixIcon: Icon(Icons.search)),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  _searchPeople(value);
                },
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  innerList.length > 0 || outList.length > 0
                      ? !isExpand
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    '内部作业',
                                    style: TextStyle(
                                        color: Color(0xff242424),
                                        fontSize: size.width * 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: size.width * 120,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: innerList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return WorkInsideItem(
                                            dataMap: innerList[index],
                                            changeChoose: _changeChoose,
                                            changeGuardian: () {
                                              _changeGuardian(innerList[index]);
                                            },
                                            guardian: guarDian);
                                      }),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.all(10),
                                //   child: Text(
                                //     '承包商',
                                //     style: TextStyle(
                                //         color: Color(0xff242424),
                                //         fontSize: size.width * 22,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                // Container(
                                //   height: size.width * 95,
                                //   child: ListView.builder(
                                //       scrollDirection: Axis.horizontal,
                                //       itemCount: outList.length,
                                //       itemBuilder:
                                //           (BuildContext context, int index) {
                                //         return WorkContractorItem(
                                //             dataMap: outList[index],
                                //             changeChoose: _changeChoose);
                                //       }),
                                // ),
                              ],
                            )
                          : Column(children: [
                              Column(
                                children:
                                    innerList.asMap().keys.map<Widget>((index) {
                                  return Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(size.width * 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          innerList[index]['headImg']
                                                      .toString()
                                                      .indexOf('http') >
                                                  -1
                                              ? Image.network(
                                                  innerList[index]['headImg']
                                                      .toString(),
                                                  width: size.width * 60,
                                                  height: size.width * 60,
                                                )
                                              : Image.asset(
                                                  'assets/images/work_avatar.png',
                                                  width: size.width * 60,
                                                  height: size.width * 60,
                                                ),
                                                SizedBox(
                                                  width: size.width * 20,
                                                ),
                                          Expanded(
                                              child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(
                                                      size.width * 5),
                                                  child: Text(
                                                    innerList[index]['name']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: placeHolder),
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width * 400,
                                                  margin: EdgeInsets.all(
                                                      size.width * 5),
                                                  child: Text(
                                                    innerList[index]
                                                            ['departments']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: placeHolder,
                                                        fontSize: size.width * 26),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(
                                                      size.width * 5),
                                                  child: Text(
                                                    innerList[index]
                                                            ['positions']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: placeHolder,
                                                        fontSize: size.width * 26),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                          guarDian['id'] ==
                                                  innerList[index]['id']
                                              ? Container(
                                                  padding: EdgeInsets.all(
                                                      size.width * 10),
                                                  decoration: BoxDecoration(
                                                      color: themeColor,
                                                      shape: BoxShape.circle),
                                                  child: Text(
                                                    '监',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 24),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    _changeGuardian(
                                                        innerList[index]);
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    color: themeColor,
                                                    size: size.width * 50,
                                                  ),
                                                ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                       elevation: MaterialStateProperty.all(0) 
                                                      ),
                                            onPressed: () {
                                              innerList[index]['isChoose'] =
                                                  false;
                                              _changeChoose(
                                                  innerList[index], false);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red),
                                              child: Icon(
                                                Icons.remove,
                                                size: size.width * 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Column(
                                children:
                                    outList.asMap().keys.map<Widget>((index) {
                                  return Card(
                                      child: Padding(
                                    padding: EdgeInsets.all(
                                      size.width * 10,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(
                                                  size.width * 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * 10,
                                                  vertical: size.width * 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          size.width * 5),
                                                  color: themeColor),
                                              child: Text(
                                                outList[index]['name'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: size.width * 30),
                                              ),
                                            ),
                                            Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/icon_wrok_share.png'),
                                                      )),
                                                  width: size.width * 30,
                                                  height: size.width * 30,
                                                ))
                                          ],
                                        ),
                                        Container(
                                          width: size.width * 400,
                                          height: size.width * 100,
                                          child: outList[index]['names'] != null
                                              ? ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, _index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        outList[index]['names']
                                                            .removeAt(_index);
                                                        if (mounted) {
                                                          setState(() {});
                                                        }
                                                      },
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Container(
                                                            width:
                                                                size.width * 80,
                                                            height:
                                                                size.width * 80,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    size.width *
                                                                        5),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    themeColor,
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Center(
                                                              child: Text(
                                                                outList[index]['names']
                                                                            [
                                                                            _index]
                                                                        ['name']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.width *
                                                                            22,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                              right: 0,
                                                              top: size.width *
                                                                  10,
                                                              child: Icon(
                                                                Icons
                                                                    .remove_circle,
                                                                color:
                                                                    Colors.red,
                                                                size:
                                                                    size.width *
                                                                        30,
                                                              ))
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  itemCount: outList[index]
                                                          ['names']
                                                      .length,
                                                )
                                              : Container(),
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: size.width * 110,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      width: 1,
                                                      color: placeHolder))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  WorkDialog.myDialog(
                                                      context, () {}, 2,
                                                      widget: DialogAddPeople(
                                                    onPress: (
                                                        {String image,
                                                        String name,
                                                        String
                                                            certificateName}) {
                                                      if (name == '' ||
                                                          image == '') {
                                                        Fluttertoast.showToast(
                                                            msg: "添加人员不能为空");
                                                        return;
                                                      }
                                                      outList[index]['names']
                                                          .add({
                                                        "name": name,
                                                        "certificateName":
                                                            certificateName,
                                                        "frontPicture": image
                                                      });

                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                    },
                                                  ));
                                                },
                                                child: Icon(
                                                  Icons.add_circle,
                                                  color: Color(0xff09ba07),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _changeChoose(
                                                      outList[index], false);
                                                },
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ));
                                }).toList(),
                              )
                            ])
                      : Container(),
                  innerList.length > 0 || outList.length > 0
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 100),
                          child: Center(
                            child: Stack(
                              alignment: const FractionalOffset(0.5, 0.5),
                              children: <Widget>[
                                Divider(),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                          CircleBorder(),
                                          ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  onPressed: () {
                                    isExpand = !isExpand;
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFF8C9098),
                                          width: size.width * 1),
                                      color: Color(0xFFFFFFFF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      !isExpand
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_up,
                                      size: size.width * 33,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  Column(
                    children: data
                        .asMap()
                        .keys
                        .map((index) => AddWorkPeopleItem(
                              dataMap: data[index],
                              changeChoose: _changeChoose,
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (guarDian.isEmpty) {
                Fluttertoast.showToast(msg: '监护人不能为空');
                return;
              }
              if (innerList.length < 2) {
                Fluttertoast.showToast(msg: '作业人不能为空');
                return;
              }

              // 温 帅
              for (var i = 0; i < innerList.length; i++) {
                if (innerList[i]['id'] == guarDian['id']) {
                  innerList[i]['guarDian'] = true;
                }
              }
              bool next = true;
              String names = '';
              outList.forEach((element) {
                if (element['names'].length == 0) {
                  next = false;
                  names = element['name'];
                }
              });
              if (!next) {
                Fluttertoast.showToast(msg: '$names 没有选择人');
              } else {
                if (widget.callback != null) {
                  widget.callback(
                      inner: innerList, outer: outList, guarDian: guarDian);
                }
                Navigator.pop(context, true);
              }
            },
            child: Container(
              decoration:
                  BoxDecoration(gradient: LinearGradient(colors: lineGradBlue)),
              padding: EdgeInsets.symmetric(vertical: size.width * 20),
              alignment: Alignment.center,
              child: Text(
                '确定',
                style:
                    TextStyle(color: Colors.white, fontSize: size.width * 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WorkContractorItem extends StatefulWidget {
  WorkContractorItem({this.dataMap, this.changeChoose});
  final Map dataMap;
  final Function changeChoose;
  @override
  _WorkContractorItemState createState() => _WorkContractorItemState();
}

class _WorkContractorItemState extends State<WorkContractorItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.dataMap['isChoose'] = false;
        widget.changeChoose(widget.dataMap, false);
      },
      child: Stack(
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(widget.dataMap['name'].toString()),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: size.width * 26,
              height: size.width * 26,
              decoration: BoxDecoration(
                color: Color(0xff4492FF),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Center(
                child: Text(
                  '10',
                  style:
                      TextStyle(color: Colors.white, fontSize: size.width * 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkInsideItem extends StatefulWidget {
  WorkInsideItem(
      {this.dataMap,
      this.guardian,
      this.changeChoose,
      @required this.changeGuardian});
  final Map dataMap, guardian;
  final Function changeChoose, changeGuardian;
  @override
  _WorkInsideItemState createState() => _WorkInsideItemState();
}

class _WorkInsideItemState extends State<WorkInsideItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          widget.dataMap['isChoose'] = false;
          widget.changeChoose(widget.dataMap, false);
        },
        child: Container(
          padding: EdgeInsets.all(size.width * 5),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: size.width * 60,
                    height: size.width * 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50.0),
                      image: DecorationImage(
                        image: widget.dataMap['photoUrl']
                                    .toString()
                                    .indexOf('http') >
                                -1
                            ? NetworkImage(widget.dataMap['photoUrl'])
                            : AssetImage(
                                'assets/images/work_avatar.png',
                              ),
                      ),
                    ),
                  ),
                  Text(
                    widget.dataMap['name'].toString(),
                    style: TextStyle(
                        color: Color(0xff242424), fontSize: size.width * 20),
                  ),
                ],
              ),
              widget.guardian['id'] == widget.dataMap['id']
                  ? Container(
                      padding: EdgeInsets.all(size.width * 15),
                      decoration: BoxDecoration(
                          color: themeColor, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          '监',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: size.width * 20),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: widget.changeGuardian,
                      child: Icon(
                        Icons.add_circle,
                        color: themeColor,
                        size: size.width * 60,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddWorkPeopleItem extends StatefulWidget {
  AddWorkPeopleItem({
    this.dataMap,
    this.changeChoose,
  });
  final Map dataMap;
  final Function changeChoose;
  @override
  _AddWorkPeopleItemState createState() => _AddWorkPeopleItemState();
}

class _AddWorkPeopleItemState extends State<AddWorkPeopleItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Container(
            width: size.width * 80,
            height: size.width * 80,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50.0),
                image: DecorationImage(
                    image: widget.dataMap['photoUrl']
                                .toString()
                                .indexOf('http') >
                            -1
                        ? NetworkImage(widget.dataMap['photoUrl'].toString())
                        : AssetImage('assets/images/work_avatar.png'))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    widget.dataMap['name'].toString(),
                    style: TextStyle(
                        color: Color(0xff666666), fontSize: size.width * 24),
                  ),
                ),
                widget.dataMap['departments'] != null
                    ? Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          widget.dataMap['departments'].toString(),
                          style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: size.width * 24),
                        ),
                      )
                    : Container(),
                widget.dataMap['positions'] != null
                    ? Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          widget.dataMap['positions'].toString(),
                          style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: size.width * 24),
                        ),
                      )
                    : Container(),
                Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 40,
                      height: size.width * 40,
                      margin: EdgeInsets.all(5),
                      child: Image.asset('assets/images/icon_card.png'),
                    ),
                    Container(
                      width: size.width * 40,
                      height: size.width * 40,
                      margin: EdgeInsets.all(5),
                      child: Image.asset('assets/images/icon_card.png'),
                    ),
                    Container(
                      width: size.width * 40,
                      height: size.width * 40,
                      margin: EdgeInsets.all(5),
                      child: Image.asset('assets/images/icon_card.png'),
                    ),
                  ],
                )
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
                backgroundColor: MaterialStateProperty.all(Colors.white),elevation: MaterialStateProperty.all(0)),
            onPressed: () {
              if (widget.dataMap['isChoose'] != true) {
                widget.dataMap['isChoose'] = true;
              } else {
                widget.dataMap['isChoose'] = false;
              }
              widget.changeChoose(widget.dataMap, widget.dataMap['isChoose']);
              if (mounted) {
                setState(() {});
              }
            },
            child: Icon(
              widget.dataMap['isChoose'] == true
                  ? Icons.check_circle
                  : Icons.panorama_fish_eye,
              color: widget.dataMap['isChoose'] == true
                  ? Color(0xff09ba07)
                  : placeHolder,
              size: size.width * 36,
            ),
          ),
        ],
      ),
    ));
  }
}
