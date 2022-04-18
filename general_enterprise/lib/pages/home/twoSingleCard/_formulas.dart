import 'package:enterprise/common/clickImage.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class Formulas extends StatefulWidget {
  @override
  _FormulasState createState() => _FormulasState();
}

class _FormulasState extends State<Formulas> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  List data = [];

  _getData() {
    myDio.request(type: 'get', url: Interface.getTwoCards).then((value) {
      if (value is List) {
        data = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // SingleChildScrollView(
        //                     child: Wrap(
        //                       children: widget.list[i]['data'].map<Widget>((_ele) {
        //                         Color _conColors = _juegeColor(_ele);
        //                         return GestureDetector(
        //                           onTap: () {
        //                             widget.list[i]['value'] = _ele['name'];
        //                             if (_ele['name'] == '查看全部') {
        //                               widget.list[i]['title'] =
        //                                   widget.list[i]['saveTitle'];
        //                             } else {
        //                               widget.list[i]['title'] = _ele['name'];
        //                             }
        //                             if (mounted) {
        //                               setState(() {});
        //                             }
        //                             widget.getDataList();
        //                             Navigator.pop(context);
        //                           },
        //                           child: Container(
        //                             padding: EdgeInsets.symmetric(
        //                                 vertical: size.width * 20),
        //                             decoration: BoxDecoration(
        //                                 color: _conColors,
        //                                 border: Border(
        //                                     bottom: BorderSide(
        //                                         width: 1, color: underColor))),
        //                             child: Center(
        //                               child: Text(
        //                                 _ele['name'],
        //                                 style: TextStyle(
        //                                     fontSize: size.width * 30,
        //                                     color: _conColors.toString() ==
        //                                             'Color(0xff2674fd)'
        //                                         ? Colors.white
        //                                         : Colors.black),
        //                               ),
        //                             ),
        //                           ),
        //                         );
        //                       }).toList(),
        //                     ),
        //                   );
        MyRefres(
            child: (index, list) => Container(
                  margin: EdgeInsets.only(
                      top: size.width * 20,
                      left: size.width * 15,
                      right: size.width * 15),
                  padding: EdgeInsets.all(size.width * 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1.0,
                            spreadRadius: 1.0)
                      ]),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 350,
                            child: Text(
                              '口诀名称：${data[index]['title']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: size.width * 30,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 30,
                          ),
                          Text('适用部门：${data[index]['name']}',style: TextStyle(
                                fontSize: size.width * 26,
                              ),)
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: size.width * 150,
                        width: size.width * 150,
                        padding: EdgeInsets.all(size.width * 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0)
                            ]),
                        child: list[index]['imageUrl'] != null &&
                                list[index]['imageUrl'] != ""
                            ? ClickImage(
                                list[index]['imageUrl'],
                                // fit: BoxFit.cover,
                                // width: size.width * 100,
                              )
                            : Container(
                                height: size.width * 100,
                                width: size.width * 100,
                                alignment: Alignment.center,
                                color: Color(0xffF9F9F9),
                                child: Text('暂无图片'),
                              ),
                      )
                    ],
                  ),
                ),

            // Container(
            //       // margin: EdgeInsets.symmetric(horizontal: size.width * 100, vertical: size.width * 20),
            //       // padding: EdgeInsets.symmetric(vertical: size.width * 10),
            //       // height: size.width * 300,
            //       width: size.width * 100,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.all(Radius.circular(size.width * 20)),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black12,
            //       blurRadius: 1.0,
            //       spreadRadius: 1.0
            //     )
            //   ]
            // ),
            // child: list[index]['imageUrl'] != null &&
            //         list[index]['imageUrl'] != ""
            //     ?
            //     // ClickImage(
            //     //     list[index]['imageUrl'],
            //     //     // fit: BoxFit.cover,
            //     //     width: size.width * 50,
            //     //     height: size.width * 50,
            //     //     // width: width,
            //     //   )
            //     Image.network(
            //       list[index]['imageUrl'],
            //       width: size.width * 50,
            //         height: size.width * 50,
            //     )
            //     : Container(
            //         height: size.width * 194,
            //         width: size.width * 50,
            //         alignment: Alignment.center,
            //         color: Color(0xffF9F9F9),
            //         child: Text('暂无图片'),
            //       ),
            //     ),
            url: Interface.getTwoCards,
            method: 'get');
  }
}
