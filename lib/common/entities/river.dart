class RiverEntity {
  List<RiverBean>? list;
  int? total;

  RiverEntity({this.list, this.total});

  RiverEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => RiverBean.fromJson(e)).toList();
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

class RiverBean {
  String? riverName;
  int? userId;
  int? jingzhangId;
  String? basinId;
  String? waterSystemId;
  String? riverLength;
  String? mianji;
  String? categoryId;
  String? gradeId;
  String? typeId;
  String? shangjiRiverId;
  String? waterStandard;
  String? riverElevation;
  String? code;
  String? path;
  String? shoreSeparationId;
  String? riverLng;
  String? riverLat;
  String? riverEndLng;
  String? riverEndLat;
  int? riverAreaId;
  String? riverPlaceName;
  String? estuaryLng;
  String? estuaryLat;
  int? estuaryAreaId;
  String? estuaryPlaceName;
  String? riverAverageGradient;
  String? averageMultiannualDropWaterDepth;
  String? hydrologicStationId;
  String? isHydrologicStation;
  String? isActualMeasureMaximumFlood;
  String? riverSurvey;
  String? naturalSurvey;
  String? remark;
  String? areaId;
  String? id;
  String? flowThroughDeptNames;
  String? shangjiRiverName;
  String? shangjiRiverCode;
  String? creator;
  num? createTime;

  RiverBean({this.riverName, this.userId, this.jingzhangId, this.basinId, this.waterSystemId, this.riverLength, this.mianji, this.categoryId, this.gradeId, this.typeId, this.shangjiRiverId, this.waterStandard, this.riverElevation, this.code, this.path, this.shoreSeparationId, this.riverLng, this.riverLat, this.riverEndLng, this.riverEndLat, this.riverAreaId, this.riverPlaceName, this.estuaryLng, this.estuaryLat, this.estuaryAreaId, this.estuaryPlaceName, this.riverAverageGradient, this.averageMultiannualDropWaterDepth, this.hydrologicStationId, this.isHydrologicStation, this.isActualMeasureMaximumFlood, this.riverSurvey, this.naturalSurvey, this.remark, this.areaId, this.id, this.flowThroughDeptNames, this.shangjiRiverName, this.shangjiRiverCode, this.creator, this.createTime});

  RiverBean.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    jingzhangId = json["jingzhangId"];
    riverName = json["riverName"];
    basinId = json["basinId"];
    waterSystemId = json["waterSystemId"];
    riverLength = json["riverLength"];
    mianji = json["mianji"];
    categoryId = json["categoryId"];
    gradeId = json["gradeId"];
    typeId = json["typeId"];
    shangjiRiverId = json["shangjiRiverId"];
    waterStandard = json["waterStandard"];
    riverElevation = json["riverElevation"];
    code = json["code"];
    path = json["path"];
    shoreSeparationId = json["shoreSeparationId"];
    riverLng = json["riverLng"];
    riverLat = json["riverLat"];
    riverEndLng = json["riverEndLng"];
    riverEndLat = json["riverEndLat"];
    riverAreaId = json["riverAreaId"];
    riverPlaceName = json["riverPlaceName"];
    estuaryLng = json["estuaryLng"];
    estuaryLat = json["estuaryLat"];
    estuaryAreaId = json["estuaryAreaId"];
    estuaryPlaceName = json["estuaryPlaceName"];
    riverAverageGradient = json["riverAverageGradient"];
    averageMultiannualDropWaterDepth = json["averageMultiannualDropWaterDepth"];
    hydrologicStationId = json["hydrologicStationId"];
    isHydrologicStation = json["isHydrologicStation"];
    isActualMeasureMaximumFlood = json["isActualMeasureMaximumFlood"];
    riverSurvey = json["riverSurvey"];
    naturalSurvey = json["naturalSurvey"];
    remark = json["remark"];
    areaId = json["areaId"];
    id = json["id"];
    flowThroughDeptNames = json["flowThroughDeptNames"];
    shangjiRiverName = json["shangjiRiverName"];
    shangjiRiverCode = json["shangjiRiverCode"];
    creator = json["creator"];
    createTime = json["createTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["riverName"] = riverName;
    _data["basinId"] = basinId;
    _data["waterSystemId"] = waterSystemId;
    _data["riverLength"] = riverLength;
    _data["mianji"] = mianji;
    _data["categoryId"] = categoryId;
    _data["gradeId"] = gradeId;
    _data["typeId"] = typeId;
    _data["shangjiRiverId"] = shangjiRiverId;
    _data["waterStandard"] = waterStandard;
    _data["riverElevation"] = riverElevation;
    _data["code"] = code;
    _data["path"] = path;
    _data["shoreSeparationId"] = shoreSeparationId;
    _data["riverLng"] = riverLng;
    _data["riverLat"] = riverLat;
    _data["riverEndLng"] = riverEndLng;
    _data["riverEndLat"] = riverEndLat;
    _data["riverAreaId"] = riverAreaId;
    _data["riverPlaceName"] = riverPlaceName;
    _data["estuaryLng"] = estuaryLng;
    _data["estuaryLat"] = estuaryLat;
    _data["estuaryAreaId"] = estuaryAreaId;
    _data["estuaryPlaceName"] = estuaryPlaceName;
    _data["riverAverageGradient"] = riverAverageGradient;
    _data["averageMultiannualDropWaterDepth"] = averageMultiannualDropWaterDepth;
    _data["hydrologicStationId"] = hydrologicStationId;
    _data["isHydrologicStation"] = isHydrologicStation;
    _data["isActualMeasureMaximumFlood"] = isActualMeasureMaximumFlood;
    _data["riverSurvey"] = riverSurvey;
    _data["naturalSurvey"] = naturalSurvey;
    _data["remark"] = remark;
    _data["areaId"] = areaId;
    _data["id"] = id;
    _data["flowThroughDeptNames"] = flowThroughDeptNames;
    _data["shangjiRiverName"] = shangjiRiverName;
    _data["shangjiRiverCode"] = shangjiRiverCode;
    _data["creator"] = creator;
    _data["createTime"] = createTime;
    return _data;
  }
}
