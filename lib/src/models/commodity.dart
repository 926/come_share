import 'dart:convert';

import 'package:come_share/src/models/lot.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:come_share/src/utils/formatters.dart';
import 'package:meta/meta.dart';

part 'commodity.g.dart';

enum StockUnit {
  gram,
  kilogram,
  unit,
  centiliter,
  liter,
  box,
  centimeter,
  meter,
}

@JsonSerializable()
class Commodity {
  final String companyUuid;
  final int id;
  String name;
  StockUnit stockUnit;
  String photo;
  final bool status;
  final DateTime statusUpdateDate;
  @JsonKey(
    fromJson: lotsFromJson,
    toJson: lotsToJson,
  )
  List<Lot> lots;
  final DateTime date;
  final DateTime updateDate;

  Commodity(
      {this.companyUuid,
      @required this.id,
      @required this.name,
      this.stockUnit,
      this.photo,
      this.status,
      this.statusUpdateDate,
      this.lots,
      this.date,
      this.updateDate});

  factory Commodity.fromJson(Map<String, dynamic> json) =>
      _$CommodityFromJson(json);

  String get stockUnitText {
    switch (stockUnit) {
      case StockUnit.kilogram:
        return 'kg';
      case StockUnit.gram:
        return 'g';
      case StockUnit.liter:
        return 'l';
      case StockUnit.centiliter:
        return 'cl';
      case StockUnit.unit:
        return 'unite';
      case StockUnit.box:
        return 'boite';
      case StockUnit.centimeter:
        return 'cm';
      case StockUnit.meter:
        return 'm';
      default:
        return '?';
    }
  }

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

  Map<String, dynamic> toJson() => _$CommodityToJson(this);

  String toRawJson() => json.encode(toJson());
}
