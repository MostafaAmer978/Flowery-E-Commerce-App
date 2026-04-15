import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/repo/tracking_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CallDriverUseCase {
  final TrackingRepo _trackingRepo;
  CallDriverUseCase(this._trackingRepo);
  Future<FirebaseResult<void>> call(String phoneNumber) =>
      _trackingRepo.callDriverRepo(phoneNumber);
}
