import 'package:json_annotation/json_annotation.dart'
    show JsonKey, JsonSerializable;

part 'notification.g.dart';

@JsonSerializable()
class MissingModelNotification {
  const MissingModelNotification(
    this.id,
    this.imageUrl,
    this.fabricName,
    this.fabricId,
    this.size,
    this.totalAmount,
  );

  factory MissingModelNotification.fromJson(Map<String, dynamic> json) =>
      _$MissingModelNotificationFromJson(json);

  MissingModelNotification copyWith({
    String? id,
    String? imageUrl,
    String? fabricName,
    String? fabricId,
    int? size,
    int? totalAmount,
  }) {
    return MissingModelNotification(
      id ?? this.id,
      imageUrl ?? this.imageUrl,
      fabricName ?? this.fabricName,
      fabricId ?? this.fabricId,
      size ?? this.size,
      totalAmount ?? this.totalAmount,
    );
  }

  @JsonKey(name: 'Id')
  final String id;

  @JsonKey(name: 'ImageUrl')
  final String imageUrl;

  @JsonKey(name: 'FabricName')
  final String fabricName;

  @JsonKey(name: 'FabricId')
  final String fabricId;

  @JsonKey(name: 'Size')
  final int size;

  @JsonKey(name: 'TotalAmount')
  final int totalAmount;

  Map<String, dynamic> toJson() => _$MissingModelNotificationToJson(this);
}
