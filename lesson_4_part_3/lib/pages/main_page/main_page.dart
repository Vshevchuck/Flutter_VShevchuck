import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(onPressed: downloading, child: Text('Download'),),
    );
  }
  downloading()async{
    final status = await Permission.storage.request();
    if(status.isGranted)
      {
        final externalDir = await getExternalStorageDirectory();
        final taskId = await FlutterDownloader.enqueue(
          url:
          'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg',
          savedDir: externalDir.path,
          fileName: "test",
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
