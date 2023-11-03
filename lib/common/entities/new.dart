
import 'file.dart';

class NewsEntity {
  List<NewBean>? list;
  int? total;

  NewsEntity({this.list, this.total});

  NewsEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => NewBean.fromJson(e)).toList();
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

class NewBean {
  int? id;
  String? newsTitle;
  int? newsType;
  List<AttachFiles>? attachFiles;

  NewBean({this.id, this.newsTitle, this.newsType, this.attachFiles});

  NewBean.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    newsTitle = json["newsTitle"];
    newsType = json["newsType"];
    attachFiles = json["attachFiles"] == null ? null : (json["attachFiles"] as List).map((e) => AttachFiles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["newsTitle"] = newsTitle;
    _data["newsType"] = newsType;
    if(attachFiles != null) {
      _data["attachFiles"] = attachFiles?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

