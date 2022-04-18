// import 'package:enterprise/common/myAppbar.dart';
// import 'package:enterprise/common/myCustomColor.dart';
// import 'package:enterprise/common/myDateSelect.dart';
// import 'package:enterprise/service/context.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RiskAccountDialog extends StatefulWidget {
//   RiskAccountDialog(
//       {this.title,
//       this.layer,
//       this.callback,
//       this.listTitle,
//       this.listTable,
//       @required this.showRiskAccountDialogDrop,
//       this.id,
//       this.riskItemtoCallback,
//       this.screen,
//       this.dropList,
//       this.accDataMap,
//       this.sign,
//       @required this.noTime});
//   final String title, layer;
//   final Function callback, riskItemtoCallback;
//   final List listTitle, listTable, dropList;
//   final bool showRiskAccountDialogDrop;
//   final int id;
//   final int screen;
//   final Map accDataMap;
//   final String sign;
//   final bool noTime;
//   // dropList [[{'title':"","data":['21','22'],"value":""}]]
//   @override
//   _RiskAccountDialogState createState() => _RiskAccountDialogState();
// }

// class _RiskAccountDialogState extends State<RiskAccountDialog> {
//   List dropList = [
//     {
//       'title': '请选择排查结果',
//       'data': [
//         {'name': '异常'},
//         {'name': '正常'},
//         {'name': '逾期'},
//       ],
//       'value': '',
//       'limit': 'type'
//     },
//   ];

//   dynamic queryParameters = {"size": "30", "type": "1"};
//   List<String> choiceDate = [
//     DateTime.now().year.toString(),
//     DateTime.now().month.toString(),
//     ''
//   ];
//   GlobalKey<_AccountListState> _globalKey = GlobalKey();
//   _changeDrop() {
//     for (var i = 1; i < dropList.length; i++) {
//       if (dropList[i]['title'] != dropList[i]['saveTitle']) {
//         queryParameters[dropList[i]['limit'].toString()] = dropList[i]['title'];
//       } else {
//         queryParameters[dropList[i]['limit']] = null;
//       }
//     }
//     if (dropList[0]['title'] == '与我相关') {
//       queryParameters['type'] = "1";
//     } else {
//       queryParameters['type'] = "0";
//     }
//   }

