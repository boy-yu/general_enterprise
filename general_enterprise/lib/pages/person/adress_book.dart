import 'dart:async';
import 'package:enterprise/common/Refre.dart';
import 'package:enterprise/common/clickImage.dart';
import 'package:enterprise/common/loding.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdressBook extends StatefulWidget {
  @override
  _AdressBookState createState() => _AdressBookState();
}

class _AdressBookState extends State<AdressBook> with TickerProviderStateMixin {
  List<PeopleStructure> adressS = [];
  List<PeopleStructure> cacheData = [];
  int addNum = 0;
  bool continues = true, _refresh = false;

  List<String> changeLetter = []; //, letter:
  List<double> _saveOffset = [];
  int letterChoose = 0;
  List<int> changeIndex = [];
  List<Map> data = [];
  int length = 0;
  TextEditingController _editingController = TextEditingController();
  _juedgeInitials(name) {
    String str = PinyinHelper.getShortPinyin(name);
    return str;
  }

  ScrollController _controller = ScrollController();
  List<String> _letterList = [];
  GlobalKey<_RightBarState> _globalKey = GlobalKey();
  AnimationController _animationController;
  Animation<double> _opacity;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _opacity = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _getPeople();
    _controller.addListener(() {
      if (!_globalKey.currentState.click) {
        if (_controller.offset < _saveOffset[1]) {
          _globalKey.currentState._changeLetterChoose(0);
        }
        for (var i = 1; i < _saveOffset.length - 1; i++) {
          if (_controller.offset > _saveOffset[i] && _saveOffset[i] != 0) {
            if (_controller.offset < _saveOffset[i + 1] ||
                _saveOffset[i + 1] == 0) {
              _globalKey.currentState._changeLetterChoose(i);
            }
          }
        }
      }
    });

