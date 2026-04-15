import 'package:flowers_ecommerce_app/core/utils/enums.dart';

sealed class TrackOrderEvent {}

class GetVehicleByIdEvent extends TrackOrderEvent {
  final String vehicleId;
  GetVehicleByIdEvent({required this.vehicleId});
}

class GetOrderByIdEvent extends TrackOrderEvent {
  final String orderId;
  GetOrderByIdEvent({required this.orderId});
}

class UpdateOrderStatusEvent extends TrackOrderEvent {
  final String orderId;
  final OrderStatus status;

  UpdateOrderStatusEvent({required this.orderId, required this.status});
}
