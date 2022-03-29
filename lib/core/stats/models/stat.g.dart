// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stat _$StatFromJson(Map<String, dynamic> json) => Stat(
      json['Id'] as String,
      json['FabricId'] as String,
      (json['BuyDates'] as Map<String, dynamic>).map(
        (String k, dynamic e) =>
            MapEntry<DateTime, int>(DateTime.parse(k), e as int),
      ),
    );

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'Id': instance.id,
      'FabricId': instance.fabricId,
      'BuyDates': instance.buyDatesAndQuantity.map(
        (DateTime k, dynamic e) =>
            MapEntry<String, dynamic>(k.toIso8601String(), e),
      ),
    };
