import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/button.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DownDatePicker extends StatefulWidget {
  final Function(List<String>) onConfirm;

  const DownDatePicker({super.key, required this.onConfirm});

  @override
  State<DownDatePicker> createState() => _DownDatePickerState();
}

class _DownDatePickerState extends State<DownDatePicker> {
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late FocusNode _startFocusNode;
  late FocusNode _endFocusNode;

  @override
  void initState() {
    super.initState();
    _startFocusNode = FocusNode();
    _endFocusNode = FocusNode();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    // FocusScope.of(context).requestFocus(_startFocusNode);
  }

  @override
  void dispose() {
    super.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _startFocusNode.dispose();
    _endFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(top: 190),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _startDateController,
                  focusNode: _startFocusNode,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  autofocus: true,
                ),
              )),
              Text("至"),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _endDateController,
                  focusNode: _endFocusNode,
                  textAlign: TextAlign.center,
                  readOnly: true,
                ),
              )),
            ],
          ),
        ),
        Picker(
            hideHeader: true,
            adapter: DateTimePickerAdapter(
              type: PickerDateTimeType.kYMD,
              isNumberMonth: true,
              maxValue: DateTime.now(),
              minValue: DateTime(2010),
              value: DateTime.now(),
            ),
            selectedTextStyle: TextStyle(color: Colors.blue),
            onConfirm: (Picker picker, List value) {
              print((picker.adapter as DateTimePickerAdapter).value);
            },
            onSelect: (Picker picker, int index, List<int> selected) {
              DateTime? value = (picker.adapter as DateTimePickerAdapter).value;
              if (value == null) return;
              String formattedDate = DateFormat('yyyy-MM-dd').format(value);
              if (_startFocusNode.hasFocus) {
                _startDateController.text = formattedDate;
                // widget.onChange(DownDatePickerType.start, formattedDate);
              } else if (_endFocusNode.hasFocus) {
                _endDateController.text = formattedDate;
                // widget.onChange(DownDatePickerType.end, formattedDate);
              }
            }).makePicker(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: btnFlatButtonWidget(
                  height: 40,
                  fontSize: 14,
                  title: "恢复默认",
                  gbColor: AppColor.secondaryText,
                  onPressed: () {
                    _endDateController.text = "";
                    _startDateController.text = "";
                    _startFocusNode.unfocus();
                    _endFocusNode.unfocus();
                    Get.back();
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: btnFlatButtonWidget(
                  height: 40,
                  fontSize: 14,
                  title: "确认",
                  onPressed: () {
                    widget.onConfirm([
                      _startDateController.text,
                      _endDateController.text,
                    ]);
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

enum DownDatePickerType { start, end }
