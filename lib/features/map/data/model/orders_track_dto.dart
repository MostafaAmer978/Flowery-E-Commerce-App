import 'package:flowers_ecommerce_app/features/map/data/model/order_item_track_dto.dart';
import 'package:flowers_ecommerce_app/features/map/data/model/store_track_dto.dart';
import 'package:flowers_ecommerce_app/features/map/data/model/user_track_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'orders_track_dto.g.dart';

@JsonSerializable()
class OrdersTrackDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final UserTrackDto? user;
  @JsonKey(name: "orderItems")
  final List<OrderItemsTrackDto>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "store")
  final StoreTrackDto? store;

  OrdersTrackDto({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
  });

  factory OrdersTrackDto.fromJson(Map<String, dynamic> json) {
    return _$OrdersTrackDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersTrackDtoToJson(this);
  }
}
