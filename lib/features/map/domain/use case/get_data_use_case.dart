import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/entites/tracking_entity.dart';
import 'package:flowers_ecommerce_app/features/map/domain/repo/tracking_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDataUseCase {
  final TrackingRepo _trackingRepo;
  GetDataUseCase(this._trackingRepo);
  Future<FirebaseResult<TrackingEntity>> call(String orderId) =>
      _trackingRepo.getDataRepo(orderId);
}
