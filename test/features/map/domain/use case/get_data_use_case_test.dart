import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/entites/tracking_entity.dart';
import 'package:flowers_ecommerce_app/features/map/domain/repo/tracking_repo.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/get_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/mockito.dart' as mockito;

import 'call_driver_use_case_test.mocks.dart';

@GenerateMocks([TrackingRepo])
void main() {
  MockTrackingRepo mockTrackingRepo = MockTrackingRepo();
  GetDataUseCase getDataUseCase = GetDataUseCase(mockTrackingRepo);
  mockito.provideDummy<FirebaseResult<TrackingEntity>>(
    FirebaseSuccessResult(
      data: TrackingEntity(
        orderId: '',
        driverLocation: const LatLng(30.0444, 31.2357),
        driverNumber: '',
        driverName: '',
        storeLocation: const LatLng(30.0444, 31.2357),
      ),
    ),
  );
  FirebaseSuccessResult successResult = FirebaseSuccessResult<TrackingEntity>(
    data: TrackingEntity(
      orderId: '',
      driverNumber: '',
      driverName: '',
      storeLocation: const LatLng(30.0444, 31.2357),
      driverLocation: null,
    ),
  );
  test('when call getDataUseCase is should call from trackin repo', () async {
    when(mockTrackingRepo.getDataRepo(any)).thenAnswer(
      (_) async =>
          FirebaseSuccessResult<TrackingEntity>(data: successResult.data),
    );
    var result = await getDataUseCase.call('');
    expect(result, isA<FirebaseSuccessResult<TrackingEntity>>());
  });
}
