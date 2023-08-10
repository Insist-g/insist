import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';

class ButtonPro extends StatefulWidget {
  final bool enabled;
  final double width;
  final double height;
  final String text;
  final Color color;
  final Color disableColor;
  final int milliseconds;
  final Function? onClick;
  final ButtonProController? controller;

  ButtonPro({
    this.enabled = false,
    this.width = 500,
    this.height = 40,
    this.text = "Hello",
    this.milliseconds = 1000,
    this.color = Colors.deepPurpleAccent,
    this.disableColor = Colors.grey,
    this.onClick,
    this.controller,
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
      widget.controller!.removeListener();
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
            borderRadius: BorderRadius.circular(_changSize ? 20 : 10)),
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
                    fontSize: 16,
                    color: AppColor.white,
                    fontWeight: FontWeight.w500)),
      ),
      onTap: widget.enabled ? () => pressed() : null,
    );
  }

  listener(value) {
    setState(() => _changSize = value);
    Future.delayed(Duration(milliseconds: widget.milliseconds - 100), () {
      setState(() => _showProgress = value);
    });
  }

  pressed() async {
    var state = await widget.onClick?.call() ?? false;
    widget.controller == null
        ? listener(state)
        : setState(() =>
            state ? widget.controller?.start() : widget.controller?.stop());
  }

}

typedef ButtonProListener = void Function(bool isOpen);

class ButtonProController {
  bool _loading = false;
  ButtonProListener? _buttonProListener;

  get state => _loading;

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

  void removeListener() {
    _buttonProListener = null;
  }

}
