import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'index.dart';

class ListenerPage extends GetView<ListenerController> {
  const ListenerPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return Column(
      children: [Expanded(child: _body()), _bottomView()],
    );
  }

  //底部播放工具栏
  Widget _bottomView() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.black12,
            ),
          ),
          Container(
            width: 60,
            height: 60,
            color: Colors.amber,
            margin: EdgeInsets.only(left: 20, bottom: 10),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return AudioPlayerPage();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListenerController>(
      init: ListenerController(),
      id: "listener",
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}

class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  final _player = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(children: [
    AudioSource.asset('assets/audio/penglaigejingqugaikuang.m4a')
    // AudioSource.uri(Uri.parse(
    //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3')),
    // AudioSource.uri(Uri.parse(
    //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3')),
    // AudioSource.uri(Uri.parse(
    //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3')),
  ]);

  @override
  void initState() {
    super.initState();
    _player.setAudioSource(_playlist);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              _player.play().onError((error, stackTrace) =>
                  Log().d((error ?? "").toString(), tag: "onError--"));
            },
          ),
          SizedBox(height: 20),
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: () {
              _player.pause();
            },
          ),
        ],
      ),
    );
  }
}
