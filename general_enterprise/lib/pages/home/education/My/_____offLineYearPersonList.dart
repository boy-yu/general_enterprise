import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/education/My/_examinePersonList.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class OffLineYearPersonList extends StatefulWidget {
  OffLineYearPersonList({this.type, this.data});
  final int type;
  final List data;
  @override
  _OffLineYearPersonListState createState() => _OffLineYearPersonListState();
}

class _OffLineYearPersonListState extends State<OffLineYearPersonList> {
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
        return Text('完成培训人员');
        break;
      case 2:
        return Text('未完成培训人员');
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
    setState(() {});
    // _getSort();
  }

  List dropList = [
    {
      'title': '选择部门',
      'data': [],
      'value': '',
      'saveTitle': '选择部门'
    },
  ];

  // List dropList1 = [
  //   {
  //     'title': '从高到低',
  //     'data': [
  //       {
  //         'name': '从高到低',
  //       },
  //       {
  //         'name': '从低到高',
  //       },
  //     ],
  //     'value': '',
  //     'saveTitle': '从高到低'
  //   },
  // ];

  // String sortMode = '从高到低';

  // _getSort(){
  //   if(sortMode == '从高到低'){
  //     peopleList.sort((left,right)=>right['score'].compareTo(left['score']));
  //   }else{
  //     peopleList.sort((left,right)=>left['score'].compareTo(right['score']));
  //   }
  //   setState(() {});
  // }

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
                // Expanded(
                //   child: DropDown(
                //     dropList1,
                //     0,
                //     callbacks: (val) {
                //       sortMode = val['status'];
                //       _getSort();
                //     },
                //   ),
                // ),
              ]
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: size.width * 20, horizontal: size.width * 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 200,
                      alignment: Alignment.center,
                      child: Text(
                        '姓名'
                      ),
                    ),
                    Container(
                      width: size.width * 500,
                      alignment: Alignment.center,
                      child: Text(
                        '部门'
                      ),
                    ),
                    // Container(
                    //   width: size.width * 150,
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     '分数'
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 2,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 20),
                  child: ListView.builder(
                    itemCount: peopleList.length,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: size.width * 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: size.width * 200,
                                  alignment: Alignment.center,
                                  child: Text(
                                    peopleList[index]['nickname'].toString()
                                  ),
                                ),
                                Container(
                                  width: size.width * 500,
                                  alignment: Alignment.center,
                                  child: Text(
                                    peopleList[index]['departmentName'].toString()
                                  ),
                                ),
                                // Container(
                                //   width: size.width * 150,
                                //   alignment: Alignment.center,
                                //   child: Text(
                                //     peopleList[index]['score'].toString()
                                //   ),
                                // ),
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