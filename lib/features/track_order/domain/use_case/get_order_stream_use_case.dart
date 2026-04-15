import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/repo/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderStreamUseCase {
  final TrackOrderRepo _repo;

  GetOrderStreamUseCase(this._repo);

  Stream<ApiResult<OrderEntity>> invoke(String orderId) {
    return _repo.getOrderStream(orderId);
  }
}
