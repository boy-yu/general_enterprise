import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/pages/home/emergencyRescue/__emergencyRescueTeamList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireBaseFile extends StatefulWidget {
  @override
  _FireBaseFileState createState() => _FireBaseFileState();
}

class _FireBaseFileState extends State<FireBaseFile> {
  List state = [
    {'title': '已落实', 'color': Color(0xff3174FF)},
    {'title': '即将过期', 'color': Color(0xffFFB533)},
    {'title': '未落实', 'color': Color(0xffFF5917)}
  ];
  List data = [
    {"title": '防雷检测报告', 'state': 0}
  ];

  //

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('设备设施清单'),
        child: MyRefres(
            child: (index, list) => Padding(
                  padding: EdgeInsets.fromLTRB(
                      size.width * 20, size.width * 20, size.width * 20, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.all(size.width * 20)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        if (list[index]['fileValue'] == '' ||
                            list[index]['fileValue'] == null) {
                          Fluttertoast.showToast(msg: '暂无文件');
                        } else {
                          Navigator.pushNamed(context, '/webview', arguments: {
                            'url': Interface.online(list[index]['fileValue']),
                            'title': list[index]['name']
                          });
                        }
                      },
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ShadowIcon(
                            icon: 'assets/images/fire/_Firefile@2x.png',
                            width: size.width * 50,
                            height: size.width * 50,
                            padding: EdgeInsets.all(size.width * 10),
                          ),
                          SizedBox(
                            width: size.width * 30,
                          ),
                          Text(
                            list[index]['name'].toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          // Text(
                          //   state[list[index]['type']]['title'].toString(),
                          //   style:
                          //       TextStyle(color: state[list[index]['type']]['color']),
                          // )
                        ],
                      )),
                ),
            url: Interface.getFlpsystemList,
            method: 'get')

        //  ListView.builder(
        //     padding: EdgeInsets.all(size.width * 20),
        //     itemCount: data.length,
        //     itemBuilder: (context, index) => RaisedButton(
        //           padding: EdgeInsets.all(size.width * 25),
        //           onPressed: () {
        //             Navigator.pushNamed(context, '/fireControl/FireBaseLookFile');
        //           },
        //           color: Colors.white,
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //             children: [
        //               ShadowIcon(
        //                 'assets/images/fire/Firefile@2x.png',
        //                 width: size.width * 50,
        //                 height: size.width * 50,
        //                 padding: EdgeInsets.all(size.width * 10),
        //               ),
        //               Text(data[index]['title']),
        //               Text(
        //                 state[data[index]['state']]['title'],
        //                 style: TextStyle(
        //                     color: state[data[index]['state']]['color']),
        //               )
        //             ],
        //           ),
        //         )),
        );
  }
}
