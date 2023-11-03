import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/book.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/image_wrap.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/input.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/patrol/history/logic.dart';
import 'package:get/get.dart';

class PatrolHistoryItem extends StatefulWidget {
  final Example? data;

  const PatrolHistoryItem({super.key, required this.data});

  @override
  State<PatrolHistoryItem> createState() => _PatrolHistoryItemState();
}

class _PatrolHistoryItemState extends State<PatrolHistoryItem> {
  final logic = Get.find<PatrolHistoryLogic>();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.data?.remark ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(widget.data?.name ?? ""),
            color: AppColor.dividerColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Column(
                children: (widget.data?.aswitch ?? []).map((e) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.title ?? ""),
                  Switch(
                    value: e.select ?? false,
                    onChanged: logic.isEdit
                        ? (value) {
                            e.select = value;
                            logic.update();
                          }
                        : null,
                  )
                ],
              );
            }).toList()),
          ),
          Container(
            width: double.infinity,
            child: Text("巡察结果备注"),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: EditText(
              lines: 10,
              isShowDelete: false,
              enabled: logic.isEdit,
              controller: _controller,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text("照片"),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ImageWrap(
                data: widget.data?.images,
                enabled: logic.isEdit,
              )),
        ],
      ),
      onTap: () {
        Utils.hideKeyboard(context);
      },
    );
  }
}
