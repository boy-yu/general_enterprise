import 'package:enterprise/common/clickImage.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';

class NewSourchMutiplePeople extends StatefulWidget {
  NewSourchMutiplePeople(
      {this.title,
      this.value,
      this.way = false,
      this.bindKey,
      this.userId = -1,
      this.filterId,
      @required this.callback,
      this.style, this.palcehoder = const []});
  final String title, bindKey;
  final List<PeopleStructure> palcehoder;
  final TextStyle style;
  final List<PeopleStructure> value;
  final bool way; // false mutiple  true drop
  final int userId;
  final List filterId;
  final Function(List<PeopleStructure> map) callback;
  // state   true  choose own
  @override
  _NewSourchMutiplePeopleState createState() => _NewSourchMutiplePeopleState();
}

class _NewSourchMutiplePeopleState extends State<NewSourchMutiplePeople> {
  List<Map> msg = [];
  List id = [];
  List<String> name = [];
  List peopleMsg = [];
  List<PeopleStructure> chooseData = [];
  _changeMsg(List<PeopleStructure> data) {
    msg = [];
    id = [];
    name = [];
    chooseData.clear();
    for (var i = 0; i < data.length; i++) {
      id.add(data[i].id);
      name.add(data[i].name);
      msg.add({"nickname": data[i].name, "positions": data[i].position});
      chooseData = data;
    }
    if (mounted) {
      setState(() {});
    }
    widget.callback(data);
  }

  @override
  void initState() {
    super.initState();

    if (widget.value != null) {
    } else {
      if (widget.userId > 0) {
        id = [];
        name = [];
        PeopleStructure.getSecharPeople(id: widget.userId).then((value) {
          if (value.isNotEmpty) {
            msg.add({
              "nickname": value[0].name,
              "positions": value[0].position,
              "id": value[0].id
            });
            id.add(value[0].id);
            name.add(value[0].name);
            setState(() {});

            widget.callback(value);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * 10),
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.title ?? '',
                    style: widget.style ??
                        TextStyle(
                            fontSize: size.width * 30, color: Colors.black),
                  ),
                  SizedBox(
                    width: size.width * 10,
                  ),
                  msg.length == 0 && widget.value == null
                      ? Expanded(
                          child: Text(
                          '请选择${widget.title}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: placeHolder,
                              fontSize: widget.style == null
                                  ? size.width * 30
                                  : widget.style.fontSize ?? size.width * 30),
                        ))
                      : Spacer(),
                  Icon(Icons.keyboard_arrow_right, color: Colors.black)
                ],
              ),
              msg.length > 0
                  ? Column(
                      children: chooseData
                          .map<Widget>((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text('姓名:' + e.name.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: widget.style == null
                                                      ? size.width * 30
                                                      : widget
                                                          .style.fontSize))),
                                      SizedBox(
                                        width: size.width * 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                            '职位:' + e.position.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: widget.style == null
                                                    ? size.width * 30
                                                    : widget.style.fontSize ??
                                                        size.width * 30)),
                                      )
                                    ],
                                  ),
                                  ClipOval(
                                    child: ClickImage(e.photoUrl,
                                        width: 40, height: 40),
                                  )
                                ],
                              ))
                          .toList())
                  : widget.value is List
                      ? Column(
                          children: widget.value.map<Widget>((e) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text('姓名:' + e.name.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: widget.style == null
                                                    ? size.width * 30
                                                    : widget.style.fontSize))),
                                    SizedBox(
                                      width: size.width * 20,
                                    ),
                                    Expanded(
                                      child: Text('职位:' + e.position.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: widget.style == null
                                                  ? size.width * 30
                                                  : widget.style.fontSize ??
                                                      size.width * 30)),
                                    )
                                  ],
                                ),
                                ClipOval(
                                  child: ClickImage(e.photoUrl,
                                      width: 40, height: 40),
                                )
                              ],
                            );
                          }).toList(),
                        )
                      : Column(
                          children: widget.palcehoder.map<Widget>((e) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text('姓名:' + e.name.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: widget.style == null
                                                    ? size.width * 30
                                                    : widget.style.fontSize))),
                                    SizedBox(
                                      width: size.width * 20,
                                    ),
                                    Expanded(
                                      child: Text('职位:' + e.position.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: widget.style == null
                                                  ? size.width * 30
                                                  : widget.style.fontSize ??
                                                      size.width * 30)),
                                    )
                                  ],
                                ),
                                ClipOval(
                                  child: ClickImage(e.photoUrl,
                                      width: 40, height: 40),
                                )
                              ],
                            );
                          }).toList(),
                        ),
              
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => ChoosePeople(
                    changeMsg: _changeMsg,
                    way: widget.way,
                    filterId: widget.filterId));
          }),
    );
  }
}

