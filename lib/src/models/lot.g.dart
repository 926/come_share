// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lot _$LotFromJson(Map<String, dynamic> json) {
  return Lot(
    companyUuid: json['companyUuid'] as String,
    id: json['id'] as int,
    commodityId: json['commodityId'] as int,
    comment: json['comment'] as String,
    quantity: (json['quantity'] as num)?.toDouble(),
    isDefault: json['isDefault'] as bool,
    lotDate: json['lotDate'] == null
        ? null
        : DateTime.parse(json['lotDate'] as String),
  );
}

Map<String, dynamic> _$LotToJson(Lot instance) => <String, dynamic>{
      'companyUuid': instance.companyUuid,
      'id': instance.id,
      'commodityId': instance.commodityId,
      'comment': instance.comment,
      'quantity': instance.quantity,
      'isDefault': instance.isDefault,
      'lotDate': instance.lotDate?.toIso8601String(),
    };
