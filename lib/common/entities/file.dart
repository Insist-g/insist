import 'dart:core';

class RiverFileEntity {
  List<RiverFile>? list;
  int? total;

  RiverFileEntity({this.list, this.total});

  RiverFileEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => RiverFile.fromJson(e)).toList();
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (list != null) {
      _data["list"] = list?.map((e) => e.toJson()).toList();
    }
    _data["total"] = total;
    return _data;
  }
}

class RiverFile {
  String? riverId;
  String? policyName;
  num? policyDate;
  num? startYear;
  num? endYear;
  String? editOrg;
  String? remark;
  String? fileName;
  String? path;
  String? id;
  String? riverName;
  String? code;
  String? categoryId;
  String? creator;
  String? updater;
  num? createTime;
  num? updateTime;
  List<AttachFiles>? attachFiles;

  RiverFile(
      {this.riverId,
      this.policyName,
      this.policyDate,
      this.startYear,
      this.endYear,
      this.editOrg,
      this.remark,
      this.fileName,
      this.path,
      this.id,
      this.riverName,
      this.code,
      this.categoryId,
      this.creator,
      this.updater,
      this.createTime,
      this.updateTime,
      this.attachFiles});

  RiverFile.fromJson(Map<String, dynamic> json) {
    riverId = json["riverId"];
    policyName = json["policyName"];
    policyDate = json["policyDate"];
    startYear = json["startYear"];
    endYear = json["endYear"];
    editOrg = json["editOrg"];
    remark = json["remark"];
    fileName = json["fileName"];
    path = json["path"];
    id = json["id"];
    riverName = json["riverName"];
    code = json["code"];
    categoryId = json["categoryId"];
    creator = json["creator"];
    updater = json["updater"];
    createTime = json["createTime"];
    updateTime = json["updateTime"];
    attachFiles = json["attachFiles"] == null
        ? null
        : (json["attachFiles"] as List)
            .map((e) => AttachFiles.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["riverId"] = riverId;
    _data["policyName"] = policyName;
    _data["policyDate"] = policyDate;
    _data["startYear"] = startYear;
    _data["endYear"] = endYear;
    _data["editOrg"] = editOrg;
    _data["remark"] = remark;
    _data["fileName"] = fileName;
    _data["path"] = path;
    _data["id"] = id;
    _data["riverName"] = riverName;
    _data["code"] = code;
    _data["categoryId"] = categoryId;
    _data["creator"] = creator;
    _data["updater"] = updater;
    _data["createTime"] = createTime;
    _data["updateTime"] = updateTime;
    if (attachFiles != null) {
      _data["attachFiles"] = attachFiles?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class FileEntity {
  List<FileItem>? list;
  int? total;

  FileEntity({this.list, this.total});

  FileEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => FileItem.fromJson(e)).toList();
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

class FileItem {
  String? type;
  String? title;
  String? content;
  String? remark;
  String? id;
  num? createTime;
  String? creatorName;
  List<AttachFiles>? attachFiles;

  FileItem({this.type, this.title, this.content, this.remark, this.id, this.createTime, this.creatorName, this.attachFiles});

  FileItem.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    title = json["title"];
    content = json["content"];
    remark = json["remark"];
    id = json["id"];
    createTime = json["createTime"];
    creatorName = json["creatorName"];
    attachFiles = json["attachFiles"] == null ? null : (json["attachFiles"] as List).map((e) => AttachFiles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    _data["title"] = title;
    _data["content"] = content;
    _data["remark"] = remark;
    _data["id"] = id;
    _data["createTime"] = createTime;
    _data["creatorName"] = creatorName;
    if(attachFiles != null) {
      _data["attachFiles"] = attachFiles?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class AttachFiles {
  int? fileId;
  String? name;
  String? url;
  String? memo;
  String? fileType;

  AttachFiles({this.fileId, this.name, this.url, this.memo, this.fileType});

  AttachFiles.fromJson(Map<String, dynamic> json) {
    fileId = json["fileId"];
    name = json["name"];
    url = json["url"];
    memo = json["memo"];
    fileType = json["fileType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fileId"] = fileId;
    _data["name"] = name;
    _data["url"] = url;
    _data["memo"] = memo;
    _data["fileType"] = fileType;
    return _data;
  }
}

class LawFileEntity {
  List<LawFileBean>? list;
  int? total;

  LawFileEntity({this.list, this.total});

  LawFileEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => LawFileBean.fromJson(e)).toList();
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

class LawFileBean {
  ManDocs? manDocs;
  List<AttachFiles>? attachFileList;

  LawFileBean({this.manDocs, this.attachFileList});

  LawFileBean.fromJson(Map<String, dynamic> json) {
    manDocs = json["manDocs"] == null ? null : ManDocs.fromJson(json["manDocs"]);
    attachFileList = json["attachFileList"] == null ? null : (json["attachFileList"] as List).map((e) => AttachFiles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(manDocs != null) {
      _data["manDocs"] = manDocs?.toJson();
    }
    if(attachFileList != null) {
      _data["attachFileList"] = attachFileList?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}


class ManDocs {
  num? createTime;
  num? updateTime;
  String? creator;
  String? updater;
  bool? deleted;
  String? creatorName;
  String? updaterName;
  int? id;
  String? code;
  String? name;
  int? type;
  List<DocTypeList>? docTypeList;
  int? level;
  String? publishOrg;
  String? version;
  String? contact;
  String? remark;
  List<AttachFiles>? attachFiles;

  ManDocs({this.createTime, this.updateTime, this.creator, this.updater, this.deleted, this.creatorName, this.updaterName, this.id, this.code, this.name, this.type, this.docTypeList, this.level, this.publishOrg, this.version, this.contact, this.remark, this.attachFiles});

  ManDocs.fromJson(Map<String, dynamic> json) {
    createTime = json["createTime"];
    updateTime = json["updateTime"];
    creator = json["creator"];
    updater = json["updater"];
    deleted = json["deleted"];
    creatorName = json["creatorName"];
    updaterName = json["updaterName"];
    id = json["id"];
    code = json["code"];
    name = json["name"];
    type = json["type"];
    docTypeList = json["docTypeList"] == null ? null : (json["docTypeList"] as List).map((e) => DocTypeList.fromJson(e)).toList();
    level = json["level"];
    publishOrg = json["publishOrg"];
    version = json["version"];
    contact = json["contact"];
    remark = json["remark"];
    attachFiles = json["attachFiles"] == null ? null : (json["attachFiles"] as List).map((e) => AttachFiles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createTime"] = createTime;
    _data["updateTime"] = updateTime;
    _data["creator"] = creator;
    _data["updater"] = updater;
    _data["deleted"] = deleted;
    _data["creatorName"] = creatorName;
    _data["updaterName"] = updaterName;
    _data["id"] = id;
    _data["code"] = code;
    _data["name"] = name;
    _data["type"] = type;
    if(docTypeList != null) {
      _data["docTypeList"] = docTypeList?.map((e) => e.toJson()).toList();
    }
    _data["level"] = level;
    _data["publishOrg"] = publishOrg;
    _data["version"] = version;
    _data["contact"] = contact;
    _data["remark"] = remark;
    if(attachFiles != null) {
      _data["attachFiles"] = attachFiles?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class DocTypeList {
  String? createTime;
  String? updateTime;
  String? creator;
  String? updater;
  bool? deleted;
  String? creatorName;
  String? updaterName;
  int? id;
  String? name;
  int? parentId;
  String? parentName;
  String? remark;

  DocTypeList({this.createTime, this.updateTime, this.creator, this.updater, this.deleted, this.creatorName, this.updaterName, this.id, this.name, this.parentId, this.parentName, this.remark});

  DocTypeList.fromJson(Map<String, dynamic> json) {
    createTime = json["createTime"];
    updateTime = json["updateTime"];
    creator = json["creator"];
    updater = json["updater"];
    deleted = json["deleted"];
    creatorName = json["creatorName"];
    updaterName = json["updaterName"];
    id = json["id"];
    name = json["name"];
    parentId = json["parentId"];
    parentName = json["parentName"];
    remark = json["remark"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["createTime"] = createTime;
    _data["updateTime"] = updateTime;
    _data["creator"] = creator;
    _data["updater"] = updater;
    _data["deleted"] = deleted;
    _data["creatorName"] = creatorName;
    _data["updaterName"] = updaterName;
    _data["id"] = id;
    _data["name"] = name;
    _data["parentId"] = parentId;
    _data["parentName"] = parentName;
    _data["remark"] = remark;
    return _data;
  }
}