import 'dart:math';

class PieChartBean {
  int? count;
  List? data;

  PieChartBean({this.count, this.data});
}

class BarChartBean {
  String? riverId;
  String? riverName;
  int? patrolNumber;
  int? questionsNumber;
  int? disposeNumber;
  int? maxNumber;

  BarChartBean(
      {this.riverId,
      this.riverName,
      this.patrolNumber,
      this.questionsNumber,
      this.disposeNumber,
      this.maxNumber});

  BarChartBean.fromJson(Map<String, dynamic> json) {
    riverId = json["riverId"];
    riverName = json["riverName"];
    patrolNumber = json["patrolNumber"];
    questionsNumber = json["questionsNumber"];
    disposeNumber = json["disposeNumber"];
    maxNumber = max(
        10,
        max(json["patrolNumber"] ?? 0,
            max(json["questionsNumber"] ?? 0, json["disposeNumber"] ?? 0)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["riverId"] = riverId;
    _data["riverName"] = riverName;
    _data["patrolNumber"] = patrolNumber;
    _data["questionsNumber"] = questionsNumber;
    _data["disposeNumber"] = disposeNumber;
    return _data;
  }
}
