import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/book.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:get/get.dart';
import 'index.dart';

//https://www.jianshu.com/p/b5292ef7c38c 吸顶效果
class GuiderInfoPage extends GetView<GuiderInfoController> {
  final GuiderWord? guiderWord;
  const GuiderInfoPage(this.guiderWord, {Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("${guiderWord?.content?.fold(0, (int sum, item) => sum + countLengthWithoutPunctuation(item.str ?? ""))} 字")
            .marginOnly(right: 20),
        Expanded(
          child: ListView.builder(
              itemCount: guiderWord?.content?.length,
              itemBuilder: (context, index) {
                final date = guiderWord?.content?[index];
                final List<String>? imageList = guiderWord?.content
                    ?.where((item) => (item.image ?? "").isNotEmpty)
                    .map((item) => item.image!)
                    .toList();
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          date?.title ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            "${countLengthWithoutPunctuation(date?.str ?? "")}字",
                            style: TextStyle(
                                fontSize: 12, color: AppColor.secondaryText)),
                      ],
                    ),
                    SizedBox(height: 5),
                    SelectableText(
                      date?.str ?? "",
                      style: TextStyle(fontSize: 15),
                    ),
                    if ((date?.image ?? "").isNotEmpty)
                      InkWell(
                        child: Hero(
                          child: date!.image!.startsWith('http')
                              ? netImageCached(date.image!,
                                      width: Get.width, height: Get.width / 2)
                                  .marginSymmetric(vertical: 10)
                              : Image.asset(date.image!,
                                  width: Get.width, height: Get.width / 2),
                          tag: index.toString(),
                        ),
                        onTap: () {
                          final int _index =
                              imageList?.indexOf(date.image ?? "") ?? -1;
                          Utils.showViewBigPhoto(
                              images: imageList ?? [],
                              heroTag: index.toString(),
                              index: _index == -1 ? 0 : _index);
                        },
                      )
                    else
                      SizedBox(
                        height: 5,
                      ),
                  ],
                );
              }).marginSymmetric(vertical: 10, horizontal: 20),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuiderInfoController>(
      init: GuiderInfoController(),
      id: "guider_info",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(guiderWord?.name ?? "")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
