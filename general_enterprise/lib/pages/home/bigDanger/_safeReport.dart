import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueTeamList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SafeReport extends StatefulWidget {
  @override
  _SafeReportState createState() => _SafeReportState();
}

class _SafeReportState extends State<SafeReport> {
  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => Item(list[index]),
        url: Interface.getCoMajorHazardFileList,
        method: 'get');
  }
}

class Item extends StatelessWidget {
  Item(this.data);
  final Map data;
  final List state = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          size.width * 20, size.width * 20, size.width * 20, 0),
      child: InkWell(
        onTap: () {
          if (data['annexUrl'].toString().indexOf('http') > -1) {
            Navigator.pushNamed(context, '/webview', arguments: {
              'url': Interface.online(data['annexUrl']),
              'title': data['title'].toString() ?? ''
            });

            // Navigator.pushNamed(context, '/webview', arguments: {
            //   'url': '${Interface.onlineWork}${data['annexUrl']}',
            //   'title': data['title'].toString()
            // });
          } else {
            Fluttertoast.showToast(msg: '暂无文件');
          }
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(size.width * 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShadowIcon(
                      icon: 'assets/images/apply.png',
                      width: size.width * 70,
                      height: size.width * 70,
                    ),
                    SizedBox(width: size.width * 100),
                    Expanded(
                      child: Text(
                        data['title'].toString(),
                        style: TextStyle(
                            fontSize: size.width * 36,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
