import 'package:camicie_mockup/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'size_model.g.dart';

@JsonSerializable()
class SizeModel {
  const SizeModel(this.id, this.modelOfShirtEnum, this.size);

  factory SizeModel.fromJson(Map<String, dynamic> json) =>
      _$SizeModelFromJson(json);

  SizeModel copyWith({
    String? id,
    ModelOfShirtEnum? modelOfShirtEnum,
    int? size,
  }) {
    return SizeModel(
      id ?? this.id,
      modelOfShirtEnum ?? this.modelOfShirtEnum,
      size ?? this.size,
    );
  }

  @JsonKey(name: 'Id')
  final String id;

  @JsonKey(name: 'ModelOfShirtEnum')
  final ModelOfShirtEnum modelOfShirtEnum;

  @JsonKey(name: 'Size')
  final int size;

  Map<String, dynamic> toJson() => _$SizeModelToJson(this);
}
