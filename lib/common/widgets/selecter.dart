import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/icons.dart';

class CheckView extends StatefulWidget {
  final Function(bool)? onValueChange;
  final bool value;

  CheckView({this.onValueChange, this.value = false});

  @override
  State<CheckView> createState() => _CheckViewState();
}

class _CheckViewState extends State<CheckView> {
  late bool _checked;

  @override
  void initState() => _checked = widget.value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          _checked ? AlIcon.pig_chroma : AlIcon.pig_black,
          size: 14,
        ),
      ),
      onTap: () {
        setState(() => _checked = !_checked);
        if (widget.onValueChange != null) {
          widget.onValueChange!(_checked);
        }
      },
    );
  }
}
