
class VideoEntity {
  List<VideoBean>? list;
  int? total;

  VideoEntity({this.list, this.total});

  VideoEntity.fromJson(Map<String, dynamic> json) {
    list = json["list"] == null ? null : (json["list"] as List).map((e) => VideoBean.fromJson(e)).toList();
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

class VideoBean {
  String? deviceType;
  String? deviceName;
  String? deviceCode;
  int? relateType;
  String? relateId;
  String? lng;
  String? lat;
  String? operator;
  String? phone;
  String? memo;
  int? inputType;
  int? dataType;
  String? interfaceUrl;
  num? remoteControl;
  int? controlType;
  String? unitMondel;
  String? deviceIp;
  int? id;
  num? createTime;
  String? relateRiverName;
  String? relateReachName;
  String? relateGateName;
  String? relateGateHoleName;

  VideoBean({this.deviceType, this.deviceName, this.deviceCode, this.relateType, this.relateId, this.lng, this.lat, this.operator, this.phone, this.memo, this.inputType, this.dataType, this.interfaceUrl, this.remoteControl, this.controlType, this.unitMondel, this.deviceIp, this.id, this.createTime, this.relateRiverName, this.relateReachName, this.relateGateName, this.relateGateHoleName});

  VideoBean.fromJson(Map<String, dynamic> json) {
    deviceType = json["deviceType"];
    deviceName = json["deviceName"];
    deviceCode = json["deviceCode"];
    relateType = json["relateType"];
    relateId = json["relateId"];
    lng = json["lng"];
    lat = json["lat"];
    operator = json["operator"];
    phone = json["phone"];
    memo = json["memo"];
    inputType = json["inputType"];
    dataType = json["dataType"];
    interfaceUrl = json["interfaceUrl"];
    remoteControl = json["remoteControl"];
    controlType = json["controlType"];
    unitMondel = json["unitMondel"];
    deviceIp = json["deviceIp"];
    id = json["id"];
    createTime = json["createTime"];
    relateRiverName = json["relateRiverName"];
    relateReachName = json["relateReachName"];
    relateGateName = json["relateGateName"];
    relateGateHoleName = json["relateGateHoleName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["deviceType"] = deviceType;
    _data["deviceName"] = deviceName;
    _data["deviceCode"] = deviceCode;
    _data["relateType"] = relateType;
    _data["relateId"] = relateId;
    _data["lng"] = lng;
    _data["lat"] = lat;
    _data["operator"] = operator;
    _data["phone"] = phone;
    _data["memo"] = memo;
    _data["inputType"] = inputType;
    _data["dataType"] = dataType;
    _data["interfaceUrl"] = interfaceUrl;
    _data["remoteControl"] = remoteControl;
    _data["controlType"] = controlType;
    _data["unitMondel"] = unitMondel;
    _data["deviceIp"] = deviceIp;
    _data["id"] = id;
    _data["createTime"] = createTime;
    _data["relateRiverName"] = relateRiverName;
    _data["relateReachName"] = relateReachName;
    _data["relateGateName"] = relateGateName;
    _data["relateGateHoleName"] = relateGateHoleName;
    return _data;
  }
}