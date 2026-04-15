import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/data/model/response_dto.dart';
import 'package:flowers_ecommerce_app/features/map/data/repo_imp/tracking_repo_imp.dart';
import 'package:flowers_ecommerce_app/features/map/data/sources/tracking_ds.dart';
import 'package:flowers_ecommerce_app/features/map/domain/entites/tracking_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tracking_repo_imp_test.mocks.dart';

@GenerateMocks([TrackingDataSource])
void main() {
  group('test repoTracking', () {
    final MockTrackingDataSource trackingDataSource = MockTrackingDataSource();
    final repo = TrackingRepoImp(trackingDataSource);
    test(
      'when call getDataRepo is should call getDataRepo from DataSource on success',
      () async {
        when(
          trackingDataSource.getData(any),
        ).thenAnswer((_) async => ResponseDto());
        var result = await repo.getDataRepo('');
        expect(result, isA<FirebaseSuccessResult<TrackingEntity>>());
      },
    );
    test(
      'when call getDataRepo is should call getDataRepo from DataSource on error',
      () async {
        when(trackingDataSource.getData(any)).thenThrow(Exception());
        var result = await repo.getDataRepo('');
        expect(result, isA<FirebaseErrorResult<TrackingEntity>>());
      },
    );
    test(
      'when call streamDriverLocationRepo is should call streamDriverLocationRepo from DataSource on success',
      () {
        when(
          trackingDataSource.streamDriverLocation(any),
        ).thenAnswer((_) => const Stream.empty());
        var result = repo.streamDriverLocationRepo('');
        expect(result, isA<Stream<FirebaseResult<LatLng?>>>());
      },
    );
    test(
      'when call streamDriverLocationRepo is should call streamDriverLocationRepo from DataSource on error',
      () {
        when(
          trackingDataSource.streamDriverLocation(any),
        ).thenThrow(Exception());
        var result = repo.streamDriverLocationRepo('');
        expect(result, isA<Stream<FirebaseResult<LatLng?>>>());
      },
    );
    test(
      'when call callDriverRepo is should call callDriverRepo from DataSource on success',
      () async {
        when(
          trackingDataSource.callDriver(any),
        ).thenAnswer((_) => Future.value());
        var result = await repo.callDriverRepo('');
        expect(result, isA<FirebaseSuccessResult<void>>());
      },
    );
    test(
      'when call callDriverRepo is should call callDriverRepo from DataSource on error',
      () async {
        when(trackingDataSource.callDriver(any)).thenThrow(Exception());
        var result = await repo.callDriverRepo('');
        expect(result, isA<FirebaseErrorResult<void>>());
      },
    );
    test(
      'when call openWatsAppRepo is should call openWatsAppRepo from DataSource on success',
      () async {
        when(
          trackingDataSource.openWatsApp(any),
        ).thenAnswer((_) => Future.value());
        var result = await repo.openWatsAppRepo('');
        expect(result, isA<FirebaseSuccessResult<void>>());
      },
    );
    test(
      'when call openWatsAppRepo is should call openWatsAppRepo from DataSource on error',
      () async {
        when(trackingDataSource.openWatsApp(any)).thenThrow(Exception());
        var result = await repo.openWatsAppRepo('');
        expect(result, isA<FirebaseErrorResult<void>>());
      },
    );
  });
}
