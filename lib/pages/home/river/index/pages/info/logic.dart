import 'package:dio/dio.dart';
import 'package:flutter_ducafecat_news_getx/common/apis/river.dart';
import 'package:flutter_ducafecat_news_getx/common/entities/river.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';
import 'package:flutter_ducafecat_news_getx/pages/home/river/index/logic.dart';
import 'package:get/get.dart';

class RiverInfoLogic extends GetxController with StateMixin<RiverBean?> {
  List columnData = [];
  String riverId = "";

  setColumnData(RiverBean data) {
    this.columnData = [
      {
        "title": "长度",
        "value": data.riverLength ?? 0,
      },
      {
        "title": "面积",
        "value": data.mianji ?? 0,
      },
      {
        "title": "河流编码",
        "value": data.code ?? '',
      },
      {
        "title": "所属流域",
        "value": DictStore.to.findLabel(value: data.basinId, type: DictKeys.CTRL_RIVER_BASIN),
      },
      {
        "title": "所属水系",
        "value": DictStore.to.findLabel(value: data.waterSystemId, type: DictKeys.CTRL_PROCESSING_STATE),
      },
      {
        "title": "河流级别",
        "value": DictStore.to.findLabel(value: data.gradeId, type: DictKeys.CTRL_RIVER_GRADE),
      },
      {
        "title": "水面基准",
        "value": data.waterStandard ?? '',
      },
      {
        "title": "河源高程",
        "value": data.riverElevation ?? '',
      },
      {
        "title": "河流所在辖区",
        "value": data.areaId ?? '',
      },
      {
        "title": "起点",
        "value": data.riverAreaId ?? '',
      },
      {
        "title": "终点",
        "value": data.estuaryAreaId ?? '',
      },
      {
        "title": "河长",
        "value": data.userId ?? '',
      },
      {
        "title": "警长",
        "value": data.jingzhangId ?? '',
      },
      // {
      //   "title": "联系部门",
      //   "value": "无字段",
      // },
      // {
      //   "title": "联系人",
      //   "value": "无字段",
      // },
      {
        "title": "简介",
        "value": data.remark ?? '',
      },
      {
        "title": "自然状况",
        "value": data.riverSurvey ?? '',
      },
    ];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    riverId = Get.find<RiverIndexLogic>().riverId ?? "";
    getRiverDetail();
  }

  getRiverDetail() async {
    change(null, status: RxStatus.loading());
    RiverApi.getRiverDetail(riverId).then((value) {
      if (value.data != null) {
        setColumnData(value.data!);
      }
      change(value.data,
          status: value.data == null ? RxStatus.empty() : RxStatus.success());
    }).onError<DioException>((error, stackTrace) {
      change(null, status: RxStatus.error(error.message ?? ""));
    });
  }
}
