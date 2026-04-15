import 'package:latlong2/latlong.dart';

class TrackingEntity {
  String orderId;
  String driverNumber;
  String driverName;
  LatLng storeLocation;
  LatLng? driverLocation;

  TrackingEntity({
    required this.orderId,
    required this.driverNumber,
    required this.driverName,
    required this.storeLocation,
    required this.driverLocation,
  });
}
