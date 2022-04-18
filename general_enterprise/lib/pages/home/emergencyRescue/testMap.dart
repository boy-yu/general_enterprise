import 'package:enterprise/common/myAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
// import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart'
//     show BMFCoordinate, BMFEdgeInsets;
// import 'package:flutter_bmfmap/BaiduMap/map/bmf_map_controller.dart';
// import 'package:flutter_bmfmap/BaiduMap/map/bmf_map_view.dart';
// import 'package:flutter_bmfmap/BaiduMap/models/bmf_map_options.dart';

class TestMap extends StatefulWidget {
  @override
  _TestMapState createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(39.917215, 116.380341),
      zoomLevel: 12,
      mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onBMFMapCreated(BMFMapController controller) {}
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Text('百度地图'),
      child: BMFMapWidget(
        onBMFMapCreated: (controller) {
          onBMFMapCreated(controller);
        },
        mapOptions: mapOptions,
      ),
    );
  }
}
