import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'message.dart';

class BotMessage extends StatelessWidget {
  final Widget child;
  final dateCreate = DateTime.now();

  BotMessage({
    Key key,
    this.child,
  }) : super(key: key);

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
                DateFormat('kk:mm').format(dateCreate),
                style: Theme.of(context).textTheme.caption.apply(
                      color: subtitleColor,
                    ),
              )
            ],
          ),
          Container(height: 8),
          child
        ],
      ),
    );
  }
}
