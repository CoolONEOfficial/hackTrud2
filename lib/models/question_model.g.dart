// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) {
  return QuestionModel(
    json['id'] as int,
    json['shortCode'] as String,
    json['question'] as String,
    _$enumDecodeNullable(_$AnswerTypeEnumMap, json['answerType']),
  );
}

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shortCode': instance.shortCode,
      'question': instance.question,
      'answerType': _$AnswerTypeEnumMap[instance.answerType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$AnswerTypeEnumMap = {
  AnswerType.BOOLEAN: 'BOOLEAN',
  AnswerType.STRING: 'STRING',
  AnswerType.INTEGER: 'INTEGER',
  AnswerType.STRING_ARRAY: 'STRING_ARRAY',
  AnswerType.INTEGER_ARRAY: 'INTEGER_ARRAY',
};
