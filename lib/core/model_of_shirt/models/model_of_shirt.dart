import 'package:camicie_mockup/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_of_shirt.g.dart';

@JsonSerializable()
class ModelOfShirt {
  const ModelOfShirt(
    this.id,
    this.modelOfShirtEnum,
  );

  factory ModelOfShirt.fromJson(Map<String, dynamic> json) =>
      _$ModelOfShirtFromJson(json);

  ModelOfShirt copyWith({
    String? id,
    ModelOfShirtEnum? modelOfShirtEnum,
    List<String>? sizesId,
  }) {
    return ModelOfShirt(
      id ?? this.id,
      modelOfShirtEnum ?? this.modelOfShirtEnum,
    );
  }

  @JsonKey(name: 'Id')
  final String id;

  @JsonKey(name: 'ModelOfShirtEnum')
  final ModelOfShirtEnum modelOfShirtEnum;

  Map<String, dynamic> toJson() => _$ModelOfShirtToJson(this);
}
