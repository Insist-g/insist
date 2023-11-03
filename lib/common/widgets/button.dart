import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';
import 'package:flutter_ducafecat_news_getx/common/style/style.dart';

/// 扁平圆角按钮
Widget btnFlatButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color gbColor = AppColors.primaryElement,
  String title = "button",
  Color fontColor = AppColors.primaryElementText,
  double fontSize = 18,
  String fontName = "Montserrat",
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Container(
    width: width,
    height: height,
    child: TextButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 16,
        )),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.focused) &&
                !states.contains(MaterialState.pressed)) {
              return Colors.blue;
            } else if (states.contains(MaterialState.pressed)) {
              return Colors.deepPurple;
            }
            return fontColor;
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.blue[200];
          }
          return gbColor;
        }),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: Radii.k6pxRadius,
        )),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontFamily: fontName,
          fontWeight: fontWeight,
          fontSize: fontSize,
          height: 1,
        ),
      ),
      onPressed: onPressed,
    ),
  );
}

/// 第三方按钮
Widget btnFlatButtonBorderOnlyWidget({
  required VoidCallback onPressed,
  double width = 88,
  double height = 44,
  required String iconFileName,
}) {
  return Container(
    width: width,
    height: height,
    child: TextButton(
      style: ButtonStyle(
        // textStyle: MaterialStateProperty.all(TextStyle(
        //   fontSize: 16.sp,
        // )),
        // foregroundColor: MaterialStateProperty.resolveWith(
        //   (states) {
        //     if (states.contains(MaterialState.focused) &&
        //         !states.contains(MaterialState.pressed)) {
        //       return Colors.blue;
        //     } else if (states.contains(MaterialState.pressed)) {
        //       return Colors.deepPurple;
        //     }
        //     return AppColors.primaryElementText;
        //   },
        // ),
        // backgroundColor: MaterialStateProperty.resolveWith((states) {
        //   if (states.contains(MaterialState.pressed)) {
        //     return Colors.blue[200];
        //   }
        //   return AppColors.primaryElement;
        // }),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: Radii.k6pxRadius,
        )),
      ),
      child: Image.asset(
        "assets/images/icons-$iconFileName.png",
      ),
      onPressed: onPressed,
    ),
  );
}

/// 缩小旋转按钮
class ButtonPro extends StatefulWidget {
  final bool enabled;
  final double width;
  final double height;
  final Color color;
  final Color disableColor;
  final int milliseconds;
  final Function? onClick;
  final ButtonProController? controller;
  final String text;
  final double firstRadius;
  final double lastRadius;

  ButtonPro({
    this.enabled = false,
    this.width = 500,
    this.height = 40,
    this.firstRadius = 10,
    this.lastRadius = 20,
    this.milliseconds = 1000,
    this.color = Colors.deepPurpleAccent,
    this.disableColor = Colors.grey,
    this.onClick,
    this.controller,
    this.text = 'hello',
  });

  @override
  State<ButtonPro> createState() => _ButtonProState();
}

class _ButtonProState extends State<ButtonPro>
    with SingleTickerProviderStateMixin {
  bool _showProgress = false;
  bool _changSize = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.setListener(listener);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller != null) {
      widget.controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        width: _changSize ? widget.height * 2 : widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: widget.enabled ? widget.color : widget.disableColor,
            borderRadius: BorderRadius.circular(
                _changSize ? widget.lastRadius : widget.firstRadius)),
        alignment: AlignmentDirectional.center,
        duration: Duration(milliseconds: widget.milliseconds),
        curve: Curves.fastOutSlowIn,
        child: _showProgress
            ? Container(
                width: widget.height,
                height: widget.height,
                padding: EdgeInsets.all(widget.height / 5),
                child: const CircularProgressIndicator(
                    backgroundColor: Colors.black12, color: AppColor.white),
              )
            : Text(widget.text,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    color: AppColor.white,
                    fontWeight: FontWeight.w500)),
      ),
      onTap: widget.enabled ? () => pressed() : null,
    );
  }

  listener(value) {
    if (!mounted) return;
    setState(() => _changSize = value);
    Future.delayed(Duration(milliseconds: widget.milliseconds - 100), () {
      if (!mounted) return;
      setState(() => _showProgress = value);
    });
  }

  pressed() async {
    var state = await widget.onClick?.call();
    if (state == null) return;
    listener(state);
  }
}

typedef ButtonProListener = void Function(bool isOpen);

class ButtonProController {
  bool _loading = false;
  ButtonProListener? _buttonProListener;

  get state => _loading;

  get listener => _buttonProListener;

  setListener(ButtonProListener listener) {
    _buttonProListener = listener;
  }

  void start() {
    if (_buttonProListener != null) {
      _loading = true;
      _buttonProListener!(true);
    }
  }

  void stop() {
    if (_buttonProListener != null) {
      _loading = false;
      _buttonProListener!(false);
    }
  }

  void dispose() {
    _buttonProListener = null;
  }
}
//
// //下拉选择按钮
// class DownButton2 extends StatefulWidget {
//   final List<String> items;
//   final String defString;
//   final double height;
//   final double width;
//
//   const DownButton2({
//     super.key,
//     required this.items,
//     this.defString = '默认',
//     this.width = 100,
//     this.height = 50,
//   });
//
//   @override
//   State<DownButton2> createState() => _DownButton2State();
// }
//
// class _DownButton2State extends State<DownButton2> {
//   String? selectedValue;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         isExpanded: true,
//         hint: Text(
//           widget.defString,
//           style: AppTextStyle.secondary_14,
//         ),
//         items: widget.items
//             .map((String item) => DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(
//                     item,
//                     style: AppTextStyle.secondary_14,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ))
//             .toList(),
//         value: selectedValue,
//         onChanged: (String? value) {
//           setState(() {
//             selectedValue = value;
//           });
//         },
//         buttonStyleData: ButtonStyleData(
//             height: widget.height,
//             width: widget.width,
//             padding: const EdgeInsets.only(left: 14, right: 14),
//             elevation: 0,
//             decoration: BoxDecoration(color: Colors.white)),
//         dropdownStyleData: DropdownStyleData(
//           elevation: 0,
//           maxHeight: 200,
//           width: double.infinity,
//           decoration: BoxDecoration(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
//
