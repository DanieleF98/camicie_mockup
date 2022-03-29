// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissingModelNotification _$MissingModelNotificationFromJson(
  Map<String, dynamic> json,
) =>
    MissingModelNotification(
      json['Id'] as String,
      json['ImageUrl'] as String,
      json['FabricName'] as String,
      json['FabricId'] as String,
      json['Size'] as int,
      json['TotalAmount'] as int,
    );

Map<String, dynamic> _$MissingModelNotificationToJson(
  MissingModelNotification instance,
) =>
    <String, dynamic>{
      'Id': instance.id,
      'ImageUrl': instance.imageUrl,
      'FabricName': instance.fabricName,
      'FabricId': instance.fabricId,
      'Size': instance.size,
      'TotalAmount': instance.totalAmount,
    };
