import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/order_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/response/vehicle_response_dto.dart';

abstract class TrackOrderRemoteDataSource {
  Future<VehicleResponseDto> getVehicleById(String vehicleId);
  Stream<OrderDto> getOrderStream(String orderId);
  Future<void> updateOrderStatusFirebase(String orderId, OrderStatus status);
}
