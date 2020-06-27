// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lot _$LotFromJson(Map<String, dynamic> json) {
  return Lot(
    companyUuid: json['companyUuid'] as String,
    id: json['id'] as int,
    subcommodityId: json['subcommodityId'] as int,
    commodityId: json['commodityId'] as int,
    initialQuantity: (json['initialQuantity'] as num)?.toDouble(),
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
      'subcommodityId': instance.subcommodityId,
      'commodityId': instance.commodityId,
      'initialQuantity': instance.initialQuantity,
      'quantity': instance.quantity,
      'isDefault': instance.isDefault,
      'lotDate': instance.lotDate?.toIso8601String(),
    };
