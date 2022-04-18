import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/productList/__postListDetails.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class CheckPostList extends StatefulWidget {
  @override
  _CheckPostListState createState() => _CheckPostListState();
}

class _CheckPostListState extends State<CheckPostList> {
  ThrowFunc _throwFunc = ThrowFunc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyRefres(
        padding: EdgeInsets.all(10),
        child: (index, data) => PostDetail(data: data[index], i: index, button: 1,callback: (){
          _throwFunc.run();
        }),
        throwFunc: _throwFunc,
        url: Interface.getRoleReportList,
        method: 'get');
  }
}

// class CheckPostItem extends StatelessWidget {
//   CheckPostItem(this.dataMap, this.callback);
//   final Map dataMap;
//   final Function callback;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: () {
//           if (dataMap['traceable'] == 1) {
//             Navigator.pushNamed(context, '/index/productList/checkPostGuard',
//                 arguments: {
//                   "title": dataMap['title'],
//                   "status": dataMap['status'],
//                   "type": dataMap['type'],
//                   "rolesId": dataMap['rolesId'],
//                   "userId": dataMap['userId'],
//                 });
//           } else {
//             Fluttertoast.showToast(msg: '此数据无法操作');
//           }
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     child: Text(
//                   dataMap['title'].toString(),
//                   style: TextStyle(
//                       color:
//                           dataMap['status'] == 1 ? placeHolder : Colors.black),
//                 )),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: size.width * 20),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         border: Border.all(width: 1, color: themeColor)),
//                     padding: EdgeInsets.all(size.width * 8),
//                     child: Text(
//                       dataMap['status'] == 1 ? '已完成' : '待签收',
//                       style: TextStyle(
//                           fontSize: size.width * 20,
//                           color: dataMap['status'] == 1
//                               ? Color(0xff5FC754)
//                               : themeColor),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ));
//   }
// }
