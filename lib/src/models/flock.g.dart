// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flock _$FlockFromJson(Map<String, dynamic> json) {
  return Flock(
    key: json['key'] as int,
    axeUuid: json['axeUuid'] as String,
    items: (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    comment: json['comment'] as String,
    received: json['received'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    creationDate: json['creationDate'] == null
        ? null
        : DateTime.parse(json['creationDate'] as String),
    flockType: _$enumDecodeNullable(_$FlockTypeEnumMap, json['flockType']),
    herderId: json['herderId'] as String,
    status: json['status'] as bool,
    statusUpdateDate: json['statusUpdateDate'] == null
        ? null
        : DateTime.parse(json['statusUpdateDate'] as String),
  );
}

Map<String, dynamic> _$FlockToJson(Flock instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  writeNotNull('axeUuid', instance.axeUuid);
  writeNotNull('items', _itemsToJson(instance.items));
  writeNotNull('comment', instance.comment);
  writeNotNull('received', instance.received);
  writeNotNull('date', instance.date?.toIso8601String());
  writeNotNull('creationDate', instance.creationDate?.toIso8601String());
  writeNotNull('flockType', _$FlockTypeEnumMap[instance.flockType]);
  writeNotNull('herderId', instance.herderId);
  writeNotNull('status', instance.status);
  writeNotNull(
      'statusUpdateDate', instance.statusUpdateDate?.toIso8601String());
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$FlockTypeEnumMap = {
  FlockType.gathered: 'gathered',
};
