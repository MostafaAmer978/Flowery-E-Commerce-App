import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/repo/tracking_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class TrackingDriverUseCase {
  final TrackingRepo _trackingRepo;
  TrackingDriverUseCase(this._trackingRepo);
  Stream<FirebaseResult<LatLng?>> call(String orderId) =>
      _trackingRepo.streamDriverLocationRepo(orderId);
}
