import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/input.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/search.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/selecter.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/event/list/logic.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

class SearchDrawer extends StatelessWidget {
  const SearchDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<EventListLogic>();

    return Drawer(
      width: Get.width - 50,
      child: Container(
        color: AppColor.white,
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SearchEdit(
                        controller: logic.searchController,
                        backgroundColor: AppColor.gray,
                      ).expanded(),
                      IconButton(
                          icon: Icon(Icons.refresh_outlined),
                          onPressed: () {
                            logic.examineState
                                .forEach((element) => element.select = false);
                            logic.eventState
                                .forEach((element) => element.select = false);
                            logic.searchController.text = "";
                            logic.startDateController.text = "";
                            logic.endDateController.text = "";
                            logic.problemStatus = null;
                            logic.checkStatus = null;
                            logic.closeDrawer();
                            logic.onRefresh();
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "事件状态",
                    style: AppTextStyle.primary_14_w500,
                  ),
                  CheckViewGroup(
                    list: logic.eventState,
                    onValueChange: (value) {
                      logic.problemStatus = value;
                      logic.onRefresh();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "审核状态",
                    style: AppTextStyle.primary_14_w500,
                  ),
                  CheckViewGroup(
                    list: logic.examineState,
                    onValueChange: (value) {
                      logic.checkStatus = value;
                      logic.onRefresh();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "时间选择",
                    style: AppTextStyle.primary_14_w500,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: EditText(
                          contentPadding: EdgeInsets.zero,
                          isShowDelete: false,
                          controller: logic.startDateController,
                          focusNode: logic.startFocusNode,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          hintText: "开始时间",
                          onTap: () {
                            showPickerDateTime24(confirm: (value) {
                              logic.startDateController.text = value;
                            });
                          },
                        ),
                      )),
                      Text("至"),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: EditText(
                          controller: logic.endDateController,
                          focusNode: logic.endFocusNode,
                          isShowDelete: false,
                          textAlign: TextAlign.center,
                          contentPadding: EdgeInsets.zero,
                          hintText: "结束时间",
                          readOnly: true,
                          onTap: () {
                            showPickerDateTime24(confirm: (value) {
                              logic.endDateController.text = value;
                              logic.onRefresh();
                            });
                          },
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 1,
            //       child: btnFlatButtonWidget(
            //         title: "重置",
            //         gbColor: AppColor.dividerColor,
            //         onPressed: () {},
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: btnFlatButtonWidget(
            //         title: "搜索",
            //         onPressed: () {
            //           logic.closeDrawer();
            //         },
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

showPickerDateTime24({
  Function(String)? confirm,
}) async {
  Picker(
      cancelText: "取消",
      confirmText: "确认",
      adapter: DateTimePickerAdapter(
        type: PickerDateTimeType.kYMD,
        isNumberMonth: true,
        yearBegin: 2000,
        yearEnd: DateTime.now().year,
      ),
      title: Text(""),
      onConfirm: (Picker picker, List value) async {
        if (confirm != null) {
          DateTime? value = (picker.adapter as DateTimePickerAdapter).value;
          if (value == null) return;
          String formattedDate = DateFormat('yyyy-MM-dd').format(value);
          confirm(formattedDate);
        }
      }).showModal(Get.context!);
}
