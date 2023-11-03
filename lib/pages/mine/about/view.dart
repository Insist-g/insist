import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/decoration.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于系统"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: AppDecoration.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(width: 80, height: 80, "assets/images/logo.png"),
                  SizedBox(height: 10),
                  Text(APP_NAME,style: AppTextStyle.primary_16_w500,),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
                "该应用是由德州陵城区水务局推出的全市水环境信息公开发布平台，用于向全社会公布本市的河流（涌）河长信息及水质数据，接受群众的监督和建议，推进“水更清”工作开展，宣传水环境保护理念，促进德州市水环境整体改善。"),
            SizedBox(height: 40),
            Text("联系我们",style: AppTextStyle.primary_16_w500),
            SizedBox(height: 10),
            Text("咨询："),
            Text("邮箱："),
          ],
        ),
      ),
    );
  }
}
