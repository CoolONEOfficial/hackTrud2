import 'package:flutter/widgets.dart';
import 'package:hacktrud/components/message/question.dart';
import 'package:hacktrud/components/radio_message.dart';
import 'package:hacktrud/provider/NetworkProvider.dart';
import 'package:hacktrud/types/message.dart';
import 'package:hacktrud/types/resume.dart';
import 'package:tuple/tuple.dart';

import '../text_message.dart';

class SelectTypeMessage implements MessageContent {
  @override
  final Function(dynamic) didOutput;

  final Tuple2<ResumeType, String> recomendedType;

  SelectTypeMessage(
    this.didOutput, {
    this.recomendedType,
  });

  @override
  List<Widget> buildMessageContent() => [
        TextMessage(
          TextMessageType.ChooseType,
          arg: recomendedType.item1,
        ),
        RadioMessage(
          ResumeType.values.map((e) => e.name).toList(),
          didOutput: (o) => didOutput(
            Tuple2(
              ResumeType.values.firstWhere(
                (type) => o == type.name,
              ),
              recomendedType.item2,
            ),
          ),
        )
      ];

  @override
  Future<MessageContent> didInput(BuildContext context, input) async {
    if (input is Tuple2<ResumeType, String>) {
      var questions = await NetworkProvider.shared
          .getQuestions(input.item1.engName, input.item2);
      var contents = [];

      for (var question in questions.reversed) {
        contents.add(QuestionMessage(
          (output) {
            didOutput(output);
          },
          questionModel: question,
          nextContent: contents.isNotEmpty ? contents.last : null,
        ));
      }

      return contents.last;
    }
    return null;
  }
}
