import 'package:flowers_ecommerce_app/features/track_order/domain/entities/driver_data_entity.dart';

class OrderEntity {
  final String id;
  final String createdAt;
  final bool isDelivered;
  final String state;
  final String userState;
  final DriverDataEntity driverData;

  const OrderEntity({
    required this.id,
    required this.createdAt,
    required this.isDelivered,
    required this.state,
    required this.userState,
    required this.driverData,
  });
}
