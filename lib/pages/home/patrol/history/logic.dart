import 'package:flutter_ducafecat_news_getx/common/entities/book.dart';
import 'package:get/get.dart';

class PatrolHistoryLogic extends GetxController with StateMixin<List<Example>> {
  bool isEdit = false;

  final testData = [
    {
      "name": "题西林子点位",
      "switch": [
        {
          "title": "水闸是否正常",
          "select": false,
        },
        {
          "title": "水闸前是否有垃圾堆积",
          "select": true,
        },
        {
          "title": "点位摄像头是否损坏",
          "select": false,
        },
        {
          "title": "点位传感器是否损坏",
          "select": true,
        }
      ],
      "remark": "阿克苏结婚登记拉回到那打卡见识到了就好大课间活动啦收到了姐啊姐点链接啊很冷静的考虑",
      "images": [
        "https://lmg.jj20.com/up/allimg/4k/s/02/2109250006343S5-0-lp.jpg",
        "https://img2.baidu.com/it/u=3853345508,384760633&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1200",
        "https://img0.baidu.com/it/u=1604010673,2427861166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889"
      ],
    },
    {
      "name": "西北后村点位",
      "switch": [
        {
          "title": "水闸是否正常",
          "select": false,
        },
        {
          "title": "水闸前是否有垃圾堆积",
          "select": true,
        },
        {
          "title": "点位摄像头是否损坏",
          "select": true,
        },
        {
          "title": "点位传感器是否损坏",
          "select": false,
        }
      ],
      "remark": "阿克苏结婚登记拉回到那打卡见识到了就好大课间活动啦收到了姐啊姐点链接啊很冷静的考虑",
      "images": [
        "https://lmg.jj20.com/up/allimg/4k/s/02/2109250006343S5-0-lp.jpg",
        "https://img2.baidu.com/it/u=3853345508,384760633&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1200",
        "https://img0.baidu.com/it/u=1604010673,2427861166&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
        "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
      ],
    }
  ];

  @override
  void onReady() {
    change(testData.map((e) => Example.fromJson(e)).toList(),
        status: RxStatus.success());
  }

  rightTap() {
    this.isEdit = !this.isEdit;
    update();
  }

  switchChange(value){

  }
}
