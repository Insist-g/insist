class DictBean {
  String? dictType;
  String? value;
  String? label;
  String? colorType;
  String? cssClass;

  DictBean(
      {this.dictType, this.value, this.label, this.colorType, this.cssClass});

  DictBean.fromJson(Map<String, dynamic> json) {
    dictType = json["dictType"];
    value = json["value"];
    label = json["label"];
    colorType = json["colorType"];
    cssClass = json["cssClass"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dictType"] = dictType;
    _data["value"] = value;
    _data["label"] = label;
    _data["colorType"] = colorType;
    _data["cssClass"] = cssClass;
    return _data;
  }
}
