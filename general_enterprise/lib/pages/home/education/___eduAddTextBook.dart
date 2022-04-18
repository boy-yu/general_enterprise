import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduAddTextBook extends StatefulWidget {
  EduAddTextBook({this.educationTrainingResources});
  final List educationTrainingResources;
  @override
  _EduAddTextBookState createState() => _EduAddTextBookState();
}

class _EduAddTextBookState extends State<EduAddTextBook> {
  int select = -1;

  void _textKeywordFieldChanged(String str) {
    print(str);
  }

  List dropList1 = [
    {'title': '教材类型···名称', 'data': [], 'value': '', 'saveTitle': '教材类型···名称'},
  ];

  List dropList2 = [
    {'title': '第二层教材类型', 'data': [], 'value': '', 'saveTitle': '第二层教材类型'},
  ];

  List dropList3 = [
    {'title': '第三层教材类型', 'data': [], 'value': '', 'saveTitle': '第三层教材类型'},
  ];

  ThrowFunc _throwFunc = ThrowFunc();
  Map queryParameters;

  @override
  void initState() {
    super.initState();
    _getData();
    _getDropList1();
  }

  _getDropList1() {
    myDio.request(
        type: "get",
        url: Interface.getResourcesTypeLeveLOne,
    ).then((value) {
      if (value is List) {
        dropList1[0]['data'] = value;
      }
      setState(() {});
    });
  }

  _getDropList2(int id) {
    myDio.request(
        type: "get",
        url: Interface.getResourcesTypeSubordinate,
        queryParameters: {
          'parentId': id
        }
    ).then((value) {
      if (value is List) {
        dropList2[0]['data'] = value;
      }
      setState(() {});
    });
  }

  _getDropList3(int id) {
    myDio.request(
        type: "get",
        url: Interface.getResourcesTypeSubordinate,
        queryParameters: {
          'parentId': id
        }
    ).then((value) {
      if (value is List) {
        dropList3[0]['data'] = value;
      }
      setState(() {});
    });
  }

  _getData({int id}){
    print(id);
    if(id == null){
      myDio.request(
        type: "get",
        url: Interface.getEducationTrainingResourcesList,
      ).then((value) {
        if (value['records'] is List) {
          data = value['records'];
          if(data.isNotEmpty){
            for (int i = 0; i < data.length; i++) {
              if(widget.educationTrainingResources.isNotEmpty){
                for (int j = 0; j < widget.educationTrainingResources.length; j++) {
                  if(widget.educationTrainingResources[j]['id'] == data[i]['id']){
                    data[i]['select'] = 1;
                  }
                }
              }
            }
          }
        }
        setState(() {});
      });
    }else{
      myDio.request(
        type: "get",
        url: Interface.getEducationTrainingResourcesList,
        queryParameters: {
          'typeId': id,
        }
      ).then((value) {
        if (value['records'] is List) {
          data = value['records'];
        }
        setState(() {});
      });
    }
  }

  List data = [];

