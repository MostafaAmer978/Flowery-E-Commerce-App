import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/driver_data_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/repo/track_order_repo.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/use_case/get_order_stream_use_case.dart';
import 'get_order_stream_use_case_test.mocks.dart';

@GenerateMocks([TrackOrderRepo])
void main() {
  group('GetOrderStreamUseCase', () {
    late MockTrackOrderRepo mockRepo;
    late GetOrderStreamUseCase usecase;

    const orderId = 'order_123';

    const orderEntity = OrderEntity(
      id: orderId,
      createdAt: '2025-01-01',
      isDelivered: false,
      state: 'active',
      userState: 'pending',
      driverData: DriverDataEntity(
        firstName: 'Ahmed',
        lastName: 'Rajeh',
        phone: '123456789',
        photo: 'photo_url',
        vehicleType: 'Car',
      ),
    );

    setUp(() {
      mockRepo = MockTrackOrderRepo();
      usecase = GetOrderStreamUseCase(mockRepo);
    });

    provideDummy<ApiResult<OrderEntity>>(ApiSuccessResult(data: orderEntity));

    test(
      'when calling invoke should return a stream emitting ApiSuccessResult<OrderEntity>',
      () async {
        when(
          mockRepo.getOrderStream(orderId),
        ).thenAnswer((_) => Stream.value(ApiSuccessResult(data: orderEntity)));

        final resultStream = usecase.invoke(orderId);

        await expectLater(
          resultStream,
          emits(isA<ApiSuccessResult<OrderEntity>>()),
        );

        verify(mockRepo.getOrderStream(orderId)).called(1);
      },
    );

    test(
      'when repo emits ApiErrorResult should return a stream emitting ApiErrorResult<OrderEntity>',
      () async {
        final errorResult = ApiErrorResult<OrderEntity>(
          failure: Failure(errorMessage: 'Order not found'),
        );
        provideDummy<ApiErrorResult<OrderEntity>>(errorResult);

        when(
          mockRepo.getOrderStream(orderId),
        ).thenAnswer((_) => Stream.value(errorResult));

        final resultStream = usecase.invoke(orderId);
        await expectLater(
          resultStream,
          emits(isA<ApiErrorResult<OrderEntity>>()),
        );

        verify(mockRepo.getOrderStream(orderId)).called(1);
      },
    );
  });
}
