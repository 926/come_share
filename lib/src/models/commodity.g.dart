// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commodity _$CommodityFromJson(Map<String, dynamic> json) {
  return Commodity(
    companyUuid: json['companyUuid'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    weight: (json['weight'] as num)?.toDouble(),
    photo: json['photo'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
    status: json['status'] as bool,
    statusUpdateDate: json['statusUpdateDate'] == null
        ? null
        : DateTime.parse(json['statusUpdateDate'] as String),
    lots: lotsFromJson(json['lots'] as List),
  );
}

Map<String, dynamic> _$CommodityToJson(Commodity instance) => <String, dynamic>{
      'companyUuid': instance.companyUuid,
      'id': instance.id,
      'name': instance.name,
      'weight': instance.weight,
      'photo': instance.photo,
      'date': instance.date?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'status': instance.status,
      'statusUpdateDate': instance.statusUpdateDate?.toIso8601String(),
      'lots': lotsToJson(instance.lots),
    };
