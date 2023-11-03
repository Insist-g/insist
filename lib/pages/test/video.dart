// import 'dart:io';
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class ChewieDemo extends StatefulWidget {
//   const ChewieDemo({
//     Key? key,
//     this.title = 'Chewie Demo',
//   }) : super(key: key);
//
//   final String title;
//
//   @override
//   State<StatefulWidget> createState() {
//     return _ChewieDemoState();
//   }
// }
//
// class _ChewieDemoState extends State<ChewieDemo> {
//   late VideoPlayerController _videoPlayerController1;
//   ChewieController? _chewieController;
//   int? bufferDelay;
//
//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController1.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }
//
//   String srcs =
//       "http://58.56.253.82:7086/live/cameraid/1000005%248/substream/2.m3u8";
//
//   Future<void> initializePlayer() async {
//     _videoPlayerController1 = VideoPlayerController.networkUrl(Uri.parse(srcs));
//
//     await _videoPlayerController1.initialize();
//     _videoPlayerController1.addListener(() {
//
//     });
//     _createChewieController();
//     setState(() {});
//   }
//
//   void _createChewieController() {
//     _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController1,
//         isLive: true,
//         progressIndicatorDelay:
//             bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
//         hideControlsTimer: const Duration(seconds: 1),
//         errorBuilder: (context, errorMessage) {
//           return Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(Icons.error_outline, color: Colors.white,),
//                 Text(errorMessage),
//                 TextButton(child: Text("点我重试"),onPressed: (){
//                 })
//               ],
//             ),
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: _chewieController != null &&
//                 _chewieController!.videoPlayerController.value.isInitialized
//             ? Chewie(
//                 controller: _chewieController!,
//               )
//             : const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 20),
//                   Text('Loading'),
//                 ],
//               ),
//       ),
//     );
//   }
// }
