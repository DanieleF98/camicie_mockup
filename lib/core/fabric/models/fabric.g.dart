// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fabric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fabric _$FabricFromJson(Map<String, dynamic> json) => Fabric(
      json['Id'] as String,
      json['Size'] as int,
      $enumDecode(_$ModelOfShirtEnumEnumMap, json['ModelOfShirtEnum']),
      json['TotalAmount'] as int,
      json['ImageUrl'] as String,
      json['FabricName'] as String,
    );

Map<String, dynamic> _$FabricToJson(Fabric instance) => <String, dynamic>{
      'Id': instance.id,
      'Size': instance.size,
      'ModelOfShirtEnum': _$ModelOfShirtEnumEnumMap[instance.modelOfShirtEnum],
      'TotalAmount': instance.totalAmount,
      'ImageUrl': instance.imageUrl,
      'FabricName': instance.fabricName,
    };

const Map<ModelOfShirtEnum, String> _$ModelOfShirtEnumEnumMap =
    <ModelOfShirtEnum, String>{
  ModelOfShirtEnum.classic: 'classic',
  ModelOfShirtEnum.classicSlim: 'classicSlim',
  ModelOfShirtEnum.slim: 'slim',
};
