import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'lot.g.dart';

Map<String, dynamic> lotToJson(Lot lot) => _$LotToJson(lot);
Lot lotFromJson(Map<String, dynamic> json) => _$LotFromJson(json);

List<Map<String, dynamic>> lotsToJson(List<Lot> lots) =>
    lots.map((lot) => lotToJson(lot)).toList();

List<Lot> lotsFromJson(List json) =>
    json
        ?.cast<Map>()
        ?.cast<Map<String, dynamic>>()
        ?.map((lot) => lotFromJson(lot))
        ?.toList() ??
    [];

@JsonSerializable()
class Lot {
  final String companyUuid;
  int commodityId;
  final int id;
  String comment;
  double quantity;
  bool isDefault;
  DateTime lotDate;

  Lot({
    this.companyUuid,
    @required this.commodityId,
    @required this.id,
    this.comment,
    this.quantity,
    this.isDefault = false,
    this.lotDate,
  });

  factory Lot.fromJson(Map<String, dynamic> json) => lotFromJson(json);

  Map<String, dynamic> toJson() => lotToJson(this);
}

// buggin me
// else if (dlcFormatter != null) {
//       return dlcFormatter.format(dlc);
