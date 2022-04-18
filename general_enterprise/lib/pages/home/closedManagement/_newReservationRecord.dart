import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class NewReservationRecord extends StatefulWidget {
  @override
  State<NewReservationRecord> createState() => _NewReservationRecordState();
}

class _NewReservationRecordState extends State<NewReservationRecord> {
  int type = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 30, vertical: size.width * 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      type = 1;
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        Text(
                          '车辆记录',
                          style: TextStyle(
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: size.width * 10,
                        ),
                        Container(
                          height: size.width * 4,
                          width: size.width * 104,
                          decoration: BoxDecoration(
                              color: type == 1
                                  ? Color(0xFF2E6BFB)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 2.0))),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      type = 2;
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        Text(
                          '人员记录',
                          style: TextStyle(
                            fontSize: size.width * 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: size.width * 10,
                        ),
                        Container(
                          height: size.width * 4,
                          width: size.width * 104,
                          decoration: BoxDecoration(
                              color: type == 1
                                  ? Colors.transparent
                                  : Color(0xFF2E6BFB),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 2.0))),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: type == 1 ? CarOrderRecordList() : PerOrderRecordList(),
        )
      ],
    );
  }
}

class CarOrderRecordList extends StatefulWidget {
  @override
  State<CarOrderRecordList> createState() => _CarOrderRecordListState();
}

class _CarOrderRecordListState extends State<CarOrderRecordList> {
  Widget _getImage(state) {
    switch (state) {
      case 1:
        return Image.asset(
          "assets/images/icon_shtg@2x.png",
          height: size.width * 30,
          width: size.width * 30,
        );
        break;
      case 2:
        return Image.asset(
          "assets/images/icon_shwtg@2x.png",
          height: size.width * 30,
          width: size.width * 30,
        );
        break;
      case 0:
        return Image.asset(
          "assets/images/icon_dsh@2x.png",
          height: size.width * 30,
          width: size.width * 30,
        );
        break;
      default:
        return Container();
    }
  }

  Widget _getText(state) {
    switch (state) {
      case 1:
        return Text(
          '审核通过',
          style: TextStyle(
            color: Color(0xFF3072FE),
            fontSize: size.width * 24,
            fontWeight: FontWeight.bold,
          ),
        );
        break;
      case 2:
        return Text(
          '审核未通过',
          style: TextStyle(
            color: Color(0xFFFF6934),
            fontSize: size.width * 24,
            fontWeight: FontWeight.bold,
          ),
        );
        break;
      case 0:
        return Text(
          '待审核',
          style: TextStyle(
            color: Color(0xFFFFD234),
            fontSize: size.width * 24,
            fontWeight: FontWeight.bold,
          ),
        );
        break;
      default:
        return Text("");
    }
  }

