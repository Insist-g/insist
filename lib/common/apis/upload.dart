import 'package:flutter_ducafecat_news_getx/common/entities/upload.dart';
import 'package:flutter_ducafecat_news_getx/common/services/http.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';

class UploadAPI {
  static const String _UPLOAD_NEW = '/app-api/infra/file/upload';

  static Future<UploadResponse?> upLoadFile(String filePath,
      {UploadType? uploadType}) async {
    var response = await HttpUtil().uploadFile(_UPLOAD_NEW, filePath,
        params: {"path": (uploadType ?? UploadType.them).name});
    if (response == null ||
        response["code"] != RSP_OK ||
        response["data"] == null) return null;
    return UploadResponse.fromJson(response["data"]);
  }

  static Future<List<UploadResponse>> upLoadFileList(List<String> filePathList,
      {UploadType? uploadType}) async {
    List<UploadResponse> uploadResponseList = [];
    for (String path in filePathList) {
      var res = await upLoadFile(path, uploadType: uploadType);
      if (res != null) uploadResponseList.add(res);
    }
    return uploadResponseList;
  }
}


