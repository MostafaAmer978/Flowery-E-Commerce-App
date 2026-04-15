import 'dart:async';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/core/utils/app_constants.dart';
import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/data_source/track_order_remote_ds.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/order_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/response/vehicle_response_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/repo/track_order_repo_imp.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_repo_imp_test.mocks.dart';

@GenerateMocks([
  TrackOrderRemoteDataSource,
  InternetConnectionChecker,
  OrderDto,
  VehicleResponseDto,
])
void main() {
  late MockTrackOrderRemoteDataSource mockRemoteDataSource;
  late MockInternetConnectionChecker mockConnectionChecker;
  late TrackOrderRepoImp repo;

  setUp(() {
    mockRemoteDataSource = MockTrackOrderRemoteDataSource();
    mockConnectionChecker = MockInternetConnectionChecker();
    repo = TrackOrderRepoImp(mockRemoteDataSource, mockConnectionChecker);
  });

  group('TrackOrderRepoImp Tests', () {
    test(
      'getVehicleById should return ApiErrorResult when exception occurs',
      () async {
        const vehicleId = 'veh_error';

        when(
          mockRemoteDataSource.getVehicleById(vehicleId),
        ).thenThrow(Exception('API failure'));

        final result = await repo.getVehicleById(vehicleId);

        expect(result, isA<ApiErrorResult<VehicleEntity>>());
        verify(mockRemoteDataSource.getVehicleById(vehicleId)).called(1);
      },
    );

    test(
      'getOrderStream should emit ApiErrorResult<OrderEntity> on error',
      () async {
        const orderId = 'order_error';
        when(
          mockRemoteDataSource.getOrderStream(orderId),
        ).thenAnswer((_) => Stream.error(Exception('Order stream failed')));

        final stream = repo.getOrderStream(orderId);

        await expectLater(stream, emits(isA<ApiErrorResult<OrderEntity>>()));
        verify(mockRemoteDataSource.getOrderStream(orderId)).called(1);
      },
    );

    test(
      'updateOrderStatusFirebase should return FirebaseSuccessResult',
      () async {
        const orderId = 'order_update';
        final status = OrderStatus.values.first;

        when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);
        when(
          mockRemoteDataSource.updateOrderStatusFirebase(orderId, status),
        ).thenAnswer((_) async {});

        final result = await repo.updateOrderStatusFirebase(orderId, status);

        expect(result, isA<FirebaseSuccessResult>());
        verify(
          mockRemoteDataSource.updateOrderStatusFirebase(orderId, status),
        ).called(1);
      },
    );

    test(
      'updateOrderStatusFirebase should return FirebaseErrorResult when no internet',
      () async {
        const orderId = 'order_no_internet';
        final status = OrderStatus.values.first;

        when(
          mockConnectionChecker.hasConnection,
        ).thenAnswer((_) async => false);

        final result = await repo.updateOrderStatusFirebase(orderId, status);

        expect(result, isA<FirebaseErrorResult>());
        final failure = (result as FirebaseErrorResult).failure;
        expect(failure.errorMessage, AppConstants.noInternet);
        verifyNever(
          mockRemoteDataSource.updateOrderStatusFirebase(orderId, status),
        );
      },
    );

    test(
      'updateOrderStatusFirebase should return FirebaseErrorResult when update fails',
      () async {
        const orderId = 'order_fail';
        final status = OrderStatus.values.first;

        when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);
        when(
          mockRemoteDataSource.updateOrderStatusFirebase(orderId, status),
        ).thenThrow(Exception('Update failed'));

        final result = await repo.updateOrderStatusFirebase(orderId, status);

        expect(result, isA<FirebaseErrorResult>());
        final failure = (result as FirebaseErrorResult).failure;
        expect(failure.errorMessage, contains('Update failed'));
      },
    );
  });
}
