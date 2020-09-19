import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacktrud/components/message.dart';

import 'my_message.dart';

class FileMessage extends StatelessWidget {
  final String filename;

  const FileMessage(this.filename, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const tint = Color.fromRGBO(71, 118, 230, 1.0);

    return MyMessage(
      child: Row(
        children: [
          Icon(
            Icons.attach_file,
            color: tint,
          ),
          SizedBox(width: 10),
          Text(
            "test.txt",
            style: TextStyle(
              color: tint,
            ),
          ),
        ],
      ),
    );
  }
}
