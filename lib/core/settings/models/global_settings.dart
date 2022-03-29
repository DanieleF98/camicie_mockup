import 'package:json_annotation/json_annotation.dart'
    show JsonKey, JsonSerializable;

part 'global_settings.g.dart';

@JsonSerializable()
class GlobalSettings {
  const GlobalSettings(
    this.id,
    this.homeScreenText,
  );

  factory GlobalSettings.fromJson(Map<String, dynamic> json) =>
      _$GlobalSettingsFromJson(json);

  GlobalSettings copyWith(String? homeScreenText) {
    return GlobalSettings(id, homeScreenText ?? this.homeScreenText);
  }

  @JsonKey(name: 'Id')
  final String id;

  @JsonKey(name: 'HomeScreenText')
  final String homeScreenText;

  Map<String, dynamic> toJson() => _$GlobalSettingsToJson(this);
}
