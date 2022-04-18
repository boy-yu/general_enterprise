import 'package:enterprise/common/refreshList.dart';
import 'package:enterprise/service/context.dart';
import 'package:enterprise/tool/funcType.dart';
import 'package:enterprise/tool/interface.dart';
import 'package:flutter/material.dart';

class GasDectList extends StatefulWidget {
  final int bookId;
  const GasDectList({Key key, this.bookId}) : super(key: key);
  @override
  _GasDectListState createState() => _GasDectListState();
}

class _GasDectListState extends State<GasDectList> {
  ThrowFunc _throwFunc = ThrowFunc();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 30, vertical: size.width * 40),
      child: MyRefres(
        child: (index, list) => GasList(list[index], () {
          _throwFunc.run();
        }),
        url: Interface.getGasList,
        throwFunc: _throwFunc,
        method: 'get',
        queryParameters: {"bookId": widget.bookId},
      ),
    );
  }
}

class GasList extends StatelessWidget {
  final Map data;
  final Function callCack;
  const GasList(this.data, this.callCack, {Key key}) : super(key: key);

  String _generateImage(String icon) {
    String iconUrl = '';
    switch (icon) {
      case '动火作业':
        iconUrl = 'assets/images/icon_fire_check.png';

        break;
      case '临时用电':
        iconUrl = 'assets/images/icon_electric_check.png';

        break;
      case '吊装作业':
        iconUrl = 'assets/images/icon_hoisting_check.png';

        break;
      case '高处作业':
        iconUrl = 'assets/images/icon_height_check.png';

        break;
      case '受限空间':
        iconUrl = 'assets/images/icon_limitation_check.png';

        break;
      case '盲板抽堵':
        iconUrl = 'assets/images/icon_blind_plate_wall_check.png';

        break;
      case '动土作业':
        iconUrl = 'assets/images/icon_soil_check.png';

        break;
      case '断路作业':
        iconUrl = 'assets/images/icon_turnoff_check.png';

        break;
      default:
        iconUrl = 'assets/images/icon_hoisting_check.png';
    }
    return iconUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 1)
      ]),
      child: Row(
        children: [
          Image.asset(_generateImage(data['workName'].toString()),
              width: size.width * 75, height: size.width * 85),
          SizedBox(width: size.width * 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['workName'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6D9FFD),
                      fontSize: size.width * 40)),
              SizedBox(
                width: size.width * 300,
                child: Text(
                    data['detectionDate'] != null
                        ? '上次检测时间：\n${data['detectionDate']}'
                        : data['portableDetectionint'] == 1
                            ? '请完成便携式气体检测'
                            : '请完成取样检测',
                    style: TextStyle(
                        color: data['detectionDate'] != null
                            ? Color(0xff6D9FFD)
                            : Colors.black.withOpacity(.6),
                        fontSize: size.width * 24)),
              )
            ],
          ),
          Spacer(),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff6D9FFD)),
                padding: MaterialStateProperty.all(EdgeInsets.all(0))),
            onPressed: () {
              Navigator.pushNamed(context, '/home/work/gasDetection',
                  arguments: {
                    "title":
                        data['portableDetectionint'] == 1 ? '便携式检测' : '取样检测',
                    "detectionSite": data['detectionSite'] as List,
                    "id": data['id'],
                    "type": 2
                  }).then((value) => callCack());
            },
            child: Text(
              '填写数据',
              style: TextStyle(fontSize: size.width * 24),
            ),
          )
        ],
      ),
    );
  }
}
