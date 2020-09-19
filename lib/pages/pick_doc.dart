
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PickDocPage extends StatefulWidget {
  PickDocPage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PickDocPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Выберите резюме"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformButton(
              child: Text("Выбрать документ"),
              onPressed: () async {
                FilePickerResult result = await FilePicker.platform.pickFiles();
                if(result != null) {
                  File file = File(result.files.single.path);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}