    _refresh = PeopleStructure.state;
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    // _timer.cancel();
    super.dispose();
  }

  _sort({int init = 0}) {
    for (var i = init; i < (init + data.length) ~/ 2; i++) {
      for (var j = (init + data.length) ~/ 2; j < data.length; j++) {
        if (data[i]['name'].toString().codeUnits[0] >
            data[j]['name'].toString().codeUnits[0]) {
          Map _map = data[i];
          data[i] = data[j];
          data[j] = _map;
        }
      }
    }
    if (init < data.length - 1) {
      _sort(init: (init + data.length) ~/ 2);
    }
  }

  _getPeople() {
    addNum = 0;
    adressS.clear();
    changeLetter.clear();
    cacheData.clear();
    changeIndex.clear();
    _letterList.clear();
    _saveOffset.clear();
    data.clear();
    PeopleStructure.getStaticPeople().then((res) {
      if (res is List) {
        int j = res.length;
        for (var i = 0; i < j; i++) {
          if (res[i].name.isNotEmpty) {
            String short = _juedgeInitials(res[i].name[0]);
            if (changeLetter.indexOf(short) == -1) {
              changeLetter.add(short);
              data.add({
                "name": short == ' ' ? '#' : short,
                "value": [res[i]]
              });
            } else {
              data[changeLetter.indexOf(short)]['value'].add(res[i]);
            }
          }
        }
        _sort();
        data.forEach((element) {
          _letterList.add(element['name']);
          _saveOffset.add(0.0);
          // cacheData.add(PeopleStructure(id: -1, name: element['name']));
          // element['value']
          //   ..forEach((_element) {
          //     cacheData.add(_element);
          //   });
        });
        _addtionPeople();
      }
    });
    if (mounted) {
      _animationController.forward();
      setState(() {});
    }
  }

  _addtionPeople() {
    // int j = cacheData.length;
    // for (var i = addNum; i < j; i++) {
    //   if (i > addNum + 40) {
    //     addNum = i;
    //     break;
    //   }
    //   adressS.add(cacheData[i]);
    // }
    // adressS = cacheData;

    int j = data.length;
    for (var i = addNum; i < j; i++) {
      // adressS.add(PeopleStructure(id: -1, name: data[i]['name']));

      for (var z = 0; z < data[i]['value'].length; z++) {
        if (z == 0) {
          PeopleStructure _peopleStructure = data[i]['value'][z];
          _peopleStructure.sort = data[i]['name'];
          // adressS.add(data[i]['value'][z]);
        }
        adressS.add(data[i]['value'][z]);
      }
    }

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    if (mounted) {
      setState(() {});
    }
    // });
  }

  _secherPeople(String name) {
    if (name.codeUnits.length == 1) {
      if (name.codeUnits[0] < 127) {
        name = _juedgeInitials(name);
        data.forEach((element) {
          if (element['name'] == name) {
            continues = false;
            adressS = element['value'];
            setState(() {});
          }
        });
      } else {
        PeopleStructure.getSecharPeople(input: name).then((value) {
          adressS = value;
          continues = false;
          if (mounted) {
            setState(() {});
          }
        });
      }
    } else {
      if (name == '') {
        continues = true;
        _getPeople();
      } else {
        PeopleStructure.getSecharPeople(input: name).then((value) {
          adressS = value;
          continues = false;
          if (mounted) {
            setState(() {});
          }
        });
      }
    }
  }

  _changeLetterFun(int index) {
    int _jumpTotal = 0;
    for (var i = 0; i < index; i++) {
      _jumpTotal += data[i]['value'].length;
    }
    double value = _jumpTotal * size.width * 240;
    // _controller.animateTo(value + 1,
    //     duration: Duration(milliseconds: 200), curve: Curves.linear);
    _controller.jumpTo(value + 1);
  }

  final List<dynamic> tipLetter = [{}];

  List<String> title = ['个人通讯录', '组织通讯录'];
  int titleIndex = 0;

  Widget _generateOffset(PeopleStructure map) {
    int _index = _letterList.indexOf(map.sort);
    double itemHeight = 0.0;

    for (var i = 0; i < _index; i++) {
      itemHeight += size.width * 240 * data[i]['value'].length;
    }
    _saveOffset[_index] = itemHeight;
    return Text(map.sort.toUpperCase());
  }

  Future refreshPeople() async {
    final _result = await PeopleStructure.getNetpeople(delete: true);
    if (_result) {
      _getPeople();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: title
              .asMap()
              .keys
              .map((index) => Container(
                    decoration: BoxDecoration(
                        border: titleIndex == index
                            ? Border(
                                bottom:
                                    BorderSide(width: 2, color: Colors.white))
                            : null),
                    child: InkWell(
                      child: Text(
                        title[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 36,
                            color: Colors.white),
                      ),
                      onTap: () {
                        titleIndex = index;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                    ),
                  ))
              .toList(),
        ),
        padding: EdgeInsets.only(
            left: size.width * 131,
            right: size.width * 131,
            top: size.width * 100,
            bottom: size.width * 20),
        decoration: BoxDecoration(color: themeColor),
      ),
      Container(
        height: size.width * 76,
        margin: EdgeInsets.fromLTRB(
            size.width * 40, size.width * 30, size.width * 40, size.width * 5),
        decoration: BoxDecoration(
            color: Color(0xffFAFAFB),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: placeHolder.withOpacity(.2), width: 2)),
        child: TextField(
          controller: _editingController,
          textInputAction: TextInputAction.search,
          onChanged: _secherPeople,
          onSubmitted: _secherPeople,
          maxLines: 1,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(
                  size.width * 40, 0, size.width * 40, size.width * 22),
              hintText: '搜索',
              hintStyle: TextStyle(color: Color(0xffACACBC))),
        ),
      ),
      titleIndex == 0
          ? adressS.isNotEmpty
              ? Expanded(
                  child: Row(children: [
                    Expanded(
                      child: Refre(
                          child: (child, state, end, updata) {
                            return FadeTransition(
                              opacity: _opacity,
                              child: Column(
                                children: [
                                  child,
                                  Expanded(
                                      child: ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          padding: EdgeInsets.all(0),
                                          itemExtent: size.width * 240,
                                          controller: _controller,
                                          itemCount: adressS.length,
                                          itemBuilder: (context, index) {
                                            return PersonItem(
                                              adressS[index],
                                              generateOffset: _generateOffset,
                                            );
                                          }))
                                ],
                              ),
                            );
                          },
                          initRefresh: false,
                          onRefresh: () async {
                            _refresh = true;
                            await refreshPeople();
                            _refresh = false;
                          }),
                    ),
                    RightBar(
                      letterList: _letterList,
                      changeLetterFun: _changeLetterFun,
                      key: _globalKey,
                    ),
                  ]),
                )
              : _refresh
                  ? Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: size.width * 300),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/empty@2x.png",
                            height: size.width * 288,
                            width: size.width * 374,
                          ),
                          Text('暂无人员'),
                        ],
                      ))
                  : StaticLoding()
          : Expanded(child: OrginPage())
    ])
    );
  }
}

class RightBar extends StatefulWidget {
  RightBar({@required this.letterList, @required this.changeLetterFun, Key key})
      : super(key: key);
  final List<String> letterList;
  final Function(int index) changeLetterFun;
  @override
  _RightBarState createState() => _RightBarState();
}