  List<Widget> _getWidget(Map data) {
    switch (data['type']) {
      case 2:   // 普通车辆
        return [
          Padding(
            padding: EdgeInsets.all(size.width * 20),
            child: Row(
              children: [
                Text(
                  '车牌号:' + data['carNo'],
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                _getImage(data['status']),
                SizedBox(
                  width: size.width * 10,
                ),
                _getText(data['status'])
              ],
            ),
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
          ),
          Container(
            padding: EdgeInsets.all(size.width * 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '预计来访时间:${DateTime.fromMillisecondsSinceEpoch(data['visitingTime']).toString().substring(0, 19)}',
                  style: TextStyle(
                      fontSize: size.width * 24, color: Color(0xFF333333)),
                ),
                SizedBox(
                  height: size.width * 19,
                ),
                Text(
                  '驾驶员姓名:${data['name']}',
                  style: TextStyle(
                      fontSize: size.width * 24, color: Color(0xFF333333)),
                ),
                data['state'] == 1
                    ? SizedBox(
                        height: size.width * 19,
                      )
                    : Container(),
                data['state'] == 1
                    ? Text(
                        '未通过理由:${data['result']}',
                        style: TextStyle(
                            fontSize: size.width * 24,
                            color: Color(0xFF333333)),
                      )
                    : Container(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                                  context, '/home/closedManagement/appointment',
                                  arguments: {
                                    'data': data,
                                    'type': ''
                                  });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            right: size.width * 30, top: size.width * 20),
                        child: Text(
                          '再次发起申请',
                          style: TextStyle(
                              color: Color(0xFFFF6934),
                              fontSize: size.width * 24,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/closedManagement/appointmentRecordReview',
                            arguments: {'data': data, 'type': '普通车辆'});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 23,
                            vertical: size.width * 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                                color: Color(0xFF3072FE),
                                width: size.width * 2)),
                        child: Text(
                          '详情',
                          style: TextStyle(
                              color: Color(0xFF3072FE),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ];
        break;
      case 1:   // 危化品车辆
        return [
          Padding(
            padding: EdgeInsets.all(size.width * 20),
            child: Row(
              children: [
                Text(
                  '车牌号:${data['carNo']}',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: size.width * 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                _getImage(data['status']),
                SizedBox(
                  width: size.width * 10,
                ),
                _getText(data['status'])
              ],
            ),
          ),
          Container(
            height: size.width * 1,
            color: Color(0xFFEEEEEE),
          ),
          Container(
            padding: EdgeInsets.all(size.width * 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '预计来访时间:${DateTime.fromMillisecondsSinceEpoch(data['visitingTime']).toString().substring(0, 19)}',
                  style: TextStyle(
                      fontSize: size.width * 24, color: Color(0xFF333333)),
                ),
                SizedBox(
                  height: size.width * 19,
                ),
                Text(
                  '对接人:${data['oppositePerson']}',
                  style: TextStyle(
                      fontSize: size.width * 24, color: Color(0xFF333333)),
                ),
                SizedBox(
                  height: size.width * 19,
                ),
                Text(
                  '对接人电话:${data['oppositeTelephone']}',
                  style: TextStyle(
                      fontSize: size.width * 24, color: Color(0xFF333333)),
                ),
                SizedBox(
                  height: size.width * 19,
                ),
                Text(
                  '运输危险化学品名称:${data['hazardousMaterial']}',
                  style: TextStyle(
                      fontSize: size.width * 24, color: Color(0xFF333333)),
                ),
                SizedBox(
                  height: size.width * 19,
                ),
                Text(
                  '运载状态:${data['carryingStatus'] == 0 ? "空载" : "重载"}',
                  style: TextStyle(
                      fontSize: size.width * 24, color: Color(0xFF333333)),
                ),
                data['state'] == 1
                    ? SizedBox(
                        height: size.width * 19,
                      )
                    : Container(),
                data['state'] == 1
                    ? Text(
                        '未通过理由:${data['result']}',
                        style: TextStyle(
                            fontSize: size.width * 24,
                            color: Color(0xFF333333)),
                      )
                    : Container(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                                  context, '/home/closedManagement/appointment',
                                  arguments: {
                                    'data': data,
                                    'type': ''
                                  });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            right: size.width * 30, top: size.width * 20),
                        child: Text(
                          '再次发起申请',
                          style: TextStyle(
                              color: Color(0xFFFF6934),
                              fontSize: size.width * 24,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/closedManagement/appointmentRecordReview',
                            arguments: {'data': data, 'type': '危化品车辆'});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 23,
                            vertical: size.width * 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                                color: Color(0xFF3072FE),
                                width: size.width * 2)),
                        child: Text(
                          '详情',
                          style: TextStyle(
                              color: Color(0xFF3072FE),
                              fontSize: size.width * 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ];
        break;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 10))),
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 30, vertical: size.width * 20),
              child: Column(
                children: _getWidget(list[index]),
              ),
            ),
        page: true,
        url: Interface.getHistoricalSubscribe,
        listParam: "records",
        queryParameters: {
          'type': 2,
        },
        method: 'get');
  }
}

class PerOrderRecordList extends StatefulWidget {
  @override
  State<PerOrderRecordList> createState() => _PerOrderRecordListState();
}

class _PerOrderRecordListState extends State<PerOrderRecordList> {
  Widget _getImage(state) {
    switch (state) {
      case 1:
        return Image.asset(
          "assets/images/icon_shtg@2x.png",
          height: size.width * 30,
          width: size.width * 30,
        );
        break;
      case 2:
        return Image.asset(
          "assets/images/icon_shwtg@2x.png",
          height: size.width * 30,
          width: size.width * 30,
        );
        break;
      case 0:
        return Image.asset(
          "assets/images/icon_dsh@2x.png",
          height: size.width * 30,
          width: size.width * 30,
        );
        break;
      default:
        return Container();
    }
  }

