import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 输入框
Widget inputTextEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
}) {
  return Container(
    height: 44.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
      color: AppColors.secondaryElement,
      borderRadius: Radii.k6pxRadius,
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 9),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: "Avenir",
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
      ),
      maxLines: 1,
      autocorrect: false, // 自动纠正
      obscureText: isPassword, // 隐藏输入内容, 密码框
    ),
  );
}

/// email 输入框
/// 背景白色，文字黑色，带阴影
Widget inputEmailEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
}) {
  return Container(
    height: 44.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
      color: AppColors.primaryBackground,
      borderRadius: Radii.k6pxRadius,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(41, 0, 0, 0),
          offset: Offset(0, 1),
          blurRadius: 0,
        ),
      ],
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 9),
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColors.primaryText,
        ),
      ),
      style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: "Avenir",
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
      ),
      maxLines: 1,
      autocorrect: false, // 自动纠正
      obscureText: isPassword, // 隐藏输入内容, 密码框
    ),
  );
}

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
