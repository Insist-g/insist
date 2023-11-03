import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/permission.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapLogic extends GetxController {
  final MapController mapController = MapController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final points = [
    {
      "title": "站点分布",
      "pointsInfo": [
        {
          "name": "河道水位站",
          "id": 1,
          "icon": "url",
          "select": false,
          "points": [
            {"longitude": 126.83725, "latitude": 43.39348},
            {"longitude": 126.85102, "latitude": 43.39242}
          ]
        }
      ]
    },
    {
      "title": "水资源",
      "pointsInfo": [
        {
          "name": "雨量站",
          "id": 2,
          "icon": "Icons.account_balance_outlined",
          "select": false,
          "points": [
            {"longitude": 126.85343, "latitude": 43.40158},
            {"longitude": 126.88399, "latitude": 43.40669}
          ]
        }
      ]
    },
  ];
  final lines = [
    {
      "title": "水域岸线",
      "linesInfo": [
        {
          "name": "提防",
          "id": 1,
          "icon": "Icons.account_balance_outlined",
          "select": true,
          "points": [
            [
              {"longitude": 126.55016, "latitude": 43.83878},
              {"longitude": 127.33645, "latitude": 43.74057},
              {"longitude": 128.21956, "latitude": 43.45625},
            ],
            [
              {"longitude": 126.85333, "latitude": 43.40142},
              {"longitude": 126.88368, "latitude": 43.40669},
              {"longitude": 126.91491, "latitude": 43.41892},
            ],
          ]
        }
      ]
    },
    {
      "title": "水域岸线2",
      "linesInfo": [
        {
          "name": "河流红线",
          "id": 1,
          "icon": "Icons.account_balance_outlined",
          "select": true,
          "points": [
            [
              {"longitude": 126.55016, "latitude": 42.83878},
              {"longitude": 127.33645, "latitude": 42.74057},
              {"longitude": 128.21956, "latitude": 42.45625},
            ],
            [
              {"longitude": 126.85333, "latitude": 42.40142},
              {"longitude": 126.88368, "latitude": 42.40669},
              {"longitude": 126.91491, "latitude": 42.41892},
            ],
          ]
        }
      ]
    }
  ];

  List<PointsItem> drawPointsData = [];
  List<LinesItem> drawLinesData = [];
  bool _is3D = true;

  bool get mapIs3D => _is3D;

  @override
  void onInit() {
    super.onInit();
    drawPointsData = points.map((e) => PointsItem.fromJson(e)).toList();
    drawLinesData = lines.map((e) => LinesItem.fromJson(e)).toList();
    update();
  }

  @override
  void onReady() {
    super.onReady();
    move();
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  void getCurrentPosition() {}

  void move() {
    LocationUtil.getCurrentLocation(showLoading: false).then((value) {
      if (value == null) return;
      mapController.move(LatLng(value.latitude, value.longitude), 15);
    });
  }

  void switchMap() {
    _is3D = !_is3D;
    update();
  }

  void onChange(bool value, info) {
    info.select = value;
    update();
  }

  List<LatLng> getPointsList() {
    List<LatLng> list = [];
    for (var pointsItem in drawPointsData) {
      for (var pointsInfo in pointsItem.pointsInfo ?? []) {
        if (pointsInfo.select ?? false) {
          for (var points in pointsInfo.points) {
            list.add(LatLng(points.latitude, points.longitude));
          }
        }
      }
    }
    return list;
  }

  List<List<LatLng>> getLinesList() {
    List<List<LatLng>> list = [];
    for (var linesItem in drawLinesData) {
      for (LinesInfo linesInfo in linesItem.linesInfo ?? []) {
        if (linesInfo.select ?? false) {
          for (List<Points> line in linesInfo.points ?? []) {
            List<LatLng> a = line
                .map((e) => LatLng(e.latitude ?? 0, e.longitude ?? 0))
                .toList();
            list.add(a);
          }
        }
      }
    }
    return list;
  }
}

class PointsItem {
  String? title;
  List<PointsInfo>? pointsInfo;

  PointsItem({this.title, this.pointsInfo});

  PointsItem.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    pointsInfo = json["pointsInfo"] == null
        ? null
        : (json["pointsInfo"] as List)
            .map((e) => PointsInfo.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    if (pointsInfo != null) {
      _data["pointsInfo"] = pointsInfo?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class LinesItem {
  String? title;
  List<LinesInfo>? linesInfo;

  LinesItem({this.title, this.linesInfo});

  LinesItem.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    linesInfo = json["linesInfo"] == null
        ? null
        : (json["linesInfo"] as List)
            .map((e) => LinesInfo.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    if (linesInfo != null) {
      _data["linesInfo"] = linesInfo?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class PointsInfo {
  String? name;
  int? id;
  String? icon;
  bool? select;
  List<Points>? points;

  PointsInfo({this.name, this.id, this.icon, this.select, this.points});

  PointsInfo.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
    icon = json["icon"];
    select = json["select"];
    points = json["points"] == null
        ? null
        : (json["points"] as List).map((e) => Points.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["id"] = id;
    _data["icon"] = icon;
    _data["select"] = select;
    if (points != null) {
      _data["points"] = points?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Points {
  double? longitude;
  double? latitude;

  Points({this.longitude, this.latitude});

  Points.fromJson(Map<String, dynamic> json) {
    longitude = json["longitude"];
    latitude = json["latitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["longitude"] = longitude;
    _data["latitude"] = latitude;
    return _data;
  }
}

class LinesInfo {
  String? name;
  int? id;
  String? icon;
  bool? select;
  List<List<Points>>? points;

  LinesInfo({this.name, this.id, this.icon, this.select, this.points});

  LinesInfo.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
    icon = json["icon"];
    select = json["select"];
    points = (json["points"] == null
            ? null
            : (json["points"] as List)
                .map((e) => e == null
                    ? []
                    : (e as List).map((e) => Points.fromJson(e)).toList())
                .toList())
        ?.cast<List<Points>>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["id"] = id;
    _data["icon"] = icon;
    _data["select"] = select;
    if (points != null) {
      _data["points"] =
          points?.map((e) => e?.map((e) => e.toJson()).toList() ?? []).toList();
    }
    return _data;
  }
}
