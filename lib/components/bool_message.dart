import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'my_message.dart';

class BoolMessage extends StatelessWidget {
  final bool value;

  const BoolMessage(this.value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MyMessage(
        child: Text(
          value ? "Да" : "Нет",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
}
