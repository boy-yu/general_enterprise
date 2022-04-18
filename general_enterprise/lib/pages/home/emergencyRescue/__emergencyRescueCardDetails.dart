import 'package:enterprise/common/clickImage.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class EmergencyRescueCardDetails extends StatefulWidget {
  EmergencyRescueCardDetails({this.id});
  final int id;
  @override
  _EmergencyRescueCardDetailsState createState() =>
      _EmergencyRescueCardDetailsState();
}

class _EmergencyRescueCardDetailsState
    extends State<EmergencyRescueCardDetails> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getCardDetailsList();
  }

  _getCardDetailsList() {
    myDio.request(
        type: 'get',
        url: Interface.getSelectCardsByStructureId,
        queryParameters: {"structureId": widget.id}).then((value) {
      if (value is List) {
        data = value;
        for (int i = 0; i < data.length; i++) {
          data[i]['isShow'] = false;
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Map details = {};
  String personnel;

  _getCardDetails(int id) {
    myDio.request(
        type: 'get',
        url: Interface.getShowCardById,
        queryParameters: {
          "structureId": widget.id,
          "cardId": id
        }).then((value) {
      if (value is Map) {
        details = value;
        personnel = '';

        if (details['users'] is List) {
          for (var i = 0; i < details['users'].length; i++) {
            if (i != details['users'].length - 1) {
              personnel += details['users'][i].toString() + '、';
            } else {
              personnel += details['users'][i].toString();
            }
          }
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('处置卡详情'),
      child: data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 15, horizontal: size.width * 20),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * 20,
                                horizontal: size.width * 15),
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * 80,
                                  height: size.width * 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF1F8FF),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: size.width * 36,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 500,
                                      child: Text(
                                        data[index]['disposalCardName'] != null
                                            ? data[index]['disposalCardName']
                                            : '',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: size.width * 30,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.width * 10,
                                    ),
                                    Text(
                                      '使用证持卡人数：' +
                                          data[index]['num'].toString(),
                                      style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: size.width * 28,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    data[index]['isShow'] =
                                        !data[index]['isShow'];
                                    if (data[index]['id'] != null) {
                                      _getCardDetails(data[index]['id']);
                                    }
                                    setState(() {});
                                  },
                                  child: Icon(
                                    data[index]['isShow']
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Color(0xff999999),
                                    size: size.width * 60,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        data[index]['isShow']
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                margin: EdgeInsets.only(top: size.width * 5),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.width * 20,
                                      horizontal: size.width * 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: size.width * 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              details['positiveUrl'] == null ||
                                                      details['positiveUrl'] ==
                                                          ''
                                                  ? Container(
                                                      width: size.width * 310,
                                                      height: size.width * 180,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                    )
                                                  : ClickImage(
                                                      details['positiveUrl'],
                                                      width: size.width * 310,
                                                      fit: BoxFit.cover,
                                                      height: size.width * 180),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Text(
                                                '正面',
                                                style: TextStyle(
                                                    color: Color(0xffCCCCCC),
                                                    fontSize: size.width * 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              details['reverseUrl'] == null ||
                                                      details['reverseUrl'] ==
                                                          ''
                                                  ? Container(
                                                      width: size.width * 310,
                                                      height: size.width * 180,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)
                                                                      )
                                                                ),
                                                                child: Image.asset(
                                                        'assets/images/image_recent_control.jpg',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : ClickImage(
                                                      details['reverseUrl'],
                                                      width: size.width * 310,
                                                      fit: BoxFit.cover,
                                                      height: size.width * 180),
                                              SizedBox(
                                                height: size.width * 10,
                                              ),
                                              Text(
                                                '反面',
                                                style: TextStyle(
                                                    color: Color(0xffCCCCCC),
                                                    fontSize: size.width * 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.width * 20,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '持卡人：',
                                            style: TextStyle(
                                              color: Color(0xff666666),
                                              fontSize: size.width * 28,
                                            ),
                                          ),
                                          details != null &&
                                                  details['users'] is List
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 5),
                                                  width: size.width * 550,
                                                  height: size.width * 200,
                                                  child: ListView(
                                                    children: [
                                                      Text(personnel,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff666666),
                                                            fontSize:
                                                                size.width * 28,
                                                          ),
                                                          maxLines: 100,
                                                          overflow: TextOverflow
                                                              .ellipsis)
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
              })
          : Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: size.width * 100),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/empty@2x.png",
                    height: size.width * 288,
                    width: size.width * 374,
                  ),
                  Text('暂无处置卡')
                ],
              )),
    );
  }
}
