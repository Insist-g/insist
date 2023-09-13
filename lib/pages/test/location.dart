import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/permission.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class GDLocation extends StatefulWidget {
  @override
  _GDLocationState createState() => new _GDLocationState();
}

class _GDLocationState extends State<GDLocation> {
  Map<String, Object>? _locationResult;

  StreamSubscription<Map<String, Object>>? _locationListener;

  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  @override
  void initState() {
    super.initState();

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    /// <b>必须保证在调用定位功能之前调用， 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// [hasContains] 隐私声明中是否包含高德隐私政策说明
    ///
    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// <b>必须保证在调用定位功能之前调用, 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 动态申请定位权限
    requestPermission();

    ///设置Android和iOS的apiKey<br>
    ///key的申请请参考高德开放平台官网说明<br>
    ///Android: https://lbs.amap.com/api/android-location-sdk/guide/create-project/get-key
    ///iOS: https://lbs.amap.com/api/ios-location-sdk/guide/create-project/get-key
    AMapFlutterLocation.setApiKey("28cb4afe1972b1391a393a685c9cee6a", "");

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      setState(() {
        _locationResult = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    ///移除定位监听
    if (null != _locationListener) {
      _locationListener?.cancel();
    }

    ///销毁定位
    _locationPlugin.destroy();
  }

  ///设置定位参数
  void _setLocationOption() {
    AMapLocationOption locationOption = new AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);
  }

  ///开始定位
  void _startLocation() {
    ///开始定位之前设置定位参数
    _setLocationOption();
    _locationPlugin.startLocation();
  }

  ///停止定位
  void _stopLocation() {
    _locationPlugin.stopLocation();
  }

  Container _createButtonContainer() {
    return new Container(
        alignment: Alignment.center,
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new ElevatedButton(
              onPressed: _startLocation,
              child: new Text('开始定位'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
            new Container(width: 20.0),
            new ElevatedButton(
              onPressed: _stopLocation,
              child: new Text('停止定位'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            )
          ],
        ));
  }

  Widget _resultWidget(key, value) {
    return new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            alignment: Alignment.centerRight,
            width: 100.0,
            child: new Text('$key :'),
          ),
          new Container(width: 5.0),
          new Flexible(child: new Text('$value', softWrap: true)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    widgets.add(_createButtonContainer());

    if (_locationResult != null) {
      _locationResult?.forEach((key, value) {
        widgets.add(_resultWidget(key, value));
      });
    }

    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('AMap Location plugin example app'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    ));
  }

  ///获取iOS native的accuracyAuthorization类型
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
        await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}

class FLMap extends StatefulWidget {
  const FLMap({Key? key}) : super(key: key);

