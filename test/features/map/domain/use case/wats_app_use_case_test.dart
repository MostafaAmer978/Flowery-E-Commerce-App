import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/repo/tracking_repo.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/wats_app_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'call_driver_use_case_test.mocks.dart';

@GenerateMocks([TrackingRepo])
void main() {
  MockTrackingRepo mockTrackingRepo = MockTrackingRepo();
  FirebaseResult<void> successResult = FirebaseSuccessResult(data: null);
  WatsappUseCase watsappUseCase = WatsappUseCase(mockTrackingRepo);
  test(
    'when call openWatsAppUseCase is should call from trakingrepo',
    () async {
      mockito.provideDummy<FirebaseResult<void>>(
        FirebaseSuccessResult(data: null),
      );

      when(
        mockTrackingRepo.openWatsAppRepo(any),
      ).thenAnswer((_) async => successResult);
      var result = await watsappUseCase.call('');
      expect(result, isA<FirebaseResult<void>>());
    },
  );
}
