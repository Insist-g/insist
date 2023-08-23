import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String url;
  final String? title;
  final String? jsParameter;

  const WebPage({required this.url, this.title, this.jsParameter});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
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
      // ..loadFlutterAsset('assets/html/test.html');
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.title == null
          ? null
          : AppBar(
              title: Text(widget.title!),
            ),
      floatingActionButton: IconButton(
        icon: Icon(AlIcon.logo, size: 30),
        onPressed: () => _callHtmlMethodWithParam(),
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
            if (widget.title == null)
              Positioned(
                  top: 0,
                  left: 20,
                  child: IconButton(
                    color: Colors.black,
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Get.back(),
                  ))
          ],
        ),
      ),
    );
  }

  NavigationDelegate _buildNavigationDelegate() {
    return NavigationDelegate(
      onProgress: (int progress) =>
          Log().d(progress.toString(), tag: 'onProgress'),
      onPageStarted: (String url) =>
          Log().d('Page started loading: $url', tag: 'onPageStarted'),
      onWebResourceError: (error) =>
          Log().d(error.toString(), tag: 'onWebResourceError'),
      onPageFinished: (String url) {
        setState(() => isLoading = false);
        _webViewController.runJavaScript(
            'receiveParameter("初始化，传入html参数:${widget.jsParameter}");');
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
    const parameter = 'flutter 调用js方法并传入参数';
    await _webViewController.runJavaScript('callHtmlMethod("$parameter");');
  }
}
