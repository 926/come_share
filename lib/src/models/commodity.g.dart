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
    stockUnit: _$enumDecodeNullable(_$StockUnitEnumMap, json['stockUnit']),
    photo: json['photo'] as String,
    status: json['status'] as bool,
    statusUpdateDate: json['statusUpdateDate'] == null
        ? null
        : DateTime.parse(json['statusUpdateDate'] as String),
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
    lots: lotsFromJson(json['lots'] as List),
  );
}

Map<String, dynamic> _$CommodityToJson(Commodity instance) => <String, dynamic>{
      'companyUuid': instance.companyUuid,
      'id': instance.id,
      'name': instance.name,
      'stockUnit': _$StockUnitEnumMap[instance.stockUnit],
      'photo': instance.photo,
      'status': instance.status,
      'statusUpdateDate': instance.statusUpdateDate?.toIso8601String(),
      'date': instance.date?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'lots': lotsToJson(instance.lots),
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$StockUnitEnumMap = <StockUnit, dynamic>{
  StockUnit.gram: 'gram',
  StockUnit.kilogram: 'kilogram',
  StockUnit.unit: 'unit',
  StockUnit.centiliter: 'centiliter',
  StockUnit.liter: 'liter',
  StockUnit.box: 'box',
  StockUnit.centimeter: 'centimeter',
  StockUnit.meter: 'meter'
};
