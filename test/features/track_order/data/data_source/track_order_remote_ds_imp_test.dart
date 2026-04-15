import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_ecommerce_app/core/network/api_constants.dart';
import 'package:flowers_ecommerce_app/core/network/api_services.dart';
import 'package:flowers_ecommerce_app/core/services/firebase_services.dart';
import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/data_source/track_order_remote_ds_imp.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/order_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/response/vehicle_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_remote_ds_imp_test.mocks.dart';

@GenerateMocks([ApiServices, FirebaseService, DocumentSnapshot])
void main() {
  late MockApiServices mockApiServices;
  late MockFirebaseService mockFirebaseService;
  late TrackOrderRemoteDataSourceImp dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    mockFirebaseService = MockFirebaseService();
    dataSource = TrackOrderRemoteDataSourceImp(
      mockApiServices,
      mockFirebaseService,
    );
  });

  group('TrackOrderRemoteDataSourceImp', () {
    group('getVehicleById', () {
      test(
        'should call ApiServices.getVehicleById and return VehicleResponseDto',
        () async {
          const vehicleId = 'vehicle-123';
          final mockResponse = VehicleResponseDto(
            message: 'success',
            vehicle: null,
          );

          when(
            mockApiServices.getVehicleById(vehicleId),
          ).thenAnswer((_) async => mockResponse);

          final result = await dataSource.getVehicleById(vehicleId);

          expect(result, isA<VehicleResponseDto>());
          expect(result.message, 'success');
          verify(mockApiServices.getVehicleById(vehicleId)).called(1);
        },
      );

      test(
        'should propagate exception when ApiServices.getVehicleById fails',
        () async {
          const vehicleId = 'vehicle-error';
          when(
            mockApiServices.getVehicleById(vehicleId),
          ).thenThrow(Exception('API failure'));

          expect(
            () => dataSource.getVehicleById(vehicleId),
            throwsA(isA<Exception>()),
          );
          verify(mockApiServices.getVehicleById(vehicleId)).called(1);
        },
      );
    });

    group('getOrderStream', () {
      test('should return OrderDto when document exists', () async {
        const orderId = 'order-123';
        final mockSnapshot = MockDocumentSnapshot();
        final orderData = {
          '_id': orderId,
          'createdAt': '2023-01-01',
          'isDelivered': false,
          'state': 'pending',
          'userState': 'confirmed',
        };

        when(mockSnapshot.exists).thenReturn(true);
        when(mockSnapshot.data()).thenReturn(orderData);

        when(
          mockFirebaseService.streamData(ApiConstants.orderCollection, orderId),
        ).thenAnswer((_) => Stream.value(mockSnapshot));

        final stream = dataSource.getOrderStream(orderId);
        final result = await stream.first;

        expect(result, isA<OrderDto>());
        expect(result.id, orderId);
        verify(
          mockFirebaseService.streamData(ApiConstants.orderCollection, orderId),
        ).called(1);
      });

      test('should throw exception when document does not exist', () async {
        const orderId = 'missing-order';
        final mockSnapshot = MockDocumentSnapshot();

        when(mockSnapshot.exists).thenReturn(false);
        when(
          mockFirebaseService.streamData(ApiConstants.orderCollection, orderId),
        ).thenAnswer((_) => Stream.value(mockSnapshot));

        final stream = dataSource.getOrderStream(orderId);

        await expectLater(stream, emitsError(isA<Exception>()));
        verify(
          mockFirebaseService.streamData(ApiConstants.orderCollection, orderId),
        ).called(1);
      });

      test('should propagate stream errors', () async {
        const orderId = 'error-order';
        when(
          mockFirebaseService.streamData(ApiConstants.orderCollection, orderId),
        ).thenAnswer((_) => Stream.error(Exception('Firebase error')));

        final stream = dataSource.getOrderStream(orderId);

        await expectLater(stream, emitsError(isA<Exception>()));
        verify(
          mockFirebaseService.streamData(ApiConstants.orderCollection, orderId),
        ).called(1);
      });
    });

    group('updateOrderStatusFirebase', () {
      test(
        'should call FirebaseService.updateData with correct parameters (pending)',
        () async {
          const orderId = 'order-123';
          const status = OrderStatus.pending;

          when(
            mockFirebaseService.updateData(
              ApiConstants.orderCollection,
              orderId,
              {ApiConstants.userState: status.name},
            ),
          ).thenAnswer((_) async => Future.value());

          await dataSource.updateOrderStatusFirebase(orderId, status);

          verify(
            mockFirebaseService.updateData(
              ApiConstants.orderCollection,
              orderId,
              {ApiConstants.userState: status.name},
            ),
          ).called(1);
        },
      );

      test(
        'should propagate exception when FirebaseService.updateData fails',
        () async {
          const orderId = 'order-error';
          const status = OrderStatus.completed;

          when(
            mockFirebaseService.updateData(
              ApiConstants.orderCollection,
              orderId,
              {ApiConstants.userState: status.name},
            ),
          ).thenThrow(Exception('Firebase update failed'));

          expect(
            () => dataSource.updateOrderStatusFirebase(orderId, status),
            throwsA(isA<Exception>()),
          );
          verify(
            mockFirebaseService.updateData(
              ApiConstants.orderCollection,
              orderId,
              {ApiConstants.userState: status.name},
            ),
          ).called(1);
        },
      );

      test('should use correct status.name for completed', () async {
        const orderId = 'order-123';
        const status = OrderStatus.completed;

        when(
          mockFirebaseService.updateData(
            ApiConstants.orderCollection,
            orderId,
            {ApiConstants.userState: status.name},
          ),
        ).thenAnswer((_) async => Future.value());

        await dataSource.updateOrderStatusFirebase(orderId, status);

        verify(
          mockFirebaseService.updateData(
            ApiConstants.orderCollection,
            orderId,
            {ApiConstants.userState: 'completed'},
          ),
        ).called(1);
      });
    });
  });
}
