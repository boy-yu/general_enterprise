import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';
// import 'package:scan/scan.dart';
// import 'package:audioplayers/audio_cache.dart';

class ProductStorage extends StatefulWidget {
  ProductStorage({this.warehouse});
  final String warehouse;
  @override
  _ProductStorageState createState() => _ProductStorageState();
}

class _ProductStorageState extends State<ProductStorage> {
  // ScanController controller = ScanController();

  // 初始化
  // AudioCache player = AudioCache();

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.warehouse.toString() + '入库'),
      child: Container(),
      // ScanView(
      //   controller: controller,
      //   scanAreaScale: 0.5,
      //   scanLineColor: Colors.black,
      //   onCapture: (String data) async {
      //     // player.play('scanSucceed.mp3');
      //     controller.resume();
      //   },
      // ),
    );
  }
}