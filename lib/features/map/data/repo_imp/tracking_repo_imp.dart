import 'package:firebase_core/firebase_core.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/data/mapper/map_to_entity.dart';
import 'package:flowers_ecommerce_app/features/map/data/sources/tracking_ds.dart';
import 'package:flowers_ecommerce_app/features/map/domain/entites/tracking_entity.dart';
import 'package:flowers_ecommerce_app/features/map/domain/repo/tracking_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@Injectable(as: TrackingRepo)
class TrackingRepoImp implements TrackingRepo {
  final TrackingDataSource _trackingDataSource;
  TrackingRepoImp(this._trackingDataSource);
  @override
  Future<FirebaseResult<TrackingEntity>> getDataRepo(String orderId) {
    return safeFirebaseCall<TrackingEntity>(() async {
      final responseDto = await _trackingDataSource.getData(orderId);
      return responseDto.toEntity();
    });
  }

  @override
  Stream<FirebaseResult<LatLng?>> streamDriverLocationRepo(
    String orderId,
  ) async* {
    yield* _trackingDataSource
        .streamDriverLocation(orderId)
        .map((locString) {
          try {
            final parts = locString.split(',');
            final latitude = double.tryParse(parts[0].trim());
            final longitude = double.tryParse(parts[1].trim());

            if (latitude == null || longitude == null) {
              return FirebaseErrorResult<LatLng?>(
                failure: Failure(errorMessage: locString),
              );
            }

            return FirebaseSuccessResult<LatLng?>(
              data: LatLng(latitude, longitude),
            );
          } catch (e) {
            return FirebaseErrorResult<LatLng?>(
              failure: e is FirebaseException
                  ? ServerFailure.fromFirebaseError(exception: e)
                  : Failure(errorMessage: e.toString()),
            );
          }
        })
        .handleError((error) {
          return FirebaseErrorResult<LatLng?>(
            failure: error is FirebaseException
                ? ServerFailure.fromFirebaseError(exception: error)
                : Failure(errorMessage: error.toString()),
          );
        });
  }

  @override
  Future<FirebaseResult<void>> callDriverRepo(String phoneNumber) {
    return safeFirebaseCall(
      () async => _trackingDataSource.callDriver(phoneNumber),
    );
  }

  @override
  Future<FirebaseResult<void>> openWatsAppRepo(String phoneNumber) {
    return safeFirebaseCall(
      () async => _trackingDataSource.openWatsApp(phoneNumber),
    );
  }
}
