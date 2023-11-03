import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 缓存图片
Widget netImageCached(
  String url, {
  double width = 48,
  double height = 48,
  double radius = 6,
  EdgeInsetsGeometry? margin,
  netImageCachedType type = netImageCachedType.def,
  bool overlay = false, //遮罩层
}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: type == netImageCachedType.avatar
            ? BorderRadius.circular(100)
            : BorderRadius.all(Radius.circular(radius)),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          colorFilter: overlay
              ? ColorFilter.mode(Color(0x33000000), BlendMode.darken)
              : null,
        ),
      ),
    ),
    placeholder: (context, url) {
      return Container(
        alignment: Alignment.center,
        child: SpinKitFadingCube(size: 30, color: AppColor.mainColor),
      );
    },
    errorWidget: (context, url, error) => SizedBox(
      width: width,
      height: height,
      child: type == netImageCachedType.def
          ? Center(
              child: Icon(Icons.error),
            )
          : ClipOval(
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
    ),
  );
}

enum netImageCachedType { def, avatar }
