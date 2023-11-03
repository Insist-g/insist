import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';

import 'divider.dart';

/// 透明背景 AppBar
AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title != null
        ? Center(
            child: title,
          )
        : null,
    leading: leading,
    actions: actions,
  );
}

/// 10像素 Divider
Widget divider20Px({Color bgColor = AppColor.grayBackground, double? height}) {
  return Container(
    height: height ?? 20,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}

Widget divider1Px(
    {double height = 1,
    double? indent = 0,
    Color bgColor = AppColor.dividerColor}) {
  return Divider(
      height: height, indent: indent, endIndent: indent, color: bgColor);
}

Widget dividerSolid1Px({double indent = 0}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: indent),
    height: 1,
    child: CustomPaint(
      painter: DashedLinePainter(
          color: AppColor.dividerColor, strokeWidth: 1, gapWidth: 4),
    ),
  );
}

Widget dividerVertical({
  double width = 5,
  double height = 20,
  color = AppColor.primaryBackground,
  margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
}) {
  return Container(
    width: width,
    height: height,
    margin: margin,
    decoration: BoxDecoration(
      borderRadius: Radii.k3pxRadius,
      color: color,
    ),
  );
}

Widget sliverMargin(
    {required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding}) {
  return SliverToBoxAdapter(
    child: Container(
      margin: margin ?? EdgeInsets.only(top: 20),
      padding: padding,
      child: child,
    ),
  );
}
