// import 'dart:convert';

// import 'package:enterprise/common/myAppbar.dart';
// import 'package:enterprise/common/myCustomColor.dart';
// import 'package:enterprise/pages/home/work/history/workBase.dart';
// import 'package:enterprise/service/context.dart';
// import 'package:enterprise/tool/funcType.dart';
// import 'package:flutter/material.dart';

// class CustomWorkPlan extends StatefulWidget {
//   CustomWorkPlan({@required this.circuit});
//   final int circuit;
//   @override
//   _CustomWorkPlanState createState() => _CustomWorkPlanState();
// }

// class _CustomWorkPlanState extends State<CustomWorkPlan> {
//   List data = [];
//   List<bool> check = [];
//   List allData = [];
//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }

//   _getData() {
//     data.clear();
//     check.clear();
//     print(widget.circuit);
//     WorkDateBase().getData().then((value) {
//       allData = value;
//       value.forEach((element) {
//         data.add(element['plan']);
//         check.add(false);
//       });
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MyAppbar(
//       title: Text('我的自定义计划'),
//       child: Column(
//         children: [
//           data.isNotEmpty
//               ? Expanded(
//                   child: ListView.builder(
//                   padding: EdgeInsets.all(size.width * 20),
//                   itemBuilder: (context, index) => Card(
//                     child: Padding(
//                       padding: EdgeInsets.all(size.width * 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   '作业名称: ${data[index][0]['value'].toString()}'),
//                               Text(
//                                   '作业区域: ${data[index][1]['value'].toString()}'),
//                               Text(
//                                   '属地单位: ${data[index][2]['value'].toString()}'),
//                             ],
//                           ),
//                           Checkbox(
//                               value: check[index],
//                               onChanged: (_bool) {
//                                 for (var i = 0; i < check.length; i++) {
//                                   check[i] = false;
//                                 }
//                                 check[index] = _bool;
//                                 setState(() {});
//                               }),
//                         ],
//                       ),
//                     ),
//                   ),
//                   itemCount: data.length,
//                 ))
//               : Expanded(
//                   child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       "assets/images/empty@2x.png",
//                       height: size.width * 288,
//                       width: size.width * 374,
//                     ),
//                     Text('暂无数据')
//                   ],
//                 )),
//           data.isNotEmpty
//               ? Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(themeColor)),
//                       onPressed: () async {
//                         List _tempData = jsonDecode(jsonEncode(data));
//                         int findIndex = check.indexOf(true);

//                         if (findIndex > -1) {
//                           for (var i = 0;
//                               i < _tempData[findIndex].length;
//                               i++) {
//                             if (_tempData[findIndex][i]['title'] == '作业风险辨识人') {
//                               // _riskIdentify = ele['value'];
//                               List _data = [];
//                               for (var j = 0;
//                                   j < _tempData[findIndex][i]['value'].length;
//                                   j++) {
//                                 List<PeopleStructure> _sqlReve =
//                                     await PeopleStructure.getSecharPeople(
//                                         id: _tempData[findIndex][i]['value']
//                                             [j]);
//                                 _data.add({
//                                   'nickname': _sqlReve[0].name,
//                                   'positions': _sqlReve[0].position,
//                                   'id': _tempData[findIndex][i]['value'][j]
//                                 });
//                               }
//                               _tempData[findIndex][i]['value'] = _data;
//                             }
//                             if (_tempData[findIndex][i]['title'] == '作业计划审批人') {
//                               List _data = [];
//                               for (var j = 0;
//                                   j < _tempData[findIndex][i]['value'].length;
//                                   j++) {
//                                 List<PeopleStructure> _sqlReve =
//                                     await PeopleStructure.getSecharPeople(
//                                         id: _tempData[findIndex][i]['value']
//                                             [j]);
//                                 _data.add({
//                                   'nickname': _sqlReve[0].name,
//                                   'positions': _sqlReve[0].position,
//                                   'id': _tempData[findIndex][i]['value'][j]
//                                 });
//                               }
//                               _tempData[findIndex][i]['value'] = _data;
//                             }
//                           }
//                         }
//                         Navigator.pop(context,
//                             findIndex > -1 ? _tempData[findIndex] : null);
//                       },
//                       child: Text('确定'),
//                     ),
//                     ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.red)),
//                       onPressed: () async {
//                         int findIndex = check.indexOf(true);
//                         if (findIndex > -1) {
//                           await WorkDateBase()
//                               .deleteData(allData[findIndex]['id']);
//                           _getData();
//                         }
//                       },
//                       child: Text('删除'),
//                     )
//                   ],
//                 )
//               : Container()
//         ],
//       ),
//     );
//   }
// }
