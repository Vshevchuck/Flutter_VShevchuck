import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int progress =0;
  final ReceivePort _receivePort = ReceivePort();
  static downloadingCallBack(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    sendPort?.send([id,status,progress]);
  }

  @override
  void initState(){
    super.initState();
    FlutterDownloader.registerCallback(downloadingCallBack);
    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(onPressed: downloading, child: Text('Download'),),
    );
  }

  downloading()async{
    final status = await Permission.storage.request();
    Directory? directory;
    if(status.isGranted)
      {
        final externalDir = await Directory('/storage/emulated/0/Download');
        final taskId = await FlutterDownloader.enqueue(
          url:
          'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg',
          savedDir: externalDir.path,
          fileName: "test.jpeg",
          showNotification: true, // show download progress in status bar (for Android)
          openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        );
      }
    else
      {
        print("Premission deined");
      }
  }
}
