import 'package:flowers_ecommerce_app/features/track_order/data/model/response/vehicle_response_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';

extension VehicleMapper on VehicleResponseDto {
  VehicleEntity toEntity() {
    return VehicleEntity(image: vehicle?.image ?? '');
  }
}
