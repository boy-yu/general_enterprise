import 'package:enterprise/common/CustomEcharts.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class HiddenPicture extends StatefulWidget {
  HiddenPicture({Key key, this.queryParameters}) : super(key: key);
  final Map queryParameters;
  @override
  _HiddenPictureState createState() => _HiddenPictureState();
}

class _HiddenPictureState extends State<HiddenPicture>
    with AutomaticKeepAliveClientMixin {
  List<TogglePicType> titleBar = [
    TogglePicType(
        title: "当前隐患控制情况",
        data: [
          XAxisSturct(names: "受控项", color: Color(0xff31CB72), nums: 0),
          XAxisSturct(names: "不受控", color: Color(0xffFE7A92), nums: 0),
        ],
        totalNum: 0),
    TogglePicType(
        title: "排查异常处置情况",
        data: [
          XAxisSturct(names: "待确认", color: Color(0xffFB681E), nums: 0),
          XAxisSturct(names: "待整改", color: Color(0xffFBAC51), nums: 0),
          XAxisSturct(names: "待审批", color: Color(0xffFCD073), nums: 0),
        ],
        totalNum: 0),
  ];
  int choosed = 0;
  int x = 0;

  //  今日排查落实进度
  Future<TogglePicTypedata> _getImplementationStatistics() async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[0].data);
    widget.queryParameters['controlType'] = 1;
    final value = await myDio.request(
        type: 'get',
        url: Interface.getImplementationStatistics,
        queryParameters: Map<String, dynamic>.from(widget.queryParameters));

    if (value is Map) {
      _data.data[0].nums = value['controlledNum'] * 1.0;
      _data.data[1].nums = value['uncontrolledNum'] * 1.0;
      _data.totalNum = value['totalNum'];
    }
    return _data;
  }

  // 排查异常处置情况
  Future<TogglePicTypedata> _getDisposalDiddenDangersStatistics() async {
    TogglePicTypedata _data = TogglePicTypedata(data: titleBar[1].data);
    final value = await myDio.request(
        type: 'get',
        url: Interface.getDisposalDiddenDangersStatistics,
        queryParameters: Map<String, dynamic>.from(widget.queryParameters));

    if (value is Map) {
      _data.data[0].nums = value['confirmedNum'] * 1.0;
      _data.data[1].nums = value['rectificatioNum'] * 1.0;
      _data.data[2].nums = value['approveNum'] * 1.0;
      _data.totalNum = value['confirmedNum'] +
          value['rectificatioNum'] +
          value['approveNum'];
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: EdgeInsets.only(
            left: size.width * 20,
            right: size.width * 10,
            top: size.width * 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width * 20),
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(.2),
            )),
        child: CustomEchart().togglePic(
            data: titleBar,
            centerChild: '控制总数',
            onpress: (index) async {
              if (index == 0) return await _getImplementationStatistics();
              return await _getDisposalDiddenDangersStatistics();
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
