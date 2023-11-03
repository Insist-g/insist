import 'package:flutter/material.dart';
import 'dart:async';
import 'package:open_filex/open_filex.dart';


class OpenFilePage extends StatefulWidget {
  const OpenFilePage({Key? key}) : super(key: key);

  @override
  OpenFilePageState createState() => OpenFilePageState();
}

class OpenFilePageState extends State<OpenFilePage> {
  var _openResult = 'Unknown';

  Future<void> openFile() async {
    const filePath = '/storage/emulated/0/电表核验 2022-08-25 11:01:58.xlsx';
    final result = await OpenFilex.open(filePath);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('open result: $_openResult\n'),
              TextButton(
                onPressed: openFile,
                child: const Text('Tap to open file'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