  Widget _getText(state) {
    switch (state) {
      case 1:
        return Text(
          '审核通过',
          style: TextStyle(
            color: Color(0xFF3072FE),
            fontSize: size.width * 24,
            fontWeight: FontWeight.bold,
          ),
        );
        break;
      case 2:
        return Text(
          '审核未通过',
          style: TextStyle(
            color: Color(0xFFFF6934),
            fontSize: size.width * 24,
            fontWeight: FontWeight.bold,
          ),
        );
        break;
      case 0:
        return Text(
          '待审核',
          style: TextStyle(
            color: Color(0xFFFFD234),
            fontSize: size.width * 24,
            fontWeight: FontWeight.bold,
          ),
        );
        break;
      default:
        return Text("");
    }
  }

  final picker = ImagePicker();

  Future getGalleryImage(int id) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        File _image = File(pickedFile.path);
        uploadImg(_image.path, id);
      } else {
        print('No image selected.');
      }
    });
  }

  ThrowFunc _throwFunc;

  Future<dynamic> uploadImg(String path, int id) async {
    Fluttertoast.showToast(msg: '照片上传中请稍后。。。');
    final res = await Future.delayed(Duration(seconds: 1), () async {
      final res = await Dio().post(
        Interface.uploadUrl,
        data: FormData.fromMap({"file": await MultipartFile.fromFile(path)}),
      );
      return res;
    });
    if (res.data['code'] == 200) {
      myDio.request(type: 'put', url: Interface.putUploadPhotos, data: {
        "id": id,
        "url": res.data['message'],
      }).then((value) {
        successToast('修改成功');
        _throwFunc.run();
      });
      Fluttertoast.showToast(msg: '照片上传成功');
    } else {
      Interface().error({'message': "上传失败"}, context);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return MyRefres(
        child: (index, list) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 10))),
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 30, vertical: size.width * 20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 20),
                    child: Row(
                      children: [
                        Text(
                          '对接人:${list[index]['oppositePerson']}',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: size.width * 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        _getImage(list[index]['status']),
                        SizedBox(
                          width: size.width * 10,
                        ),
                        _getText(list[index]['status'])
                      ],
                    ),
                  ),
                  Container(
                    height: size.width * 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  Container(
                    padding: EdgeInsets.all(size.width * 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '预计来访时间:${DateTime.fromMillisecondsSinceEpoch(list[index]['visitingTime']).toString().substring(0, 19)}',
                          style: TextStyle(
                              fontSize: size.width * 24,
                              color: Color(0xFF333333)),
                        ),
                        SizedBox(
                          height: size.width * 19,
                        ),
                        Text(
                          '对接人电话:${list[index]['oppositeTelephone']}',
                          style: TextStyle(
                              fontSize: size.width * 24,
                              color: Color(0xFF333333)),
                        ),
                        list[index]['status'] == 2
                            ? SizedBox(
                                height: size.width * 19,
                              )
                            : Container(),
                        list[index]['status'] == 2
                            ? Text(
                                '未通过理由:${list[index]['result']}',
                                style: TextStyle(
                                    fontSize: size.width * 24,
                                    color: Color(0xFF333333)),
                              )
                            : Container(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // getGalleryImage();
                                Navigator.pushNamed(
                                  context, '/home/closedManagement/appointment',
                                  arguments: {
                                    'data': list[index],
                                    'type': '人员预约'
                                  });
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    right: size.width * 30,
                                    top: size.width * 20),
                                child: Text(
                                  '再次发起申请',
                                  style: TextStyle(
                                      color: Color(0xFFFF6934),
                                      fontSize: size.width * 24,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            Spacer(),
                            list[index]['isInput'] == 0 &&
                                    list[index]['status'] == 1
                                ? GestureDetector(
                                    onTap: () {
                                      getGalleryImage(list[index]['id']);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 23,
                                          vertical: size.width * 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                          border: Border.all(
                                              color: Color(0xFF3072FE),
                                              width: size.width * 2)),
                                      child: Text(
                                        '重新上传照片',
                                        style: TextStyle(
                                            color: Color(0xFF3072FE),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          '/closedManagement/appointmentRecordReview',
                                          arguments: {
                                            'data': list[index],
                                            'type': '人员预约'
                                          });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 23,
                                          vertical: size.width * 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                          border: Border.all(
                                              color: Color(0xFF3072FE),
                                              width: size.width * 2)),
                                      child: Text(
                                        '详情',
                                        style: TextStyle(
                                            color: Color(0xFF3072FE),
                                            fontSize: size.width * 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        page: true,
        url: Interface.getHistoricalSubscribe,
        listParam: "records",
        queryParameters: {
          'type': 1,
        },
        throwFunc: _throwFunc,
        method: 'get');
  }
}
