import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class VideoView extends StatefulWidget {

  final double width;
  final double height;
   String videoUrl;
   VideoView({required this.width, required this.height, required this.videoUrl});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {

  late FijkPlayer player;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.videoUrl.isEmpty) widget.videoUrl = 'http://58.56.253.82:7086/live/cameraid/1000005%248/substream/2.m3u8';
    player = FijkPlayer();
    player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);
    startPlay();
  }


  @override
  void dispose() async {
    await player.stop();
    player.dispose();
    super.dispose();
  }

  void startPlay() async {
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    await player.setDataSource(widget.videoUrl, autoPlay: false).catchError((e) {
      print("setDataSource error: $e");
    });
  }


  @override
  Widget build(BuildContext context) {
    return FijkView(
      width: widget.width,
      height: widget.height,
      player: player,
      color: Colors.black,
      panelBuilder: fijkPanel2Builder(snapShot: false,doubleTap: false),
      fsFit: FijkFit.fill,
      // panelBuilder: simplestUI,
    );
  }
}
