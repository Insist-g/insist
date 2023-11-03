import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                HttpUtil()
                    .uploadFile("/prod-api/app-api/infra/file/upload",
                        "/storage/emulated/0/TunnelDown/3a485be5-a542-4dcd-afc4-c29a4b8b8a34.mp4")
                    .onError((error, stackTrace) {
                  Log().d(error.toString());
                });
              },
              child: Text("上传"))
        ],
      ),
    );
  }
}

class VideoView extends StatefulWidget {
  final String url;
  //是否是封面
  final bool isCover;

  const VideoView({super.key, required this.url, this.isCover = true});

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.url.contains('http')) {
      _controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.url));
    } else {
      _controller = VideoPlayerController.file(File(widget.url));
    }
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                if (widget.isCover)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Color(0x55000000),
                  ),
                Center(
                  child: widget.isCover
                      ? Icon(
                          Icons.video_file,
                          color: AppColor.white,
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                )
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: SpinKitFadingCube(size: 30, color: AppColor.mainColor),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
