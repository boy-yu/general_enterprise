import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enterprise/common/myAppbar.dart';
import 'package:enterprise/common/myCustomColor.dart';
import 'package:enterprise/service/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, BMFEdgeInsets;
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';

class EmergencyRescueRim extends StatefulWidget {
  @override
  _EmergencyRescueRimState createState() => _EmergencyRescueRimState();
}

class _EmergencyRescueRimState extends State<EmergencyRescueRim> {
  BMFMapOptions mapOptions;
  BMFMapController _controller;

  BaiduLocation _baiduLocation;
  LocationFlutterPlugin _locationPlugin = LocationFlutterPlugin();
  StreamSubscription<Map<String, Object>> _locationListener;
  @override
  void initState() {
    super.initState();
    _locationPlugin.requestPermission();

    _locationListener =
        _locationPlugin.onResultCallback().listen((Map<String, Object> result) {
      try {
        _baiduLocation = BaiduLocation.fromMap(result);
        _controller.showUserLocation(true);
        _controller.updateMapOptions(BMFMapOptions(
            center: BMFCoordinate(
                _baiduLocation.latitude, _baiduLocation.longitude)));
        BMFCoordinate coordinate =
            BMFCoordinate(_baiduLocation.latitude, _baiduLocation.longitude);

        BMFLocation location = BMFLocation(
            coordinate: coordinate,
            altitude: 0,
            horizontalAccuracy: 5,
            verticalAccuracy: -1.0,
            speed: -1.0,
            course: -1.0);

        BMFUserLocation userLocation = BMFUserLocation(
          location: location,
        );
        _controller?.updateLocationData(userLocation);
        _locationPlugin.stopLocation();
        _locationListener?.cancel();
      } catch (e) {
        print(e);
      }
    });

    _init();
  }

  void _setLocOption() {
    /// android 端设置定位参数
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
    androidOption.setScanspan(1000); // 设置发起定位请求时间间隔

    Map androidMap = androidOption.getMap();

    /// ios 端设置定位参数
    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    iosOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    iosOption.setBMKLocationCoordinateType(
        "BMKLocationCoordinateTypeBMK09LL"); // 设置返回的位置坐标系类型
    iosOption.setActivityType("CLActivityTypeAutomotiveNavigation"); // 设置应用位置类型
    iosOption.setLocationTimeout(10); // 设置位置获取超时时间
    iosOption.setDesiredAccuracy("kCLLocationAccuracyBest"); // 设置预期精度参数
    iosOption.setReGeocodeTimeout(10); // 设置获取地址信息超时时间
    iosOption.setDistanceFilter(100); // 设置定位最小更新距离
    iosOption.setAllowsBackgroundLocationUpdates(true); // 是否允许后台定位
    iosOption.setPauseLocUpdateAutomatically(true); //  定位是否会被系统自动暂停

    Map iosMap = iosOption.getMap();

    _locationPlugin.prepareLoc(androidMap, iosMap);
  }

  _getServeAdress(String adress) {
    String url =
        'http://api.map.baidu.com/geocoding/v3/?address=$adress&output=json&ak=pX3RnNIHme2N7eqMNgHBYLDyW8spKZAP&mcode=6D:D9:EB:07:59:72:F5:07:8F:78:28:4C:82:7C:12:B4:0D:03:BE:E4;com.example.enterprise';
    // 红牌楼
    Dio().request(url, options: Options(method: 'get')).then((value) {
      final _data = jsonDecode(value.data);
      if (_data is Map) {
        Map _location = _data['result'];
        if (_location != null) {
          _location = _location['location'];
          _controller.addMarker(BMFMarker(
              position: BMFCoordinate(_location['lat'], _location['lng']),
              icon: 'assets/images/806A.png'));
          _controller.updateMapOptions(BMFMapOptions(
              center: BMFCoordinate(_location['lat'], _location['lng'])));
        }
      }
    });
  }

  Map mapLocation = {};
  _init() async {
    _setLocOption();
    _locationPlugin.startLocation();
    mapOptions = BMFMapOptions(
      center: BMFCoordinate(mapLocation['latitude'] ?? 30.647856,
          mapLocation['longitude'] ?? 104.095453),
      zoomLevel: 12,
      mapPadding: BMFEdgeInsets(left: 30, top: 30, right: 30, bottom: 0),
    );
  }

  @override
  void dispose() {
    _locationListener?.cancel();
    super.dispose();
  }

  // 红牌楼
  @override
  Widget build(BuildContext context) {
    return MyAppbar(
        title: Text('周边资源'),
        elevation: 0,
        child: Stack(
          children: [
            BMFMapWidget(
              onBMFMapCreated: (controller) {
                _controller = controller;
              },
              mapOptions: mapOptions,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: lineGradBlue),
              ),
              height: 30,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: -10,
                    child: Container(
                      margin: EdgeInsets.only(left: 25),
                      // padding: EdgeInsets.only(bottom: size.width * 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35)),
                      width: MediaQuery.of(context).size.width - 50,
                      height: size.width * 70,
                      child: TextField(
                        onSubmitted: _getServeAdress,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: size.width * 60,
                                vertical: size.width * 25),
                            border: InputBorder.none,
                            // hintText: '请输入',
                            hintStyle: TextStyle(
                                color: Color(0xff333333),
                                fontSize: size.width * 30),
                            suffix: Text(
                              '资源关键词',
                              style: TextStyle(
                                  color: Color(0xffB3B3B3),
                                  fontSize: size.width * 24),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
