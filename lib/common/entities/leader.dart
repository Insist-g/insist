import 'package:flutter_ducafecat_news_getx/common/entities/river.dart';

class LeaderEntity {
  List<LeaderBean>? list;
  int? total;

  LeaderEntity({this.list, this.total});

  LeaderEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null
        ? null
        : (json["list"] as List).map((e) => LeaderBean.fromJson(e)).toList();
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

class LeaderBean {
  int? userId;
  int? userType;
  String? name;
  String? phone;
  String? contacttel;
  String? riverDuty;
  String? adminduty;
  String? mainLeader;
  String? administrationLevel;
  String? portalState;
  String? isWork;
  int? deptId;
  int? id;
  String? riverId;
  String? creator;
  num? createTime;
  String? deptName;
  List<String>? reachNames;

  LeaderBean(
      {this.userId,
      this.userType,
      this.name,
      this.phone,
      this.contacttel,
      this.riverDuty,
      this.adminduty,
      this.mainLeader,
      this.administrationLevel,
      this.portalState,
      this.isWork,
      this.deptId,
      this.id,
      this.riverId,
      this.creator,
      this.createTime,
      this.reachNames,
      this.deptName});

  LeaderBean.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    userType = json["userType"];
    name = json["name"];
    phone = json["phone"];
    contacttel = json["contacttel"];
    riverDuty = json["riverDuty"];
    adminduty = json["adminduty"];
    mainLeader = json["mainLeader"];
    administrationLevel = json["administrationLevel"];
    portalState = json["portalState"];
    isWork = json["isWork"];
    deptId = json["deptId"];
    id = json["id"];
    riverId = json["riverId"];
    creator = json["creator"];
    createTime = json["createTime"];
    deptName = json["deptName"];
    reachNames = json["reachUserDOList"] == null
        ? null
        : (json["reachUserDOList"] as List)
            .map((e) => (e['reachName'] ?? "") as String)
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["userId"] = userId;
    _data["userType"] = userType;
    _data["name"] = name;
    _data["phone"] = phone;
    _data["contacttel"] = contacttel;
    _data["riverDuty"] = riverDuty;
    _data["adminduty"] = adminduty;
    _data["mainLeader"] = mainLeader;
    _data["administrationLevel"] = administrationLevel;
    _data["portalState"] = portalState;
    _data["isWork"] = isWork;
    _data["deptId"] = deptId;
    _data["id"] = id;
    _data["riverId"] = riverId;
    _data["creator"] = creator;
    _data["createTime"] = createTime;
    _data["deptName"] = deptName;
    return _data;
  }
}

class LeaderDetailEntity {
  UserExtDo? userExtDo;
  List<RiverBean>? riverList;

  LeaderDetailEntity({this.userExtDo, this.riverList});