//   String status;
//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget _getWidget() {
//     if (widget.noTime) {
//       return Container();
//     } else {
//       if (widget.layer == 'item') {
//         if (widget.screen != 1) {
//           return _dropDown();
//         } else {
//           return Container();
//         }
//       } else {
//         return DateSelect(
//           listTitle: widget.listTitle,
//           callbacks: (val) {
//             choiceDate[0] = val['_year'];
//             choiceDate[1] = val['_month'];
//             choiceDate[2] = val['_day'];
//             _globalKey.currentState._getAccountList(choiceDate);
//           },
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MyAppbar(
//       title: Text(widget.title.toString()),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           _getWidget(),
//           widget.layer == 'item' &&
//                   widget.showRiskAccountDialogDrop == true &&
//                   widget.screen != 1
//               ? ResultDropDown(
//                   dropList,
//                   0,
//                   _changeDrop,
//                   callbacks: (val) {
//                     status = val['status'];
//                     _globalKey.currentState._getAccountItemList(
//                         status: status, startDate: startDate, endDate: endDate);
//                   },
//                 )
//               : Container(),
//           SizedBox(
//             height: size.width * 20,
//           ),
//           DropList(
//             dropList: widget.dropList,
//             callback: () {
//               _globalKey.currentState._getAccountItemList(
//                   status: status, startDate: startDate, endDate: endDate);
//             },
//           ),
//           Expanded(
//               child: AccountList(
//                   layer: widget.layer,
//                   choiceDate: choiceDate,
//                   callbacks: widget.callback,
//                   status: status,
//                   startDate: startDate,
//                   ids: widget.id,
//                   accDataMap: widget.accDataMap,
//                   sign: widget.sign,
//                   title: widget.title,
//                   endDate: endDate,
//                   listTitle: widget.listTitle,
//                   listTable: widget.listTable,
//                   riskItemtoCallback: widget.riskItemtoCallback,
//                   key: _globalKey)),
//         ],
//       ),
//     );
//   }

//   String startDate;
//   String endDate;

//   Widget _dropDown() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Expanded(
//           child: MyDateSelect(
//             title: 'startDate',
//             purview: 'startDate',
//             callback: (value) {
//               startDate = value;
//             },
//           ),
//         ),
//         Expanded(
//           child: MyDateSelect(
//             title: 'endDate',
//             purview: 'endDate',
//             callback: (value) {
//               endDate = value;
//               setState(() {});
//               _globalKey.currentState
//                   ._getAccountItemList(startDate: startDate, endDate: endDate);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class DropList extends StatefulWidget {
//   DropList({
//     this.dropList,
//     this.callback,
//   });
//   final List<List> dropList;
//   final Function callback;

//   @override
//   _DropListState createState() => _DropListState();
// }

// class _DropListState extends State<DropList> {
//   List<List> data = [];
//   bool special = false;
//   @override
//   void initState() {
//     super.initState();
//     _distribution();
//   }

//   _distribution() {
//     data = [];
//     if (widget.dropList is List) {
//       for (var i = 0; i < widget.dropList.length; i++) {
//         if (i % 2 == 0) {
//           data.add([]);
//         }
//         widget.dropList[i].forEach((element) {
//           if (element['title'] == '排查结果' ||
//               element['title'] == '点检结果' ||
//               element['title'] == '管控结果') special = true;
//           data[data.length - 1].add(element);
//         });
//       }
//     }
//   }

//   int choosed = 0;
//   // bool show = false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(
//           children: data
//               .asMap()
//               .keys
//               .map((index) => Row(
//                     children: data[index]
//                         .asMap()
//                         .keys
//                         .map((_index) => Expanded(
//                                 child: InkWell(
//                               onTap: () {
//                                 choosed = index + _index;
//                                 setState(() {});
//                                 showModalBottomSheet(
//                                     context: context,
//                                     builder: (_) => SingleChildScrollView(
//                                           child: Column(
//                                             children: data[index][_index]
//                                                     ['data']
//                                                 .asMap()
//                                                 .keys
//                                                 .map<Widget>((__index) =>
//                                                     Center(
//                                                         child: InkWell(
//                                                       onTap: () {
//                                                         data[index][_index]
//                                                             ['value'] = __index;
//                                                         data[index][_index]
//                                                                 ['title'] =
//                                                             data[index][_index]
//                                                                     ['data']
//                                                                 [__index];
//                                                         setState(() {});
//                                                         widget.callback();
//                                                         Navigator.pop(context);
//                                                       },
//                                                       child: Container(
//                                                         decoration: BoxDecoration(
//                                                             border: Border(
//                                                                 bottom: BorderSide(
//                                                                     width: 1,
//                                                                     color:
//                                                                         underColor))),
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 vertical:
//                                                                     size.width *
//                                                                         20),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             Text(data[index][
//                                                                             _index]
//                                                                         ['data']
//                                                                     [__index]
//                                                                 .toString())
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     )))
//                                                 .toList(),
//                                           ),
//                                         ));
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.all(size.width * 10),
//                                 padding: EdgeInsets.all(size.width * 20),
//                                 decoration: BoxDecoration(
//                                     border:
//                                         Border.all(width: 1, color: underColor),
//                                     borderRadius:
//                                         BorderRadius.circular(size.width * 20)),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       data[index][_index]['title'].toString(),
//                                       style: TextStyle(color: placeHolder),
//                                     ),
//                                     Icon(Icons.keyboard_arrow_down)
//                                   ],
//                                 ),
//                               ),
//                             )))
//                         .toList(),
//                   ))
//               .toList(),
//         ),
//         special
//             ? Padding(
//                 padding: EdgeInsets.all(size.width * 20),
//                 child: Row(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: size.width * 20),
//                       color: Color(0xffCBCBCB),
//                       width: size.width * 14,
//                       height: size.width * 14,
//                     ),
//                     Text(
//                       '无隐患',
//                       style: TextStyle(fontSize: size.width * 24),
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: size.width * 20),
//                       color: Color(0xffFBAB00),
//                       width: size.width * 14,
//                       height: size.width * 14,
//                     ),
//                     Text(
//                       '一般隐患',
//                       style: TextStyle(fontSize: size.width * 24),
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: size.width * 20),
//                       color: Color(0xffEB1111),
//                       width: size.width * 14,
//                       height: size.width * 14,
//                     ),
//                     Text(
//                       '重大隐患',
//                       style: TextStyle(fontSize: size.width * 24),
//                     ),
//                   ],
//                 ),
//               )
//             : Container()
//       ],
//     );
//   }
// }

