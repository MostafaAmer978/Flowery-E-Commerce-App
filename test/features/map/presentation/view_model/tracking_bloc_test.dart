import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/entites/tracking_entity.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/call_driver_use_case.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/get_data_use_case.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/tracking_driver_use_case.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/wats_app_use_case.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_bloc.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_event.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tracking_bloc_test.mocks.dart';

@GenerateMocks([
  GetDataUseCase,
  TrackingDriverUseCase,
  CallDriverUseCase,
  WatsappUseCase,
])
void main() {
  // provide dummy for void FirebaseResult
  provideDummy<FirebaseResult<void>>(FirebaseSuccessResult(data: null));

  late MockGetDataUseCase mockGetDataUseCase;
  late MockTrackingDriverUseCase mockTrackingDriverUseCase;
  late MockCallDriverUseCase mockCallDriverUseCase;
  late MockWatsappUseCase mockWatsappUseCase;
  late TrackingViewModel cubit;

  setUp(() {
    mockGetDataUseCase = MockGetDataUseCase();
    mockTrackingDriverUseCase = MockTrackingDriverUseCase();
    mockCallDriverUseCase = MockCallDriverUseCase();
    mockWatsappUseCase = MockWatsappUseCase();

    cubit = TrackingViewModel(
      mockGetDataUseCase,
      mockTrackingDriverUseCase,
      mockCallDriverUseCase,
      mockWatsappUseCase,
    );
  });

  tearDown(() => cubit.close());

  group('📦 GetDataEvent Tests', () {
    const testDriverLocation = LatLng(30.0, 31.0);
    final testEntity = TrackingEntity(
      driverName: 'Ali',

      driverLocation: testDriverLocation,
      orderId: '',
      driverNumber: '',
      storeLocation: const LatLng(33, 444),
    );

    blocTest<TrackingViewModel, TrackingState>(
      'emits [loading -> success] when GetDataEvent succeeds',
      build: () {
        provideDummy<FirebaseResult<TrackingEntity>>(
          FirebaseSuccessResult<TrackingEntity>(
            data: TrackingEntity(
              driverName: '',
              driverLocation: const LatLng(0, 0),
              orderId: '',
              driverNumber: '',
              storeLocation: const LatLng(33, 444),
            ),
          ),
        );
        when(mockGetDataUseCase.call(any)).thenAnswer(
          (_) async => FirebaseSuccessResult<TrackingEntity>(data: testEntity),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetDataEvent('order123')),

      expect: () => [
        isA<TrackingState>().having((s) => s.isLoading, 'isLoading', true),

        isA<TrackingState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.trackingEntity, 'trackingEntity', testEntity)
            .having((s) => s.etaText.isNotEmpty, 'etaText not empty', true),
      ],
    );

    blocTest<TrackingViewModel, TrackingState>(
      'emits [loading -> error] when GetDataEvent fails',
      build: () {
        provideDummy<FirebaseResult<TrackingEntity>>(
          FirebaseErrorResult<TrackingEntity>(
            failure: Failure(errorMessage: ''),
          ),
        );
        when(mockGetDataUseCase.call(any)).thenAnswer(
          (_) async => FirebaseErrorResult<TrackingEntity>(
            failure: Failure(errorMessage: 'Failed to load data'),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetDataEvent('order123')),
      expect: () => [
        const TrackingState(isLoading: true),
        const TrackingState(isLoading: false, errorMsg: 'Failed to load data'),
      ],
    );
  });

  group('CallDriverEvent Tests', () {
    blocTest<TrackingViewModel, TrackingState>(
      'emits [loadingPhone:true -> loadingPhone:false] when callDriver succeeds',
      build: () {
        when(
          mockCallDriverUseCase.call(any),
        ).thenAnswer((_) async => FirebaseSuccessResult(data: null));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(CallDriverEvent('01012345678')),
      expect: () => [
        const TrackingState(isLoaddingPhone: true),
        const TrackingState(isLoaddingPhone: false),
      ],
    );

    blocTest<TrackingViewModel, TrackingState>(
      'emits [loadingPhone:true -> loadingPhone:false with error] when callDriver fails',
      build: () {
        when(mockCallDriverUseCase.call(any)).thenAnswer(
          (_) async => FirebaseErrorResult<void>(
            failure: Failure(errorMessage: 'Call failed'),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(CallDriverEvent('01012345678')),
      expect: () => [
        const TrackingState(isLoaddingPhone: true),
        const TrackingState(errorPhone: 'Call failed', isLoaddingPhone: false),
      ],
    );
  });

  group('StreamDriverLocationEvent Tests', () {
    const expectedLocation = LatLng(30.0, 31.0);

    ///oooooooooo

    blocTest<TrackingViewModel, TrackingState>(
      'emits state with driver location when stream emits FirebaseSuccessResult',
      build: () {
        when(mockTrackingDriverUseCase.call(any)).thenAnswer(
          (_) => Stream.value(
            FirebaseSuccessResult<LatLng?>(data: expectedLocation),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(StreamDriverLocationEvent('123')),
      expect: () => [cubit.state.copyWith(driverLocation: expectedLocation)],
    );

    blocTest<TrackingViewModel, TrackingState>(
      'emits errorMsg when stream emits FirebaseErrorResult',
      build: () {
        when(mockTrackingDriverUseCase.call(any)).thenAnswer(
          (_) => Stream.value(
            FirebaseErrorResult<LatLng?>(
              failure: Failure(errorMessage: 'Stream error'),
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(StreamDriverLocationEvent('123')),
      expect: () => [cubit.state.copyWith(errorMsg: 'Stream error')],
    );
  });
}
