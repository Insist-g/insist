import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/book.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/widgets.dart';
import 'package:flutter_ducafecat_news_getx/pages/book/recommended/guider_info/index.dart';
import 'package:get/get.dart';

class Item extends StatelessWidget {
  final GuiderWord? date;
  const Item({Key? key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: (date?.image?.length ?? 0) > 1 ? _item2() : _item1(),
      ),
      onTap: () {
        if (date?.pdf != null) {
          Utils.toPdfPage(path: date?.pdf ?? "", title: date?.name ?? "");
        } else {
          Get.to(GuiderInfoPage(date));
        }
      },
    );
  }

  _item1() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date?.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryText,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                date?.content?.first.str ?? "",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.secondaryText,
                ),
              ),
            ],
          ),
        ),
        (date?.image?.length ?? 0) > 0
            ? netImageCached(date!.image!.first, width: 120, height: 100)
                .marginOnly(left: 10)
            : SizedBox.shrink(),
      ],
    );
  }

  _item2() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              date?.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryText,
              ),
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: date!.image!
                .map((e) => Container(
                      margin: EdgeInsets.only(right: 10),
                      child: netImageCached(e, height: 80, width: 100),
                    ))
                .toList(),
          ),
        ).marginSymmetric(vertical: 5),
        Text(
          date?.content?.first.str ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: AppColor.secondaryText,
          ),
        ),
      ],
    );
  }
}
