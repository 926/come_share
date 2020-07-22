import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'herder.g.dart';

@JsonSerializable()
class Herder {
  @JsonKey(ignore: true)
  int key;
  @JsonKey(includeIfNull: false, nullable: true)
  final int id;
  @JsonKey(includeIfNull: false, nullable: true)
  int bidon;
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
  String avatar;
  @JsonKey(includeIfNull: false, nullable: true)
  String qrcode; //
  @JsonKey(includeIfNull: false, nullable: true)
  DateTime date; // if herder info are updated, keep date here
  @JsonKey(includeIfNull: false, nullable: true)
  DateTime updateDate; // if herder info are updated, keep date here
  @JsonKey(includeIfNull: false, nullable: true)
  bool status;
  @JsonKey(includeIfNull: false, nullable: true)
  DateTime statusUpdateDate; // if status changes, update date here

  Herder({
    this.id,
    this.bidon,
    this.firstName,
    this.lastName,
    this.tel,
    this.mail,
    this.address,
    this.avatar,
    this.qrcode,
    this.date,
    this.updateDate,
    this.status,
    this.statusUpdateDate,
  });

  String get sharableText {
    final sb = StringBuffer()
      ..writeln('bid : $bidon')
      ..writeln('prenom : $firstName')
      ..writeln('nom : $lastName');
    return sb.toString();
  }

  factory Herder.fromJson(Map<String, dynamic> json) => _$HerderFromJson(json);

  Map<String, dynamic> toJson() => _$HerderToJson(this);
  String toRawJson() => json.encode(toJson());
}
