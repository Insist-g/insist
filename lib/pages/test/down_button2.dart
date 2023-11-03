import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GeolocatorSettingsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator Settings Example'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: const LatLng(0, 0),
          zoom: 1,
          minZoom: 0,
          maxZoom: 19,
        ),
        children: [
          TileLayer(
            urlTemplate: 'http://t{s}.tianditu.gov.cn/vec_w/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&markers=116.34867,39.94593|116.42626,39.94731|116.4551,39.90267|116.43381,39.86766|116.34249,39.87178|116.32807,39.90748&LAYER=vec&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=9640a1797b85caa77fef86ccea6947a1',
            userAgentPackageName: 'cn.com.guobaoyou.insist',
            subdomains: ['0', '1', '2', '3'],
            maxZoom: 18,
          ),
          CurrentLocationLayer(
            positionStream: const LocationMarkerDataStreamFactory()
                .fromGeolocatorPositionStream(
              stream: Geolocator.getPositionStream(
                locationSettings: const LocationSettings(
                  accuracy: LocationAccuracy.medium,
                  distanceFilter: 50,
                  timeLimit: Duration(minutes: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
