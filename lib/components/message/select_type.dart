import 'package:flutter/widgets.dart';
import 'package:hacktrud/components/radio_message.dart';
import 'package:hacktrud/types/message.dart';
import 'package:hacktrud/types/resume.dart';

import '../text_message.dart';

class SelectTypeMessage implements MessageContent {
  @override
  final Function(dynamic) didOutput;

  SelectTypeMessage(this.didOutput);

  @override
  List<Widget> buildMessageContent() => [
        TextMessage(
          TextMessageType.ChooseType,
          arg: ResumeType.Waiter,
        ),
        RadioMessage(
          ResumeType.values.map((e) => e.name).toList(),
          didOutput: (o) => didOutput(
            ResumeType.values.firstWhere(
              (type) => o == type.name,
            ),
          ),
        )
      ];

  @override
  Future<MessageContent> didInput(BuildContext context, input) {
    if (input is ResumeType) {}
    return null;
  }
}
