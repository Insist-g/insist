import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';

class EditText extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isInputPwd;
  final TextInputType? inputType;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;

  const EditText(
      {Key? key,
      this.controller,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.inputType,
      this.contentPadding,
      this.textStyle,
      this.enabled = true,
      this.isInputPwd = false})
      : super(key: key);

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  bool _isShowPwd = false;
  late bool _isShowDelete;

  @override
  void initState() {
    super.initState();

    /// 获取初始值
    _isShowDelete = (widget.controller?.text ?? '').isNotEmpty;

    /// 监听输入改变
    widget.controller?.addListener(() {
      setState(() {
        _isShowDelete = (widget.controller?.text ?? '').isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isInputPwd ? !_isShowPwd : false,
      onChanged: (value) {},
      keyboardType: widget?.inputType,
      style: widget.textStyle,
      enabled: widget.enabled,
      decoration: InputDecoration(
        prefixIcon: widget?.prefixIcon,
        suffixIcon: Material(
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_isShowDelete)
                IconButton(
                  onPressed: () {
                    widget.controller?.text = '';
                  },
                  icon: const Icon(Icons.clear_rounded),
                ),
              if (widget.isInputPwd && _isShowDelete)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isShowPwd = !_isShowPwd;
                    });
                  },
                  icon: Icon(
                    Icons.visibility_rounded,
                    color: _isShowPwd
                        ? AppColor.primaryText
                        : AppColor.primaryText,
                  ),
                ),
              if (widget?.suffixIcon != null) widget.suffixIcon!
            ],
          ),
        ),
        labelText: widget?.labelText,
        labelStyle: TextStyle(fontSize: 16, color: AppColor.mainColor, fontWeight: FontWeight.w400),
        fillColor: Colors.white12,
        contentPadding: widget.contentPadding,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 14, color: AppColor.primaryText),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColor.mainColor)
        )
      ),
    );
  }
}
