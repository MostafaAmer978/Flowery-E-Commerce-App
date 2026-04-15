import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/repo/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderFirebaseUseCase {
  // ignore: prefer_final_fields
  TrackOrderRepo _repo;
  UpdateOrderFirebaseUseCase(this._repo);
  Future<FirebaseResult> invoke(String orderId, OrderStatus status) {
    return _repo.updateOrderStatusFirebase(orderId, status);
  }
}
