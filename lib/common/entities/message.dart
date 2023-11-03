import 'file.dart';

class MessageEntity {
  List<MessageBean>? list;
  int? total;

  MessageEntity({this.list, this.total});

  MessageEntity.fromMessageJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => MessageBean.fromMessageJson(e)).toList();
    total = json["total"];
  }

  MessageEntity.fromNewsJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => MessageBean.fromNewsJson(e)).toList();
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

class MessageBean {
  String? title;
  int? type;
  String? content;
  int? status;
  int? id;
  num? createTime;
  String? creator;
  String? creatorName;
  List<AttachFiles>? attachFiles;

  MessageBean({this.title, this.type, this.content, this.status, this.id, this.createTime, this.creator, this.creatorName, this.attachFiles});

  MessageBean.fromMessageJson(Map<String, dynamic> json) {
    title = json["title"];
    type = json["type"];
    content = json["content"];
    status = json["status"];
    id = json["id"];
    createTime = json["createTime"];
    creator = json["creator"];
    creatorName = json["creatorName"];
    attachFiles = json["attachFiles"] == null ? null : (json["attachFiles"] as List).map((e) => AttachFiles.fromJson(e)).toList();
  }


  MessageBean.fromNewsJson(Map<String, dynamic> json) {
    title = json["newsTitle"];
    type = json["newsType"];
    content = json["newsContent"];
    status = json["newsStatus"];
    creator = json["publiher"];
    createTime = json["releaseTime"];
    id = json["id"];
    attachFiles = json["attachFiles"] == null ? null : (json["attachFiles"] as List).map((e) => AttachFiles.fromJson(e)).toList();
    creator = json["creator"];
    createTime = json["createTime"];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["type"] = type;
    _data["content"] = content;
    _data["status"] = status;
    _data["id"] = id;
    _data["createTime"] = createTime;
    _data["creator"] = creator;
    _data["creatorName"] = creatorName;
    if(attachFiles != null) {
      _data["attachFiles"] = attachFiles?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

