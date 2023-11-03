import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logic.dart';

class VideoInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(VideoInfoLogic());
    return Scaffold(
      appBar: AppBar(
        title: Text("监控详情"),
      ),
      body: GetBuilder<VideoInfoLogic>(builder: (logic) {
        return Column(
          children: [
            FijkView(
              width: Get.width,
              height: 300,
              player: logic.player,
              color: Colors.black,
              panelBuilder: fijkPanel2Builder(snapShot: false,doubleTap: false),
              fsFit: FijkFit.fill,
              // panelBuilder: simplestUI,

            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.crop), Text("截图")],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.stop_circle_outlined), Text("录制")],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.view_headline), Text("历史图像")],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_drop_up,
                      size: 40,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_left,
                          size: 40,
                        ),
                        Icon(
                          Icons.camera,
                          size: 40,
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 40,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("-"),
                    Text("缩放").marginSymmetric(horizontal: 20),
                    Text("+"),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ))
          ],
        );
      }),
    );
  }
}
