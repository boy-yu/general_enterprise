import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExaminePersonList extends StatefulWidget {
  ExaminePersonList({@required this.type, @required this.data, @required this.planId, @required this.stage, this.year, this.endTime});
  final int type, endTime;
  final List data;
  final int planId;
  final int stage;
  final String year;
  @override
  _ExaminePersonListState createState() => _ExaminePersonListState();
}

class _ExaminePersonListState extends State<ExaminePersonList> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    peopleList = widget.data;
    if(peopleList.isNotEmpty){
      _getDepartmentList();
    }
  }

  _getDepartmentList(){
    List departmentList = [];
    for (int i = 0; i < peopleList.length; i++) {
      departmentList.add(peopleList[i]['departmentName']);
    }
    List newList = [];
    for(int i = 0; i < departmentList.length; i++ ){
       bool isContains = newList.contains(departmentList[i]);
       if(!isContains){
           newList.add(departmentList[i]);
       }
    }
    departmentList.clear();
    departmentList.add({'name': '查看全部'});
    for (int i = 0; i < newList.length; i++) {
      departmentList.add({'name': newList[i]});
    }
    dropList[0]['data'] = departmentList;
  }

  Widget _getTitle() {
    switch (widget.type) {
      case 1:
        return Text('通过考核人员');
        break;
      case 2:
        return Text('未通过考核人员');
        break;
      case 3:
        return Text('补考通过人员');
        break;
      default:
        return Text('');
    }
  }

  String key = '';
  String dep = '查看全部';

  _searchPeople(String keywords) {
    key = keywords;
    if(widget.data.isNotEmpty){
      _getData(key, dep);
    }
  }

  List peopleList = [];

  _getData(String keywords, String department){
    peopleList = widget.data;
    List newList = [];
    for (int i = 0; i < peopleList.length; i++) {
      if(keywords == '' && department == '查看全部'){   //  无搜索关键字 无部门筛选
        newList.add(peopleList[i]);
      }
      if(keywords != '' && department == '查看全部'){   //  搜索关键字
        if(peopleList[i]['departmentName'].contains(keywords) || peopleList[i]['nickname'].contains(keywords)){
          newList.add(peopleList[i]);
        }
      }
      if(keywords == '' && department != '查看全部'){   //  部门筛选
        if(peopleList[i]['departmentName'] == department){
          newList.add(peopleList[i]);
        }
      }
      if(keywords != '' && department != '查看全部'){   //  搜索关键字及部门筛选
        if(peopleList[i]['departmentName'] == department && (peopleList[i]['nickname'].contains(keywords) || peopleList[i]['departmentName'].contains(keywords))){
          newList.add(peopleList[i]);
        }
      }
    }
    peopleList = newList;
    _getSort();
  }

  List dropList = [
    {
      'title': '选择部门',
      'data': [],
      'value': '',
      'saveTitle': '选择部门'
    },
  ];

  List dropList1 = [
    {
      'title': '从高到低',
      'data': [
        {
          'name': '从高到低',
        },
        {
          'name': '从低到高',
        },
      ],
      'value': '',
      'saveTitle': '从高到低'
    },
  ];

  String sortMode = '从高到低';

  _getSort(){
    if(sortMode == '从高到低'){
      peopleList.sort((left,right)=>right['score'].compareTo(left['score']));
    }else{
      peopleList.sort((left,right)=>left['score'].compareTo(right['score']));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: _getTitle(),
      child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: size.width * 30, right: size.width * 30, top: size.width * 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 10)),
                  border: Border.all(
                      width: size.width * 1, color: Color(0xff999999)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: size.width * 20,
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: size.width * 20),
                      width: size.width * 500,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: '搜索您的关键字',
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          _searchPeople(value);
                          // _context.peopleSearch(value);
                        },
                        // onChanged: onSearchTextChanged,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: <Widget>[
                // 选择部门
                Expanded(
                  child: DropDown(
                    dropList,
                    0,
                    callbacks: (val) {
                      dep = val['status'];
                      if(widget.data.isNotEmpty){
                        _getData(key, dep);
                      }
                    },
                  ),
                ),
                //选择排序方式
                Expanded(
                  child: DropDown(
                    dropList1,
                    0,
                    callbacks: (val) {
                      sortMode = val['status'];
                      _getSort();
                    },
                  ),
                ),
              ]
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: size.width * 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 180,
                      alignment: Alignment.center,
                      child: Text(
                        '姓名'
                      ),
                    ),
                    Container(
                      width: size.width * 400,
                      alignment: Alignment.center,
                      child: Text(
                        '部门'
                      ),
                    ),
                    Container(
                      width: size.width * 150,
                      alignment: Alignment.center,
                      child: Text(
                        '分数'
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 2,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: peopleList.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          if(widget.endTime != null){
                            if(widget.endTime > DateTime.now().millisecondsSinceEpoch){
                              Fluttertoast.showToast(msg: '未到考试结束时间');
                            }else{
                              Navigator.pushNamed(context,
                                "/home/education/eduCheckExamLedgerDetails",
                                arguments: {
                                  'userId': peopleList[index]['userId'],
                                  'planId': widget.planId,
                                  'stage': widget.stage,
                                  'year': widget.year
                                });
                            }
                          }else{
                            Navigator.pushNamed(context,
                              "/home/education/eduCheckExamLedgerDetails",
                              arguments: {
                                'userId': peopleList[index]['userId'],
                                'planId': widget.planId,
                                'stage': widget.stage,
                                'year': widget.year
                              });
                          }
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: size.width * 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width * 180,
                                    alignment: Alignment.center,
                                    child: Text(
                                      peopleList[index]['nickname'].toString()
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 400,
                                    alignment: Alignment.center,
                                    child: Text(
                                      peopleList[index]['departmentName'].toString()
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 150,
                                    alignment: Alignment.center,
                                    child: Text(
                                      peopleList[index]['score'].toString() 
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: size.width * 1,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: size.width * 10),
                              color: Color(0xffeeeeee),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                )
              )
            ],
          ),
        ),
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown(this.list, this.index, {Key key, this.callbacks})
      : super(key: key);
  final int index;
  final List list;
  final callbacks;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.list.asMap().keys.map((i) {
      return Expanded(
          child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 200,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                                widget.list[i]['data'].map<Widget>((_ele) {
                              Color _juegeColor() {
                                Color _color = widget.list[i]['value'] == '' &&
                                        _ele['name'] == '查看全部'
                                    ? themeColor
                                    : widget.list[i]['value'] == _ele['name']
                                        ? themeColor
                                        : Colors.white;
                                return _color;
                              }

                              Color _conColors = _juegeColor();
                              return GestureDetector(
                                onTap: () {
                                  widget.list[i]['value'] = _ele['name'];
                                  if (_ele['name'] == '查看全部') {
                                    widget.list[i]['title'] =
                                        widget.list[i]['saveTitle'];
                                  } else {
                                    widget.list[i]['title'] = _ele['name'];
                                  }
                                  widget.callbacks({
                                    'status': _ele['name'],
                                    'id': _ele['id'],
                                  });
                                  setState(() {});
                                  // widget.getDataList();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 32),
                                  decoration: BoxDecoration(
                                      color: _conColors,
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: underColor))),
                                  child: Center(
                                    child: Text(
                                      _ele['name'],
                                      style: TextStyle(
                                          fontSize: size.width * 30,
                                          color: _conColors.toString() ==
                                                  'Color(0xff6ea3f9)'
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Expanded(child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ))
                    ],
                  ),
                );
              });
        },
        child: Container(
          width: size.width * 220,
          height: size.width * 53,
          margin: EdgeInsets.all(size.width * 20.0),
          padding: EdgeInsets.only(
              left: size.width * 20.0, right: size.width * 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: size.width * 1,
              color: Color(0xffDCDCDC),
            ),
            borderRadius: BorderRadius.circular(size.width * 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.list[i]['title'].toString(),
                style: TextStyle(
                    color: Color(0xff898989),
                    fontSize: size.width * 22,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff898989),
                size: size.width * 30,
              ),
            ],
          ),
        ),
      ));
    }).toList());
  }
}

