import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';

class TimerWidget extends StatefulWidget {
  final Function sendCode;
  final Color? backGroundColor;
  final Color? textColor;
  final double? fontSize;
  final String? text;
  final bool initCount;

  const TimerWidget(
      {Key? key,
      required this.sendCode,
      this.backGroundColor,
      this.textColor,
      this.fontSize,
      this.initCount = false,
      this.text})
      : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;

  var _countdownTime = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.initCount) {
        _countdownTime = 59;
        _timer ??= Timer.periodic(const Duration(seconds: 1), call);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            widget.backGroundColor ?? AppColor.mainColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))
      ),
      child: Text(handleCodeAutoSizeText(),
          style: TextStyle(
              color: widget.textColor ?? Colors.white,
              fontSize: widget.fontSize)),
      onPressed: _countdownTime == 0 ? btnPress() : null,
    );
  }

  btnPress() {
    if (_countdownTime == 0) {
      return () {
        startCountdown();
      };
    }
  }

  String handleCodeAutoSizeText() {
    if (_countdownTime > 0) {
      return '$_countdownTime' + '重新发送';
    } else {
      return widget.text ?? '获取验证码';
    }
  }

  call(timer) {
    if (_countdownTime < 1) {
      _timer?.cancel();
      _timer = null;
    } else {
      setState(() {
        _countdownTime -= 1;
      });
    }
  }

  startCountdown() async {
    if (await widget.sendCode.call() != true) return;
    _countdownTime = 60;
    _timer ??= Timer.periodic(const Duration(seconds: 1), call);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer?.cancel();
    }
  }
}
