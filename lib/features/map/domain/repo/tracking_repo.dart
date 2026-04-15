import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/entites/tracking_entity.dart';
import 'package:latlong2/latlong.dart';

abstract interface class TrackingRepo {
  Future<FirebaseResult<TrackingEntity>> getDataRepo(String orderId);
  Stream<FirebaseResult<LatLng?>> streamDriverLocationRepo(String orderId);
  Future<FirebaseResult<void>> callDriverRepo(String phoneNumber);
  Future<FirebaseResult<void>> openWatsAppRepo(String phoneNumber);
}
