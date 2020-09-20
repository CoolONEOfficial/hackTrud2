import 'package:flutter/src/widgets/framework.dart';
import 'package:hacktrud/types/message.dart';

import '../vacancy_message.dart';

class WorkMessage implements MessageContent {
  @override
  final Function(dynamic) didOutput;

  WorkMessage(this.didOutput);

  @override
  List<Widget> buildMessageContent() => [
        VacancyMessage(
          "Курьер в Яндекс.Еда",
          "Вы можете выполнять заказы не только пешком. Если вы хорошо управляетесь с велосипедом, самокатом, роликами и другими средствами передвижения — используйте их.",
        )
      ];

  @override
  Future<MessageContent> didInput(BuildContext context, input) async {
    return null;
  }
}
