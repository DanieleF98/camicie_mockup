import 'package:json_annotation/json_annotation.dart';

part 'stat.g.dart';

@JsonSerializable()
class Stat {
  const Stat(this.id, this.fabricId, this.buyDatesAndQuantity);

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);

  Stat copyWith({
    String? id,
    String? fabricId,
    Map<DateTime, int>? buyDatesAndQuantity,
  }) {
    return Stat(
      id ?? this.id,
      fabricId ?? this.fabricId,
      buyDatesAndQuantity ?? this.buyDatesAndQuantity,
    );
  }

  @JsonKey(name: 'Id')
  final String id;

  @JsonKey(name: 'FabricId')
  final String fabricId;

  @JsonKey(name: 'BuyDates')
  final Map<DateTime, int> buyDatesAndQuantity;

  Map<String, dynamic> toJson() => _$StatToJson(this);
}
