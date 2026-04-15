import 'package:flowers_ecommerce_app/core/errors/firebase_results.dart';
import 'package:flowers_ecommerce_app/features/map/domain/entites/tracking_entity.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/call_driver_use_case.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/get_data_use_case.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/tracking_driver_use_case.dart';
import 'package:flowers_ecommerce_app/features/map/domain/use%20case/wats_app_use_case.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_event.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

@injectable
class TrackingViewModel extends Cubit<TrackingState> {
  final GetDataUseCase _getDataUseCase;
  final TrackingDriverUseCase _getDriverLocationStreamUseCase;
  final CallDriverUseCase _callDriverUseCase;
  final WatsappUseCase _watsappUseCase;

  MapController mapController = MapController();

  TrackingViewModel(
    this._getDataUseCase,
    this._getDriverLocationStreamUseCase,
    this._callDriverUseCase,
    this._watsappUseCase,
  ) : super(const TrackingState());

  void doIntent(TrackingEvent event) {
    switch (event) {
      case GetDataEvent():
        _getData(event.orderId);
        break;
      case StreamDriverLocationEvent():
        _streamDriverLocation(event.orderId);
        break;
      case CallDriverEvent():
        _callDriver(event.phoneNumber);
        break;
      case WatsappDriverEvent():
        _watsappDriver(event.phoneNumber);
        break;
    }
  }

  Future<void> _getData(String orderId) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getDataUseCase.call(orderId);

    switch (result) {
      case FirebaseSuccessResult<TrackingEntity>():
        final trackingData = result.data;

        const distanceCalc = Distance();
        final distanceKm = distanceCalc.as(
          LengthUnit.Kilometer,
          trackingData.driverLocation!,
          const LatLng(31.0152881, 30.5197196),
        );

        const avgSpeedKmPerHour = 40;
        final hours = distanceKm / avgSpeedKmPerHour;
        final eta = DateTime.now().add(Duration(hours: hours.round()));
        final formattedEta = DateFormat('dd MMM yyyy, hh:mm a').format(eta);
        emit(
          state.copyWith(
            trackingEntity: trackingData,
            etaText: formattedEta,
            isLoading: false,
          ),
        );
        break;

      case FirebaseErrorResult<TrackingEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMsg: result.failure.errorMessage,
          ),
        );
        break;
    }
  }

  void _streamDriverLocation(String orderId) {
    _getDriverLocationStreamUseCase.call(orderId).listen((driverLocation) {
      switch (driverLocation) {
        case FirebaseSuccessResult():
          emit(state.copyWith(driverLocation: driverLocation.data));
        case FirebaseErrorResult():
          emit(state.copyWith(errorMsg: driverLocation.failure.errorMessage));
      }
    });
  }

  void _callDriver(String phoneNumber) async {
    emit(state.copyWith(isLoaddingPhone: true));
    final result = await _callDriverUseCase.call(phoneNumber);

    switch (result) {
      case FirebaseSuccessResult<void>():
        emit(state.copyWith(isLoaddingPhone: false));
        break;
      case FirebaseErrorResult<void>():
        emit(
          state.copyWith(
            isLoaddingPhone: false,
            errorPhone: result.failure.errorMessage,
          ),
        );
        break;
    }
  }

  void _watsappDriver(String phoneNumber) async {
    emit(state.copyWith(isLoaddingPhone: true));
    final result = await _watsappUseCase.call(phoneNumber);

    switch (result) {
      case FirebaseSuccessResult<void>():
        emit(state.copyWith(isLoaddingPhone: false));
        break;
      case FirebaseErrorResult<void>():
        emit(
          state.copyWith(
            isLoaddingPhone: false,
            errorPhone: result.failure.errorMessage,
          ),
        );
        break;
    }
  }
}
