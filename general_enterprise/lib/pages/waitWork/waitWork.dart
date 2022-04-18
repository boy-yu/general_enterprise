import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCount.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/common/newMyInput.dart';
import 'package:enterprise/pages/home/work/work_dilog/_dilog.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WaitWorkStruck {
  String title, url;
  int value;
  bool isclick;
  Widget custom;
  Widget Function(dynamic valuem, Function func) widget;
  List<WaitWorkStruck> data;
  WaitWorkStruck(
      {this.title,
      this.url,
      this.value,
      this.isclick,
      this.widget,
      this.data,
      this.custom});
}

class WaitWork extends StatefulWidget {
  WaitWork({this.way});
  final int way;
  @override
  _WaitWorkState createState() => _WaitWorkState();
}

class _WaitWorkState extends State<WaitWork> {
  List<WaitWorkStruck> data = [];

  Future customClick({Map message}) async {
    await WorkDialog.myDialog(myContext, () {}, 2,
        widget: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 20),
              child: Text('值班承诺'),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 20),
              child: Text(
                  '我承诺，我已到达公司，并将于${message['startDate']}  -  ${message['endDate']}在公司值班，值班期间将严格遵守公司值班管理制度，完成值班工作！'),
            ),
            Row(
              children: [
                Spacer(),
                Text(
                  '承诺人：${myprefs.getString("username")}',
                ),
                SizedBox(
                  width: size.width * 40,
                )
              ],
            ),
            Row(
              children: [
                Spacer(),
                Text(
                    '承诺时间：  ${DateTime.now().toLocal().toString().split('.')[0]}'),
                SizedBox(
                  width: size.width * 40,
                )
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeColor)),
              onPressed: () {
                myDio.request(type: 'put', url: Interface.putSignIn, data: {
                  'id': message['id'],
                  'signInformation':
                      '我承诺，我已到达公司，并将于${message['startDate']}  -  ${message['endDate']}在公司值班，值班期间将严格遵守公司值班管理制度，完成值班工作！'
                }).then((value) {
                  Navigator.pop(myContext);
                });
              },
              child: Text('确定'),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    List<String> menuList = myprefs.getStringList('appFunctionMenu');
    data = [
      WaitWorkStruck(
        title: '聊天',
        value: 3,
        isclick: false,
        custom: Container(child: Text('custom style')),
      ),
      WaitWorkStruck(
          title: '应急值守',
          value: 0,
          isclick: false,
          url: Interface.getDutySign,
          widget: (value, fun) {
            return Text('跳转页面');
          }),
      WaitWorkStruck(
          title: '企业风险研判承诺',
          value: 0,
          isclick: false,
          url: Interface.getWorkCommitmentList,
          widget: (value, fun) {
            return Text('跳转页面');
          }),
    ];
    if(menuList.contains('安全作业')){
      data.add(
        WaitWorkStruck(title: '作业', value: 2, isclick: false, data: [
          WaitWorkStruck(
              title: '作业承诺',
              value: 0,
              isclick: false,
              url: Interface.getWorkDutyList,
              widget: (value, fun) {
                return Column(  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          value['workName'].toString(),
                          style: TextStyle(
                              fontSize: size.width * 28,
                              color: Color(0xff3074FF),
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          value['position'].toString(),
                          style: TextStyle(
                              fontSize: size.width * 30,
                              color: Color(0xff16BA63),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      height: size.width * 2,
                      width: double.infinity,
                      color: Color(0xffEFEFEF),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Text(
                      '属地单位:  ${value['territorialUnit']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '作业区域:  ${value['region']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '涉及作业:  ${value['workType']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            WorkDialog.myDialog(context, () {}, 2,
                                widget: Padding(
                                  padding: EdgeInsets.all(size.width * 20),
                                  child: Column(
                                    children: [
                                      Text(
                                          '我承诺自觉遵守安全生产的法律、法规和公司安全管理规章制度，严守本工种的《安全操作规程》，认真执行《安全技术交底》；并已了解本次作业的内容、风险，各项安全措施已落实到位。保证做到：不违章操作、不违章指挥、不违反劳动纪律、不冒险作业。'),
                                      Center(
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        themeColor)),
                                            onPressed: () {
                                              myDio
                                                  .request(
                                                type: 'put',
                                                url: Interface.putWorkDuty +
                                                    value['id'].toString(),
                                              )
                                                  .then((value) {
                                                successToast("成功!");
                                                Navigator.pop(context);
                                                fun();
                                              });
                                            },
                                            child: Text('确定承诺')),
                                      )
                                    ],
                                  ),
                                ));
                          },
                          child: Container(
                              height: size.width * 60,
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 30.0)),
                                  color: Color(0xffEDFAF3)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/cn@2x.png',
                                    height: size.width * 41,
                                    width: size.width * 41,
                                  ),
                                  Text(
                                    '承诺',
                                    style: TextStyle(
                                      fontSize: size.width * 29,
                                      color: Color(0xff16BA63),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () async {
                            Counter _counter =
                                Provider.of<Counter>(myContext, listen: false);
                            _counter.emptySubmitDates();
                            Navigator.pushNamed(
                                myContext, '/home/work/WorkTicker',
                                arguments: {
                                  "circuit": value['executionFlow'] == 8
                                      ? value['executionFlow'] + 1
                                      : value['executionFlow'],
                                  "id": value['flowId'],
                                  "operable": false,
                                  "bookId": value['bookId'],
                                  "executionMemo": value['executionMemo']
                                });
                          },
                          child: Container(
                              height: size.width * 60,
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 30.0)),
                                  color: Color(0xffE9F0FF)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/ck@2x.png',
                                    height: size.width * 32,
                                    width: size.width * 51,
                                  ),
                                  Text(
                                    '查看',
                                    style: TextStyle(
                                      fontSize: size.width * 29,
                                      color: Color(0xff236DFF),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                );
              }),
          WaitWorkStruck(
              title: '作业人及监护人承诺',
              value: 0,
              isclick: false,
              url: Interface.getWorkCommitmentList,
              widget: (value, fun) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          value['workName'].toString(),
                          style: TextStyle(
                              fontSize: size.width * 28,
                              color: Color(0xff3074FF),
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        // Text(
                        //   value['position'],
                        //   style: TextStyle(
                        //       fontSize: size.width * 30,
                        //       color: Color(0xff16BA63),
                        //       fontWeight: FontWeight.bold),
                        // ),
                      ],
                    ),
                    Container(
                      height: size.width * 2,
                      width: double.infinity,
                      color: Color(0xffEFEFEF),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Text(
                      '属地单位:  ${value['territorialUnit']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '作业区域:  ${value['region']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '涉及作业:  ${value['workType']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            WorkDialog.myDialog(context, () {}, 2,
                                widget: Padding(
                                  padding: EdgeInsets.all(size.width * 20),
                                  child: Column(
                                    children: [
                                      Text(
                                          '我承诺自觉遵守安全生产的法律、法规和公司安全管理规章制度，严守本工种的《安全操作规程》，认真执行《安全技术交底》；并已了解本次作业的内容、风险，各项安全措施已落实到位。保证做到：不违章操作、不违章指挥、不违反劳动纪律、不冒险作业。'),
                                      Center(
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        themeColor)),
                                            onPressed: () {
                                              myDio
                                                  .request(
                                                type: 'put',
                                                url: Interface.putAddWorkCommon +
                                                    value['id'].toString(),
                                              )
                                                  .then((value) {
                                                successToast("成功!");
                                                Navigator.pop(myContext);
                                                fun();
                                              });
                                            },
                                            child: Text('确定承诺')),
                                      )
                                    ],
                                  ),
                                ));
                          },
                          child: Container(
                              height: size.width * 60,
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 30.0)),
                                  color: Color(0xffEDFAF3)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/cn@2x.png',
                                    height: size.width * 41,
                                    width: size.width * 41,
                                  ),
                                  Text(
                                    '承诺',
                                    style: TextStyle(
                                      fontSize: size.width * 29,
                                      color: Color(0xff16BA63),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () async {
                            Counter _counter =
                                Provider.of<Counter>(myContext, listen: false);
                            _counter.emptySubmitDates();
                            Navigator.pushNamed(
                                myContext, '/home/work/WorkTicker',
                                arguments: {
                                  "circuit": value['executionFlow'] == 8
                                      ? value['executionFlow'] + 1
                                      : value['executionFlow'],
                                  "id": value['flowId'],
                                  "operable": false,
                                  "bookId": value['bookId'],
                                  "executionMemo": value['executionMemo']
                                });
                          },
                          child: Container(
                              height: size.width * 60,
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 30.0)),
                                  color: Color(0xffE9F0FF)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/ck@2x.png',
                                    height: size.width * 32,
                                    width: size.width * 51,
                                  ),
                                  Text(
                                    '查看',
                                    style: TextStyle(
                                      fontSize: size.width * 29,
                                      color: Color(0xff236DFF),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                );
              }),
          WaitWorkStruck(
              title: '作业审批',
              value: 0,
              isclick: false,
              url: Interface.getWorkDepartmentListApply,
              widget: (value, fun) {
                bool isAppro = true;
                List _list = value["workDutyCrowdList"];
                int operable = value["operable"];
                if (_list.isNotEmpty) {
                  for (var i = 0; i < _list.length; i++) {
                    if (_list[i]['sign'].toString() == '') {
                      isAppro = false;
                    }
                  }
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          value['workName'],
                          style: TextStyle(
                              fontSize: size.width * 28,
                              color: Color(0xff3074FF),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      height: size.width * 2,
                      width: double.infinity,
                      color: Color(0xffEFEFEF),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Text(
                      '属地单位:  ${value['territorialUnit']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '作业区域:  ${value['region']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '涉及作业:  ${value['workType']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            isAppro
                                ? operable == 1
                                    ? await WorkDialog.myDialog(context, () {}, 2,
                                        widget: Padding(
                                          padding:
                                              EdgeInsets.all(size.width * 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  '作业审批',
                                                  style: TextStyle(
                                                      color: Color(0xff0059FF),
                                                      fontSize: size.width * 36,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.width * 20,
                                              ),
                                              Text(
                                                '${value['departmentOpinion']['opinionTitle']}:',
                                                style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: size.width * 30,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Container(
                                                  width: double.infinity,
                                                  height: size.width * 250,
                                                  child: Stack(
                                                    children: [
                                                      NewMyInput(
                                                        title: '',
                                                        value: value[
                                                                    'departmentOpinion']
                                                                ['opinionContent']
                                                            .toString(),
                                                        line: 4,
                                                        onChange: (String text) {
                                                          value['departmentOpinion']
                                                                  [
                                                                  'opinionContent'] =
                                                              text;
                                                        },
                                                        textStyle: TextStyle(
                                                            color:
                                                                Color(0xffB6BAC2),
                                                            fontSize:
                                                                size.width * 30),
                                                      ),
                                                    ],
                                                  )),
                                              Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    myDio
                                                        .request(
                                                            type: 'put',
                                                            url: Interface
                                                                    .putWorkDepartmentListApply +
                                                                value['id']
                                                                    .toString(),
                                                            data: value[
                                                                'departmentOpinion'])
                                                        .then((value) {
                                                      successToast('审批成功');
                                                      Navigator.pop(context);
                                                      fun();
                                                    });
                                                  },
                                                  child: Container(
                                                    height: size.width * 75,
                                                    width: size.width * 500,
                                                    margin: EdgeInsets.symmetric(
                                                        vertical:
                                                            size.width * 50),
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                          colors: [
                                                            Color(0xff3174FF),
                                                            Color(0xff1C3AEA),
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    size.width *
                                                                        38.0))),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '确定',
                                                      style: TextStyle(
                                                          fontSize:
                                                              size.width * 36,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ))
                                    : Container()
                                : await WorkDialog.myDialog(context, () {}, 2,
                                    widget: Container(
                                      // color: Color(0xffF0F1FF),
                                      child: Padding(
                                        padding: EdgeInsets.all(size.width * 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                '作业流程',
                                                style: TextStyle(
                                                    color: Color(0xff0059FF),
                                                    fontSize: size.width * 36,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.width * 20,
                                            ),
                                            Container(
                                              height: size.width * 400,
                                              child: ListView.builder(
                                                  itemCount: _list.length,
                                                  itemBuilder: (context, index) {
                                                    return Container(
                                                      margin: EdgeInsets.all(
                                                          size.width * 20),
                                                      padding: EdgeInsets.all(
                                                          size.width * 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      size.width *
                                                                          10.0)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset: Offset(
                                                                    0, 0), //x,y轴
                                                                color: Colors
                                                                    .black12, //投影颜色
                                                                blurRadius:
                                                                    2 //投影距离
                                                                )
                                                          ]),
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                _list[index]
                                                                    ['position'],
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff2F3F5A),
                                                                    fontSize:
                                                                        size.width *
                                                                            32,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    size.width *
                                                                        10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    _list[index]
                                                                        ['user'],
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xff889AB8),
                                                                      fontSize:
                                                                          size.width *
                                                                              24,
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      launch(
                                                                          'tel:${_list[index]["phone"]}');
                                                                    },
                                                                    child: Text(
                                                                      '(${_list[index]["phone"]})',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff999999),
                                                                        fontSize:
                                                                            size.width *
                                                                                24,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height:
                                                                    size.width *
                                                                        54,
                                                                width:
                                                                    size.width *
                                                                        148,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        gradient: _list[index]['sign'] ==
                                                                                ''
                                                                            ? null
                                                                            : LinearGradient(
                                                                                begin: Alignment.topCenter,
                                                                                end: Alignment.bottomCenter,
                                                                                colors: [
                                                                                  Color(0xff266EFF),
                                                                                  Color(0xff528BFF),
                                                                                ],
                                                                              ),
                                                                        color: _list[index]['sign'] ==
                                                                                ''
                                                                            ? Color(
                                                                                0xffCED8EA)
                                                                            : null,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(size.width *
                                                                                27.0)),
                                                                        boxShadow: _list[index]['sign'] ==
                                                                                ''
                                                                            ? null
                                                                            : [
                                                                                BoxShadow(
                                                                                    offset: Offset(2, 1), //x,y轴
                                                                                    color: Color(0xff2A71FF), //投影颜色
                                                                                    blurRadius: 1 //投影距离
                                                                                    )
                                                                              ]),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  _list[index][
                                                                              'sign'] ==
                                                                          ''
                                                                      ? '承诺中'
                                                                      : '已承诺',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          size.width *
                                                                              28,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    size.width *
                                                                        15,
                                                              ),
                                                              Text(
                                                                _list[index][
                                                                            'sign'] ==
                                                                        ''
                                                                    ? ''
                                                                    : _list[index]
                                                                        [
                                                                        'agreeTime'],
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff889AB8),
                                                                    fontSize:
                                                                        size.width *
                                                                            16),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            Center(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: size.width * 75,
                                                  width: size.width * 500,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: size.width * 50),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.centerLeft,
                                                        end:
                                                            Alignment.centerRight,
                                                        colors: [
                                                          Color(0xff3174FF),
                                                          Color(0xff1C3AEA),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  size.width *
                                                                      38.0))),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '确定',
                                                    style: TextStyle(
                                                        fontSize: size.width * 36,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: Container(
                              height: size.width * 60,
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(size.width * 30.0)),
                                  color: Color(0xffEDFAF3)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/sp@2x.png',
                                    height: size.width * 41,
                                    width: size.width * 41,
                                  ),
                                  Text(
                                    !isAppro
                                        ? "承诺中"
                                        : operable == 1
                                            ? '审批'
                                            : '审批进行中',
                                    style: TextStyle(
                                      fontSize: size.width * 29,
                                      color: Color(0xff16BA63),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () async {
                            Counter _counter =
                                Provider.of<Counter>(myContext, listen: false);
                            _counter.emptySubmitDates();
                            Navigator.pushNamed(
                                myContext, '/home/work/WorkTicker',
                                arguments: {
                                  "circuit": value['executionFlow'] == 8
                                      ? value['executionFlow'] + 1
                                      : value['executionFlow'],
                                  "id": value['flowId'],
                                  "operable": false,
                                  "bookId": value['bookId'],
                                  "executionMemo": value['executionMemo']
                                });
                          },
                          child: Container(
                              height: size.width * 60,
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 30.0)),
                                  color: Color(0xffE9F0FF)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/ck@2x.png',
                                    height: size.width * 32,
                                    width: size.width * 51,
                                  ),
                                  Text(
                                    '查看',
                                    style: TextStyle(
                                      fontSize: size.width * 29,
                                      color: Color(0xff236DFF),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                );
              }),
          WaitWorkStruck(
              title: '变更监护人',
              value: 0,
              isclick: false,
              url: Interface.getWorkChangeGuardianList,
              widget: (value, fun) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value['workName'],
                      style: TextStyle(
                          fontSize: size.width * 28,
                          color: Color(0xff3074FF),
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: size.width * 2,
                      width: double.infinity,
                      color: Color(0xffEFEFEF),
                      margin: EdgeInsets.symmetric(vertical: size.width * 20),
                    ),
                    Text(
                      '当前监护人:  ${value['beforeChangeUser']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    Text(
                      '属地单位:  ${value['territorialUnit']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '作业区域:  ${value['region']}',
                      style: TextStyle(
                          color: Color(0xff7D7D7D), fontSize: size.width * 23),
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '涉及作业:  ',
                          style: TextStyle(
                              color: Color(0xff7D7D7D),
                              fontSize: size.width * 23),
                        ),
                        Text(value['workType'],
                            style: TextStyle(
                                color: Color(0xff7D7D7D),
                                fontSize: size.width * 23)),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 10,
                    ),
                    Text(
                      '变更原因:  ${value['changeMemo']}',
                      style: TextStyle(
                        color: Color(0xff7D7D7D),
                        fontSize: size.width * 23,
                      ),
                    ),
                    SizedBox(
                      height: size.width * 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            myDio.request(
                                type: 'put',
                                url: Interface.putWorkGuardian,
                                data: {
                                  'id': value['id'],
                                  'isAgree': 1
                                }).then((value) {
                              successToast("成功!");
                              Navigator.pop(myContext);
                              fun();
                            });
                          },
                          child: Container(
                              height: size.width * 60,
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 30.0)),
                                  color: Color(0xffEDFAF3)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.done,
                                      color: Color(0xff16BA63),
                                      size: size.width * 40),
                                  Text(
                                    '确认',
                                    style: TextStyle(
                                      fontSize: size.width * 29,
                                      color: Color(0xff16BA63),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            String turnDownMemo = '';
                            WorkDialog.myDialog(context, () {}, 2,
                                widget: Column(
                                  children: [
                                    Text('驳回原因',
                                        style: TextStyle(
                                            color: Color(0xff0059FF),
                                            fontSize: size.width * 36)),
                                    Container(
                                        margin: EdgeInsets.all(20),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 20,
                                            vertical: size.width * 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xffF1F5FD)),
                                        child: Stack(
                                          children: [
                                            TextField(
                                              minLines: 3,
                                              maxLines: 5,
                                              autofocus: true,
                                              style: TextStyle(
                                                  fontSize: size.width * 30),
                                              onChanged: (value) =>
                                                  turnDownMemo = value,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "请填写更改监护人原因"),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Image.asset(
                                                  'assets/images/changeGrantionbj@2x.png',
                                                  width: size.width * 36,
                                                  height: size.width * 36,
                                                ))
                                          ],
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          myDio.request(
                                              type: 'put',
                                              url: Interface.putWorkGuardian,
                                              data: {
                                                'id': value['id'],
                                                'isAgree': 2,
                                                'turnDownMemo': turnDownMemo
                                              }).then((value) {
                                            successToast("成功!");
                                            Navigator.pop(myContext);
                                            fun();
                                          });
                                        },
                                        child: Text('确定'))
                                  ],
                                ));
                          },
                          child: Container(
                              height: size.width * 60,
                              width: size.width * 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 30.0)),
                                  color: Color(0xffE9F0FF)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.close,
                                      color: Color(0xff236DFF),
                                      size: size.width * 40),
                                  Text(
                                    '驳回',
                                    style: TextStyle(
                                      fontSize: size.width * 29,
                                      color: Color(0xff236DFF),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                );
              })
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('待办项'),
      child: Container(
          // padding: EdgeInsets.all(size.width * 0),
          child: data.isNotEmpty
              ? DataTree(data: data, way: widget.way)
              : Container()),
    );
  }
}

