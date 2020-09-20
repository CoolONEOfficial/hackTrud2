import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacktrud/components/message.dart';

class RadioMessage extends StatelessWidget {
  final Function(dynamic) didOutput;
  final List<String> answers;
  final List<dynamic> values;

  const RadioMessage(
    this.answers, {
    this.values,
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
                .asMap()
                .entries
                .map(
                  (i) {
                    var index = i.key;
                    var answer = i.value;
                    return [
                      Expanded(
                        child: Platform.isIOS
                            ? CupertinoButton(
                                child: buildButtonContent(answer, context),
                                onPressed: () => didTapButton(index),
                                minSize: 0,
                                padding: EdgeInsets.zero,
                              )
                            : Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  child: buildButtonContent(answer, context),
                                  onTap: () => didTapButton(index),
                                ),
                              ),
                      ),
                      Container(
                        color: Color.fromRGBO(221, 221, 221, 1),
                        width: 0.5,
                        height: 23,
                      )
                    ];
                  },
                )
                .expand((e) => e)
                .toList()
                  ..removeLast(),
          ),
        ),
      );

  void didTapButton(int index) {
    didOutput(values != null ? values[index] : answers[index]);
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
