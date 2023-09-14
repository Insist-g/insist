import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';

class TDMapOverLay extends StatefulWidget {
  const TDMapOverLay({Key? key}) : super(key: key);

  @override
  State<TDMapOverLay> createState() => _TDMapOverLayState();
}

class _TDMapOverLayState extends State<TDMapOverLay> {
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String? messageFromOverlay;

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
      setState(() {
        messageFromOverlay = 'message from UI: $message';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.0,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  homePort ??= IsolateNameServer.lookupPortByName(
                    _kPortNameHome,
                  );
                  homePort?.send('Date: ${DateTime.now()}');
                },
                child: const Text("Send message to UI"),
              ),
            ),
            Text(messageFromOverlay ?? '')
          ],
        ),
      ),
    );
  }
}
