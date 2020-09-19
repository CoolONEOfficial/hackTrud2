import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:hacktrud/provider/NetworkProvider.dart';
import 'package:hacktrud/types/message.dart';

import '../text_message.dart';
import 'select_type.dart';

class ResumeMessage implements Replyable, MessageContent {
  @override
  final Function(dynamic) didOutput;

  ResumeMessage(this.didOutput);

  @override
  bool get attachable => true;

  @override
  List<Widget> buildMessageContent() => [
        TextMessage(TextMessageType.Resume),
      ];

  @override
  bool textValidate(String text) {
    return text.length > 20;
  }

  @override
  Future<MessageContent> didInput(BuildContext context, input) async {
    String text;
    switch (input.runtimeType) {
      case String:
        text = input;
        break;
      case File:
        File file = input;
        text = file.readAsStringSync();
        break;
      default:
        return null;
    }

    var recomendedType = await NetworkProvider.shared.uploadResume(text);

    return SelectTypeMessage(
      (output) {
        didOutput(output);
      },
      recomendedType: recomendedType,
    );
  }

  @override
  String get hintText => "Напишите о себе...";
}