  List<int> resourcesIds = [];

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('新增教材'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.width * 75,
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 30, vertical: size.width * 20),
                  padding: EdgeInsets.all(size.width * 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 37)),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 1.0),
                      ]),
                  child: Container(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(size.width * 17),
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: '请输入课程关键词',
                        hintStyle: TextStyle(
                          fontSize: size.width * 28,
                          color: Color(0xffA6A6A6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      maxLines: 1,
                      onChanged: _textKeywordFieldChanged,
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: MyEduDropDown(
                          dropList1,
                          0,
                          callbacks: (val) {
                            dropList2[0]['data'] = [];
                            dropList3[0]['data'] = [];
                            dropList2[0]['title'] = dropList2[0]['saveTitle'];
                            dropList3[0]['title'] = dropList3[0]['saveTitle'];
                            _getDropList2(val['id']);
                            _getData();
                            _throwFunc.run(argument: queryParameters);
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: MyEduDropDown(
                          dropList2,
                          0,
                          callbacks: (val) {
                            dropList3[0]['data'] = [];
                            dropList3[0]['title'] = dropList3[0]['saveTitle'];
                            _getDropList3(val['id']);
                            _getData();
                            _throwFunc.run(argument: queryParameters);
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: MyEduDropDown(
                          dropList3,
                          0,
                          callbacks: (val) {
                            _getData(id: val['id']);
                            _throwFunc.run(argument: queryParameters);
                            setState(() {});
                          },
                        ),
                      )
                    ]),
                SizedBox(
                  height: size.width * 30,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index){
                return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: size.width * 10,
                              horizontal: size.width * 30),
                          padding: EdgeInsets.all(size.width * 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0),
                              ]),
                          child: Row(
                            children: [
                              Image.network(
                                data[index]['coverUrl'],
                                height: size.width * 139,
                                width: size.width * 209,
                              ),
                              SizedBox(
                                width: size.width * 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['title'],
                                    style: TextStyle(
                                        fontSize: size.width * 28,
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: size.width * 300,
                                        child: Text(data[index]['introduction'],
                                            style: TextStyle(
                                              fontSize: size.width * 22,
                                              color: Color(0xff999999),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(
                                        width: size.width * 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return ShowDialog(
                                                    child: Center(
                                                  child: Container(
                                                    height: size.width * 500,
                                                    width: size.width * 690,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    size.width *
                                                                        10))),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: size
                                                                      .width *
                                                                  20,
                                                              vertical:
                                                                  size.width *
                                                                      10),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Spacer(),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Icon(
                                                                  Icons.clear,
                                                                  size:
                                                                      size.width *
                                                                          40,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Text(
                                                            data[index]['title'],
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.width *
                                                                        36,
                                                                color: Color(
                                                                    0xff0059FF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.width * 30,
                                                          ),
                                                          Text(
                                                            data[index]
                                                                ['introduction'],
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.width *
                                                                        30,
                                                                color: Color(
                                                                    0xff9D9D9D)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                              });
                                        },
                                        child: Text(
                                          '[简介]',
                                          style: TextStyle(
                                              fontSize: size.width * 20,
                                              color: Color(0xff1D3DEB)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 10,
                                  ),
                                  Text(
                                    '本教材包含${data[index]['classHours']}个课时',
                                    style: TextStyle(
                                        color: Color(0xff16CAA2),
                                        fontSize: size.width * 16),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            right: 0,
                            top: size.width * 65,
                            child: GestureDetector(
                              onTap: () {
                                if(data[index]['select'] == null){
                                  data[index]['select'] = 1;
                                }else{
                                  data[index]['select'] = null;
                                }
                                setState(() {});
                              },
                              child: Image.asset(
                                data[index]['select'] == 1 ? 'assets/images/dui@2x.png' : 'assets/images/dui(14)@2x.png',
                                height: size.width * 61,
                                width: size.width * 61,
                              ),
                            ))
                      ],
                    );
              }
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                resourcesIds = [];
                for (var i = 0; i < data.length; i++) {
                  if(data[i]['select'] == 1){
                    resourcesIds.add(data[i]['id']);
                  }
                }
                Navigator.pop(context, resourcesIds);
                // resourcesIds
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
          )
        ],
      ),
    );
  }
}

class MyEduDropDown extends StatefulWidget {
  const MyEduDropDown(this.list, this.index, {Key key, this.callbacks})
      : super(key: key);
  final int index;
  final List list;
  final callbacks;
  @override
  _MyEduDropDownState createState() => _MyEduDropDownState();
}

class _MyEduDropDownState extends State<MyEduDropDown> {
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
          margin: EdgeInsets.only(
              top: 10.0, left: size.width * 10.0, right: size.width * 10.0),
          padding: EdgeInsets.only(
              left: size.width * 20.0, right: size.width * 10.0),
          decoration: BoxDecoration(
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
