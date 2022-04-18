import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';

class EduHaveParticipatedAloneList extends StatefulWidget {
  EduHaveParticipatedAloneList({this.haveParticipatedList, this.type, this.planType});
  final List haveParticipatedList;
  final int type, planType;
  @override
  _EduHaveParticipatedAloneListState createState() => _EduHaveParticipatedAloneListState();
}

class _EduHaveParticipatedAloneListState extends State<EduHaveParticipatedAloneList> {
  TextEditingController _editingController = TextEditingController();
  
  List personnelList = [];

  _secher(String keys) {
    personnelList = [];
    for (int i = 0; i < widget.haveParticipatedList.length; i++) {
      if(widget.haveParticipatedList[i]['nickname'].toString().indexOf(keys)!=-1){
        personnelList.add(widget.haveParticipatedList[i]);
      }
    }
    perSelect = 0;
    if(personnelList.isNotEmpty){
      _getData(personnelList);
      nameSelect = personnelList[perSelect]['nickname'];
    }else{
      _getData(widget.haveParticipatedList);
      nameSelect = widget.haveParticipatedList[perSelect]['nickname'];
    }
    setState(() {});
  }

  int perSelect = 0;

  String nameSelect = '';

  @override
  void initState() {
    super.initState();
    if(widget.haveParticipatedList.isNotEmpty){
      nameSelect = widget.haveParticipatedList[0]['nickname'];
      _getData(widget.haveParticipatedList);
    }
  }

  _getNum(List list){
    if(widget.type == 2){
      return list[perSelect]['onLineTrainingSituationList'].length.toString();
    }else if(widget.type == 3){
      return list[perSelect]['offlineTrainingSituationList'].length.toString();
    }
  }

  List data = [];

