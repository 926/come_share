// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lot _$LotFromJson(Map<String, dynamic> json) {
  return Lot(
    companyUuid: json['companyUuid'] as String,
    commodityId: json['commodityId'] as int,
    id: json['id'] as int,
    comment: json['comment'] as String,
    isDefault: json['isDefault'] as bool,
    lotDate: json['lotDate'] == null
        ? null
        : DateTime.parse(json['lotDate'] as String),
  );
}

Map<String, dynamic> _$LotToJson(Lot instance) => <String, dynamic>{
      'companyUuid': instance.companyUuid,
      'commodityId': instance.commodityId,
      'id': instance.id,
      'comment': instance.comment,
      'isDefault': instance.isDefault,
      'lotDate': instance.lotDate?.toIso8601String(),
    };
