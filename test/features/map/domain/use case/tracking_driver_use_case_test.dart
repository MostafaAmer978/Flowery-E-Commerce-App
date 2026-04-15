import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/repo/tracking_repo.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/tracking_driver_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mockito/mockito.dart';

import 'tracking_driver_use_case_test.mocks.dart';

@GenerateMocks([TrackingRepo])
void main() {
  mockito.provideDummy<FirebaseResult<LatLng?>>(
    FirebaseSuccessResult(data: const LatLng(0.0, 0.0)),
  );

  late MockTrackingRepo mockTrackingRepo;
  late TrackingDriverUseCase trackingDriverUseCase;

  setUp(() {
    mockTrackingRepo = MockTrackingRepo();
    trackingDriverUseCase = TrackingDriverUseCase(mockTrackingRepo);
  });

  test('should emit driver location from repository stream', () async {
    const orderId = '123';
    const expectedLocation = LatLng(30.0, 31.0);
    final expectedResult = FirebaseSuccessResult(data: expectedLocation);

    when(
      mockTrackingRepo.streamDriverLocationRepo(orderId),
    ).thenAnswer((_) => Stream.value(expectedResult));

    final resultStream = trackingDriverUseCase.call(orderId);

    await expectLater(resultStream, emits(expectedResult));
    verify(mockTrackingRepo.streamDriverLocationRepo(orderId)).called(1);
  });
}