// class DateSelect extends StatefulWidget {
//   const DateSelect({Key key, this.callbacks, this.listTitle}) : super(key: key);
//   final callbacks;
//   final List listTitle;
//   @override
//   _DateSelectState createState() => _DateSelectState();
// }

// class _DateSelectState extends State<DateSelect> {
//   String _year;
//   String _month;
//   String _day;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Container(
//           width: size.width * 200,
//           height: size.width * 60,
//           margin: EdgeInsets.only(top: 10, left: 20),
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Color(0xffD2D2D2),
//             ),
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//           child: _itemYear(TextStyle(
//             color: placeHolder,
//             fontSize: size.width * 32,
//           )),
//         ),
//         Container(
//           width: size.width * 200,
//           height: size.width * 60,
//           margin: EdgeInsets.only(top: 10),
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Color(0xffD2D2D2),
//             ),
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//           child: _itemMonth(TextStyle(
//             color: placeHolder,
//             fontSize: size.width * 32,
//           )),
//         ),
//         Container(
//           width: size.width * 200,
//           height: size.width * 60,
//           margin: EdgeInsets.only(top: 10, right: 20),
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Color(0xffD2D2D2),
//             ),
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//           child: _itemDay(TextStyle(
//             color: placeHolder,
//             fontSize: size.width * 32,
//           )),
//         ),
//       ],
//     );
//   }

//   List<DropdownMenuItem<int>> year = [];
//   int _yearValue;
//   _generateYear() {
//     year = [];
//     month = [];
//     day = [];
//     int cureenYear = DateTime.now().year;
//     for (var i = 0; i < 10; i++) {
//       year.add(DropdownMenuItem(
//         value: cureenYear - i,
//         child: Text((cureenYear - i).toString()),
//       ));
//     }
//   }

//   List<DropdownMenuItem<int>> month = [];
//   int _monthValue;
//   _generateMonth() {
//     month = [];
//     day = [];
//     for (var i = 1; i <= 12; i++) {
//       month.add(DropdownMenuItem(
//         value: i,
//         child: Text((0 + i).toString()),
//       ));
//     }
//   }

//   List<DropdownMenuItem<int>> day = [];
//   int _dayValue;
//   _generateDay(int month, int year) {
//     int days;
//     switch (month) {
//       case 1:
//         days = 31;
//         _getday(days);
//         break;
//       case 2:
//         if (year % 100 != 0) {
//           if (year % 4 == 0) {
//             days = 29;
//           } else {
//             days = 28;
//           }
//         } else {
//           if (year % 400 == 0) {
//             days = 29;
//           } else {
//             days = 28;
//           }
//         }
//         _getday(days);
//         break;
//       case 3:
//         days = 31;
//         _getday(days);
//         break;
//       case 4:
//         days = 30;
//         _getday(days);
//         break;
//       case 5:
//         days = 31;
//         _getday(days);
//         break;
//       case 6:
//         days = 30;
//         _getday(days);
//         break;
//       case 7:
//         days = 31;
//         _getday(days);
//         break;
//       case 8:
//         days = 31;
//         _getday(days);
//         break;
//       case 9:
//         days = 30;
//         _getday(days);
//         break;
//       case 10:
//         days = 31;
//         _getday(days);
//         break;
//       case 11:
//         days = 30;
//         _getday(days);
//         break;
//       case 12:
//         days = 31;
//         _getday(days);
//         break;
//       default:
//     }
//   }

//   _getday(int days) {
//     day = [];
//     for (var i = 1; i <= days; i++) {
//       day.add(DropdownMenuItem(
//         value: i,
//         child: Text((0 + i).toString()),
//       ));
//     }
//   }

