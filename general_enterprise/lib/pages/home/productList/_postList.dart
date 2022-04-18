import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckPostList extends StatefulWidget {
  CheckPostList({this.rescueCard, Key key}) : super(key: key);
  final String rescueCard;
  @override
  _CheckPostListState createState() => _CheckPostListState();
}

class _CheckPostListState extends State<CheckPostList> {
  PageController _pageController = PageController();
  int page = 0;
  int id = 0;

  List<Map> peoplePageList = [];

  @override
  void initState() {
    super.initState();
    _getData(0);
    _pageController.addListener(() {
      if (_pageController.page.toString().length == 3 &&
          _pageController.page.toString().substring(2, 3) == '0') {
        bool next = page > _pageController.page.toInt();
        page = _pageController.page.toInt();
        if (next) {
          for (var i = peoplePageList.length - 1; i > page; i--) {
            peoplePageList.removeAt(i);
          }
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _getData(int ids) {
    if (page < peoplePageList.length - 1) {
      _pageController.animateToPage(++page,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
      return;
    }
    PeopleStructure.queryOnlyDepartment(ids).then((value) {
      if (value is List) {
        if (value.isNotEmpty) {
          peoplePageList.add({'departmentId': value});
          page = peoplePageList.length - 1;
          // _getUserDataList(index: page);
          _pageController.animateToPage(page, duration: Duration(milliseconds: 200), curve: Curves.linear);
          if (mounted) {
            setState(() {});
          }
        } else {
          Fluttertoast.showToast(msg: '已无下级单位');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PageView.builder(
                controller: _pageController,
                itemCount: peoplePageList.length,
                itemBuilder: (context, index) => ListView.builder(
                    cacheExtent: 3,
                    itemCount: peoplePageList[index]['departmentId'].length,
                    itemBuilder: (context, _index) => PeopleItem(
                        mapData: peoplePageList[index]['departmentId'][_index],
                        nextCallback: () async {
                          if (widget.rescueCard == 'rescueCard') {
                            Navigator.pushNamed(context,
                                '/emergencyRescue/__emergencyRescueCardDetails',
                                arguments: {
                                  "id": peoplePageList[index]['departmentId'][_index].id,
                                });
                          } else {
                            List<HiddenDangerInterface> _leftbar = [];
                            id = peoplePageList[index]['departmentId'][_index]
                                .id;
                            List data = await PeopleStructure.getListPeople(id);
                            if (data.isEmpty) {
                              Fluttertoast.showToast(msg: '该部门下没有人员');
                              return;
                            }
                            _leftbar = _leftbar.changeHiddenDangerInterfaceType(
                                data,
                                title: 'name',
                                icon: 'static:photoUrl',
                                id: 'id',
                                name: 'name');

                            _leftbar[0].color = Colors.white;
                            Navigator.pushNamed(
                                context, '/index/productList/CommonPage',
                                arguments: {
                                  "leftBar": _leftbar,
                                  "index": 0,
                                  "title": '责任清单',
                                  "widgetType": 'PostListCommonPage',
                                  // "arguments": {
                                  //   "completedTotalNum": peoplePageList[index]
                                  //       ['completedTotalNum'],
                                  //   "undoneTotalNum": peoplePageList[index]
                                  //       ['undoneTotalNum']
                                  // }
                                });
                          }
                        },
                        callback: () {
                          id = peoplePageList[index]['departmentId'][_index].id;
                          _getData(id);
                        }))
                    )
        ),
      ],
    );
  }
}

class PeopleItem extends StatelessWidget {
  PeopleItem({this.mapData, this.callback, this.nextCallback});
  final PeopleStructure mapData;
  final Function callback, nextCallback;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 40, right: size.width * 20, top: size.width * 20),
      padding: EdgeInsets.all(size.width * 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12, blurRadius: 5.0, spreadRadius: 2.0),
          ]),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: callback,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        mapData.name,
                        style: TextStyle(
                            color: Color(0xff7487A4),
                            fontSize: size.width * 26,
                            fontWeight: FontWeight.w600),
                      )),
                      SizedBox(
                        width: size.width * 10,
                      ),
                      // Text(
                      //   mapData.id.toString(),
                      //   style: TextStyle(
                      //     color: Colors.black
                      //   ),
                      // ),
                      Text(
                        '（共' + mapData.nums.toString() + '个部门）',
                        style: TextStyle(
                            color: Color(0xff91A6C6),
                            fontSize: size.width * 24),
                      )
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/checkList4Key@2x.png',
                  width: size.width * 30,
                  height: size.width * 31,
                ),
              ],
            ),
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 20),
            height: size.width * 76.8,
            width: size.width * 1,
            color: Color(0xff9BB3D9),
          ),
          InkWell(
            onTap: nextCallback,
            child: Container(
              width: size.width * 80,
              height: size.width * 40,
              margin: EdgeInsets.only(right: size.width * 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 30),
                  gradient: LinearGradient(colors: [
                    Color(0xff2D6DFF),
                    Color(0xff7973FF),
                  ])),
              alignment: Alignment.center,
              child: Text(
                '查看',
                style:
                    TextStyle(color: Colors.white, fontSize: size.width * 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PostPicture extends StatefulWidget {
  @override
  _PostPictureState createState() => _PostPictureState();
}

class _PostPictureState extends State<PostPicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * 440,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 30, vertical: size.width * 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff5FC753), shape: BoxShape.circle),
                width: size.width * 8,
                height: size.width * 8,
                margin: EdgeInsets.only(right: size.width * 20),
              ),
              Text(
                '作业清单',
                style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: size.width * 22,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff0FA3FD), shape: BoxShape.circle),
                width: size.width * 8,
                height: size.width * 8,
                margin: EdgeInsets.symmetric(horizontal: size.width * 20),
              ),
              Text(
                '监护清单',
                style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: size.width * 22,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: size.width * 10,
          ),
        ],
      ),
    );
  }
}