  _getData(List list){
    if(widget.type == 2){
      data = list[perSelect]['onLineTrainingSituationList'];
    }else if(widget.type == 3){
      data = list[perSelect]['offlineTrainingSituationList'];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size widghtSize = MediaQuery.of(context).size;
    return MyAppbar(
      title: widget.type == 2 ? Text('线上培训已计划人员') : Text('现场培训已计划人员'),
      child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: size.width * 75,
                      margin: EdgeInsets.fromLTRB(size.width * 40,
                          size.width * 30, size.width * 40, size.width * 5),
                      decoration: BoxDecoration(
                          color: Color(0xffFAFAFB),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: placeHolder.withOpacity(.2), width: 2)),
                      child: TextField(
                        controller: _editingController,
                        textInputAction: TextInputAction.search,
                        onChanged: _secher,
                        onSubmitted: _secher,
                        maxLines: 1,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              size: size.width * 40,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(size.width * 40,
                                0, size.width * 40, size.width * 38),
                            hintText: '请输入名字',
                            hintStyle: TextStyle(
                                color: Color(0xffACACBC),
                                fontSize: size.width * 24)),
                      ),
                    ),
                    Container(
                        height: size.width * 150,
                        child: widget.haveParticipatedList.isNotEmpty
                            ? personnelList.isNotEmpty
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: personnelList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          perSelect = index;
                                          nameSelect = personnelList[perSelect]
                                              ['nickname'];
                                          _getNum(personnelList);
                                          _getData(personnelList);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: size.width * 100,
                                          padding: EdgeInsets.only(
                                              top: size.width * 30),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: size.width * 64,
                                                width: size.width * 64,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: index == perSelect
                                                          ? AssetImage(
                                                              'assets/images/dotted_line_quan_select@2x@2x.png')
                                                          : AssetImage(
                                                              'assets/images/dotted_line_quan@2x.png'),
                                                      fit: BoxFit.cover),
                                                ),
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: size.width * 44,
                                                  width: size.width * 44,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                          image: personnelList[index][
                                                                      'photoUrl'] !=
                                                                  ''
                                                              ? NetworkImage(
                                                                  personnelList[index]
                                                                      [
                                                                      'photoUrl'])
                                                              : AssetImage(
                                                                  'assets/images/image_recent_control.jpg'),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  size.width *
                                                                      50))),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Text(
                                                personnelList[index]
                                                    ['nickname'],
                                                style: TextStyle(
                                                    color: index == perSelect
                                                        ? Color(0xff3073FE)
                                                        : Color(0xff949494),
                                                    fontSize: size.width * 18),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.haveParticipatedList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          perSelect = index;
                                          nameSelect =
                                              widget.haveParticipatedList[
                                                  perSelect]['nickname'];
                                          _getNum(widget.haveParticipatedList);
                                          _getData(widget.haveParticipatedList);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: size.width * 100,
                                          padding: EdgeInsets.only(
                                              top: size.width * 30),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: size.width * 64,
                                                width: size.width * 64,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: index == perSelect
                                                          ? AssetImage(
                                                              'assets/images/dotted_line_quan_select@2x@2x.png')
                                                          : AssetImage(
                                                              'assets/images/dotted_line_quan@2x.png'),
                                                      fit: BoxFit.cover),
                                                ),
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: size.width * 44,
                                                  width: size.width * 44,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                          image: widget.haveParticipatedList[index]
                                                                      [
                                                                      'photoUrl'] !=
                                                                  ''
                                                              ? NetworkImage(widget
                                                                      .haveParticipatedList[index]
                                                                  ['photoUrl'])
                                                              : AssetImage(
                                                                  'assets/images/image_recent_control.jpg'),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  size.width * 50))),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Text(
                                                widget.haveParticipatedList[
                                                    index]['nickname'],
                                                style: TextStyle(
                                                    color: index == perSelect
                                                        ? Color(0xff3073FE)
                                                        : Color(0xff949494),
                                                    fontSize: size.width * 18),
                                                maxLines: 1
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                            : Center(
                                child: Text('暂无人员'),
                              ))
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Container(
                padding: EdgeInsets.all(size.width * 30),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '参加培训统计：',
                          style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: size.width * 24),
                        ),
                        SizedBox(
                          height: size.width * 5,
                        ),
                        Text(
                          widget.haveParticipatedList.isNotEmpty
                              ? personnelList.isNotEmpty
                                  ? _getNum(personnelList) + '次'
                                  : _getNum(widget.haveParticipatedList) + '次'
                              : '0次',
                          style: TextStyle(
                              color: Color(0xff5570FF),
                              fontSize: size.width * 52,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text(
                      nameSelect + '培训详情',
                      style: TextStyle(
                          fontSize: size.width * 28,
                          color: Color(0xff999999),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 20,
              ),
              Expanded(
                child: Container(
                color: Colors.white,
                child: data.isNotEmpty
                    ? ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 20),
                            decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(size.width * 10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0),
                                  ]),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                GestureDetector(
                                  onTap: (){
                                    if (widget.type == 2) {   // 线上
                                      if(widget.planType == 1){   // 普通培训
                                        Navigator.pushNamed(
                                          context, "/home/education/styduPlanDetail",
                                          arguments: {
                                            'planId': data[index]['planId'],
                                            'source': 2
                                          }
                                        );
                                      }else if(widget.planType == 2){   // 年度培训
                                        Navigator.pushNamed(
                                          context, 
                                          "/home/education/yearPlanDetails",
                                          arguments: {
                                            'id': data[index]['planId']
                                          }
                                        );
                                      }
                                    } else if (widget.type == 3) {    // 线下
                                      if(widget.planType == 1){   // 普通培训
                                        Navigator.pushNamed(
                                          context, "/home/education/styduOfflinePlanDetail",
                                          arguments: {
                                            'planId': data[index]['planId'],
                                            'title': data[index]['planName']
                                          }
                                        );
                                      }else if(widget.planType == 2){   // 年度培训
                                        Navigator.pushNamed(
                                          context, 
                                          "/home/education/offLineYearPlanDetails",
                                          arguments: {
                                            'id': data[index]['planId']
                                          }
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          data[index]['planName'].toString(),
                                          style: TextStyle(
                                              color: Color(0xff4D4D4D),
                                              fontSize: size.width * 28,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          size: size.width * 40,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                widget.type == 2 ? Container(
                                  height: size.width * 1,
                                  color: Color(0xffeeeeee),
                                  width: double.infinity,
                                ) : Container(),
                                widget.type == 2 ? ListView.builder(
                                  shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                                  physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                                  itemCount: data[index]['stage'].length,
                                  itemBuilder: (context, _index){
                                    return InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(
                                          context, 
                                          "/home/education/eduCheckExamLedgerDetails", 
                                          arguments: {
                                            'examinationId': data[index]['stage'][_index]['id']
                                          }
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(size.width * 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              '第' + (_index + 1).toString() + '阶段考核分数：${data[index]['stage'][_index]['score']}',
                                              style: TextStyle(
                                                color: Color(0xff4D4D4D),
                                                fontSize: size.width * 28,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.keyboard_arrow_right,
                                              size: size.width * 40,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                ) : Container()
                            ],
                          ),
                          );
                        })
                    : Container(
                        alignment: Alignment.center,
                        child: Text('暂无数据'),
                      ),
              ))
            ],
          )
        // Container(
        //   color: Colors.white,
        //   child: ListView(
        //     children: [
        //       Container(
        //         margin: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 30),
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black12,
        //               blurRadius: 1.0,
        //               spreadRadius: 1.0
        //             ),
        //           ]
        //         ),
        //         child: Column(
        //           children: [
        //             Container(
        //               height: size.width * 75,
        //               margin: EdgeInsets.fromLTRB(
        //                   size.width * 40, size.width * 30, size.width * 40, size.width * 5),
        //               decoration: BoxDecoration(
        //                   color: Color(0xffFAFAFB),
        //                   borderRadius: BorderRadius.circular(50),
        //                   border: Border.all(color: placeHolder.withOpacity(.2), width: 2)),
        //               child: TextField(
        //                 controller: _editingController,
        //                 textInputAction: TextInputAction.search,
        //                 onChanged: _secher,
        //                 onSubmitted: _secher,
        //                 maxLines: 1,
        //                 decoration: InputDecoration(
        //                     prefixIcon: Icon(
        //                       Icons.search,
        //                       size: size.width * 40,
        //                     ),
        //                     border: InputBorder.none,
        //                     contentPadding: EdgeInsets.fromLTRB(size.width * 40, 0, size.width * 40, size.width * 38),
        //                     hintText: '请输入名字',
        //                     hintStyle: TextStyle(color: Color(0xffACACBC), fontSize: size.width * 24)),
        //               ),
        //             ),
        //             Container(
        //               height: size.width * 150,
        //               child: widget.haveParticipatedList.isNotEmpty 
        //               ? personnelList.isNotEmpty 
        //                 ? ListView.builder(
        //                   scrollDirection: Axis.horizontal,
        //                   itemCount: personnelList.length,
        //                   itemBuilder: (context, index){
        //                     return InkWell(
        //                       onTap: (){
        //                         perSelect = index;
        //                         nameSelect = personnelList[perSelect]['nickname'];
        //                         _getNum(personnelList);
        //                         _getData(personnelList);
        //                         setState(() {});
        //                       },
        //                       child: Container(
        //                         width: size.width * 100,
        //                         padding: EdgeInsets.only(top: size.width * 30),
        //                         child: Column(
        //                           children: [
        //                             Container(
        //                               height: size.width * 64,
        //                               width: size.width * 64,
        //                               decoration: BoxDecoration(
        //                                 color: Colors.white,
        //                                 image: DecorationImage(
        //                                   image: index == perSelect ? AssetImage('assets/images/dotted_line_quan_select@2x@2x.png') : AssetImage('assets/images/dotted_line_quan@2x.png'),
        //                                   fit: BoxFit.cover
        //                                 ),
        //                               ),
        //                               alignment: Alignment.center,
        //                               child: Container(
        //                                 height: size.width * 44,
        //                                 width: size.width * 44,
        //                                 decoration: BoxDecoration(
        //                                   color: Colors.white,
        //                                   image: DecorationImage(
        //                                     image: personnelList[index]['photoUrl'] != '' ? NetworkImage(personnelList[index]['photoUrl']) : AssetImage('assets/images/image_recent_control.jpg'),
        //                                     fit: BoxFit.cover
        //                                   ),
        //                                   borderRadius: BorderRadius.all(Radius.circular(size.width * 50))
        //                                 ),
        //                               ),
        //                             ),
        //                             SizedBox(
        //                               height: size.width * 10,
        //                             ),
        //                             Text(
        //                               personnelList[index]['nickname'],
        //                               style: TextStyle(
        //                                 color: index == perSelect ? Color(0xff3073FE) : Color(0xff949494),
        //                                 fontSize: size.width * 18
        //                               ),
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     );
        //                   }
        //                 )
        //                 : ListView.builder(
        //                   scrollDirection: Axis.horizontal,
        //                   itemCount: widget.haveParticipatedList.length,
        //                   itemBuilder: (context, index){
        //                     return InkWell(
        //                       onTap: (){
        //                         perSelect = index;
        //                         nameSelect = widget.haveParticipatedList[perSelect]['nickname'];
        //                         _getNum(widget.haveParticipatedList);
        //                         _getData(widget.haveParticipatedList);
        //                         setState(() {});
        //                       },
        //                       child: Container(
        //                         width: size.width * 100,
        //                         padding: EdgeInsets.only(top: size.width * 30),
        //                         child: Column(
        //                           children: [
        //                             Container(
        //                               height: size.width * 64,
        //                               width: size.width * 64,
        //                               decoration: BoxDecoration(
        //                                 color: Colors.white,
        //                                 image: DecorationImage(
        //                                   image: index == perSelect ? AssetImage('assets/images/dotted_line_quan_select@2x@2x.png') : AssetImage('assets/images/dotted_line_quan@2x.png'),
        //                                   fit: BoxFit.cover
        //                                 ),
        //                               ),
        //                               alignment: Alignment.center,
        //                               child: Container(
        //                                 height: size.width * 44,
        //                                 width: size.width * 44,
        //                                 decoration: BoxDecoration(
        //                                   color: Colors.white,
        //                                   image: DecorationImage(
        //                                     image: widget.haveParticipatedList[index]['photoUrl'] != '' ? NetworkImage(widget.haveParticipatedList[index]['photoUrl']) : AssetImage('assets/images/image_recent_control.jpg'),
        //                                     fit: BoxFit.cover
        //                                   ),
        //                                   borderRadius: BorderRadius.all(Radius.circular(size.width * 50))
        //                                 ),
        //                               ),
        //                             ),
        //                             SizedBox(
        //                               height: size.width * 10,
        //                             ),
        //                             Text(
        //                               widget.haveParticipatedList[index]['nickname'],
        //                               style: TextStyle(
        //                                 color: index == perSelect ? Color(0xff3073FE) : Color(0xff949494),
        //                                 fontSize: size.width * 18
        //                               ),
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     );
        //                   }
        //                 ) 
        //                 : Center(child: Text('暂无人员'),)
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.symmetric(horizontal: size.width * 20),
        //         padding: EdgeInsets.all(size.width * 30),
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             image: AssetImage('assets/images/edu_per_plan_canja@2x.png'),
        //             fit: BoxFit.cover
        //           ),
        //           borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
        //           boxShadow: [
        //             BoxShadow(
        //               blurRadius: 1.0,
        //               color: Colors.black12,
        //               spreadRadius: 1.0
        //             )
        //           ]
        //         ),
        //         alignment: Alignment.centerLeft,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   '参加培训统计：',
        //                   style: TextStyle(
        //                     color: Color(0xff999999),
        //                     fontSize: size.width * 24
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: size.width * 5,
        //                 ),
        //                 Text(
        //                   widget.haveParticipatedList.isNotEmpty ? personnelList.isNotEmpty ? _getNum(personnelList) + '次' : _getNum(widget.haveParticipatedList) + '次' : '0次',
        //                   style: TextStyle(
        //                     color: Color(0xff5570FF),
        //                     fontSize: size.width * 52,
        //                     fontWeight: FontWeight.bold
        //                   ),
        //                 )
        //               ],
        //             ),
        //             Text(
        //               nameSelect + '培训详情',
        //               style: TextStyle(
        //                 fontSize: size.width * 28,
        //                 color: Color(0xff999999),
        //                 fontWeight: FontWeight.bold
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.symmetric(horizontal: size.width * 20, vertical: size.width * 30),
        //         constraints: BoxConstraints(minHeight: size.width * 600),
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.all(Radius.circular(size.width * 10)),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black12,
        //               blurRadius: 1.0,
        //               spreadRadius: 1.0
        //             ),
        //           ]
        //         ),
        //         child: data.isNotEmpty ? ListView.builder(
        //           shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
        //           physics:NeverScrollableScrollPhysics(),//禁用滑动事件
        //           itemCount: data.length,
        //           itemBuilder: (context, index){
        //             return Container(
        //               height: size.width * 66,
        //               color: index % 2 == 0 ? Colors.white : Color(0xff3E94F4).withOpacity(0.05),
        //               alignment: Alignment.centerLeft,
        //               padding: EdgeInsets.only(left: size.width * 30),
        //               child: Text(
        //                 data[index]['planName'].toString(),
        //                 style: TextStyle(
        //                   color: Color(0xff4D4D4D),
        //                   fontSize: size.width * 28,
        //                   fontWeight: FontWeight.bold
        //                 ),
        //               ),
        //             );
        //           }
        //         ) : Container(
        //           height: size.width * 600,
        //           alignment: Alignment.center,
        //           child: Text('暂无数据'),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
    );
  }
}