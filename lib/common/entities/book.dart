class GuiderWord {
  String? title;
  String? content;
  String? createTime;
  int? state;
  String? location;
  List<String>? image;

  GuiderWord(
      {this.state,
      this.title,
      this.content,
      this.createTime,
      this.image,
      this.location});

  GuiderWord.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    content = json["content"];
    createTime = json["createTime"];
    state = json["state"];
    location = json["location"];
    image = json["image"] == null ? null : List<String>.from(json["image"]);
  }
}


class Example {
  String? name;
  List<Aswitch>? aswitch;
  String? remark;
  List<String>? images;

  Example({this.name, this.aswitch, this.remark, this.images});

  Example.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    aswitch = json["switch"] == null ? null : (json["switch"] as List).map((e) => Aswitch.fromJson(e)).toList();
    remark = json["remark"];
    images = json["images"] == null ? null : List<String>.from(json["images"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    if(aswitch != null) {
      _data["switch"] = aswitch?.map((e) => e.toJson()).toList();
    }
    _data["remark"] = remark;
    if(images != null) {
      _data["images"] = images;
    }
    return _data;
  }
}

class Aswitch {
  String? title;
  bool? select;

  Aswitch({this.title, this.select});

  Aswitch.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    select = json["select"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["select"] = select;
    return _data;
  }
}