  LeaderDetailEntity.fromJson(Map<String, dynamic> json) {
    userExtDo = json["userExtDO"] == null
        ? null
        : UserExtDo.fromJson(json["userExtDO"]);
    riverList = json["riverList"] == null
        ? null
        : (json["riverList"] as List)
            .map((e) => RiverBean.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (userExtDo != null) {
      _data["userExtDO"] = userExtDo?.toJson();
    }
    if (riverList != null) {
      _data["riverList"] = riverList?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class UserExtDo {
  num? createTime;
  num? updateTime;
  String? creator;
  String? updater;
  bool? deleted;
  String? creatorName;
  String? updaterName;
  int? id;
  int? userId;
  List<ReachUserDoList>? reachUserDoList;
  int? userType;
  String? name;
  String? phone;
  String? contacttel;
  String? riverDuty;
  String? adminduty;
  String? mainLeader;
  String? administrationLevel;
  String? portalState;
  String? isWork;
  int? deptId;
  String? deptName;
  Dept? dept;
  String? deptLevel;
  int? oldId;
  String? oldTable;

  UserExtDo(
      {this.createTime,
      this.updateTime,
      this.creator,
      this.updater,
      this.deleted,
      this.creatorName,
      this.updaterName,
      this.id,
      this.userId,
      this.reachUserDoList,
      this.userType,
      this.name,
      this.phone,
      this.contacttel,
      this.riverDuty,
      this.adminduty,
      this.mainLeader,
      this.administrationLevel,
      this.portalState,
      this.isWork,
      this.deptId,
      this.deptName,
      this.dept,
      this.deptLevel,
      this.oldId,
      this.oldTable});

  UserExtDo.fromJson(Map<String, dynamic> json) {
    createTime = json["createTime"];
    updateTime = json["updateTime"];
    creator = json["creator"];
    updater = json["updater"];
    deleted = json["deleted"];
    creatorName = json["creatorName"];
    updaterName = json["updaterName"];
    id = json["id"];
    userId = json["userId"];
    reachUserDoList = json["reachUserDOList"] == null
        ? null
        : (json["reachUserDOList"] as List)
            .map((e) => ReachUserDoList.fromJson(e))
            .toList();
    userType = json["userType"];
    name = json["name"];
    phone = json["phone"];
    contacttel = json["contacttel"];
    riverDuty = json["riverDuty"];
    adminduty = json["adminduty"];
    mainLeader = json["mainLeader"];
    administrationLevel = json["administrationLevel"];
    portalState = json["portalState"];
    isWork = json["isWork"];
    deptId = json["deptId"];
    deptName = json["deptName"];
    dept = json["dept"] == null ? null : Dept.fromJson(json["dept"]);
    deptLevel = json["deptLevel"];
    oldId = json["oldId"];
    oldTable = json["oldTable"];
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
    _data["userId"] = userId;
    if (reachUserDoList != null) {
      _data["reachUserDOList"] =
          reachUserDoList?.map((e) => e.toJson()).toList();
    }
    _data["userType"] = userType;
    _data["name"] = name;
    _data["phone"] = phone;
    _data["contacttel"] = contacttel;
    _data["riverDuty"] = riverDuty;
    _data["adminduty"] = adminduty;
    _data["mainLeader"] = mainLeader;
    _data["administrationLevel"] = administrationLevel;
    _data["portalState"] = portalState;
    _data["isWork"] = isWork;
    _data["deptId"] = deptId;
    _data["deptName"] = deptName;
    if (dept != null) {
      _data["dept"] = dept?.toJson();
    }
    _data["deptLevel"] = deptLevel;
    _data["oldId"] = oldId;
    _data["oldTable"] = oldTable;
    return _data;
  }
}

class Dept {
  String? createTime;
  String? updateTime;
  String? creator;
  String? updater;
  bool? deleted;
  String? creatorName;
  String? updaterName;
  int? tenantId;
  int? id;
  String? name;
  int? parentId;
  int? sort;
  String? address;
  int? leaderUserId;
  String? phone;
  String? email;
  int? status;
  int? type;
  String? code;
  int? level;
  String? shortName;
  String? parentCode;
  String? memo;
  String? geoData;

  Dept(
      {this.createTime,
      this.updateTime,
      this.creator,
      this.updater,
      this.deleted,
      this.creatorName,
      this.updaterName,
      this.tenantId,
      this.id,
      this.name,
      this.parentId,
      this.sort,
      this.address,
      this.leaderUserId,
      this.phone,
      this.email,
      this.status,
      this.type,
      this.code,
      this.level,
      this.shortName,
      this.parentCode,
      this.memo,
      this.geoData});

  Dept.fromJson(Map<String, dynamic> json) {
    createTime = json["createTime"];
    updateTime = json["updateTime"];
    creator = json["creator"];
    updater = json["updater"];
    deleted = json["deleted"];
    creatorName = json["creatorName"];
    updaterName = json["updaterName"];
    tenantId = json["tenantId"];
    id = json["id"];
    name = json["name"];
    parentId = json["parentId"];
    sort = json["sort"];
    address = json["address"];
    leaderUserId = json["leaderUserId"];
    phone = json["phone"];
    email = json["email"];
    status = json["status"];
    type = json["type"];
    code = json["code"];
    level = json["level"];
    shortName = json["shortName"];
    parentCode = json["parentCode"];
    memo = json["memo"];
    geoData = json["geoData"];
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
    _data["tenantId"] = tenantId;
    _data["id"] = id;
    _data["name"] = name;
    _data["parentId"] = parentId;
    _data["sort"] = sort;
    _data["address"] = address;
    _data["leaderUserId"] = leaderUserId;
    _data["phone"] = phone;
    _data["email"] = email;
    _data["status"] = status;
    _data["type"] = type;
    _data["code"] = code;
    _data["level"] = level;
    _data["shortName"] = shortName;
    _data["parentCode"] = parentCode;
    _data["memo"] = memo;
    _data["geoData"] = geoData;
    return _data;
  }
}

class ReachUserDoList {
  String? createTime;
  String? updateTime;
  String? creator;
  String? updater;
  bool? deleted;
  String? creatorName;
  String? updaterName;
  String? id;
  String? reachId;
  String? reachName;
  int? userExtId;
  String? userExtName;
  UserExt? userExt;
  int? systemUserId;
  int? inspecteNum;
  String? riverId;
  String? riverName;
  int? userType;
  int? deptLevel;

  ReachUserDoList(
      {this.createTime,
      this.updateTime,
      this.creator,
      this.updater,
      this.deleted,
      this.creatorName,
      this.updaterName,
      this.id,
      this.reachId,
      this.reachName,
      this.userExtId,
      this.userExtName,
      this.userExt,
      this.systemUserId,
      this.inspecteNum,
      this.riverId,
      this.riverName,
      this.userType,
      this.deptLevel});

  ReachUserDoList.fromJson(Map<String, dynamic> json) {
    createTime = json["createTime"];
    updateTime = json["updateTime"];
    creator = json["creator"];
    updater = json["updater"];
    deleted = json["deleted"];
    creatorName = json["creatorName"];
    updaterName = json["updaterName"];
    id = json["id"];
    reachId = json["reachId"];
    reachName = json["reachName"];
    userExtId = json["userExtId"];
    userExtName = json["userExtName"];
    userExt =
        json["userExt"] == null ? null : UserExt.fromJson(json["userExt"]);
    systemUserId = json["systemUserId"];
    inspecteNum = json["inspecteNum"];
    riverId = json["riverId"];
    riverName = json["riverName"];
    userType = json["userType"];
    deptLevel = json["deptLevel"];
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
    _data["reachId"] = reachId;
    _data["reachName"] = reachName;
    _data["userExtId"] = userExtId;
    _data["userExtName"] = userExtName;
    if (userExt != null) {
      _data["userExt"] = userExt?.toJson();
    }
    _data["systemUserId"] = systemUserId;
    _data["inspecteNum"] = inspecteNum;
    _data["riverId"] = riverId;
    _data["riverName"] = riverName;
    _data["userType"] = userType;
    _data["deptLevel"] = deptLevel;
    return _data;
  }
}

class UserExt {
  UserExt();

  UserExt.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};

    return _data;
  }
}
