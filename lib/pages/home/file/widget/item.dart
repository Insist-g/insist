import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/file.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_ducafecat_news_getx/common/widgets/pdf.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class FileListItem extends StatelessWidget {
  final String title;
  final String trailing;
  final List<Widget> children;

  const FileListItem(
      {super.key,
      required this.title,
      required this.trailing,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Get.width / 3),
        child: Text(trailing, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      children: children,
      initiallyExpanded: true,
    );
  }
}

class FileListItemChild extends StatefulWidget {
  final AttachFiles attachFiles;

  FileListItemChild({super.key, required this.attachFiles});

  @override
  State<FileListItemChild> createState() => _FileListItemChildState();
}

class _FileListItemChildState extends State<FileListItemChild> {
  final ValueNotifier<double?> valueNotifierProgress = ValueNotifier(null);
  String filePath = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplicationSupportDirectory().then((value) {
      filePath = '${value.path}/${widget.attachFiles.name ?? ''}';
      doesFileExist(filePath)
          .then((value) => valueNotifierProgress.value = value ? 1 : null);
    }).onError((error, stackTrace) {});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.attachFiles.name ?? ""),
      leading: Icon(
        (widget.attachFiles.fileType ?? "").contains('image')
            ? Icons.image
            : Icons.file_present_sharp,
        color: (widget.attachFiles.fileType ?? "").contains('image')
            ? AppColor.green
            : AppColor.pinkColor,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<double?>(
              valueListenable: valueNotifierProgress,
              builder: (ctx, progress, child) {
                if ((widget.attachFiles.fileType ?? "").contains('image')) {
                  return IconButton(
                      icon: Icon(Icons.drafts_outlined),
                      onPressed: () {
                        Utils.showViewBigPhoto(
                            images: [widget.attachFiles.url ?? ""], index: 0);
                      });
                }
                if (progress == null)
                  return IconButton(
                      icon: Icon(Icons.cloud_download),
                      onPressed: () {
                        if (widget.attachFiles.url == null ||
                            widget.attachFiles.name == null) {
                          EasyLoading.showInfo("文件失踪了..");
                          return;
                        }
                        downLoadFile(
                            url: widget.attachFiles.url!,
                            fileName: widget.attachFiles.name!);
                      });
                if (progress == 1)
                  return IconButton(
                    icon: Icon(Icons.download_done),
                    onPressed: () {
                      if ((widget.attachFiles.fileType ?? "").contains('pdf')) {
                        Get.to(() => PDFPage(
                              path: filePath,
                              title: widget.attachFiles.name ?? '',
                            ));
                      } else {
                        OpenFilex.open(filePath);
                      }
                    },
                  );
                return SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    backgroundColor: AppColor.mainColor,
                    valueColor: AlwaysStoppedAnimation(AppColor.dividerColor),
                    // value: progress == -1 ? null : progress, // 如果进度是确定的，那么可以设置进度百分比，0-1
                    strokeWidth: 3, // 进度条的宽度
                  ),
                );
              }),
          IconButton(
            icon: Icon(Icons.share, color: AppColor.green),
            onPressed: () {
              if (widget.attachFiles.url == null) {
                EasyLoading.showInfo("文件失踪了..");
                return;
              }
              if (valueNotifierProgress.value == 1) {
                Share.shareXFiles([XFile(filePath)]);
              } else {
                Share.shareUri(Uri.parse(widget.attachFiles.url!));
              }
            },
          ),
        ],
      ),
    );
  }

  Future downLoadFile({required String url, required String fileName}) async {
    var res = await storagePermission();
    if (res == false) return;
    HttpUtil().downloadFile(url, filePath, progress: (value) {
      valueNotifierProgress.value = value;
    }, success: () {
      valueNotifierProgress.value = 1;
    }, error: () {
      valueNotifierProgress.value = null;
      EasyLoading.showInfo("下载失败请稍后再试");
    }).then((value) {
      if (value != null) OpenFilex.open(filePath);
    }).onError<DioException>((error, stackTrace) {
      valueNotifierProgress.value = null;
      EasyLoading.showInfo(error.message ?? "下载失败请稍后再试");
    });
  }

  Future<bool> storagePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var res = await Permission.storage.request();
      return res.isGranted;
    }
    return true;
  }

  Future<bool> doesFileExist(String filePath) async {
    File file = File(filePath);
    return await file.exists();
  }
}