class DataTree extends StatefulWidget {
  DataTree({@required this.data, this.way, this.layui, this.title});
  final List<WaitWorkStruck> data;
  final int way;
  final Map layui;
  final String title;
  @override
  _DataTreeState createState() => _DataTreeState();
}

class _DataTreeState extends State<DataTree> {
  List<WaitWorkStruck> tempData = [];

  @override
  void initState() {
    super.initState();
    tempData = widget.data;
    if (widget.way is int) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _jumpNextPage(widget.way);
      });
    }
  }

  _jumpNextPage(int index) {
    if (tempData[index].title == '企业风险研判承诺') {
      Navigator.pushNamed(context, '/index/waitWork/promise');
      return;
    }
    if (tempData[index].title == '应急值守') {
      Navigator.pushNamed(context, '/index/waitWork/onDuty');
      return;
    }

    if (tempData[index].custom is Widget) {
      Navigator.pushNamed(context, '/index/waitWork/chatList');
    } else {
      if (tempData[index].data == null) {
        Navigator.pushNamed(context, '/index/waitWork/commonPage', arguments: {
          "url": tempData[index].url,
          "title": tempData[index].title,
          // 'buttonList': tempData[index].widget,
          // 'dropList': tempData[index].dr,
          'widget': tempData[index].widget,
        }).then((value) {
          context
              .read<Counter>()
              .emptyNotity(name: widget.title, account: tempData[index].title);
        });
      } else {
        if (tempData[index].isclick) {
          tempData = widget.data;
        } else {
          List deepData = [];
          tempData = [];
          widget.data.forEach((element) {
            WaitWorkStruck maps = WaitWorkStruck();
            maps.title = element.title;
            maps.custom = element.custom;
            maps.data = element.data;
            maps.isclick = element.isclick;
            maps.url = maps.url;
            maps.value = maps.value;
            maps.widget = maps.widget;
            deepData.add(maps);
          });

          tempData.add(deepData[index]);
          tempData[0].isclick = true;
        }
        setState(() {});
      }
    }
  }

  _getImage(String title) {
    switch (title) {
      case '作业':
        return 'assets/images/zy@2x.png';
        break;
      case '应急值守':
        return 'assets/images/yj@2x.png';
        break;
      case '企业风险研判承诺':
        return 'assets/images/qy@2x.png';
        break;
      case '聊天':
        return 'assets/images/lt@2x.png';
        break;
      case '作业审批':
        return 'assets/images/zysp@2x.png';
        break;
      case '作业人及监护人承诺':
        return 'assets/images/zyr@2x.png';
        break;
      case '作业承诺':
        return 'assets/images/zycn@2x.png';
      case '变更监护人':
        return 'assets/images/bg@2x.png';
        break;
      default:
        return 'assets/images/zy@2x.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = size.width;
    return ListView.builder(
      shrinkWrap: true,
      // padding: EdgeInsets.all(size.width * 40),
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                _jumpNextPage(index);
              },
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: size.width * 10),
                padding: EdgeInsets.symmetric(
                    vertical: width * 30, horizontal: width * 40),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 20),
                      child: Image.asset(
                        _getImage(tempData[index].title.toString()),
                        height: size.width * 55,
                        width: size.width * 52,
                      ),
                    ),
                    Container(
                      width: size.width * 2,
                      height: size.width * 70,
                      color: Color(0xffEBEEEF),
                      margin: EdgeInsets.only(
                          left: size.width * 10, right: size.width * 40),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Text(
                          tempData[index].title.toString(),
                          style: TextStyle(
                              fontSize: size.width * 26,
                              color: Color(0xff262626),
                              fontWeight: FontWeight.bold),
                        ),
                        context.watch<Counter>().notity[widget.title] is Map
                            ? widget.layui[tempData[index].title] != null
                                ? Positioned(
                                    right: -size.width * 30,
                                    top: -size.width * 28,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      padding: EdgeInsets.all(size.width * 5),
                                      child: Text(
                                        context
                                            .watch<Counter>()
                                            .notity[widget.title]
                                            .length
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                                : Container()
                            : context
                                    .watch<Counter>()
                                    .notity[tempData[index].title] is Map
                                ? Positioned(
                                    right: -size.width * 30,
                                    top: -size.width * 28,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      padding: EdgeInsets.all(size.width * 5),
                                      child: Text(
                                        context
                                            .watch<Counter>()
                                            .notity[tempData[index].title]
                                            .length
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                                : Container()
                      ],
                    ),
                    Spacer(),
                    Icon(
                      !tempData[index].isclick
                          ? Icons.keyboard_arrow_right
                          : Icons.keyboard_arrow_down,
                      color: placeHolder,
                      size: width * 60,
                    )
                  ],
                ),
              ),
            ),
            tempData[index].data != null && tempData[index].isclick
                ? DataTree(
                    data: tempData[index].data,
                    layui: context
                        .watch<Counter>()
                        .notity[tempData[index].title.toString()],
                    title: tempData[index].title,
                  )
                : Container()
          ],
        );
      },
      itemCount: tempData.length,
    );
  }
}
