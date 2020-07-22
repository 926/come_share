import 'dart:convert';
import 'package:come_share/src/models/item.dart';

import 'package:json_annotation/json_annotation.dart';

part 'flock.g.dart';

List<Map<String, dynamic>> _itemsToJson(List<Item> items) =>
    items.map((item) => item.toJson()).toList();

enum FlockType { gathered }

@JsonSerializable()
class Flock {
  @JsonKey(ignore: true)
  int key;

  @JsonKey(includeIfNull: false, nullable: true)
  final int id;

  @JsonKey(includeIfNull: false, nullable: true)
  final String axeUuid; // shopUuid shopId

  @JsonKey(toJson: _itemsToJson, includeIfNull: false, nullable: true)
  final List<Item> items;

  @JsonKey(includeIfNull: false, nullable: true)
  final String comment;
  @JsonKey(includeIfNull: false, nullable: true)
  final int received;
  @JsonKey(includeIfNull: false, nullable: true)
  final DateTime date;
  @JsonKey(includeIfNull: false, nullable: true)
  final DateTime creationDate;
  @JsonKey(includeIfNull: false, nullable: true)
  final FlockType flockType;
  @JsonKey(includeIfNull: false, nullable: true)
  final String herderId; // old contactInfo
  @JsonKey(includeIfNull: false, nullable: true)
  final bool status;
  @JsonKey(includeIfNull: false, nullable: true)
  final DateTime statusUpdateDate;

  Flock({
    this.id,
    this.axeUuid,
    this.items,
    this.comment,
    this.received,
    this.date,
    this.creationDate,
    this.flockType,
    this.herderId,
    this.status,
    this.statusUpdateDate,
  });

  Map<String, dynamic> flockToJson(Flock flock) => _$FlockToJson(flock);
  Flock flockFromJson(Map<String, dynamic> json) => _$FlockFromJson(json);

  List<Map<String, dynamic>> flocksToJson(List<Flock> flocks) =>
      flocks.map((flock) => flockToJson(flock)).toList();

  List<Flock> flocksFromJson(List json) => json
      .cast<Map>()
      .cast<Map<String, dynamic>>()
      .map((flock) => flockFromJson(flock))
      .toList();

  factory Flock.fromJson(Map<String, dynamic> json) => _$FlockFromJson(json);
  Map<String, dynamic> toJson() => _$FlockToJson(this);

  String toRawJson() => json.encode(toJson());

  String get type {
    if (flockType == FlockType.gathered) {
      return 'collecte';
    } else {
      return 'autres';
    }
  }
}
