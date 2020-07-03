// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collector _$CollectorFromJson(Map<String, dynamic> json) {
  return Collector(
    id: json['id'] as int,
    uuid: json['uuid'] as String,
    collectorPhoto: json['collectorPhoto'] as String,
    companyPhoto: json['companyPhoto'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    tel: json['tel'] as String,
    mail: json['mail'] as String,
    address: json['address'] as String,
    lat: json['lat'] as String,
    long: json['long'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    status: json['status'] as bool,
    statusUpdateDate: json['statusUpdateDate'] == null
        ? null
        : DateTime.parse(json['statusUpdateDate'] as String),
    serverStatus: json['serverStatus'] as bool,
    serverStatusUpdateDate: json['serverStatusUpdateDate'] == null
        ? null
        : DateTime.parse(json['serverStatusUpdateDate'] as String),
    isProd: json['isProd'] as bool,
    isLocked: json['isLocked'] as bool,
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$CollectorToJson(Collector instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('uuid', instance.uuid);
  writeNotNull('companyPhoto', instance.companyPhoto);
  writeNotNull('collectorPhoto', instance.collectorPhoto);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('tel', instance.tel);
  writeNotNull('mail', instance.mail);
  writeNotNull('address', instance.address);
  writeNotNull('lat', instance.lat);
  writeNotNull('long', instance.long);
  writeNotNull('date', instance.date?.toIso8601String());
  writeNotNull('status', instance.status);
  writeNotNull(
      'statusUpdateDate', instance.statusUpdateDate?.toIso8601String());
  writeNotNull('serverStatus', instance.serverStatus);
  writeNotNull('serverStatusUpdateDate',
      instance.serverStatusUpdateDate?.toIso8601String());
  writeNotNull('isProd', instance.isProd);
  writeNotNull('isLocked', instance.isLocked);
  writeNotNull('updateDate', instance.updateDate?.toIso8601String());
  return val;
}
