import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/pages/home/hiddenDanger/__hiddenDepartment.dart';
import 'package:enterprise/pages/home/hiddenDanger/interface.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class FireOLList extends StatefulWidget {
  const FireOLList({
    this.iconList,
    this.choosed,
    this.title,
    this.queryParameters,
  });
  final List<HiddenDangerInterface> iconList;
  final int choosed;
  final String title;
  final Map queryParameters;
  @override
  _FireOLListState createState() => _FireOLListState();
}

class _FireOLListState extends State<FireOLList> {
  List data = [
    {
      "uncontrolledNum": 0,
      "riskItem": "",
      "id": -1,
      "controlledNum": 0,
      "riskPoint": "",
      "quantity": 0,
      "keyParameterIndex": "",
      "controllable": -1
    }
  ];
  int choose;
  Map<String, dynamic> _queryParameters = {};
  String url = '';
  @override
  void initState() {
    super.initState();
    choose = widget.choosed ?? 0;
    _getData(choose);
  }

  _getData(int choose) async {
    // print(widget.queryParameters);
    if (widget.queryParameters == null) {
      _queryParameters = {
        "oneId": widget.iconList[choose].id,
        "fireType": widget.title
      };
      url = Interface.getFireRiskThreeList;
    } else {
      url = Interface.getFireRiskFour;
      _queryParameters = {"threeId": widget.iconList[choose].id};
    }
    myDio.request(type: 'get', url: url, queryParameters: _queryParameters)
        .then((value) {
      if (value is List) {
        data = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text(widget.iconList[choose].title),
        child: Stack(
          children: [
            data.isNotEmpty ? Container(
                margin: EdgeInsets.only(left: size.width * 90),
                color: Colors.white,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 10, vertical: size.width * 20),
                    itemCount: data.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            if (widget.queryParameters == null) {
                              List<HiddenDangerInterface> _iconList = [];
                              _iconList =
                                  _iconList.changeHiddenDangerInterfaceType(
                                data,
                                title: 'riskItem',
                                id: "id",
                                icon: null,
                                iconWidget: null,
                              );
                              _iconList[index].color = Colors.white;
                              Navigator.pushNamed(
                                  context, '/fireControl/fireOLLIst',
                                  arguments: {
                                    'iconList': _iconList,
                                    "title": data[index]['riskItem'],
                                    "choosed": index,
                                    "queryParameters": {"threeId": data[index]['id']}
                                  });
                            }
                          },
                          child: PersonDefense(
                            data: data[index],
                            que: widget.queryParameters,
                          )
                        ))) : Container(),
            LeftBar(
              iconList: widget.iconList,
              callback: (index) {
                choose = index;
                _getData(choose);
                setState(() {});
              },
            )
          ],
        ));
  }
}

class PersonDefense extends StatelessWidget {
  PersonDefense({this.data, this.que});
  final Map data, que;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: que == null
            ? Padding(
                padding: EdgeInsets.all(size.width * 30),
                child: Row(
                  children: [
                    Container(
                      width: size.width * 200,
                      child: Text(
                        data['riskItem'].toString(),
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: size.width * 26,
                            fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 20,
                    ),
                    Text(
                      '设施共${data['uncontrolledNum'].toString() + data['controlledNum'].toString()}项',
                      style: TextStyle(
                          color: Color(0xff3073FE), fontSize: size.width * 24),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: size.width * 10),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 5, vertical: size.width * 3),
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        data['uncontrolledNum'].toString(),
                        style: TextStyle(color: Colors.white,fontSize: size.width * 22),
                      ),
                    ),
                    Text('不受控',
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: size.width * 20))
                  ],
                ),
            )
            : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
                  child: Row(
                    children: [
                      Text(
                        data['keyParameterIndex'].toString(),
                        style: TextStyle(
                          fontSize: size.width * 32,
                          color: Color(0xff333333),
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color:  data['controllable'] == 0 ? Color(0xffF4E9E9) : Color(0xffE7F2E7),
                          borderRadius: BorderRadius.all(Radius.circular(size.width * 18))
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 15, vertical: size.width * 5),
                          child: Text(
                            data['controllable'] == 0 ? '不受控' : '受控',
                            style: TextStyle(
                              fontSize: size.width * 24,
                              color: data['controllable'] == 0 ? Color(0xffF91616) : Color(0xff67C23A),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.width * 1,
                  width: double.infinity,
                  color: Color(0xffE8EBF2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 30, vertical: size.width * 20),
                  child: Row(
                    children: [
                      Text(
                        '放置区域：',
                        style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: size.width * 26
                        ),
                      ),
                      Text(
                        data['riskPoint'],
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 26
                        ),
                      ),
                      Spacer(),
                      Text(
                        '数量：',
                        style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: size.width * 26
                        ),
                      ),
                      Text(
                        data['quantity'].toString(),
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: size.width * 26
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        // child: Padding(
        //   padding: EdgeInsets.all(size.width * 20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         que == null
        //           ? data['riskItem'].toString()
        //           : data['riskPoint'].toString()),
        //         que != null
        //           ? Text(
        //               data['keyParameterIndex'].toString(),
        //               style: TextStyle(color: themeColor),
        //             )
        //           : Container(),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           Row(
        //             children: [
        //               Container(
        //                 margin: EdgeInsets.only(right: size.width * 10),
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: size.width * 5, vertical: size.width * 3),
        //                 decoration: BoxDecoration(
        //                     color: Colors.red, shape: BoxShape.circle),
        //                 child: Text(
        //                   que == null
        //                       ? data['uncontrolledNum'].toString()
        //                       : data['quantity'].toString(),
        //                   style: TextStyle(color: Colors.white),
        //                 ),
        //               ),
        //               Text('不合规',
        //                   style: TextStyle(
        //                       color: Colors.black.withOpacity(.6),
        //                       fontSize: size.width * 20))
        //             ],
        //           ),
        //           Row(
        //             children: [
        //               Container(
        //                 margin: EdgeInsets.only(right: size.width * 10),
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: size.width * 5, vertical: size.width * 3),
        //                 decoration: BoxDecoration(
        //                     color: Color(0xffFAD400), shape: BoxShape.circle),
        //                 child: Text(
        //                   que == null
        //                       ? data['controlledNum'].toString()
        //                       : data['controllable'].toString(),
        //                   style: TextStyle(color: Colors.white),
        //                 ),
        //               ),
        //               Text('合规',
        //                   style: TextStyle(
        //                       color: Colors.black.withOpacity(.6),
        //                       fontSize: size.width * 20))
        //             ],
        //           )
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
