import 'package:flowers_ecommerce_app/features/track_order/data/model/driver_data_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: '__v')
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  final bool? isDelivered;
  final bool? isPaid;
  final String? orderNumber;
  final String? paymentType;
  final String? state;
  final int? totalPrice;
  final String? userState;
  final DriverDataDto? driverData;
  final UserDto? user;
  final Map<String, dynamic>? orders;

  OrderDto({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
    required this.isDelivered,
    required this.isPaid,
    required this.orderNumber,
    required this.paymentType,
    required this.state,
    required this.totalPrice,
    required this.userState,
    required this.driverData,
    required this.user,
    this.orders,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
}