class _RightBarState extends State<RightBar> {
  int letterChoose = 0;

  _changeLetterChoose(int index) {
    letterChoose = index;
    if (mounted) {
      setState(() {});
    }
  }

  int _onHorizontalDragStart = 0;
  bool click = false;
  bool next = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width * 40,
        margin: EdgeInsets.only(right: size.width * 10),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.letterList
                  .asMap()
                  .keys
                  .map((index) => GestureDetector(
                        onVerticalDragUpdate: (details) {
                          // int oldIndex = letterChoose;
                          int _index =
                              (details.localPosition.dy - size.width * 30) ~/
                                      (size.width * 25) +
                                  _onHorizontalDragStart;

                          if (_index >= widget.letterList.length)
                            _index = widget.letterList.length - 1;
                          if (_index < 0) _index = 0;
                          letterChoose = _index;
                          if (next) {
                            next = false;
                            widget.changeLetterFun(letterChoose);
                            Future.delayed(Duration(milliseconds: 50), () {
                              next = true;
                              click = false;
                            });
                          }
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        onTapCancel: () {
                          _onHorizontalDragStart = letterChoose;
                          print(_onHorizontalDragStart);
                        },
                        onTap: () {
                          letterChoose = index;
                          click = true;
                          if (next) {
                            next = false;
                            //   int mill =
                            widget.changeLetterFun(letterChoose);
                            Future.delayed(Duration(milliseconds: 200), () {
                              next = true;
                              click = false;
                            });
                          }
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: index == letterChoose
                              ? size.width * 30
                              : size.width * 25,
                          width: index == letterChoose
                              ? size.width * 30
                              : size.width * 25,
                          // padding: index == letterChoose
                          //     ? EdgeInsets.all(size.width * 10)
                          //     : EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == letterChoose
                                ? themeColor
                                : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              widget.letterList[index].toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size.width * 20,
                                  color: index == letterChoose
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ))
                  .toList()),
        ));
  }
}

class OrginPage extends StatefulWidget {
  @override
  _OrginPageState createState() => _OrginPageState();
}

class _OrginPageState extends State<OrginPage> {
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getOrgin();
    _pageController.addListener(() {
      if (_pageController.page.toString().length == 3) {
        if (_pageController.page.toString().substring(2, 3) == '0') {
          if (choose > _pageController.page) {
            choose = _pageController.page.toInt();
            Future.delayed(Duration(milliseconds: 100), () {
              _judgePage(_pageController.page.toInt());
            });
          }
        }
      }
    });
  }

  PageController _pageController = PageController();
  List<List<PeopleStructure>> data = [];
  List<String> titleList = [];
  int choose = 0;
  _getOrgin() {
    PeopleStructure.queryDepartment(department: 0).then((value) {
      data.add(value);
      titleList.add('联络人');
      if (mounted) {
        setState(() {});
      }
    });
  }

  int x = 0;
  _nextClick(int id, String name) {
    PeopleStructure.queryDepartment(department: id).then((value) {
      titleList.add(name);
      data.add(value);
      choose = data.length - 1;
      _pageController.jumpToPage(choose);
      if (mounted) {
        setState(() {});
      }
    });
  }

  _judgePage(int page) {
    _pageController.jumpToPage(page);
    choose = page;
    for (int i = data.length - 1; i > page; i--) {
      data.removeAt(i);
      titleList.removeAt(i);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
                color: Color(0xffF5F5FA),
                constraints:
                    BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                padding: EdgeInsets.symmetric(
                    vertical: size.width * 10, horizontal: size.width * 20),
                child: Row(
                  children: titleList
                      .asMap()
                      .keys
                      .map(
                        (index) => InkWell(
                          onTap: () {
                            _judgePage(index);
                          },
                          child: Row(
                            children: [
                              Text(
                                titleList[index].toString(),
                                style: TextStyle(
                                    color: index == choose
                                        ? themeColor
                                        : Colors.black),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color:
                                    index == choose ? themeColor : Colors.black,
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                )),
          ),
          Expanded(
              child: PageView.builder(
            controller: _pageController,
            itemCount: data.length,
            itemBuilder: (context, index) => ListView.builder(
              addRepaintBoundaries: true,
              addAutomaticKeepAlives: true,
              cacheExtent: 5,
              padding: EdgeInsets.symmetric(horizontal: size.width * 40),
              itemCount: data[index].length,
              itemBuilder: (context, _index) {
                if (data[index][_index].nums is int) {
                  return InkWell(
                      onTap: () {
                        _nextClick(
                            data[index][_index].id, data[index][_index].name);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 20),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: underColor.withOpacity(.7),
                                    width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data[index][_index].name,
                                  style: TextStyle(fontSize: size.width * 30),
                                ),
                                Text(
                                  '  (共${data[index][_index].nums}个部门)',
                                  style: TextStyle(
                                      color: placeHolder,
                                      fontSize: size.width * 26),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(left: size.width * 20),
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          width: 1,
                                          color: underColor.withOpacity(.7)))),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.playlist_play,
                                    color: themeColor,
                                  ),
                                  Text(
                                    '下级',
                                    style: TextStyle(color: themeColor),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                } else {
                  return PersonItem(data[index][_index]);
                }
              },
            ),
          ))
        ],
      ),
    );
  }
}

