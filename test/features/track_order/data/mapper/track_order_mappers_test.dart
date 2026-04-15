import 'package:flowers_ecommerce_app/features/track_order/data/mapper/track_order_mappers.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/driver_data_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/order_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/driver_data_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toEntity should map DriverDataDto to DriverDataEntity', () {
    final dto = DriverDataDto(
      nid: null,
      nidImg: null,
      id: null,
      country: null,
      createdAt: null,
      email: null,
      firstName: 'John',
      gender: null,
      lastName: 'Doe',
      passwordChangedAt: null,
      phone: '1234567890',
      photo: 'http://image',
      role: null,
      vehicleLicense: null,
      vehicleNumber: null,
      vehicleType: 'car',
      driverLocation: null,
    );

    final result = dto.toEntity();

    expect(result, isA<DriverDataEntity>());
    expect(result.firstName, 'John');
    expect(result.lastName, 'Doe');
    expect(result.phone, '1234567890');
    expect(result.photo, 'http://image');
    expect(result.vehicleType, 'car');
  });

  test('toEntity should map DriverDataDto nulls to empty strings', () {
    final dto = DriverDataDto(
      nid: null,
      nidImg: null,
      id: null,
      country: null,
      createdAt: null,
      email: null,
      firstName: null,
      gender: null,
      lastName: null,
      passwordChangedAt: null,
      phone: null,
      photo: null,
      role: null,
      vehicleLicense: null,
      vehicleNumber: null,
      vehicleType: null,
      driverLocation: null,
    );

    final result = dto.toEntity();

    expect(result.firstName, '');
    expect(result.lastName, '');
    expect(result.phone, '');
    expect(result.photo, '');
    expect(result.vehicleType, '');
  });

  test('toEntity should map OrderDto to OrderEntity and nested driver', () {
    final driverDto = DriverDataDto(
      nid: null,
      nidImg: null,
      id: null,
      country: null,
      createdAt: null,
      email: null,
      firstName: 'Alice',
      gender: null,
      lastName: 'Smith',
      passwordChangedAt: null,
      phone: '999',
      photo: 'p',
      role: null,
      vehicleLicense: null,
      vehicleNumber: null,
      vehicleType: 'bike',
      driverLocation: null,
    );

    final orderDto = OrderDto(
      id: 'order-id',
      version: null,
      createdAt: '2025-10-13',
      updatedAt: null,
      isDelivered: true,
      isPaid: null,
      orderNumber: null,
      paymentType: null,
      state: 'on-the-way',
      totalPrice: null,
      userState: 'confirmed',
      driverData: driverDto,
      user: null,
      orders: null,
    );

    final result = orderDto.toEntity();

    expect(result, isA<OrderEntity>());
    expect(result.id, 'order-id');
    expect(result.createdAt, '2025-10-13');
    expect(result.isDelivered, true);
    expect(result.state, 'on-the-way');
    expect(result.userState, 'confirmed');
    expect(result.driverData.firstName, 'Alice');
    expect(result.driverData.vehicleType, 'bike');
  });

  test('toEntity should default nulls in OrderDto and null driverData', () {
    final orderDto = OrderDto(
      id: null,
      version: null,
      createdAt: null,
      updatedAt: null,
      isDelivered: null,
      isPaid: null,
      orderNumber: null,
      paymentType: null,
      state: null,
      totalPrice: null,
      userState: null,
      driverData: null,
      user: null,
      orders: null,
    );

    final result = orderDto.toEntity();

    expect(result.id, '');
    expect(result.createdAt, '');
    expect(result.isDelivered, false);
    expect(result.userState, '');
    expect(result.driverData, isA<DriverDataEntity>());
    expect(result.driverData.firstName, '');
  });
}