//   _itemYear(style) {
//     _generateYear();
//     return DropdownButton(
//       value: _yearValue,
//       icon: Icon(
//         Icons.keyboard_arrow_down,
//         color: Color(0xff898989),
//       ),
//       iconSize: size.width * 40,
//       hint: Padding(
//         padding: EdgeInsets.only(left: size.width * 20),
//         child: Text(
//           '年',
//           style: TextStyle(color: Color(0xff100808), fontSize: size.width * 30),
//         ),
//       ),
//       isExpanded: true,
//       underline: Container(height: 0),
//       style: style,
//       items: year,
//       onChanged: (value) {
//         _yearValue = value;
//         _year = _yearValue.toString();
//         widget.callbacks({'_year': _year, '_month': _month, '_day': _day});
//         setState(() {});
//       },
//     );
//   }

//   _itemMonth(style) {
//     if (_yearValue != null) {
//       _generateMonth();
//     }
//     return DropdownButton(
//       value: _monthValue,
//       icon: Icon(
//         Icons.keyboard_arrow_down,
//         color: Color(0xff898989),
//       ),
//       iconSize: size.width * 40,
//       hint: Padding(
//         padding: EdgeInsets.only(left: size.width * 20),
//         child: Text(
//           '月',
//           style: TextStyle(color: Color(0xff100808), fontSize: size.width * 30),
//         ),
//       ),
//       isExpanded: true,
//       underline: Container(height: 0),
//       style: style,
//       items: month,
//       onChanged: (value) {
//         _monthValue = value;
//         _month = _monthValue > 9
//             ? _monthValue.toString()
//             : '0' + _monthValue.toString();
//         widget.callbacks({'_year': _year, '_month': _month, '_day': _day});
//         setState(() {});
//       },
//     );
//   }

//   _itemDay(style) {
//     if (_monthValue != null) {
//       _generateDay(_monthValue, DateTime.now().year + _yearValue);
//     }
//     return DropdownButton(
//       value: _dayValue,
//       icon: Icon(
//         Icons.keyboard_arrow_down,
//         color: Color(0xff898989),
//       ),
//       iconSize: size.width * 40,
//       hint: Padding(
//         padding: EdgeInsets.only(left: size.width * 20),
//         child: Text(
//           '日',
//           style: TextStyle(color: Color(0xff100808), fontSize: size.width * 30),
//         ),
//       ),
//       isExpanded: true,
//       underline: Container(height: 0),
//       style: style,
//       items: day,
//       onChanged: (value) {
//         _dayValue = value;
//         _day =
//             _dayValue > 9 ? _dayValue.toString() : '0' + _dayValue.toString();
//         widget.callbacks({'_year': _year, '_month': _month, '_day': _day});
//         setState(() {});
//       },
//     );
//   }
// }

// class AccountList extends StatefulWidget {
//   AccountList(
//       {this.layer,
//       this.key,
//       this.choiceDate,
//       this.callbacks,
//       this.status,
//       this.startDate,
//       this.endDate,
//       this.listTitle,
//       this.listTable,
//       this.ids,
//       this.title,
//       this.riskItemtoCallback,
//       this.accDataMap,
//       this.sign})
//       : super(key: key);
//   final String layer, title;
//   final key;
//   final Function callbacks, riskItemtoCallback;
//   final List choiceDate;
//   final String status, startDate, endDate;
//   final List listTitle, listTable;
//   final int ids;
//   final Map accDataMap;
//   final String sign;
//   @override
//   _AccountListState createState() => _AccountListState();
// }

// class _AccountListState extends State<AccountList> {
//   List listTitle = [];
//   List accountList = [];
//   List accountItemList = [];

//   List hiddenStatus = [Color(0xffCBCBCB), Color(0xffFBAB00), Color(0xffEB1111)];
//   List<String> judgeStr = ['无隐患', '一般隐患', '重大隐患'];
//   SharedPreferences prefs;
//   @override
//   void initState() {
//     super.initState();
//     _init();
//     listTitle = ['时间', '正常', '一般隐患', '重大隐患', '逾期'];
//     if (widget.listTitle is List) {
//       listTitle = widget.listTitle;
//     }
//     if (widget.layer == 'item') {
//       _getAccountItemList(
//           status: widget.status,
//           startDate: widget.startDate,
//           endDate: widget.endDate);
//     } else {
//       listTitle = ['时间', '正常', '一般隐患', '重大隐患', '逾期'];
//       _getAccountList(widget.choiceDate);
//     }
//   }

//   _init() async {
//     prefs = await SharedPreferences.getInstance();
//   }

