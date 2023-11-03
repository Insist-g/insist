import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/date.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/state_widget.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/message/info/view.dart';
import 'package:get/get.dart';
import 'logic.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MessageLogic());
    return Scaffold(
      appBar: AppBar(
        title: Text("通知公告"),
      ),
      body: GetBuilder<MessageLogic>(builder: (logic) {
        return logic.obx(
          (state) {
            return EasyRefresh(
              controller: logic.refreshController,
              onRefresh: logic.onRefresh,
              onLoad: logic.onLoading,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.primaries[index % 8],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            state?.list?[index].title ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    trailing: Text(
                      stampTimeLineFormat(state?.list?[index].createTime),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    title: Text(
                      state?.list?[index].title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      state?.list?[index].content ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Get.to(() => MessageInfoPage(data: state?.list?[index]));
                    },
                  );
                },
                itemCount: state?.list?.length,
              ),
            );
          },
          onEmpty: StateWidget.empty(),
          onError: (err) => StateWidget.error(),
          onLoading: StateWidget.loading(),
        );
      }),
    );
  }
}
