import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';

abstract class TrackOrderRepo {
  Future<ApiResult<VehicleEntity>> getVehicleById(String vehicleId);
  Stream<ApiResult<OrderEntity>> getOrderStream(String orderId);
  Future<FirebaseResult> updateOrderStatusFirebase(
    String orderId,
    OrderStatus status,
  );
}
