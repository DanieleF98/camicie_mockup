// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_of_shirt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelOfShirt _$ModelOfShirtFromJson(Map<String, dynamic> json) => ModelOfShirt(
      json['Id'] as String,
      $enumDecode(_$ModelOfShirtEnumEnumMap, json['ModelOfShirtEnum']),
    );

Map<String, dynamic> _$ModelOfShirtToJson(ModelOfShirt instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ModelOfShirtEnum': _$ModelOfShirtEnumEnumMap[instance.modelOfShirtEnum],
    };

const Map<ModelOfShirtEnum, String> _$ModelOfShirtEnumEnumMap =
    <ModelOfShirtEnum, String>{
  ModelOfShirtEnum.classic: 'classic',
  ModelOfShirtEnum.classicSlim: 'classicSlim',
  ModelOfShirtEnum.slim: 'slim',
};
