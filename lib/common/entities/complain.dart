import 'package:flutter_ducafecat_news_getx/common/entities/file.dart';

class ComplainEntity {
  List<ComplainBean>? list;
  int? total;

  ComplainEntity({this.list, this.total});

  ComplainEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => ComplainBean.fromJson(e)).toList();
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(list != null) {
      _data["list"] = list?.map((e) => e.toJson()).toList();
    }
    _data["total"] = total;
    return _data;
  }
}

class ComplainBean {
  String? title;
  String? reporter;
  String? phone;
  String? riverId;
  String? reachId;
  String? content;
  int? id;
  List<AttachFiles>? attachFiles;
  String? recvUserId;
  String? recvUserName;
  String? responseUserId;
  String? responseUserName;
  String? riverName;
  String? reachName;
  int? status;
  String? memo;
  String? replyContent;
  num? createTime;

  ComplainBean({this.title, this.reporter, this.phone, this.riverId, this.reachId, this.content, this.id, this.attachFiles, this.recvUserId, this.recvUserName, this.responseUserId, this.responseUserName, this.riverName, this.reachName, this.status, this.memo, this.replyContent, this.createTime});

  ComplainBean.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    reporter = json["reporter"];
    phone = json["phone"];
    riverId = json["riverId"];
    reachId = json["reachId"];
    content = json["content"];
    id = json["id"];
    attachFiles = json["attachFileList"] == null ? null : (json["attachFileList"] as List).map((e) => AttachFiles.fromJson(e)).toList();
    recvUserId = json["recvUserId"];
    recvUserName = json["recvUserName"];
    responseUserId = json["responseUserId"];
    responseUserName = json["responseUserName"];
    riverName = json["riverName"];
    reachName = json["reachName"];
    status = json["status"];
    memo = json["memo"];
    replyContent = json["replyContent"];
    createTime = json["createTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["reporter"] = reporter;
    _data["phone"] = phone;
    _data["riverId"] = riverId;
    _data["reachId"] = reachId;
    _data["content"] = content;
    _data["id"] = id;
    if(attachFiles != null) {
      _data["attachFiles"] = attachFiles?.map((e) => e.toJson()).toList();
    }
    _data["recvUserId"] = recvUserId;
    _data["recvUserName"] = recvUserName;
    _data["responseUserId"] = responseUserId;
    _data["responseUserName"] = responseUserName;
    _data["riverName"] = riverName;
    _data["reachName"] = reachName;
    _data["status"] = status;
    _data["memo"] = memo;
    _data["replyContent"] = replyContent;
    _data["createTime"] = createTime;
    return _data;
  }
}

