import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacktrud/types/resume.dart';

abstract class MessageContent {
  MessageContent(this.didOutput);

  List<Widget> buildMessageContent();
  Future<MessageContent> didInput(BuildContext context, input);
  final Function(dynamic) didOutput;
}

abstract class Replyable {
  bool get attachable;
  bool textValidate(String text);
  String get hintText;
}

enum MessageFrom { Me, Bot }

enum MessageType {
  Hello,
  Resume,
  Type,
  Question,
  Congrats,
}

enum TextMessageType {
  Resume,
  ChooseType,
  QuestionYears,
  QuestionSoftSkills,
}

extension TextMessageExtension on TextMessageType {
  List<TextSpan> textContent(BuildContext context, arg) {
    switch (this) {
      case TextMessageType.Resume:
        return <TextSpan>[
          TextSpan(
            text: 'Привет, меня зовут ',
          ),
          TextSpan(
            text: 'TrudBot',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
                '!\nРасскажи немного о себе или прикрепи описание в файле, а я найду тебе вакансию!',
          ),
        ];
      case TextMessageType.ChooseType:
        var textSpans = <TextSpan>[
          TextSpan(
            text: 'Выбери категорию',
          )
        ];
        if (arg is ResumeType) {
          var recomended = arg;
          textSpans.addAll([
            TextSpan(
              text: ", возможно это ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "\'" + recomended.name + "\'",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: ".",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]);
        } else {
          textSpans.add(
            TextSpan(
              text: ':',
            ),
          );
        }

        return textSpans;
      case TextMessageType.QuestionYears:
        // TODO: Handle this case.
        break;
      case TextMessageType.QuestionSoftSkills:
        // TODO: Handle this case.
        break;
    }
  }
}
