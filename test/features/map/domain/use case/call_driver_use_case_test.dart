import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/repo/tracking_repo.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/call_driver_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'call_driver_use_case_test.mocks.dart';

@GenerateMocks([TrackingRepo])
void main() {
  MockTrackingRepo mockTrackingRepo = MockTrackingRepo();
  CallDriverUseCase callDriverUseCase = CallDriverUseCase(mockTrackingRepo);
  FirebaseResult<void> successResult = FirebaseSuccessResult(data: null);

  test(
    'test when call callDriverUseCase is shoulf call from tracking repo',
    () async {
      mockito.provideDummy<FirebaseResult<void>>(
        FirebaseSuccessResult(data: null),
      );
      when(
        mockTrackingRepo.callDriverRepo(any),
      ).thenAnswer((_) async => successResult);
      var result = await callDriverUseCase.call('');
      expect(result, equals(successResult));
    },
  );
}