//   _getAccountItemList({status, startDate, endDate}) async {
//     if (widget.callbacks != null) {
//       accountItemList = await widget.callbacks(status, startDate, endDate);
//       // this hidden history detail with things
//       // if (accountList[0]['investigationResults'] is int) showMark = true;
//       setState(() {});
//     }
//   }

//   _getAccountList(choiceDate) async {
//     if (widget.callbacks != null) {
//       accountList = await widget.callbacks(choiceDate, id: widget.ids);
//       setState(() {});
//     }
//   }

//   _clickEvent(int type, int index) {
//     List _split = accountList[index]['dateTime'].split(' ');
//     List _time = [];
//     if (_split.length > 1) {
//       _time = _split[1].toString().split(':');
//     }

//     List _date = accountList[index]['dateTime'].split(' ')[0].split('-');
//     List tempDate = [];
//     _date.forEach((element) {
//       tempDate.add(element);
//     });

//     _time.forEach((element) {
//       tempDate.add(element);
//     });
//     if (tempDate.length > 3) {
//       tempDate[3] = (int.parse(tempDate[3]) + 1).toString();
//     } else {
//       tempDate[tempDate.length - 1] =
//           (int.parse(tempDate[tempDate.length - 1]) + 1).toString();
//     }
//     String endDates = '';
//     for (var i = 0; i < tempDate.length; i++) {
//       if (i < 2) {
//         endDates += tempDate[i] + '-';
//       } else if (i == 2) {
//         if (tempDate[i].length == 1) {
//           endDates += '0' + tempDate[i];
//         } else {
//           endDates += tempDate[i] + ' ';
//         }
//       } else if (i == 3) {
//         endDates += tempDate[i];
//       } else {
//         endDates += ':' + tempDate[i];
//       }
//     }
//     if (tempDate.length == 2) endDates = endDates + '01';

