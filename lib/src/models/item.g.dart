// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    lotFromJson(json['lot'] as Map<String, dynamic>),
    (json['quantity'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'lot': lotToJson(instance.lot),
      'quantity': instance.quantity,
    };
