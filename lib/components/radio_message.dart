import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacktrud/components/message.dart';

class RadioMessage extends StatelessWidget {
  final Function(dynamic) didOutput;
  final List<String> answers;

  const RadioMessage(
    this.answers, {
    Key key,
    @required this.didOutput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Message(
        padding: EdgeInsets.zero,
        color: Color.fromRGBO(46, 125, 232, 1.0),
        child: Container(
          height: 38,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: answers
                .map(
                  (answer) => [
                    Expanded(
                      child: Platform.isIOS
                          ? CupertinoButton(
                              child: buildButtonContent(answer, context),
                              onPressed: () => didTapButton(answer),
                              minSize: 0,
                              padding: EdgeInsets.zero,
                            )
                          : Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: buildButtonContent(answer, context),
                                onTap: () => didTapButton(answer),
                              ),
                            ),
                    ),
                    Container(
                      color: Color.fromRGBO(221, 221, 221, 1),
                      width: 0.5,
                      height: 23,
                    )
                  ],
                )
                .expand((e) => e)
                .toList()
                  ..removeLast(),
          ),
        ),
      );

  void didTapButton(String answer) {
    didOutput(answer);
  }

  Center buildButtonContent(String answer, BuildContext context) {
    return Center(
      child: Text(
        answer,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
