import 'package:flowers_ecommerce_app/features/map/data/model/driver_track_dto.dart';
import 'package:flowers_ecommerce_app/features/map/data/model/orders_track_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseDto {
  @JsonKey(name: "userState")
  final String? userState;
  @JsonKey(name: "driverLocation")
  final String? driverLocation;
  @JsonKey(name: "orders")
  final OrdersTrackDto? orders;
  @JsonKey(name: "driverData")
  final DriverTrackDto? driverData;

  ResponseDto({
    this.driverData,
    this.orders,
    this.userState,
    this.driverLocation,
  });

  factory ResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDtoToJson(this);
}
