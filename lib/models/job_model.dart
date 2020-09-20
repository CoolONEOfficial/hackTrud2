import 'package:json_annotation/json_annotation.dart';
part 'job_model.g.dart';

@JsonSerializable()
class JobModel {
  int id;
  String name;
  String udpipeName;

  JobModel(
    this.id,
    this.name,
    this.udpipeName,
  );

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
