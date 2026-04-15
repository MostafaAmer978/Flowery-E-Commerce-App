import 'package:flowers_ecommerce_app/core/network/api_constants.dart';
import 'package:flowers_ecommerce_app/core/network/api_services.dart';
import 'package:flowers_ecommerce_app/core/services/firebase_services.dart';
import 'package:flowers_ecommerce_app/core/utils/app_constants.dart';
import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/data_source/track_order_remote_ds.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/order_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/response/vehicle_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRemoteDataSource)
class TrackOrderRemoteDataSourceImp implements TrackOrderRemoteDataSource {
  final ApiServices _apiServices;
  final FirebaseService _firebaseService;
  static const String _orderCollection = ApiConstants.orderCollection;
  TrackOrderRemoteDataSourceImp(this._apiServices, this._firebaseService);
  @override
  Future<VehicleResponseDto> getVehicleById(String vehicleId) async {
    return await _apiServices.getVehicleById(vehicleId);
  }

  @override
  Stream<OrderDto> getOrderStream(String orderId) {
    return _firebaseService.streamData(_orderCollection, orderId).map((
      snapshot,
    ) {
      if (!snapshot.exists) {
        throw Exception(AppConstants.orderNotFound);
      }
      final data = snapshot.data() as Map<String, dynamic>;
      return OrderDto.fromJson(data);
    });
  }

  @override
  Future<void> updateOrderStatusFirebase(String orderId, OrderStatus status) {
    return _firebaseService.updateData(ApiConstants.orderCollection, orderId, {
      ApiConstants.userState: status.name,
    });
  }
}
