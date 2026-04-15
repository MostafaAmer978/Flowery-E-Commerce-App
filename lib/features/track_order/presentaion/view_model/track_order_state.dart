import 'package:equatable/equatable.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';

class TrackOrderState extends Equatable {
  final bool isLoading;
  final Failure? failure;
  final VehicleEntity? vehicleEntity;
  final bool success;
  final OrderEntity? orderEntity;

  final bool isUpdating;
  final bool updateSuccess;
  final Failure? updateFailure;

  const TrackOrderState({
    this.isLoading = false,
    this.failure,
    this.vehicleEntity,
    this.success = false,
    this.orderEntity,
    this.isUpdating = false,
    this.updateSuccess = false,
    this.updateFailure,
  });

  TrackOrderState copyWith({
    bool? isLoading,
    Failure? failure,
    VehicleEntity? vehicleEntity,
    bool? success,
    OrderEntity? orderEntity,
    bool? isUpdating,
    bool? updateSuccess,
    Failure? updateFailure,
  }) {
    return TrackOrderState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      vehicleEntity: vehicleEntity ?? this.vehicleEntity,
      success: success ?? this.success,
      orderEntity: orderEntity ?? this.orderEntity,
      isUpdating: isUpdating ?? this.isUpdating,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      updateFailure: updateFailure ?? this.updateFailure,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    failure,
    vehicleEntity,
    success,
    orderEntity,
    isUpdating,
    updateSuccess,
    updateFailure,
  ];
}
