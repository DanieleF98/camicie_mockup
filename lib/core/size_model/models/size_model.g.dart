// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeModel _$SizeModelFromJson(Map<String, dynamic> json) => SizeModel(
      json['Id'] as String,
      $enumDecode(_$ModelOfShirtEnumEnumMap, json['ModelOfShirtEnum']),
      json['Size'] as int,
    );

Map<String, dynamic> _$SizeModelToJson(SizeModel instance) => <String, dynamic>{
      'Id': instance.id,
      'ModelOfShirtEnum': _$ModelOfShirtEnumEnumMap[instance.modelOfShirtEnum],
      'Size': instance.size,
    };

const Map<ModelOfShirtEnum, String> _$ModelOfShirtEnumEnumMap =
    <ModelOfShirtEnum, String>{
  ModelOfShirtEnum.classic: 'classic',
  ModelOfShirtEnum.classicSlim: 'classicSlim',
  ModelOfShirtEnum.slim: 'slim',
};
