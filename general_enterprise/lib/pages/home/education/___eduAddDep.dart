import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EduAddDep extends StatefulWidget {
  @override
  _EduAddDepState createState() => _EduAddDepState();
}

class _EduAddDepState extends State<EduAddDep> {
  PageController _pageController = PageController();

  List<Map> depPageList = [];

  int id = 0;
  int page = 0;

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
          for (var i = depPageList.length - 1; i > page; i--) {
            depPageList.removeAt(i);
          }
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _getData(int ids) {
    if (page < depPageList.length - 1) {
      _pageController.animateToPage(++page,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
      return;
    }
    PeopleStructure.queryOnlyDepartment(ids).then((value) {
      if (value is List) {
        if (value.isNotEmpty) {
          depPageList.add({'departmentId': value});
          page = depPageList.length - 1;
          _pageController.animateToPage(page,
              duration: Duration(milliseconds: 200), curve: Curves.linear);
          if (mounted) {
            setState(() {});
          }
        } else {
          Fluttertoast.showToast(msg: '已无下级单位');
        }
      }
    });
  }

  List depIds = [];

  String _getImage(int id){
    depIds.contains(id);
    if(depIds.contains(id)){
      return 'assets/images/gou@2x.png';
    }else{
      return 'assets/images/quan@2x.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('新增调研部门'),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: PageView.builder(
                controller: _pageController,
                itemCount: depPageList.length,
                itemBuilder: (context, index) => ListView.builder(
                  cacheExtent: 3,
                  itemCount: depPageList[index]['departmentId'].length,
                  itemBuilder: (context, _index) => Container(
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
                        GestureDetector(
                          onTap: () {
                            depIds.contains(depPageList[index]['departmentId'][_index].id);
                            if(depIds.contains(depPageList[index]['departmentId'][_index].id)){
                              depIds.remove(depPageList[index]['departmentId'][_index].id);
                            }else{
                              depIds.add(depPageList[index]['departmentId'][_index].id);
                            }
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                              child: Image.asset(
                              _getImage(depPageList[index]['departmentId'][_index].id),
                              height: size.width * 36,
                              width: size.width * 36,
                            ),
                          ),
                        ),
                        Text(
                          depPageList[index]['departmentId'][_index].name,
                          style: TextStyle(
                              color: Color(0xff7487A4),
                              fontSize: size.width * 26,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: size.width * 10,
                        ),
                        Text(
                          '（共' + depPageList[index]['departmentId'][_index].nums.toString() + '个部门）',
                          style:
                              TextStyle(color: Color(0xff91A6C6), fontSize: size.width * 24),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: size.width * 20),
                          height: size.width * 76.8,
                          width: size.width * 1,
                          color: Color(0xff9BB3D9),
                        ),
                        GestureDetector(
                          onTap: (){
                            id = depPageList[index]['departmentId'][_index].id;
                            _getData(id);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/checkList4Key@2x.png',
                                width: size.width * 30,
                                height: size.width * 31,
                              ),
                              SizedBox(
                                width: size.width * 20,
                              ),
                              Text(
                                '下级',
                                style: TextStyle(
                                    color: Color(0xff445CFE),
                                    fontSize: size.width * 26,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: size.width * 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, depIds);
                },
                child: Container(
                  height: size.width * 60,
                  width: size.width * 240,
                  margin: EdgeInsets.symmetric(vertical: size.width * 30),
                  decoration: BoxDecoration(
                      color: Color(0xff0059FF),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 8))),
                  alignment: Alignment.center,
                  child: Text(
                    '确定',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}