  @override
  State<FLMap> createState() => _FLMapState();
}

class _FLMapState extends State<FLMap> {
  final String Key = '9640a1797b85caa77fef86ccea6947a1';
  late MapController _mapController;
  Position? position;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    PermissionUtil.getLocationStatus().then((value) async {
      if (value)
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high)
            .then((value) => setState(() => position = value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: position == null
          ? Center(child: Text("loading.."))
          : Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                        'This is a map that is showing (${position!.latitude}, ${position!.longitude}).'),
                  ),
                  Flexible(
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        //WGS84
                        //中心点
                        initialCenter:
                            LatLng(position!.latitude, position!.longitude),
                        //第一次加载缩放大小
                        initialZoom: 15,
                        maxZoom: 18,
                        //查看地图的限制
                        cameraConstraint: CameraConstraint.contain(
                          bounds: LatLngBounds(
                            const LatLng(-90, -180),
                            const LatLng(90, 180),
                          ),
                        ),
                        // onTap: (TapPosition tapPosition, LatLng point) {
                        //   Log().d(
                        //       tapPosition.toString() +
                        //           "--- LatLng:" +
                        //           point.toJson().toString(),
                        //       tag: 'onTap');
                        // },
                        // onLongPress: (TapPosition tapPosition, LatLng point) {
                        //   Log().d(
                        //       tapPosition.toString() +
                        //           "--- LatLng:" +
                        //           point.toJson().toString(),
                        //       tag: 'onLongPress');
                        // },
                        onMapEvent: (MapEvent e) {
                          Log().d(e.source.name, tag: 'onMapEvent');
                        },
                        onMapReady: () {
                          Log().d('', tag: 'onMapReady');
                        },
                        // onPointerCancel: (
                        //   PointerCancelEvent event,
                        //   LatLng point,
                        // ) {
                        //   Log().d(
                        //       event.toString() +
                        //           "--- LatLng:" +
                        //           point.toJson().toString(),
                        //       tag: 'onPointerCancel');
                        // },
                        // onPointerDown: (PointerDownEvent event, LatLng point) {
                        //   Log().d(
                        //       event.toString() +
                        //           "--- LatLng:" +
                        //           point.toJson().toString(),
                        //       tag: 'onPointerDown');
                        // },
                        // onPointerHover:
                        //     (PointerHoverEvent event, LatLng point) {
                        //   Log().d(
                        //       event.toString() +
                        //           "--- LatLng:" +
                        //           point.toJson().toString(),
                        //       tag: 'onPointerHover');
                        // },
                        // onPointerUp: (PointerUpEvent event, LatLng point) {
                        //   Log().d(
                        //       event.toString() +
                        //           "--- LatLng:" +
                        //           point.toJson().toString(),
                        //       tag: 'onPointerUp');
                        // },
                        // onPositionChanged:
                        //     (MapPosition position, bool hasGesture) {
                        //   Log().d(
                        //       position.toString() +
                        //           "--- hasGesture:" +
                        //           hasGesture.toString(),
                        //       tag: 'onPointerUp');
                        // },
                        // onSecondaryTap:
                        //     (TapPosition tapPosition, LatLng point) {
                        //   Log().d(
                        //       tapPosition.toString() +
                        //           "--- LatLng:" +
                        //           point.toJson().toString(),
                        //       tag: 'onSecondaryTap');
                        // },
                      ),
                      //与[children]相同，除了这些不受地图旋转的影响
                      nonRotatedChildren: [
                        RichAttributionWidget(
                          popupInitialDisplayDuration:
                              const Duration(seconds: 5),
                          animationConfig: const ScaleRAWA(),
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              // onTap: () => launchUrl(
                              //   Uri.parse('https://openstreetmap.org/copyright'),
                              // ),
                            ),
                            const TextSourceAttribution(
                              'This attribution is the same throughout this app, except where otherwise specified',
                              prependCopyright: false,
                            ),
                          ],
                        ),
                      ],
                      children: [

                        TileLayer(
                          urlTemplate:
                              'http://t{s}.tianditu.gov.cn/vec_w/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&markers=116.34867,39.94593|116.42626,39.94731|116.4551,39.90267|116.43381,39.86766|116.34249,39.87178|116.32807,39.90748&LAYER=vec&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=9640a1797b85caa77fef86ccea6947a1',
                          userAgentPackageName: 'cn.com.guobaoyou.insist',
                          subdomains: ['0', '1', '2', '3', '4', '5', '6', '7'],
                        ),
                        // TileLayer(
                        //   urlTemplate:
                        //       'http://t{s}.tianditu.gov.cn/cva_w/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=cva&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=9640a1797b85caa77fef86ccea6947a1',
                        //   userAgentPackageName: 'cn.com.guobaoyou.insist',
                        //   subdomains: ['0', '1', '2', '3', '4', '5', '6', '7'],
                        // ),
                        // TileLayer(
                        //   urlTemplate:
                        //       'http://t{s}.tianditu.gov.cn/ibo_w/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=ibo&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=9640a1797b85caa77fef86ccea6947a1',
                        //   userAgentPackageName: 'cn.com.guobaoyou.insist',
                        //   subdomains: ['0', '1', '2', '3', '4', '5', '6', '7'],
                        // ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(
                                  position!.latitude, position!.longitude),
                              builder: (ctx) => InkWell(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.greenAccent,
                                ),
                                onTap: () {
                                  Log().d(_mapController.zoom.toString());
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