class PersonItem extends StatefulWidget {
  PersonItem(this.data, {this.generateOffset});
  final PeopleStructure data;
  final Function(PeopleStructure data) generateOffset;
  @override
  _PersonItemState createState() => _PersonItemState();
}

class _PersonItemState extends State<PersonItem> {
  int message = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.data.sort != null
            ? Container(
                width: double.infinity,
                // padding: EdgeInsets.all(size.width * 10),
                height: size.width * 40,
                margin: EdgeInsets.only(left: size.width * 10),
                alignment: Alignment.centerLeft,
                color: Color(0xffF5F5FA),
                child: widget.generateOffset(widget.data),
              )
            : Container(),
        Container(
          padding: EdgeInsets.all(
            size.width * 20,
          ),
          decoration: BoxDecoration(
              border: Border(
                  top:
                      BorderSide(color: underColor.withOpacity(.3), width: 1))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: size.width * 20),
                padding: EdgeInsets.all(size.width * 5),
                width: size.width * 86,
                height: size.width * 86,
                decoration: BoxDecoration(
                    border: Border.all(color: themeColor, width: 2),
                    shape: BoxShape.circle),
                child: ClipOval(
                    child: ClickImage(widget.data.photoUrl,
                        width: size.width * 200,
                        height: size.width * 150,
                        fit: BoxFit.cover)),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.data.name + '   ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: size.width * 34),
                  ),
                  InkWell(
                      onTap: () {
                        launch('tel:${widget.data.telephone}');
                      },
                      child: Text(
                        widget.data.telephone,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: size.width * 24, color: themeColor),
                      )),
                  Text(
                    widget.data.position,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: size.width * 24, color: placeHolder),
                  ),
                  Text(
                    widget.data.department,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: size.width * 24, color: placeHolder),
                  )
                ],
              )),
              Container(
                margin: EdgeInsets.only(left: size.width * 20),
                width: size.width * 260,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      highlightColor: Color(0xff5887FF).withOpacity(.3),
                      onTap: () {
                        if (myprefs.getString('account') ==
                            widget.data.account) {
                          Fluttertoast.showToast(msg: '自己无法与自己聊天');
                        } else {
                          Navigator.pushNamed(context, '/chat', arguments: {
                            "data": widget.data,
                          }).then((value) {
                            context.read<Counter>().emptyNotity(
                                name: '聊天', account: widget.data.account);
                          });
                        }
                      },
                      child: Container(
                        width: size.width * 60,
                        height: size.width * 60,
                        margin: EdgeInsets.all(size.width * 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff5887FF),
                              offset: Offset(2, 2),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            message > 0
                                ? Positioned(
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                      width: 8,
                                      height: 8,
                                    ),
                                  )
                                : Container(),
                            Center(
                              child: Icon(
                                Icons.sms_sharp,
                                size: size.width * 30,
                                color: themeColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      highlightColor: Color(0xff5887FF).withOpacity(.3),
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(size.width * 4),
                        width: size.width * 60,
                        height: size.width * 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff5887FF),
                              offset: Offset(2, 2),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.mic,
                          size: size.width * 30,
                          color: themeColor,
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      highlightColor: Color(0xff5887FF).withOpacity(.3),
                      onTap: () {
                        if (myprefs.getString('account') ==
                            widget.data.account) {
                          Fluttertoast.showToast(msg: '自己无法与自己视频');
                        } else {
                          Navigator.pushNamed(context, '/callview',
                              arguments: {"data": widget.data, "state": false});
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(size.width * 4),
                        width: size.width * 60,
                        height: size.width * 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff5887FF),
                              offset: Offset(2, 2),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.video_call,
                          size: size.width * 30,
                          color: themeColor,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
