import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacktrud/types/resume.dart';

import 'my_message.dart';

class TypeMessage extends StatelessWidget {
  final ResumeType type;

  const TypeMessage(this.type, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MyMessage(
        child: Text(
          type.name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
}
