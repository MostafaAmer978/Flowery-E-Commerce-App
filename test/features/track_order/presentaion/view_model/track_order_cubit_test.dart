import 'dart:async';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/driver_data_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/use_case/get_order_stream_use_case.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/use_case/get_vehicle_by_id_use_case.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/use_case/update_order_firebase_use_case.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_event.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_cubit_test.mocks.dart';

@GenerateMocks([
  GetVehicleByIdUseCase,
  GetOrderStreamUseCase,
  UpdateOrderFirebaseUseCase,
])
void main() {
  late MockGetVehicleByIdUseCase mockGetVehicleByIdUseCase;
  late MockGetOrderStreamUseCase mockGetOrderStreamUseCase;
  late MockUpdateOrderFirebaseUseCase mockUpdateOrderFirebaseUseCase;
  late TrackOrderViewModel vm;

  setUpAll(() {
    provideDummy<ApiResult<OrderEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<VehicleEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<FirebaseResult>(
      FirebaseErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
  });

  setUp(() {
    mockGetVehicleByIdUseCase = MockGetVehicleByIdUseCase();
    mockGetOrderStreamUseCase = MockGetOrderStreamUseCase();
    mockUpdateOrderFirebaseUseCase = MockUpdateOrderFirebaseUseCase();
    vm = TrackOrderViewModel(
      mockGetVehicleByIdUseCase,
      mockGetOrderStreamUseCase,
      mockUpdateOrderFirebaseUseCase,
    );
  });

  group(' GetVehicleById Tests', () {
    test(' success updates state with vehicleEntity', () async {
      final vehicle = _vehicle();
      when(
        mockGetVehicleByIdUseCase.invoke(any),
      ).thenAnswer((_) async => ApiSuccessResult(data: vehicle));

      await vm.doIntent(GetVehicleByIdEvent(vehicleId: 'v1'));

      expect(vm.state.isLoading, false);
      expect(vm.state.success, true);
      expect(vm.state.vehicleEntity, vehicle);
    });

    test(' failure updates failure state', () async {
      final failure = Failure(errorMessage: 'vehicle error');
      when(
        mockGetVehicleByIdUseCase.invoke(any),
      ).thenAnswer((_) async => ApiErrorResult(failure: failure));

      await vm.doIntent(GetVehicleByIdEvent(vehicleId: 'v1'));

      expect(vm.state.isLoading, false);
      expect(vm.state.failure, failure);
      expect(vm.state.success, false);
    });
  });

  group(' GetOrderById Tests (Stream)', () {
    late StreamController<ApiResult<OrderEntity>> controller;

    setUp(() {
      controller = StreamController<ApiResult<OrderEntity>>();
      when(
        mockGetOrderStreamUseCase.invoke(any),
      ).thenAnswer((_) => controller.stream);
    });

    tearDown(() async {
      await controller.close();
    });

    test(' emits success order updates state', () async {
      final order = _order();

      unawaited(vm.doIntent(GetOrderByIdEvent(orderId: 'o1')));
      controller.add(ApiSuccessResult(data: order));

      await Future.delayed(Duration.zero);
      expect(vm.state.orderEntity, order);
      expect(vm.state.success, true);
    });

    test(' emits error updates failure state', () async {
      final failure = Failure(errorMessage: 'order error');

      unawaited(vm.doIntent(GetOrderByIdEvent(orderId: 'o1')));
      controller.add(ApiErrorResult(failure: failure));

      await Future.delayed(Duration.zero);
      expect(vm.state.failure, failure);
      expect(vm.state.success, false);
    });
  });

  group(' UpdateOrderStatus Tests', () {
    test(' success updates updateSuccess true', () async {
      when(
        mockUpdateOrderFirebaseUseCase.invoke(any, any),
      ).thenAnswer((_) async => FirebaseSuccessResult(data: null));

      await vm.doIntent(
        UpdateOrderStatusEvent(orderId: 'o1', status: OrderStatus.completed),
      );

      expect(vm.state.isUpdating, false);
      expect(vm.state.updateSuccess, true);
    });

    test(' failure updates updateFailure', () async {
      final failure = Failure(errorMessage: 'update failed');
      when(
        mockUpdateOrderFirebaseUseCase.invoke(any, any),
      ).thenAnswer((_) async => FirebaseErrorResult(failure: failure));

      await vm.doIntent(
        UpdateOrderStatusEvent(orderId: 'o1', status: OrderStatus.completed),
      );

      expect(vm.state.isUpdating, false);
      expect(vm.state.updateSuccess, false);
      expect(vm.state.updateFailure, failure);
    });
  });
}

VehicleEntity _vehicle() => const VehicleEntity(image: 'img');

OrderEntity _order() => const OrderEntity(
  id: 'o1',
  createdAt: 'now',
  isDelivered: false,
  state: 'pending',
  userState: 'waiting',
  driverData: DriverDataEntity(
    vehicleType: 'bike',
    firstName: 'Ahmed',
    lastName: 'Rajeh',
    phone: '12345',
    photo: 'img',
  ),
);
