// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  type: (json['type'] as num).toInt(),
  clipboard: json['clipboard'] as String,
  attachment: json['attachment'] as String,
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'type': instance.type,
  'clipboard': instance.clipboard,
  'attachment': instance.attachment,
};
