import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/complain.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/date.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/app.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image_wrap.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/file/widget/item.dart';
import 'package:get/get.dart';

class ComplainInfoPage extends StatelessWidget {
  final ComplainBean? data;

  ComplainInfoPage({required this.data});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.content ?? '',
                textAlign: TextAlign.start,
              ).paddingSymmetric(vertical: 20),
              ImageWrap(
                data: (data?.attachFiles ?? []).map((e) => e.url).toList(),
                enabled: false,
              ),
              SizedBox(height: 10,),
              dividerSolid1Px(),
              Text('备注:${data?.memo ?? ''}',style: AppTextStyle.primary_14, textAlign: TextAlign.start)
                  .paddingSymmetric(vertical: 10),
              dividerSolid1Px(),

              Text('所属河流:${data?.riverName ?? ''}',style: AppTextStyle.secondary_14, textAlign: TextAlign.start)
                  .paddingSymmetric(vertical: 10),
              Text('所属河段:${data?.reachName ?? ''}',style: AppTextStyle.secondary_14, textAlign: TextAlign.start)
                  .paddingSymmetric(vertical: 10),
              dividerSolid1Px(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("举报人:${data?.reporter ?? ''}",style: AppTextStyle.primary_14),
                  // Text(
                  //     "创建时间：${data?.createTime == null ? "" : stampTime(data?.createTime)}",style: AppTextStyle.secondary_14),
                ],
              ).paddingSymmetric(vertical: 10),
            ],
          ),
        ),
      ),
    );
  }
}
