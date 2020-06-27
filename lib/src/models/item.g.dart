// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    lotFromJson(json['lot'] as Map<String, dynamic>),
    (json['quantity'] as num)?.toDouble(),
  )..lots = lotsFromJson(json['lots'] as List);
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'lot': lotToJson(instance.lot),
      'lots': lotsToJson(instance.lots),
      'quantity': instance.quantity,
    };
