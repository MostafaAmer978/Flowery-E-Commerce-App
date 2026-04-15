import 'package:equatable/equatable.dart';
import 'package:flowers_ecommerce_app/features/map/domain/entites/tracking_entity.dart';
import 'package:latlong2/latlong.dart';

class TrackingState extends Equatable {
  final bool isLoading;
  final String errorMsg;
  final TrackingEntity? trackingEntity;
  final LatLng? driverLocation;
  final bool isLoaddingPhone;
  final String errorPhone;
  final String etaText;

  const TrackingState({
    this.etaText = '',
    this.driverLocation,
    this.errorPhone = '',
    this.isLoaddingPhone = false,
    this.isLoading = false,
    this.trackingEntity,
    this.errorMsg = '',
  });

  TrackingState copyWith({
    String? errorPhone,
    bool? isLoaddingPhone,
    LatLng? driverLocation,
    bool? isLoading,
    String? errorMsg,
    TrackingEntity? trackingEntity,
    double? distanceLeftKm,
    String? etaText,
    double? etaMinutes,
  }) {
    return TrackingState(
      etaText: etaText ?? this.etaText,
      driverLocation: driverLocation ?? this.driverLocation,
      errorPhone: errorPhone ?? this.errorPhone,
      isLoaddingPhone: isLoaddingPhone ?? this.isLoaddingPhone,
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      trackingEntity: trackingEntity ?? this.trackingEntity,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMsg,
    trackingEntity,
    driverLocation,
    isLoaddingPhone,
    errorPhone,
    etaText,
  ];
}
