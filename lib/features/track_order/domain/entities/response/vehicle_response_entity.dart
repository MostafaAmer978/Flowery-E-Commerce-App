import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';

class VehicleResponseEntity {
  final String message;
  final VehicleEntity vehicle;

  const VehicleResponseEntity({required this.message, required this.vehicle});
}
