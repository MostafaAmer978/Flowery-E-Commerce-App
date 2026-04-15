import 'package:flowers_ecommerce_app/features/track_order/data/model/vehicle_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vehicle_response_dto.g.dart';

@JsonSerializable()
class VehicleResponseDto {
  final String? message;
  final VehicleDto? vehicle;

  VehicleResponseDto({required this.message, required this.vehicle});

  factory VehicleResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleResponseDtoToJson(this);
}
