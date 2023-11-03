class LoginResult {
  int? userId;
  String? accessToken;
  String? refreshToken;
  int? expiresTime;

  LoginResult(
      {this.userId, this.accessToken, this.refreshToken, this.expiresTime});

  LoginResult.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    accessToken = json["accessToken"];
    refreshToken = json["refreshToken"];
    expiresTime = json["expiresTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["userId"] = userId;
    _data["accessToken"] = accessToken;
    _data["refreshToken"] = refreshToken;
    _data["expiresTime"] = expiresTime;
    return _data;
  }
}

class UserProfile {
  String? nickname;
  String? mobile;
  String? avatar;
  int? id;
  String? deptName;
  String? postName;
  String? reachNames;

  UserProfile(
      {this.nickname,
      this.mobile,
      this.avatar,
      this.id,
      this.deptName,
      this.postName,
      this.reachNames});

  UserProfile.fromJson(Map<String, dynamic> json) {
    nickname = json["nickname"] ?? "";
    mobile = json["mobile"] ?? "";
    avatar = json["avatar"] ?? "";
    id = json["id"];
    deptName = json["deptName"] ?? "";
    postName = json["postName"] ?? "";
    reachNames = json["reachNames"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["nickname"] = nickname;
    _data["mobile"] = mobile;
    _data["avatar"] = avatar;
    _data["id"] = id;
    _data["deptName"] = deptName;
    _data["postName"] = postName;
    _data["reachNames"] = reachNames;
    return _data;
  }
}
