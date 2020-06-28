import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'collector.g.dart';

@JsonSerializable()
class Collector {
  @JsonKey(includeIfNull: false, nullable: true)
  int id;
  @JsonKey(includeIfNull: false, nullable: true)
  String uuid;
  @JsonKey(includeIfNull: false, nullable: true)
  String firstName;
  @JsonKey(includeIfNull: false, nullable: true)
  String lastName;
  @JsonKey(includeIfNull: false, nullable: true)
  String tel;
  @JsonKey(includeIfNull: false, nullable: true)
  String mail;
  @JsonKey(includeIfNull: false, nullable: true)
  String address;
  @JsonKey(includeIfNull: false, nullable: true)
  String lat;
  @JsonKey(includeIfNull: false, nullable: true)
  String long;
  @JsonKey(includeIfNull: false, nullable: true)
  @JsonKey(includeIfNull: false, nullable: true)
  DateTime date;
  @JsonKey(includeIfNull: false, nullable: true)
  bool status;
  @JsonKey(includeIfNull: false, nullable: true)
  DateTime statusUpdateDate;
  @JsonKey(includeIfNull: false, nullable: true)
  bool serverStatus;
  @JsonKey(includeIfNull: false, nullable: true)
  DateTime serverStatusUpdateDate;
  @JsonKey(includeIfNull: false, nullable: true)
  bool isProd;
  @JsonKey(includeIfNull: false, nullable: true)
  bool isLocked;
  @JsonKey(includeIfNull: false, nullable: true)
  DateTime updateDate;

  Collector(
      {this.id,
      this.uuid,
      this.firstName,
      this.lastName,
      this.tel,
      this.mail,
      this.address,
      this.lat,
      this.long,
      this.date,
      this.status,
      this.statusUpdateDate,
      this.serverStatus,
      this.serverStatusUpdateDate,
      this.isProd,
      this.isLocked,
      this.updateDate});

  String get sharableText {
    final sb = StringBuffer()
      ..writeln('collecteur : $firstName $lastName')
      ..writeln('tel : $tel')
      ..writeln('mail : $mail')
      ..writeln('adresse : $address')
      ..writeln('');
    return sb.toString();
  }

  factory Collector.fromJson(Map<String, dynamic> json) =>
      _$CollectorFromJson(json);

  Map<String, dynamic> toJson() => _$CollectorToJson(this);

  String toRawJson() => json.encode(toJson());
}
