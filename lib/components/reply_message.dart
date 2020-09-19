import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'my_message.dart';

class ReplyMessage extends StatelessWidget {
  final String reply;

  const ReplyMessage(this.reply, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MyMessage(
        child: Text(
          reply,
          style: TextStyle(
            color: Colors.black,
          ),
          maxLines: 4,
          overflow: TextOverflow.fade,
        ),
      );
}
