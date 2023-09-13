import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/permission.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TDPage extends StatefulWidget {
  const TDPage();

  @override
  State<TDPage> createState() => _TDPageState();
}

class _TDPageState extends State<TDPage> {
  late final WebViewController _webViewController;
  bool isLoading = true; // 设置状态

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(_buildNavigationDelegate())
      ..addJavaScriptChannel("FlutterChannel", onMessageReceived: (message) {
        Log().d('Received message from JavaScript: ${message.message}',
            tag: "😄");
      })
      ..loadFlutterAsset("assets/html/td_map.html");

    // Future.delayed(Duration(seconds:20),()=> getPointLines());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: IconButton(
        icon: Icon(AlIcon.logo, size: 30),
        onPressed: () => getPointLines(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: _webViewController,
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  NavigationDelegate _buildNavigationDelegate() {
    return NavigationDelegate(
      // onProgress: (int progress) =>
      //     Log().d(progress.toString(), tag: 'onProgress'),
      onPageStarted: (String url) =>
          Log().d('Page started loading: $url', tag: 'onPageStarted'),
      onWebResourceError: (error) =>
          Log().d(error.toString(), tag: 'onWebResourceError'),
      onPageFinished: (String url) {
        setState(() => isLoading = false);
        PermissionUtil.getLocationStatus().then((value) async {
          if (value)
            await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high)
                .then((value) {
              final parameter = {
                "latitude": value.latitude,
                "longitude": value.longitude,
              };
              String jsonString = Uri.encodeComponent(jsonEncode(parameter));
              Log().d(parameter.toString());
              _webViewController.runJavaScript('initParameter("$jsonString");');
            });
        });
      },
      onNavigationRequest: (request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

  void _callHtmlMethodWithParam() async {
    _webViewController
      ..clearCache()
      ..reload();
    // const parameter = 'flutter 调用js方法并传入参数';
    // await _webViewController.runJavaScript('callHtmlMethod("$parameter");');
  }

  getPointLines(){
    final parameter = {
      "points" : [
        {
          "latitude": 117.111272,
          "longitude": 36.727387,
        },
        {
          "latitude": 117.087375,
          "longitude": 36.669173,
        },
      ],
      "lines" : [
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
    String jsonString = json.encode(parameter);
    Log().d(jsonString);
    Log().d(parameter.toString());
    _webViewController
        .runJavaScript('getPointLines($jsonString);');
  }
}
