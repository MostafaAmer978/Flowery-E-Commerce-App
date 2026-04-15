import 'package:flowers_ecommerce_app/features/map/data/model/response_dto.dart';
import 'package:flowers_ecommerce_app/features/map/domain/entites/tracking_entity.dart';
import 'package:latlong2/latlong.dart';

extension MapToEntity on ResponseDto {
  LatLng parseLatLng(String? value) {
    if (value == null) return const LatLng(0, 0);
    final parts = value.split(',');
    final lat = double.tryParse(parts[0]) ?? 0;
    final lng = double.tryParse(parts[1]) ?? 0;
    return LatLng(lat, lng);
  }

  TrackingEntity toEntity() {
    return TrackingEntity(
      driverLocation: parseLatLng(driverLocation),
      driverName: driverData?.firstName ?? 'no name',
      storeLocation: parseLatLng(orders?.store?.latLong),
      driverNumber: driverData?.phone ?? 'no phone',
      orderId: orders?.id ?? 'no id',
    );
  }
}