//     String strStartDateTime;
//     if (tempDate.length == 2) {
//       strStartDateTime = accountList[index]['dateTime'].toString() + '-01';
//     } else {
//       strStartDateTime = accountList[index]['dateTime'].toString();
//     }
//     int investigationResults = -1;
//     int status = -1;
//     switch (type) {
//       case 1: // 正常
//         investigationResults = 0;
//         Navigator.pushNamed(context, '/home/risk/riskDetails', arguments: {
//           "accDataMap": widget.accDataMap,
//           'strStartDateTime': strStartDateTime,
//           'endDates': endDates,
//           'investigationResults': investigationResults,
//           'status': status,
//           'sign': widget.sign
//         });
//         break;
//       case 2: // 一般隐患
//         investigationResults = 1;
//         Navigator.pushNamed(context, '/home/risk/riskDetails', arguments: {
//           "accDataMap": widget.accDataMap,
//           'strStartDateTime': strStartDateTime,
//           'endDates': endDates,
//           'investigationResults': investigationResults,
//           'status': status,
//           'sign': widget.sign
//         });
//         break;
//       case 3: // 重大隐患
//         investigationResults = 2;
//         Navigator.pushNamed(context, '/home/risk/riskDetails', arguments: {
//           "accDataMap": widget.accDataMap,
//           'strStartDateTime': strStartDateTime,
//           'endDates': endDates,
//           'investigationResults': investigationResults,
//           'status': status,
//           'sign': widget.sign
//         });
//         break;
//       case 5: // 逾期
//         status = 5;
//         Navigator.pushNamed(context, '/home/risk/riskDetails', arguments: {
//           "accDataMap": widget.accDataMap,
//           'strStartDateTime': strStartDateTime,
//           'endDates': endDates,
//           'investigationResults': investigationResults,
//           'status': status,
//           'sign': widget.sign
//         });
//         break;
//       default:
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//           width: double.infinity,
//           height: size.width * 42,
//           color: Color(0xffECECEC),
//           child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: listTitle
//                   .map(
//                     (ele) => Center(
//                       child: Text(
//                         ele,
//                         style: TextStyle(
//                             color: Color(0xff424242),
//                             fontSize: size.width * 24,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   )
//                   .toList()),
//         ),
//         (widget.layer == 'item' && accountItemList.isNotEmpty) ||
//                 accountList.isNotEmpty
//             ? Expanded(
//                 child: ListView.builder(
//                     itemCount: widget.layer == 'item'
//                         ? accountItemList.length
//                         : accountList.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         padding:
//                             EdgeInsets.symmetric(vertical: size.width * 20),
//                         margin:
//                             EdgeInsets.symmetric(horizontal: size.width * 20),
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(
//                                     color: underColor.withOpacity(0.5),
//                                     width: 1))),
//                         child: widget.listTable == null
//                             ? InkWell(
//                                 onTap: widget.layer == 'item'
//                                     ? () {
//                                         if (widget.layer == 'item') {
//                                           String token =
//                                               prefs.getString('token');
//                                           int id = widget.layer == 'item'
//                                               ? accountItemList[index]['bookId']
//                                               : accountList[index]['bookId'];
//                                           Navigator.pushNamed(
//                                               context, '/webview', arguments: {
//                                             "url":
//                                                 '$webUrl/risk-control-detail?token=$token&id=$id'
//                                           });
//                                         }
//                                       }
//                                     : null,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: <Widget>[
//                                     Center(
//                                       child: Text(
//                                         accountList[index]['dateTime']
//                                             .toString(),
//                                         style: TextStyle(
//                                             color: Color(0xff797979),
//                                             fontSize: size.width * 20),
//                                       ),
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         _clickEvent(1, index);
//                                       },
//                                       child: Container(
//                                         width: size.width * 650 / 5,
//                                         child: Center(
//                                           child: Text(
//                                             accountList[index]['normalNum']
//                                                 .toString(),
//                                             style: TextStyle(
//                                                 color: Color(0xff797979),
//                                                 fontSize: size.width * 20),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         _clickEvent(2, index);
//                                       },
//                                       child: Container(
//                                         width: size.width * 650 / 5,
//                                         child: Center(
//                                           child: Text(
//                                             accountList[index]['generalNum']
//                                                 .toString(),
//                                             style: TextStyle(
//                                                 color: Color(0xff797979),
//                                                 fontSize: size.width * 20),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         _clickEvent(3, index);
//                                       },
//                                       child: Container(
//                                         width: size.width * 650 / 5,
//                                         child: Center(
//                                           child: Text(
//                                             accountList[index]['majorNum']
//                                                 .toString(),
//                                             style: TextStyle(
//                                                 color: Color(0xff797979),
//                                                 fontSize: size.width * 20),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         _clickEvent(5, index);
//                                       },
//                                       child: Container(
//                                         width: size.width * 650 / 5,
//                                         child: Center(
//                                             child: Text(
//                                           accountList[index]['overdueNum']
//                                               .toString(),
//                                           style: TextStyle(
//                                               color: Color(0xff797979),
//                                               fontSize: size.width * 20),
//                                         )),
//                                       ),
//                                     ),
//                                   ],
//                                 ))
//                             : InkWell(
//                                 onTap: () {
//                                   String token = prefs.getString('token');
//                                   int id = widget.layer == 'item'
//                                       ? accountItemList[index]['bookId']
//                                       : accountList[index]['bookId'];
//                                   Navigator.pushNamed(context, '/webview',
//                                       arguments: {
//                                         "url":
//                                             '$webUrl/risk-account-list?token=$token&id=$id&${DateTime.now().microsecondsSinceEpoch.toString()}'
//                                       });

//                                   // hidden-trouble
//                                   // risk-account-list
//                                 },
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: size.width * 10),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: widget.listTable.map(
//                                       (ele) {
//                                         return Container(
//                                           width: size.width * 110,
//                                           child: ele == 'reportingUser'
//                                               ? Row(
//                                                   children: [
//                                                     Container(
//                                                       decoration: BoxDecoration(
//                                                           color: accountItemList[
//                                                                               index]
//                                                                           [
//                                                                           'status'] ==
//                                                                       '待确认' ||
//                                                                   accountItemList[
//                                                                               index]
//                                                                           [
//                                                                           'status'] ==
//                                                                       '逾期' ||
//                                                                   accountItemList[
//                                                                               index]
//                                                                           [
//                                                                           'status'] ==
//                                                                       '待排查'
//                                                               ? Colors.white
//                                                               : hiddenStatus[
//                                                                   accountItemList[
//                                                                           index]
//                                                                       [
//                                                                       'investigationResults']],
//                                                           shape:
//                                                               BoxShape.circle),
//                                                       width: size.width * 12,
//                                                       height: size.width * 12,
//                                                       margin: EdgeInsets.only(
//                                                           right:
//                                                               size.width * 5),
//                                                     ),
//                                                     Text(
//                                                       widget.layer == 'item'
//                                                           ? accountItemList[
//                                                                   index][ele]
//                                                               .toString()
//                                                           : accountList[index]
//                                                                   [ele]
//                                                               .toString(),
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                           color:
//                                                               Color(0xff797979),
//                                                           fontSize:
//                                                               size.width * 20),
//                                                     ),
//                                                   ],
//                                                 )
//                                               : Text(
//                                                   widget.layer == 'item'
//                                                       ? accountItemList[index]
//                                                               [ele]
//                                                           .toString()
//                                                       : accountList[index][ele]
//                                                           .toString(),
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: Color(0xff797979),
//                                                       fontSize:
//                                                           size.width * 20),
//                                                 ),
//                                         );
//                                       },
//                                     ).toList(),
//                                   ),
//                                 ),
//                               ),
//                       );
//                     }),
//               )
//             : Container(
//                 width: double.infinity,
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.only(top: size.width * 150),
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/empty@2x.png",
//                       height: size.width * 288,
//                       width: size.width * 374,
//                     ),
//                     Text('暂无数据'),
//                   ],
//                 )),
//       ],
//     );
//   }
// }

// class ResultDropDown extends StatefulWidget {
//   const ResultDropDown(this.list, this.index, this.getDataList,
//       {Key key, this.callbacks})
//       : super(key: key);
//   final int index;
//   final List list;
//   final Function getDataList;
//   final callbacks;

//   @override
//   _ResultDropDownState createState() => _ResultDropDownState();
// }

// class _ResultDropDownState extends State<ResultDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//         children: widget.list.asMap().keys.map((i) {
//       return Expanded(
//           child: GestureDetector(
//         onTap: () {
//           showBottomSheet(
//               context: context,
//               builder: (_) {
//                 return Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.3),
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         constraints: BoxConstraints(
//                           maxHeight: 200,
//                         ),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children:
//                                 widget.list[i]['data'].map<Widget>((_ele) {
//                               Color _juegeColor() {
//                                 Color _color = widget.list[i]['value'] == '' &&
//                                         _ele['name'] == '查看全部'
//                                     ? themeColor
//                                     : widget.list[i]['value'] == _ele['name']
//                                         ? themeColor
//                                         : Colors.white;
//                                 return _color;
//                               }

//                               Color _conColors = _juegeColor();
//                               return GestureDetector(
//                                 onTap: () {
//                                   widget.list[i]['value'] = _ele['name'];
//                                   if (_ele['name'] == '查看全部') {
//                                     widget.list[i]['title'] =
//                                         widget.list[i]['saveTitle'];
//                                   } else {
//                                     widget.list[i]['title'] = _ele['name'];
//                                   }
//                                   widget.callbacks({
//                                     'status': _ele['name'],
//                                   });
//                                   setState(() {});
//                                   widget.getDataList();
//                                   Navigator.pop(context);
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: size.width * 32),
//                                   decoration: BoxDecoration(
//                                       color: _conColors,
//                                       border: Border(
//                                           bottom: BorderSide(
//                                               width: 1, color: underColor))),
//                                   child: Center(
//                                     child: Text(
//                                       _ele['name'],
//                                       style: TextStyle(
//                                           fontSize: size.width * 30,
//                                           color: _conColors.toString() ==
//                                                   'Color(0xff6ea3f9)'
//                                               ? Colors.white
//                                               : Colors.black),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                       Expanded(child: GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                       ))
//                     ],
//                   ),
//                 );
//               });
//         },
//         child: Container(
//           width: size.width * 618,
//           height: size.width * 80,
//           margin: EdgeInsets.only(
//               top: 10.0, left: size.width * 10.0, right: size.width * 10.0),
//           padding: EdgeInsets.only(
//               left: size.width * 20.0, right: size.width * 10.0),
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Color(0xffD2D2D2),
//             ),
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 widget.list[i]['title'].toString(),
//                 style: TextStyle(
//                     color: Color(0xff898989), fontSize: size.width * 32),
//               ),
//               Icon(
//                 Icons.keyboard_arrow_down,
//                 color: Color(0xff898989),
//               ),
//             ],
//           ),
//         ),
//       ));
//     }).toList());
//   }
// }
