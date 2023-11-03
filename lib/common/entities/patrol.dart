class PatrolEntity {
  List<PatrolBean>? list;
  int? total;

  PatrolEntity({this.list, this.total});

  PatrolEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => PatrolBean.fromJson(e)).toList();
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

class PatrolBean {
  String? patrolName;
  int? userExtId;
  String? reachId;
  int? deptId;
  num? startTime;
  String? startLongitude;
  String? startLatitude;
  num? endTime;
  String? endLongitude;
  String? endLatitude;
  String? trackInspection;
  String? patrolState;
  String? creatTime;
  int? problemCount;
  String? path;
  String? weather;
  String? unit;
  String? content;
  String? quyu;
  String? lastcase;
  String? patrolType;
  String? kilometre;
  int? uploadStatus;
  int? taskType;
  int? patrolId;
  String? name;
  String? reachName;
  String? creator;
  String? updater;
  num? createTime;
  num? updateTime;

  PatrolBean({this.patrolName, this.userExtId, this.reachId, this.deptId, this.startTime, this.startLongitude, this.startLatitude, this.endTime, this.endLongitude, this.endLatitude, this.trackInspection, this.patrolState, this.creatTime, this.problemCount, this.path, this.weather, this.unit, this.content, this.quyu, this.lastcase, this.patrolType, this.kilometre, this.uploadStatus, this.patrolId, this.name, this.reachName, this.creator, this.taskType, this.updater, this.createTime, this.updateTime});

  PatrolBean.fromJson(Map<String, dynamic> json) {
    patrolName = json["patrolName"];
    userExtId = json["userExtId"];
    reachId = json["reachId"];
    deptId = json["deptId"];
    taskType = json["taskType"];
    startTime = json["startTime"];
    startLongitude = json["startLongitude"];
    startLatitude = json["startLatitude"];
    endTime = json["endTime"];
    endLongitude = json["endLongitude"];
    endLatitude = json["endLatitude"];
    trackInspection = json["trackInspection"];
    patrolState = json["patrolState"];
    creatTime = json["creatTime"];
    problemCount = json["problemCount"];
    path = json["path"];
    weather = json["weather"];
    unit = json["unit"];
    content = json["content"];
    quyu = json["quyu"];
    lastcase = json["lastcase"];
    patrolType = json["patrolType"];
    kilometre = json["kilometre"];
    uploadStatus = json["uploadStatus"];
    patrolId = json["patrolId"];
    name = json["name"];
    reachName = json["reachName"];
    creator = json["creator"];
    updater = json["updater"];
    createTime = json["createTime"];
    updateTime = json["updateTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["patrolName"] = patrolName;
    _data["userExtId"] = userExtId;
    _data["reachId"] = reachId;
    _data["deptId"] = deptId;
    _data["startTime"] = startTime;
    _data["startLongitude"] = startLongitude;
    _data["startLatitude"] = startLatitude;
    _data["endTime"] = endTime;
    _data["endLongitude"] = endLongitude;
    _data["endLatitude"] = endLatitude;
    _data["trackInspection"] = trackInspection;
    _data["patrolState"] = patrolState;
    _data["creatTime"] = creatTime;
    _data["problemCount"] = problemCount;
    _data["taskType"] = taskType;
    _data["path"] = path;
    _data["weather"] = weather;
    _data["unit"] = unit;
    _data["content"] = content;
    _data["quyu"] = quyu;
    _data["lastcase"] = lastcase;
    _data["patrolType"] = patrolType;
    _data["kilometre"] = kilometre;
    _data["uploadStatus"] = uploadStatus;
    _data["patrolId"] = patrolId;
    _data["name"] = name;
    _data["reachName"] = reachName;
    _data["creator"] = creator;
    _data["updater"] = updater;
    _data["createTime"] = createTime;
    _data["updateTime"] = updateTime;
    return _data;
  }
}