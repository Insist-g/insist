import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';

class TDMapOverLay extends StatefulWidget {
  const TDMapOverLay({Key? key}) : super(key: key);

  @override
  State<TDMapOverLay> createState() => _TDMapOverLayState();
}

class _TDMapOverLayState extends State<TDMapOverLay>
    with TickerProviderStateMixin {
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String messageFromOverlay = "(000.000,000.000)";

  late AnimationController _ctrl;
  late Animation<double> opacityAnim;

  @override
  void initState() {
    super.initState();
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameOverlay,
    );
    log("$res : HOME");
    _receivePort.listen((message) {
      log("message from UI: $message");
      var res = jsonDecode(message);
      Map<String, dynamic> decodedData = json.decode(message);
      double latitude = decodedData["latitude"];
      double longitude = res['longitude'] ?? "";
      setState(() {
        messageFromOverlay =
            "(${longitude.toStringAsFixed(3)},${latitude.toStringAsFixed(3)})";
      });
    });
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    opacityAnim = Tween<double>(begin: 0.2, end: 1.0).animate(_ctrl);
    _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    _ctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(messageFromOverlay,
                style: TextStyle(fontSize: 4, color: Colors.black)),
            FadeTransition(
                opacity: opacityAnim,
                child: Container(
                  width: double.infinity, height: double.infinity,
                  margin: EdgeInsets.all(13),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                )),
            Icon(Icons.gps_not_fixed,size: 35)
          ],
        ),
      ),
      onTap: (){
        homePort ??= IsolateNameServer.lookupPortByName(
          _kPortNameHome,
        );
        homePort?.send('openApp');
      },
    );
  }
}
