import 'package:camicie_mockup/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fabric.g.dart';

@JsonSerializable()
class Fabric {
  const Fabric(
    this.id,
    this.size,
    this.modelOfShirtEnum,
    this.totalAmount,
    this.imageUrl,
    this.fabricName,
  );

  factory Fabric.fromJson(Map<String, dynamic> json) => _$FabricFromJson(json);

  Fabric copyWith({
    String? id,
    int? size,
    ModelOfShirtEnum? modelOfShirtEnum,
    int? totalAmount,
    String? imageUrl,
    String? fabricName,
  }) {
    return Fabric(
      id ?? this.id,
      size ?? this.size,
      modelOfShirtEnum ?? this.modelOfShirtEnum,
      totalAmount ?? this.totalAmount,
      imageUrl ?? this.imageUrl,
      fabricName ?? this.fabricName,
    );
  }

  @JsonKey(name: 'Id')
  final String id;

  @JsonKey(name: 'Size')
  final int size;

  @JsonKey(name: 'ModelOfShirtEnum')
  final ModelOfShirtEnum modelOfShirtEnum;

  @JsonKey(name: 'TotalAmount')
  final int totalAmount;

  @JsonKey(name: 'ImageUrl')
  final String imageUrl;

  @JsonKey(name: 'FabricName')
  final String fabricName;

  Map<String, dynamic> toJson() => _$FabricToJson(this);
}
