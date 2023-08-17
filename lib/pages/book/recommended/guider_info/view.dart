import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/book.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/security.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:get/get.dart';
import 'index.dart';

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
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date?.title ?? "",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "${countLengthWithoutPunctuation(date?.str ?? "")}字",
                            style: TextStyle(
                                fontSize: 12, color: AppColor.secondaryText)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(date?.str ?? ""),
                    if (date?.image != null && (date?.image ?? "").isNotEmpty)
                      netImageCached(date!.image!,
                              width: Get.width, height: Get.width / 2)
                          .marginSymmetric(vertical: 10)
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
