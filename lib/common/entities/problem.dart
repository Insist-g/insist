class ProblemEntity {
  List<ProblemBean>? list;
  int? total;

  ProblemEntity({this.list, this.total});

  ProblemEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => ProblemBean.fromJson(e)).toList();
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

class ProblemBean {
  String? title;
  String? content;
  String? comment;
  String? memo;
  String? reporter;
  String? contact;
  String? riverId;
  String? reachId;
  num? level;
  String? checkStatus;
  num? status;
  String? lng;
  String? lat;
  int? id;
  String? riverName;
  String? reachName;
  List<AttachFileList>? attachFileList;
  String? creator;
  num? createTime;
  String? updater;
  num? updateTime;

  ProblemBean(
      {this.title,
      this.content,
      this.comment,
      this.memo,
      this.reporter,
      this.contact,
      this.riverId,
      this.reachId,
      this.level,
      this.checkStatus,
      this.status,
      this.lng,
      this.lat,
      this.id,
      this.riverName,
      this.reachName,
      this.attachFileList,
      this.creator,
      this.createTime,
      this.updater,
      this.updateTime});

  ProblemBean.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    content = json["content"];
    comment = json["comment"];
    memo = json["memo"];
    reporter = json["reporter"];
    contact = json["contact"];
    riverId = json["riverId"];
    reachId = json["reachId"];
    level = json["level"];
    checkStatus = json["checkStatus"];
    status = json["status"];
    lng = json["lng"];
    lat = json["lat"];
    id = json["id"];
    riverName = json["riverName"];
    reachName = json["reachName"];
    attachFileList = json["attachFileList"] == null
        ? null
        : (json["attachFileList"] as List)
            .map((e) => AttachFileList.fromJson(e))
            .toList();
    creator = json["creator"];
    createTime = json["createTime"];
    updater = json["updater"];
    updateTime = json["updateTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["content"] = content;
    _data["comment"] = comment;
    _data["memo"] = memo;
    _data["reporter"] = reporter;
    _data["contact"] = contact;
    _data["riverId"] = riverId;
    _data["reachId"] = reachId;
    _data["level"] = level;
    _data["checkStatus"] = checkStatus;
    _data["status"] = status;
    _data["lng"] = lng;
    _data["lat"] = lat;
    _data["id"] = id;
    _data["riverName"] = riverName;
    _data["reachName"] = reachName;
    if (attachFileList != null) {
      _data["attachFileList"] = attachFileList?.map((e) => e.toJson()).toList();
    }
    _data["creator"] = creator;
    _data["createTime"] = createTime;
    _data["updater"] = updater;
    _data["updateTime"] = updateTime;
    return _data;
  }
}



class AttachFileList {
  String? name;
  String? url;
  String? fileType;

  AttachFileList({this.name, this.url, this.fileType});

  AttachFileList.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    url = json["url"];
    fileType = json["fileType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["url"] = url;
    _data["fileType"] = fileType;
    return _data;
  }
}

class ProblemInfoEntity {
  AppProblemRespVo? appProblemRespVo;
  AppPatrolProblemRespVo? appPatrolProblemRespVo;

  ProblemInfoEntity({this.appProblemRespVo, this.appPatrolProblemRespVo});

