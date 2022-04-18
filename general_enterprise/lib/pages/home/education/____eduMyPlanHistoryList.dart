import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/education/_eduMy.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EduMyStudyPlanHistoryList extends StatefulWidget {
  @override
  _EduMyStudyPlanHistoryListState createState() => _EduMyStudyPlanHistoryListState();
}

class _EduMyStudyPlanHistoryListState extends State<EduMyStudyPlanHistoryList> {
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('考核记录'),
      child: MyRefres(
        child: (index, list) => EduPlayItem(data: list[index]),
        // InkWell(
        //   onTap: () {
        //     Navigator.pushNamed(context, "/home/education/planList", arguments: {'id': list[index]['id']});
        //   },
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(
        //         horizontal: size.width * 20, vertical: size.width * 10),
        //     child: Container(
        //       padding: EdgeInsets.symmetric(
        //           vertical: size.width * 20, horizontal: size.width * 30),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
        //         gradient: LinearGradient(
        //           begin: Alignment.centerLeft,
        //           end: Alignment.centerRight,
        //           colors: [
        //             Color(0xff4FD0A2),
        //             Color(0xff00C181),
        //           ],
        //         ),
        //       ),
        //       child: Row(
        //         children: [
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 list[index]['name'],
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: size.width * 30,
        //                     fontWeight: FontWeight.bold),
        //               ),
        //               Row(
        //                 crossAxisAlignment: CrossAxisAlignment.end,
        //                 children: [
        //                   Container(
        //                       width: size.width * 400,
        //                       child: Text(
        //                           '学习计划主要内容：${list[index]['theme']}',
        //                           style: TextStyle(
        //                               fontSize: size.width * 24,
        //                               color: Colors.white),
        //                           maxLines: 2,
        //                           overflow: TextOverflow.ellipsis)),
        //                   SizedBox(
        //                     width: size.width * 20,
        //                   ),
        //                   InkWell(
        //                     onTap: () {
        //                       showDialog(
        //                           context: context,
        //                           barrierDismissible: true,
        //                           builder: (BuildContext context) {
        //                             return ShowDialog(
        //                                 child: Center(
        //                               child: Container(
        //                                 height: size.width * 500,
        //                                 width: size.width * 690,
        //                                 decoration: BoxDecoration(
        //                                     color: Colors.white,
        //                                     borderRadius: BorderRadius.all(
        //                                         Radius.circular(size.width * 10))),
        //                                 child: Padding(
        //                                   padding: EdgeInsets.symmetric(
        //                                       horizontal: size.width * 20,
        //                                       vertical: size.width * 10),
        //                                   child: Column(
        //                                     children: [
        //                                       Row(
        //                                         children: [
        //                                           Spacer(),
        //                                           InkWell(
        //                                             onTap: () {
        //                                               Navigator.of(context).pop();
        //                                             },
        //                                             child: Icon(
        //                                               Icons.clear,
        //                                               size: size.width * 40,
        //                                               color: Colors.black,
        //                                             ),
        //                                           )
        //                                         ],
        //                                       ),
        //                                       Text(
        //                                         list[index]['name'],
        //                                         style: TextStyle(
        //                                             fontSize: size.width * 36,
        //                                             color: Color(0xff0059FF),
        //                                             fontWeight: FontWeight.bold),
        //                                       ),
        //                                       SizedBox(
        //                                         height: size.width * 30,
        //                                       ),
        //                                       Text(
        //                                         '学习计划主要内容：${list[index]['theme']}',
        //                                         style: TextStyle(
        //                                             fontSize: size.width * 30,
        //                                             color: Color(0xff9D9D9D)),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                             ));
        //                           });
        //                     },
        //                     child: Text(
        //                       '[简介]',
        //                       style: TextStyle(
        //                           fontSize: size.width * 20,
        //                           color: Color(0xff1D3DEB)),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               Text(
        //                 '考核平均分：${list[index]['avgScore']}分',
        //                 style: TextStyle(
        //                     color: Colors.white, fontSize: size.width * 22),
        //               )
        //             ],
        //           ),
        //           Spacer(),
        //           Container(
        //             height: size.width * 47,
        //             width: size.width * 132,
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius:
        //                   BorderRadius.all(Radius.circular(size.width * 23)),
        //             ),
        //             alignment: Alignment.center,
        //             child: Text(
        //               '台账',
        //               style: TextStyle(
        //                   color: Color(0xff00C181), fontSize: size.width * 22),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ), 
        listParam: 'records',
        url: Interface.getMyPlanExaminationBookList, 
        method: 'get'
      )
    );
  }
}