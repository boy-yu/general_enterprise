import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';
// import 'package:scan/scan.dart';

class EwmOutPutInStorage extends StatefulWidget {
  EwmOutPutInStorage({this.warehouse});
  final String warehouse;
  @override
  _EwmOutPutInStorageState createState() => _EwmOutPutInStorageState();
}

class _EwmOutPutInStorageState extends State<EwmOutPutInStorage> {
  // ScanController controller = ScanController();

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text(widget.warehouse + '入库'),
      child: Container(
        // width: 250, // custom wrap size
        // height: 250,
        // child: ScanView(
        //   controller: controller,
        //   scanAreaScale: .7,
        //   scanLineColor: Colors.green.shade400,
        //   onCapture: (data) {
        //     // do something
        //   },
        // ),
      ),
      // ScanView(
      //     controller: controller,
      //     scanAreaScale: 0.9,
      //     scanLineColor: Colors.black,
      //     onCapture: (String data) async {
      //       // player.play('scanSucceed.mp3');
      //       controller.resume();
      //     },
      //   ),
    );
  }
}

class QRScannerPageConfig {
  double scanAreaSize;
  Color scanLineColor;

  QRScannerPageConfig(
      {this.scanAreaSize: 1.0,
      this.scanLineColor: const Color.fromRGBO(4, 184, 67, 1)});
}

class DividerHorizontal extends StatelessWidget {
  final double height;
  final Color color;

  DividerHorizontal({this.height: 1, this.color: const Color(0xFFF8F9F8)});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
    );
  }
}