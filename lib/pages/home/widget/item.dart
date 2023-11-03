import 'package:flutter/cupertino.dart';
import 'package:flutter_ducafecat_news_getx/common/routers/names.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:get/get.dart';

Widget itemRow(
    {String? title, String? num, Color? color, EdgeInsetsGeometry? margin}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    margin: margin,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        color: color),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            title ?? "",
            style: TextStyle(fontSize: 16, color: AppColor.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
          child: Center(
            child: Text(
              num ?? "Ⅰ",
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
