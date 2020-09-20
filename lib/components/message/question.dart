import 'package:flutter/src/widgets/framework.dart';
import 'package:hacktrud/components/radio_message.dart';
import 'package:hacktrud/models/answer_model.dart';
import 'package:hacktrud/models/question_model.dart';
import 'package:hacktrud/provider/NetworkProvider.dart';
import 'package:hacktrud/types/message.dart';

import '../text_message.dart';
import 'work.dart';

class QuestionMessage implements Replyable, MessageContent {
  @override
  bool get attachable => false;

  @override
  final Function(dynamic) didOutput;

  final QuestionModel questionModel;
  final MessageContent nextContent;

  static var answerArray = List<AnswerModel>();

  QuestionMessage(
    this.didOutput, {
    this.questionModel,
    this.nextContent,
  });

  @override
  List<Widget> buildMessageContent() => [
        TextMessage.plainText(questionModel.question),
      ]..addAll(questionModel.answerType == AnswerType.BOOLEAN
          ? [
              RadioMessage(
                ["Да", "Нет"],
                values: [true, false],
                didOutput: (o) => didOutput(
                  o,
                ),
              )
            ]
          : []);

  @override
  Future<MessageContent> didInput(BuildContext context, input) async {
    AnswerModel res;
    switch (questionModel.answerType) {
      case AnswerType.BOOLEAN:
        res = AnswerModel(questionModel.id, (input as bool).toString());
        break;
      default:
        res = AnswerModel(questionModel.id, input as String);
        break;
    }
    answerArray.add(res);

    if (nextContent != null) {
      return nextContent;
    } else {
      await NetworkProvider.shared.saveQuestions(answerArray);
      return WorkMessage((o) => didOutput(o));
    }
  }

  @override
  String get hintText {
    switch (questionModel.answerType) {
      case AnswerType.STRING:
        return "Введите строку...";
        break;
      case AnswerType.INTEGER:
        return "Введите номер...";
        break;
      case AnswerType.STRING_ARRAY:
        return "Введите список строк через ';'...";
        break;
      case AnswerType.INTEGER_ARRAY:
        return "Введите список чисел через ','...";
        break;
      default:
        return null;
    }
  }

  @override
  bool textValidate(String text) {
    switch (questionModel.answerType) {
      case AnswerType.STRING:
        return text.isNotEmpty;
        break;
      case AnswerType.INTEGER:
        return int.tryParse(text) != null;
        break;
      case AnswerType.STRING_ARRAY:
        return text.contains(';') && text.length > 1;
        break;
      case AnswerType.INTEGER_ARRAY:
        return text.contains(',') && text.length > 1;
        break;
      default:
        return false;
    }
  }

  @override
  bool get replyable {
    switch (questionModel.answerType) {
      case AnswerType.STRING:
      case AnswerType.INTEGER:
      case AnswerType.STRING_ARRAY:
      case AnswerType.INTEGER_ARRAY:
        return true;
      default:
        return false;
    }
  }
}
