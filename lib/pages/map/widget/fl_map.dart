import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/store/position.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class FLMap extends StatefulWidget {
  LatLng? initCenter;
  List<LatLng>? points;
  List<List<LatLng>>? lines;
  final MapController? controller;
  final bool is3D;
  final double zoom;
  final bool currentLocation;
  final bool drawPath;

  FLMap({
    super.key,
    this.initCenter,
    this.points,
    this.lines,
    this.controller,
    //地图是否是3D
    this.is3D = true,
    //是否显示当前位置
    this.currentLocation = false,
    //是否绘制轨迹
    this.drawPath = false,
    this.zoom = 12,
  });

  @override
  State<FLMap> createState() => _FLMapState();
}

class _FLMapState extends State<FLMap> {
  final String Key = '9640a1797b85caa77fef86ccea6947a1';
  final String MAP_3D =
      "http://t{s}.tianditu.gov.cn/img_w/wmts?service=wmts&request=GetTile&version=1.0.0&LAYER=img&tileMatrixSet=w&style=default&format=tiles&TileMatrix={z}&TileRow={y}&TileCol={x}&tk=";
  final String MAP_VECTOR =
      "http://t{s}.tianditu.gov.cn/vec_w/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&markers=116.34867,39.94593|116.42626,39.94731|116.4551,39.90267|116.43381,39.86766|116.34249,39.87178|116.32807,39.90748&LAYER=vec&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=";

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.controller,
      options: MapOptions(
          center: widget.initCenter ?? LatLng(37.40564, 116.65),
          zoom: widget.zoom,
          maxZoom: 18,
          minZoom: 1,
          keepAlive: true),
      children: [
        //地图底图
        TileLayer(
          urlTemplate: (widget.is3D ? MAP_3D : MAP_VECTOR) + Key,
          userAgentPackageName: 'cn.com.guobaoyou.insist',
          subdomains: ['0', '1', '2', '3'],
          // tms: widget.is3D, // 使用TMS坐标系
        ),
        //地图标注
        TileLayer(
          urlTemplate:
              'http://t{s}.tianditu.gov.cn/cva_w/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=cva&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=9640a1797b85caa77fef86ccea6947a1',
          userAgentPackageName: 'cn.com.guobaoyou.insist',
          subdomains: ['0', '1', '2', '3'],
          backgroundColor: Colors.transparent,
        ),
        //当前位置
        if (widget.currentLocation) CurrentLocationLayer(),
        //线
        TappablePolylineLayer(
          // Will only render visible polylines, increasing performance
          polylineCulling: true,
          pointerDistanceTolerance: 20,
          polylines: (widget.lines ?? []).asMap().keys.map((index) {
            return TaggedPolyline(
              tag: 'My Polyline',
              // An optional tag to distinguish polylines in callback
              points: (widget.lines ?? [])[index],
              color: Colors.primaries[index % 10],
              strokeWidth: 2,
            );
          }).toList(),
          onTap: (List<TaggedPolyline> lineList, TapUpDetails tapPosition) {
            //tag:可以传递河流信息
            _showBottomSheet();
          },
          onMiss: (tapPosition) {
            print('No polyline was tapped at position ' +
                tapPosition.globalPosition.toString());
          },
        ),
        //轨迹
        if (widget.drawPath)
          GetBuilder<PositionStore>(builder: (logic) {
            return Obx(() {
              return PolylineLayer(
                polylines: [Polyline(points: logic.getPath)],
              );
            });
          }),
        //点
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            markers: (widget.points ?? []).map((e) {
              return Marker(
                point: LatLng(e.latitude, e.longitude),
                builder: (_) =>
                    const Icon(Icons.location_on_outlined, size: 30),
                anchorPos: AnchorPos.align(AnchorAlign.top),
                rotateAlignment: AnchorAlign.top.rotationAlignment,
              );
            }).toList(),
            popupDisplayOptions: PopupDisplayOptions(
              builder: (BuildContext context, Marker marker) => Container(
                width: 20,
                height: 20,
                color: Colors.pink,
              ),
            ),
          ),
        ),
        //取线中间的点做标记
        if (widget.lines != null)
          PopupMarkerLayer(
            options: PopupMarkerLayerOptions(
              markers: (widget.lines ?? []).map((e) {
                return Marker(
                  point: _getListCenterObj(e),
                  builder: (_) => const Icon(
                    Icons.opacity,
                    size: 30,
                    color: AppColor.mainColor,
                  ),
                  anchorPos: AnchorPos.align(AnchorAlign.top),
                  rotateAlignment: AnchorAlign.top.rotationAlignment,
                );
              }).toList(),
              popupDisplayOptions: PopupDisplayOptions(
                builder: (BuildContext context, Marker marker) => Container(
                  width: 20,
                  height: 20,
                  color: Colors.yellow,
                ),
              ),
            ),
          ),
        ////区域
        // PolygonLayer(
        //   polygons: [
        //     Polygon(
        //       color: Color(0x55000000),
        //       // 多边形的填充颜色
        //       borderColor: Colors.blue,
        //       // 多边形的边框颜色
        //       borderStrokeWidth: 1,
        //       // 边框宽度
        //       isFilled: true,
        //       points: [
        //         LatLng(43.74900, 127.34419),
        //         LatLng(43.38284, 128.23118),
        //         LatLng(42.98033, 126.77094),
        //       ],
        //     ),
        //   ],
        // ),
        //线
      ],
    );
  }

  _showBottomSheet() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("起点："),
            subtitle: Text("我是起点位置名称"),
          ),
          ListTile(
            title: Text("终点："),
            subtitle: Text("我是终点位置名称"),
          ),
          ListTile(
            title: Text("长度："),
            subtitle: Text("12km"),
          ),
          ListTile(
            title: Text("备注："),
            subtitle: Text("备注信息备注信息备注信息备注信息备注信息"),
          ),
        ],
      ),
    ));
  }

  LatLng _getListCenterObj(List<LatLng> line) {
    return line[line.length ~/ 2];
  }
}