class ChoosePeople extends StatefulWidget {
  ChoosePeople({@required this.changeMsg, @required this.way, this.filterId});
  final Function(List<PeopleStructure> data) changeMsg;
  final bool way;
  final List filterId;
  @override
  _ChoosePeopleState createState() => _ChoosePeopleState();
}

class _ChoosePeopleState extends State<ChoosePeople> {
  TextEditingController _textEditingController = TextEditingController();
  List<List<PeopleStructure>> data = [];
  List<PeopleStructure> chooseNum = [];
  bool search = false;
  List<bool> allChoose = [];
  int totalPeople = 0;
  List<String> tableList = [];
  int choosePage = 0;
  List<int> judgeRepeat = [];
  PageController _pageController = PageController();
  _getPeople(value) {
    PeopleStructure.getSecharPeople(input: value, filterId: widget.filterId)
        .then((res) {
      List temp = res;
      int tableIndex = tableList.indexOf('搜索人物');
      allChoose.add(false);
      if (tableIndex == -1) {
        data.add(temp);
        tableList.add('搜索人物');
        _pageController.animateToPage(tableList.length - 1,
            duration: Duration(milliseconds: 50), curve: Curves.ease);
      } else {
        data[tableIndex] = temp;
        if (mounted) {
          setState(() {});
        }
        _pageController.animateToPage(tableIndex,
            duration: Duration(milliseconds: 50), curve: Curves.ease);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getOrganization();
    _pageController.addListener(() {
      if (_pageController.page.toString().substring(2, 3) == '0') {
        choosePage = _pageController.page.toInt();
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getOrganization({PeopleStructure peopleList}) {
    if (peopleList == null) {
      PeopleStructure.queryDepartment(department: 0, filterId: widget.filterId)
          .then((value) {
        data.add(value);
        tableList.add('联络人');
        allChoose.add(false);
        if (mounted) {
          setState(() {});
        }
      });
    } else {
      PeopleStructure.queryDepartment(
              department: peopleList.id, filterId: widget.filterId)
          .then((value) {
        data.add(value);
        tableList.add(peopleList.name);
        allChoose.add(false);
        _pageController.animateToPage(data.length - 1,
            duration: Duration(milliseconds: 50), curve: Curves.easeIn);
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  _choosePeople(dynamic data, {bool way = true, PeopleStructure chooseData}) {
    if (!widget.way) {
      if (way) {
        if (data is List<PeopleStructure>) {
          for (var i = 0; i < data.length; i++) {
            if (data[i].name != null && data[i].nums == null) {
              data[i].choose = true;
              if (judgeRepeat.indexOf(data[i].id) == -1) {
                judgeRepeat.add(data[i].id);
                chooseNum.add(data[i]);
              }
            }
          }
        } else if (data is PeopleStructure) {
          if (judgeRepeat.indexOf(data.id) == -1) {
            judgeRepeat.add(data.id);
            chooseNum.add(data);
          }
        }
      } else {
        if (data is List) {
          for (var i = 0; i < data.length; i++) {
            data[i].choose = false;
            for (var _i = chooseNum.length - 1; _i >= 0; _i--) {
              if (chooseNum[_i].id == data[i].id) {
                judgeRepeat.removeAt(_i);
                chooseNum.removeAt(_i);
              }
            }
          }
        } else if (data is PeopleStructure) {
          for (var i = 0; i < judgeRepeat.length; i++) {
            if (judgeRepeat[i] == data.id) {
              judgeRepeat.removeAt(i);
              chooseNum.removeAt(i);
            }
          }
        }
      }
    } else {
      if (way) {
        if (judgeRepeat.length == 0) {
          judgeRepeat.add(chooseData.id);
          chooseNum.add(chooseData);
        } else {
          judgeRepeat[0] = chooseData.id;
          chooseNum[0] = (chooseData);
        }
      } else {
        judgeRepeat.clear();
        chooseNum.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffFAFAFB),
              border: Border.all(width: 1, color: placeHolder),
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.all(size.width * 30),
            padding: EdgeInsets.symmetric(horizontal: size.width * 20),
            child: TextField(
              style: TextStyle(fontSize: size.width * 30),
              onSubmitted: _getPeople,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '请输入人员姓名',
                  prefixIcon: Icon(Icons.search)),
              controller: _textEditingController,
            ),
          ),
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
                              if (index != choosePage) {
                                _pageController.animateToPage(index,
                                    duration: Duration(milliseconds: 50),
                                    curve: Curves.ease);
                                tableList.removeRange(
                                    index + 1, tableList.length);
                                data.removeRange(index + 1, data.length);
                                if (mounted) {
                                  setState(() {});
                                }
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  tableList[index],
                                  style: TextStyle(
                                      color: index != choosePage
                                          ? themeColor
                                          : placeHolder),
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
              child: PageView.builder(
                  controller: _pageController,
                  itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !widget.way
                              ? Container(
                                  color: Colors.white,
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
                                          allChoose[index] = !allChoose[index];
                                          _choosePeople(data[index],
                                              way: allChoose[index]);
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        },
                                        child: allChoose[index] == true
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
                                                      color: Color(0xffC0C0C8),
                                                    )),
                                              ),
                                      ),
                                      Text(
                                        '全选',
                                        style: TextStyle(color: themeColor),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          Expanded(
                              child: ListView.builder(
                            itemBuilder: (context, _index) {
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: underColor, width: 1))),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    elevation: MaterialStateProperty.all(0),
                                  ),
                                  onPressed: () {},
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: size.width * 2),
                                    padding: EdgeInsets.all(size.width * 20),
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: data[index][_index].nums is int
                                        ? Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 125,
                                              ),
                                              Text(
                                                data[index][_index]
                                                        .name
                                                        .toString() +
                                                    '(共' +
                                                    data[index][_index]
                                                        .nums
                                                        .toString() +
                                                    '个部门)',
                                                style: TextStyle(
                                                    color: placeHolder),
                                              ),
                                              Spacer(),
                                              ElevatedButton.icon(
                                                  style: ButtonStyle(
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(0),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .white)),
                                                  onPressed: () {
                                                    bool next = true;
                                                    tableList
                                                        .forEach((element) {
                                                      if (element ==
                                                          data[index][_index]
                                                              .name) {
                                                        next = false;
                                                      }
                                                    });

                                                    if (next) {
                                                      _getOrganization(
                                                          peopleList:
                                                              data[index]
                                                                  [_index]);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.playlist_play,
                                                    color: themeColor,
                                                  ),
                                                  label: Text(
                                                    '下级',
                                                    style: TextStyle(
                                                        color: themeColor),
                                                  ))
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all(0),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white)),
                                                onPressed: () {
                                                  if (!widget.way) {
                                                    data[index][_index].choose =
                                                        !data[index][_index]
                                                            .choose;
                                                    _choosePeople(
                                                        data[index][_index],
                                                        way: data[index][_index]
                                                            .choose);
                                                  } else {
                                                    bool tempBool = data[index]
                                                            [_index]
                                                        .choose;
                                                    data[index]
                                                        .forEach((element) {
                                                      element.choose = false;
                                                    });
                                                    if (!tempBool) {
                                                      data[index][_index]
                                                          .choose = !data[index]
                                                              [_index]
                                                          .choose;
                                                    }
                                                    _choosePeople(
                                                        data[index][_index],
                                                        way: data[index][_index]
                                                            .choose,
                                                        chooseData: data[index]
                                                            [_index]);
                                                  }
                                                  if (mounted) {
                                                    setState(() {});
                                                  }
                                                },
                                                child: data[index][_index]
                                                            .choose ==
                                                        true
                                                    ? Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    size.width *
                                                                        20),
                                                        child: Icon(
                                                          Icons.check_circle,
                                                          color: themeColor,
                                                          size: size.width * 35,
                                                        ),
                                                      )
                                                    : Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    size.width *
                                                                        20),
                                                        width: size.width * 35,
                                                        height: size.width * 35,
                                                        padding: EdgeInsets.all(
                                                            size.width * 5),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                border:
                                                                    Border.all(
                                                                  width: 1,
                                                                  color: Color(
                                                                      0xffC0C0C8),
                                                                )),
                                                      ),
                                              ),
                                              Container(
                                                  foregroundDecoration:
                                                      BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  themeColor)),
                                                  margin: EdgeInsets.only(
                                                      right: size.width * 25),
                                                  child: ClipOval(
                                                    child: ClickImage(
                                                      data[index][_index]
                                                          .photoUrl,
                                                      width: size.width * 60,
                                                      height: size.width * 60,
                                                    ),
                                                  )),
                                              Expanded(
                                                  child: Text(
                                                data[index][_index].name +
                                                    '\n' +
                                                    data[index][_index]
                                                        .department,
                                                style: TextStyle(
                                                    color: placeHolder),
                                              )),
                                            ],
                                          ),
                                  ),
                                ),
                              );
                            },
                            itemCount: data[index].length,
                          )),
                        ],
                      ),
                  itemCount: data.length)),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(width: 1, color: underColor))),
            padding: EdgeInsets.symmetric(horizontal: size.width * 20),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  '已选择：${chooseNum.length} 人',
                  style: TextStyle(color: Color(0xff0059FF)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(themeColor)),
                  onPressed: () {
                    if (!search) {
                      Navigator.pop(context);
                      widget.changeMsg(chooseNum);
                    } else {
                      _textEditingController.text = '';
                      int secharIndex = tableList.indexOf('搜索人物');
                      tableList.removeAt(secharIndex);
                      allChoose.removeAt(secharIndex);
                      data.removeAt(secharIndex);
                      search = false;
                      if (mounted) {
                        setState(() {});
                      }
                    }
                  },
                  child: Text(!search ? '确定' : '返回'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
