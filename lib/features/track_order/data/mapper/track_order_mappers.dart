import 'package:flowers_ecommerce_app/features/track_order/data/model/driver_data_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/order_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/driver_data_entity.dart';

extension OrderMapper on OrderDto {
  OrderEntity toEntity() {
    final orderId = id ?? orders?['_id'] ?? "";
    return OrderEntity(
      id: orderId,
      createdAt: createdAt ?? "",
      isDelivered: isDelivered ?? false,
      state: state ?? orders?['state'] ?? "",
      userState: userState ?? "",
      driverData: driverData?.toEntity() ?? DriverDataEntity.empty(),
    );
  }
}

extension DriverDataMapper on DriverDataDto {
  DriverDataEntity toEntity() {
    return DriverDataEntity(
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      photo: photo ?? "",
      vehicleType: vehicleType ?? "",
      phone: phone ?? "",
    );
  }
}
