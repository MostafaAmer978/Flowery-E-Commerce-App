import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/core/utils/app_constants.dart';
import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/data_source/track_order_remote_ds.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/mapper/track_order_mappers.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/mapper/vehicle_mapper.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/repo/track_order_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/transformers.dart';

@Injectable(as: TrackOrderRepo)
class TrackOrderRepoImp implements TrackOrderRepo {
  final TrackOrderRemoteDataSource _remoteDataSource;
  final InternetConnectionChecker _internetConnectionChecker;
  TrackOrderRepoImp(this._remoteDataSource, this._internetConnectionChecker);

  @override
  Future<ApiResult<VehicleEntity>> getVehicleById(String vehicleId) async {
    return await safeApiCall(() async {
      final response = await _remoteDataSource.getVehicleById(vehicleId);
      return response.toEntity();
    });
  }

  @override
  Stream<ApiResult<OrderEntity>> getOrderStream(String orderId) {
    return _remoteDataSource
        .getOrderStream(orderId)
        .map<ApiResult<OrderEntity>>(
          (orderDto) =>
              ApiSuccessResult<OrderEntity>(data: orderDto.toEntity()),
        )
        .onErrorReturnWith((error, stackTrace) {
          return ApiErrorResult<OrderEntity>(
            failure: Failure(errorMessage: error.toString()),
          );
        });
  }

  @override
  Future<FirebaseResult> updateOrderStatusFirebase(
    String orderId,
    OrderStatus status,
  ) async {
    final bool isConnected = await _internetConnectionChecker.hasConnection;

    if (!isConnected) {
      return FirebaseErrorResult(
        failure: Failure(errorMessage: AppConstants.noInternet),
      );
    }

    return safeFirebaseCall(
      () => _remoteDataSource.updateOrderStatusFirebase(orderId, status),
    );
  }
}
