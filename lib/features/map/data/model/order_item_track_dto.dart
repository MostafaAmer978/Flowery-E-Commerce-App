import 'package:flowers_ecommerce_app/features/map/data/model/product_track_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_track_dto.g.dart';

@JsonSerializable()
class OrderItemsTrackDto {
  @JsonKey(name: "product")
  final ProductTrackDto? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  OrderItemsTrackDto({this.product, this.price, this.quantity, this.id});

  factory OrderItemsTrackDto.fromJson(Map<String, dynamic> json) {
    return _$OrderItemsTrackDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemsTrackDtoToJson(this);
  }
}