  ProblemInfoEntity.fromJson(Map<String, dynamic> json) {
    appProblemRespVo = json["appProblemRespVO"] == null
        ? null
        : AppProblemRespVo.fromJson(json["appProblemRespVO"]);
    appPatrolProblemRespVo = json["appPatrolProblemRespVO"] == null
        ? null
        : AppPatrolProblemRespVo.fromJson(json["appPatrolProblemRespVO"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (appProblemRespVo != null) {
      _data["appProblemRespVO"] = appProblemRespVo?.toJson();
    }
    if (appPatrolProblemRespVo != null) {
      _data["appPatrolProblemRespVO"] = appPatrolProblemRespVo?.toJson();
    }
    return _data;
  }
}

class AppPatrolProblemRespVo {
  String? problemDescribe;
  String? patrolId;
  String? processingState;
  String? problemType;
  String? problemImagesUrl;
  String? problemVideoUrl;
  String? reportPersonBy;
  String? reportPersonTime;
  String? distributivePersonBy;
  String? distributivePersonTime;
  String? disposePerson;
  String? disposePersonTime;
  String? disposeDescribe;
  String? disposeImagesUrl;
  String? disposeVideoUrl;
  String? creatTime;
  String? problemId;
  List<AttachFiles>? attachFiles;
  String? creator;
  String? updater;
  String? createTime;
  String? updateTime;

  AppPatrolProblemRespVo(
      {this.problemDescribe,
      this.patrolId,
      this.processingState,
      this.problemType,
      this.problemImagesUrl,
      this.problemVideoUrl,
      this.reportPersonBy,
      this.reportPersonTime,
      this.distributivePersonBy,
      this.distributivePersonTime,
      this.disposePerson,
      this.disposePersonTime,
      this.disposeDescribe,
      this.disposeImagesUrl,
      this.disposeVideoUrl,
      this.creatTime,
      this.problemId,
      this.attachFiles,
      this.creator,
      this.updater,
      this.createTime,
      this.updateTime});

  AppPatrolProblemRespVo.fromJson(Map<String, dynamic> json) {
    problemDescribe = json["problemDescribe"];
    patrolId = json["patrolId"];
    processingState = json["processingState"];
    problemType = json["problemType"];
    problemImagesUrl = json["problemImagesUrl"];
    problemVideoUrl = json["problemVideoUrl"];
    reportPersonBy = json["reportPersonBy"];
    reportPersonTime = json["reportPersonTime"];
    distributivePersonBy = json["distributivePersonBy"];
    distributivePersonTime = json["distributivePersonTime"];
    disposePerson = json["disposePerson"];
    disposePersonTime = json["disposePersonTime"];
    disposeDescribe = json["disposeDescribe"];
    disposeImagesUrl = json["disposeImagesUrl"];
    disposeVideoUrl = json["disposeVideoUrl"];
    creatTime = json["creatTime"];
    problemId = json["problemId"];
    attachFiles = json["attachFiles"] == null
        ? null
        : (json["attachFiles"] as List)
            .map((e) => AttachFiles.fromJson(e))
            .toList();
    creator = json["creator"];
    updater = json["updater"];
    createTime = json["createTime"];
    updateTime = json["updateTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["problemDescribe"] = problemDescribe;
    _data["patrolId"] = patrolId;
    _data["processingState"] = processingState;
    _data["problemType"] = problemType;
    _data["problemImagesUrl"] = problemImagesUrl;
    _data["problemVideoUrl"] = problemVideoUrl;
    _data["reportPersonBy"] = reportPersonBy;
    _data["reportPersonTime"] = reportPersonTime;
    _data["distributivePersonBy"] = distributivePersonBy;
    _data["distributivePersonTime"] = distributivePersonTime;
    _data["disposePerson"] = disposePerson;
    _data["disposePersonTime"] = disposePersonTime;
    _data["disposeDescribe"] = disposeDescribe;
    _data["disposeImagesUrl"] = disposeImagesUrl;
    _data["disposeVideoUrl"] = disposeVideoUrl;
    _data["creatTime"] = creatTime;
    _data["problemId"] = problemId;
    if (attachFiles != null) {
      _data["attachFiles"] = attachFiles?.map((e) => e.toJson()).toList();
    }
    _data["creator"] = creator;
    _data["updater"] = updater;
    _data["createTime"] = createTime;
    _data["updateTime"] = updateTime;
    return _data;
  }
}

class AttachFiles {
  int? pageNo;
  int? pageSize;
  String? name;
  String? url;
  String? fileType;

  AttachFiles({this.pageNo, this.pageSize, this.name, this.url, this.fileType});

  AttachFiles.fromJson(Map<String, dynamic> json) {
    pageNo = json["pageNo"];
    pageSize = json["pageSize"];
    name = json["name"];
    url = json["url"];
    fileType = json["fileType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["pageNo"] = pageNo;
    _data["pageSize"] = pageSize;
    _data["name"] = name;
    _data["url"] = url;
    _data["fileType"] = fileType;
    return _data;
  }
}

class AppProblemRespVo {
  String? title;
  String? content;
  String? comment;
  String? memo;
  String? reporter;
  String? contact;
  String? riverId;
  String? reachId;
  num? level;
  String? checkStatus;
  num? status;
  String? lng;
  String? lat;
  int? id;
  String? riverName;
  String? reachName;
  List<AttachFileList>? attachFileList;
  String? creator;
  num? createTime;
  String? updater;
  num? updateTime;

  AppProblemRespVo(
      {this.title,
      this.content,
      this.comment,
      this.memo,
      this.reporter,
      this.contact,
      this.riverId,
      this.reachId,
      this.level,
      this.checkStatus,
      this.status,
      this.lng,
      this.lat,
      this.id,
      this.riverName,
      this.reachName,
      this.attachFileList,
      this.creator,
      this.createTime,
      this.updater,
      this.updateTime});

  AppProblemRespVo.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    content = json["content"];
    comment = json["comment"];
    memo = json["memo"];
    reporter = json["reporter"];
    contact = json["contact"];
    riverId = json["riverId"];
    reachId = json["reachId"];
    level = json["level"];
    checkStatus = json["checkStatus"];
    status = json["status"];
    lng = json["lng"];
    lat = json["lat"];
    id = json["id"];
    riverName = json["riverName"];
    reachName = json["reachName"];
    attachFileList = json["attachFileList"] == null
        ? null
        : (json["attachFileList"] as List)
            .map((e) => AttachFileList.fromJson(e))
            .toList();
    creator = json["creator"];
    createTime = json["createTime"];
    updater = json["updater"];
    updateTime = json["updateTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["content"] = content;
    _data["comment"] = comment;
    _data["memo"] = memo;
    _data["reporter"] = reporter;
    _data["contact"] = contact;
    _data["riverId"] = riverId;
    _data["reachId"] = reachId;
    _data["level"] = level;
    _data["checkStatus"] = checkStatus;
    _data["status"] = status;
    _data["lng"] = lng;
    _data["lat"] = lat;
    _data["id"] = id;
    _data["riverName"] = riverName;
    _data["reachName"] = reachName;
    if (attachFileList != null) {
      _data["attachFileList"] = attachFileList?.map((e) => e.toJson()).toList();
    }
    _data["creator"] = creator;
    _data["createTime"] = createTime;
    _data["updater"] = updater;
    _data["updateTime"] = updateTime;
    return _data;
  }
}



///---
class ChartProblemEntity {
  List<ChartProblemBean>? list;
  int? total;

  ChartProblemEntity({this.list, this.total});

  ChartProblemEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => ChartProblemBean.fromJson(e)).toList();
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

class ChartProblemBean {
  int? problemType;
  String? problemDescribe;
  int? problemSources;
  int? disposeState;

  ChartProblemBean({this.problemType, this.problemDescribe, this.problemSources, this.disposeState});

  ChartProblemBean.fromJson(Map<String, dynamic> json) {
    problemType = json["problemType"];
    problemDescribe = json["problemDescribe"];
    problemSources = json["problemSources"];
    disposeState = json["disposeState"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["problemType"] = problemType;
    _data["problemDescribe"] = problemDescribe;
    _data["problemSources"] = problemSources;
    _data["disposeState"] = disposeState;
    return _data;
  }
}