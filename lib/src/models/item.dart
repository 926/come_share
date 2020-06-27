import 'package:json_annotation/json_annotation.dart';
import 'package:come_share/src/models/lot.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  @JsonKey(
    toJson: lotToJson,
    fromJson: lotFromJson,
  )
  Lot lot;
  double quantity;

  Item(this.lot, this.quantity);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
