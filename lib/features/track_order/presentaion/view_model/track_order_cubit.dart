import 'dart:async';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/order_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/use_case/get_order_stream_use_case.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/use_case/get_vehicle_by_id_use_case.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/use_case/update_order_firebase_use_case.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_event.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackOrderViewModel extends Cubit<TrackOrderState> {
  final GetVehicleByIdUseCase _getVehicleByIdUseCase;
  final GetOrderStreamUseCase _getOrderStreamUseCase;
  StreamSubscription? _orderSubscription;
  final UpdateOrderFirebaseUseCase _updateOrderFirebaseUseCase;
  TrackOrderViewModel(
    this._getVehicleByIdUseCase,
    this._getOrderStreamUseCase,
    this._updateOrderFirebaseUseCase,
  ) : super(const TrackOrderState());

  Future<void> doIntent(TrackOrderEvent event) async {
    switch (event) {
      case GetVehicleByIdEvent():
        await _getVehicleById(event.vehicleId);
        break;
      case GetOrderByIdEvent():
        await _listenToOrder(event.orderId);
        break;
      case UpdateOrderStatusEvent():
        await _updateOrderStatus(event.orderId, event.status);
        break;
    }
  }

  Future<void> _getVehicleById(String vehicleId) async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getVehicleByIdUseCase.invoke(vehicleId);
    switch (result) {
      case ApiSuccessResult<VehicleEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            success: true,
            vehicleEntity: result.data,
          ),
        );
      case ApiErrorResult<VehicleEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: result.failure,
            success: false,
          ),
        );
    }
  }

  Future<void> _listenToOrder(String orderId) async {
    emit(state.copyWith(isLoading: true, failure: null));
    await _orderSubscription?.cancel();
    _orderSubscription = _getOrderStreamUseCase.invoke(orderId).listen((
      result,
    ) {
      switch (result) {
        case ApiSuccessResult<OrderEntity>():
          emit(
            state.copyWith(
              isLoading: false,
              success: true,
              orderEntity: result.data,
            ),
          );
          break;

        case ApiErrorResult<OrderEntity>():
          emit(
            state.copyWith(
              isLoading: false,
              success: false,
              failure: result.failure,
            ),
          );
          break;
      }
    });
  }

  Future<void> _updateOrderStatus(String orderId, OrderStatus status) async {
    emit(
      state.copyWith(
        isUpdating: true,
        updateFailure: null,
        updateSuccess: false,
      ),
    );

    final result = await _updateOrderFirebaseUseCase.invoke(orderId, status);

    switch (result) {
      case FirebaseSuccessResult():
        emit(state.copyWith(isUpdating: false, updateSuccess: true));
        break;

      case FirebaseErrorResult():
        emit(
          state.copyWith(
            isUpdating: false,
            updateSuccess: false,
            updateFailure: result.failure,
          ),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
