import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:styled_widget/styled_widget.dart';

class StateWidget extends StatelessWidget {
  StateWidget(
      {super.key,
      required this.gifPath,
      this.message,
      this.onRetry,
      this.isLoading = false});

  StateWidget.empty({this.message, this.onRetry})
      : this.gifPath = 'assets/gifs/empty.gif',
        this.isLoading = false;

  StateWidget.loading({this.message})
      : this.gifPath = 'assets/gifs/loading.gif',
        this.onRetry = null,
        this.isLoading = true;

  StateWidget.error({this.message, this.onRetry})
      : this.gifPath = 'assets/gifs/error.gif',
        this.isLoading = false;

  final String gifPath;
  final String? message;
  final bool isLoading;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            gifPath,
            width: isLoading ? 80 : 200,
            height: isLoading ? 80 : 200,
          ),
          if (message != null)
            Text(message ?? '').bold().textColor(Colors.grey).padding(top: 10),
          if (onRetry != null)
            TextButton(
              onPressed: onRetry,
              child: Text("点击重试").textColor(AppColor.pinkColor),
            ).padding(top: 10),
        ],
      ),
    );
  }
}
