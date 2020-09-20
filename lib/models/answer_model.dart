import 'package:json_annotation/json_annotation.dart';
part 'answer_model.g.dart';

@JsonSerializable()
class AnswerModel {
  int id;
  String answer;

  AnswerModel(this.id, this.answer);

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}
