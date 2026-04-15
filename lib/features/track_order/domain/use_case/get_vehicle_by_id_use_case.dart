import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/repo/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVehicleByIdUseCase {
  final TrackOrderRepo _repo;

  GetVehicleByIdUseCase(this._repo);

  Future<ApiResult<VehicleEntity>> invoke(String vehicleId) =>
      _repo.getVehicleById(vehicleId);
}
