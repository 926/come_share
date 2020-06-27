// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'herder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Herder _$HerderFromJson(Map<String, dynamic> json) {
  return Herder(
    id: json['id'] as int,
    bidon: json['bidon'] as int,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    tel: json['tel'] as String,
    mail: json['mail'] as String,
    address: json['address'] as String,
    avatar: json['avatar'] as String,
    qrcode: json['qrcode'] as String,
    overdraft: json['overdraft'] as int,
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
    status: json['status'] as bool,
    statusUpdateDate: json['statusUpdateDate'] == null
        ? null
        : DateTime.parse(json['statusUpdateDate'] as String),
    milkMonthQuota: json['milkMonthQuota'] as int,
  );
}

Map<String, dynamic> _$HerderToJson(Herder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('bidon', instance.bidon);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('tel', instance.tel);
  writeNotNull('mail', instance.mail);
  writeNotNull('address', instance.address);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('qrcode', instance.qrcode);
  writeNotNull('overdraft', instance.overdraft);
  writeNotNull('updateDate', instance.updateDate?.toIso8601String());
  writeNotNull('status', instance.status);
  writeNotNull(
      'statusUpdateDate', instance.statusUpdateDate?.toIso8601String());
  writeNotNull('milkMonthQuota', instance.milkMonthQuota);
  return val;
}
