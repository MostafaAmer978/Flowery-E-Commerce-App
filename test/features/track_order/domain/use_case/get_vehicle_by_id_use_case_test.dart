import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/repo/track_order_repo.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/use_case/get_vehicle_by_id_use_case.dart';

import 'get_vehicle_by_id_use_case_test.mocks.dart';

@GenerateMocks([TrackOrderRepo])
void main() {
  group('GetVehicleByIdUseCase', () {
    late MockTrackOrderRepo mockRepo;
    late GetVehicleByIdUseCase usecase;

    const vehicleId = 'veh_001';
    const vehicle = VehicleEntity(image: 'https://car_image.png');

    setUp(() {
      mockRepo = MockTrackOrderRepo();
      usecase = GetVehicleByIdUseCase(mockRepo);
    });

    provideDummy<ApiResult<VehicleEntity>>(ApiSuccessResult(data: vehicle));

    test(
      'when calling invoke with valid vehicleId should return ApiSuccessResult<VehicleEntity>',
      () async {
        final expected = ApiSuccessResult<VehicleEntity>(data: vehicle);
        when(
          mockRepo.getVehicleById(vehicleId),
        ).thenAnswer((_) async => expected);

        final result = await usecase.invoke(vehicleId);

        verify(mockRepo.getVehicleById(vehicleId)).called(1);
        expect(result, isA<ApiSuccessResult<VehicleEntity>>());
        expect(
          (result as ApiSuccessResult).data.image,
          equals('https://car_image.png'),
        );
      },
    );

    test(
      'when calling invoke and repo returns ApiErrorResult should return ApiErrorResult<VehicleEntity>',
      () async {
        final expected = ApiErrorResult<VehicleEntity>(
          failure: Failure(errorMessage: 'Vehicle not found'),
        );

        provideDummy<ApiErrorResult<VehicleEntity>>(expected);
        when(
          mockRepo.getVehicleById(vehicleId),
        ).thenAnswer((_) async => expected);

        final result = await usecase.invoke(vehicleId);

        verify(mockRepo.getVehicleById(vehicleId)).called(1);
        expect(result, isA<ApiErrorResult<VehicleEntity>>());
        expect(
          (result as ApiErrorResult).failure.errorMessage,
          equals('Vehicle not found'),
        );
      },
    );
  });
}
