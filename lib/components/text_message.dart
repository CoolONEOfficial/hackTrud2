import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacktrud/components/message.dart';
import 'package:hacktrud/types/message.dart';

class TextMessage extends StatelessWidget {
  final TextMessageType type;
  final arg;
  final dateCreate = DateTime.now();

  TextMessage(this.type, {Key key, this.arg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subtitleColor =
        Theme.of(context).textTheme.subtitle1.color.withOpacity(0.5);
    return Message(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "TrudBot",
                style: Theme.of(context).accentTextTheme.bodyText1.apply(
                      color: subtitleColor,
                    ),
              ),
              Spacer(),
              Text(
                "${dateCreate.hour}:${dateCreate.minute}",
                style: Theme.of(context).textTheme.caption.apply(
                      color: subtitleColor,
                    ),
              )
            ],
          ),
          Container(height: 8),
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText1,
              children: type.textContent(context, arg),
            ),
          ),
        ],
      ),
    );
  }
}
