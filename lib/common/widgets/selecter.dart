import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/event/list/logic.dart';

class CheckView extends StatefulWidget {
  final Function(bool)? onValueChange;
  final bool value;
  final String title;
  final Color selectColor;
  final Color unSelectColor;
  final EdgeInsetsGeometry padding;

  CheckView({
    this.onValueChange,
    this.value = false,
    this.title = "",
    this.selectColor = AppColor.primaryBackground,
    this.unSelectColor = AppColor.secondaryText,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  State<CheckView> createState() => _CheckViewState();
}

class _CheckViewState extends State<CheckView> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: _checked ? widget.selectColor : widget.unSelectColor,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Icon(
              _checked
                  ? Icons.check_circle_outline
                  : Icons.radio_button_unchecked_outlined,
              size: 14,
              color: _checked ? widget.selectColor : widget.unSelectColor,
            ),
          ],
        ),
      ),
      onTap: () {
        // setState(() => _checked = !_checked);
        if (widget.onValueChange != null) {
          widget.onValueChange!(_checked);
        }
      },
    );
  }
}

class CheckViewGroup extends StatefulWidget {
  final Function(String?)? onValueChange;
  List<CheckEntity> list;

  CheckViewGroup({super.key, required this.list, this.onValueChange});

  @override
  State<CheckViewGroup> createState() => _CheckViewGroupState();
}

class _CheckViewGroupState extends State<CheckViewGroup> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.list.map((e) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    e.title ?? '',
                    style: TextStyle(
                      color: (e.select ?? false)
                          ? AppColor.primaryBackground
                          : AppColor.secondaryText,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    (e.select ?? false)
                        ? Icons.check_circle_outline
                        : Icons.radio_button_unchecked_outlined,
                    size: 14,
                    color: (e.select ?? false)
                        ? AppColor.primaryBackground
                        : AppColor.secondaryText,
                  ),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                bool? isSelect = e.select;
                for (var eel in widget.list) {
                  eel.select = false;
                }
                if (isSelect == false) e.select = true;
                if (widget.onValueChange != null) {
                  widget.onValueChange!(e.select == true ? e.id : null);
                }
              });
            },
          );
        }).toList());
  }
}
