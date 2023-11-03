class UploadResponse {
  int? id;
  String? path;
  String? name;
  String? url;
  String? type;
  int? size;
  int? createTime;

  UploadResponse(
      {this.id,
      this.path,
      this.name,
      this.url,
      this.type,
      this.size,
      this.createTime});

  UploadResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    path = json["path"];
    name = json["name"];
    url = json["url"];
    type = json["type"];
    size = json["size"];
    createTime = json["createTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["path"] = path;
    _data["name"] = name;
    _data["url"] = url;
    _data["type"] = type;
    _data["size"] = size;
    _data["createTime"] = createTime;
    return _data;
  }
}

class FileEntity {
  int? fileId;
  String? name;
  String? url;
  String? memo;
  String? tableName;
  String? baseId;

  FileEntity(
      {this.fileId,
      this.name,
      this.url,
      this.memo,
      this.tableName,
      this.baseId});

  FileEntity.fromJson(Map<String, dynamic> json) {
    fileId = json["fileId"];
    name = json["name"];
    url = json["url"];
    memo = json["memo"];
    tableName = json["tableName"];
    baseId = json["baseId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fileId"] = fileId;
    _data["name"] = name;
    _data["url"] = url;
    _data["memo"] = memo;
    _data["tableName"] = tableName;
    _data["baseId"] = baseId;
    return _data;
  }
}
