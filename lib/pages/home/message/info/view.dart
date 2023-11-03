import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/message.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/date.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/file/widget/item.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class MessageInfoPage extends StatelessWidget {

  final MessageBean? data;
  
  MessageInfoPage({this.data});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data?.title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: [
              Html(data: data?.content ?? '')
                  .paddingSymmetric(vertical: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("创建人:${data?.creator ?? ''}"),
                  Text(
                      "创建时间：${data?.createTime == null ? "" : stampTime(data?.createTime)}"),
                ],
              ).paddingSymmetric(vertical: 10),
              divider1Px(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: (data?.attachFiles ?? []).map((e) {
                  return Column(
                    children: [
                      FileListItemChild(attachFiles: e),
                      dividerSolid1Px(indent: 15)
                    ],
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
