import 'package:json_annotation/json_annotation.dart';
part 'question_model.g.dart';

enum AnswerType {
  BOOLEAN,
  STRING,
  INTEGER,
  STRING_ARRAY,
  INTEGER_ARRAY,
}

@JsonSerializable()
class QuestionModel {
  int id;
  String shortCode;
  String question;
  AnswerType answerType;

  QuestionModel(
    this.id,
    this.shortCode,
    this.question,
    this.answerType,
  );

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
