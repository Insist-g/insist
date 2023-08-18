class GuiderWord {
  String? name;
  String? pdf;
  List<String>? image;
  List<Content>? content;

  GuiderWord({this.name, this.image, this.content, this.pdf});

  GuiderWord.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    pdf = json["pdf"];
    image = json["image"] == null ? null : List<String>.from(json["image"]);
    content = json["content"] == null
        ? null
        : (json["content"] as List).map((e) => Content.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["pdf"] = pdf;
    if (image != null) {
      _data["image"] = image;
    }
    if (content != null) {
      _data["content"] = content?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Content {
  String? title;
  String? image;
  String? str;

  Content({this.title, this.image, this.str});

  Content.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    image = json["image"];
    str = json["str"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["image"] = image;
    _data["str"] = str;
    return _data;
  }
}
