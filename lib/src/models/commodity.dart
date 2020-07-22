import 'dart:convert';

import 'package:come_share/src/models/lot.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:come_share/src/utils/formatters.dart';
import 'package:meta/meta.dart';

part 'commodity.g.dart';

// ? needless
/* enum StockUnit {
  gram,
  kilogram,
  unit,
  centiliter,
  liter,
  box,
  centimeter,
  meter,
} */

@JsonSerializable()
class Commodity {
  final String companyUuid;
  int id;
  String name;
  double weight;
  String photo;
  final bool status;
  final DateTime statusUpdateDate;
  final DateTime date;
  final DateTime updateDate;
  @JsonKey(
    fromJson: lotsFromJson,
    toJson: lotsToJson,
  )
  List<Lot> lots;

  Commodity(
      {this.companyUuid,
      @required this.id,
      @required this.name,
      this.weight,
      this.photo,
      this.status,
      this.statusUpdateDate,
      this.date,
      this.updateDate,
      this.lots});

  String get sharableText {
    final truc = StringBuffer();
    lots.forEach((l) {
      truc.write(
          '${numberFormatter?.format(lots?.fold(0, (value, lot) => value + lot?.quantity))}');
    });
    final sb = StringBuffer()
      ..writeln('# $id - $name')
      ..writeln('stock : ${truc.toString()}');
    return sb.toString();
  }

  factory Commodity.fromJson(Map<String, dynamic> json) =>
      _$CommodityFromJson(json);

  Map<String, dynamic> toJson() => _$CommodityToJson(this);

  String toRawJson() => json.encode(toJson());
}
