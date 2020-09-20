import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacktrud/types/message.dart';

import 'bot_message.dart';

class TextMessage extends StatelessWidget {
  final TextMessageType type;
  final String plainText;
  final arg;

  TextMessage(
    this.type, {
    Key key,
    this.arg,
    this.plainText,
  }) : super(key: key);
  TextMessage.plainText(
    this.plainText, {
    Key key,
    this.arg,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BotMessage(
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText1,
          children: type != null
              ? type.textContent(context, arg)
              : [
                  TextSpan(
                    text: plainText,
                  )
                ],
        ),
      ),
    );
  }
}
