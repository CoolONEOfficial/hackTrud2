import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacktrud/components/bot_message.dart';

class VacancyMessage extends StatelessWidget {
  final String title;
  final String description;

  const VacancyMessage(
    this.title,
    this.description, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BotMessage(
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).accentTextTheme.headline3,
            ),
            SizedBox(height: 11),
            Text(
              description,
              style: Theme.of(context).accentTextTheme.bodyText1,
            )
          ],
        ),
      );
}
