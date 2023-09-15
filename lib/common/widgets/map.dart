import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/permission.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TDMap extends StatefulWidget {
  final TDType type;
  final Function(String)? handleMessage;

  const TDMap({super.key, this.type = TDType.VIEW, this.handleMessage});

  @override
  State<TDMap> createState() => _TDMapState();
}

class _TDMapState extends State<TDMap> {
  late final WebViewController _webViewController;
  bool isLoading = true; // 设置状态
  StreamSubscription<Position>? _positionStream;
  double defLongitude = 117.126542;
  double defLatitude = 36.658634;

  @override
  void initState() {
    super.initState();
    _initWebController();
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          WebViewWidget(
            controller: _webViewController,
          ),
          Column(
            children: [
              ElevatedButton(onPressed: () => htmlGetZoom(), child: Text("getZoom")),
              ElevatedButton(onPressed: () => htmlBackStarting(), child: Text("backStarting")),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  _initWebController() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(_buildNavigationDelegate())
      ..addJavaScriptChannel("FlutterChannel", onMessageReceived: (message) {
        Log().d('Received message from JavaScript: ${message.message}',
            tag: "😄");
      })
      ..loadFlutterAsset("assets/html/td_map.html");
  }

  NavigationDelegate _buildNavigationDelegate() {
    return NavigationDelegate(
      onProgress: (int progress) =>
          Log().d(progress.toString(), tag: 'onProgress'),
      onPageStarted: (String url) =>
          Log().d('Page started loading: $url', tag: 'onPageStarted'),
      onWebResourceError: (error) =>
          Log().d(error.toString(), tag: 'onWebResourceError'),
      onPageFinished: (String url) async {
        if (widget.type == TDType.LOCATION) {
          Log().d("页面加载完成 开始获取位置");
          Position? _position = await _getPosition();
          Log().d("获取位置成功:${_position?.longitude ?? ''}" +
              DateTime.now().toString());
          htmlInitMap(
              latitude: _position?.latitude, longitude: _position?.longitude);
          Future.delayed(Duration(seconds: 10), () {
            _initPositionStream();
            Log().d("开始连续定位" + DateTime.now().toString());
          });
          // _initTimer(_position);
        } else if (widget.type == TDType.VIEW) {
          htmlInitMap();
        }
        setState(() => isLoading = false);
      },
      onNavigationRequest: (request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

  _initPositionStream() {
    _positionStream = Geolocator.getPositionStream(
        locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 50,
            //距离过滤器
            forceLocationManager: true,
            intervalDuration: const Duration(seconds: 30),
            //(Optional) Set foreground notification config to keep the app alive
            //when going to the background
            foregroundNotificationConfig: const ForegroundNotificationConfig(
              notificationText:
              "Example app will continue to receive your location even when you aren't using it",
              notificationTitle: "Running in Background",
              enableWakeLock: true,
            ))).listen(_positionStreamListener);
  }

  _positionStreamListener(Position? position) {
    if (position != null) {
      final jsonString = json.encode({
        "latitude": position.latitude,
        "longitude": position.longitude,
      });
      _webViewController.runJavaScript('pushPosition($jsonString);');
      if (widget.handleMessage != null) {
        widget.handleMessage!(jsonString);
      }
    }
  }

  Future<Position?> _getPosition() async {
    var statuses = await PermissionUtil.getLocationStatus();
    if (statuses) {
      return await Geolocator.getCurrentPosition();
    } else {
      Get.snackbar("Tip:权限提示", "位置权限未开启, 手动开启");
      return null;
    }
  }

  htmlInitMap({double? longitude, double? latitude}) {
    final _parameter = json.encode({
      "longitude": longitude ?? defLongitude,
      "latitude": latitude ?? defLatitude
    });
    _webViewController.runJavaScript('initMap($_parameter);');
  }

  htmlAddPoints(_parameter) {
    _webViewController.runJavaScript('addPoints($_parameter);');
  }

  htmlAddLines(_parameter) {
    _webViewController.runJavaScript('addLines($_parameter);');
  }

  htmlGetZoom() {
    _webViewController.runJavaScript('getZoom();');
  }

  htmlBackStarting() {
    _webViewController.runJavaScript('backStarting();');
  }

}

final pointList = [
  {
    "latitude": 117.111272,
    "longitude": 36.727387,
  },
  {
    "latitude": 117.087375,
    "longitude": 36.669173,
  },
];

final lineList = [
  [
    {
      "longitude": 117.111272,
      "latitude": 36.727387,
    },
    {
      "longitude": 117.111558,
      "latitude": 36.723864,
    },
    {
      "longitude": 117.120972,
      "latitude": 36.725021,
    },
    {
      "longitude": 117.122427,
      "latitude": 36.678291,
    },
    {
      "longitude": 117.126488,
      "latitude": 36.678736,
    },
  ]
];

final parameter = {
  "points": [
    {
      "latitude": 117.111272,
      "longitude": 36.727387,
    },
    {
      "latitude": 117.087375,
      "longitude": 36.669173,
    },
  ],
  "lines": [
    [
      {
        "longitude": 117.111272,
        "latitude": 36.727387,
      },
      {
        "longitude": 117.111558,
        "latitude": 36.723864,
      },
      {
        "longitude": 117.120972,
        "latitude": 36.725021,
      },
      {
        "longitude": 117.122427,
        "latitude": 36.678291,
      },
      {
        "longitude": 117.126488,
        "latitude": 36.678736,
      },
    ]
  ]
};

enum TDType {
  VIEW,
  LOCATION,
}
