import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/widget/driver_data.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/widget/map_widget.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_bloc.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_event.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class DriverMapPage extends StatefulWidget {
  const DriverMapPage({super.key, required this.orderId});
  final String? orderId;

  @override
  State<DriverMapPage> createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {
  bool _started = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<TrackingViewModel>()
            ..doIntent(GetDataEvent(widget.orderId ?? '')),
      child: Scaffold(
        body: BlocBuilder<TrackingViewModel, TrackingState>(
          builder: (context, state) {
            if (!_started) {
              _started = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<TrackingViewModel>().doIntent(
                  StreamDriverLocationEvent(widget.orderId ?? ''),
                );
              });
            }

            return Stack(
              children: [
                MapWidgetTracking(
                  driverPosition:
                      state.driverLocation ??
                      state.trackingEntity?.storeLocation ??
                      const LatLng(0, 0),
                  storePosition:
                      state.trackingEntity?.storeLocation ?? const LatLng(0, 0),
                  homePosition: const LatLng(31.01347266, 30.59934292),
                  mapController: context
                      .read<TrackingViewModel>()
                      .mapController,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<TrackingViewModel, TrackingState>(
                    buildWhen: (prev, curr) => prev.etaText != curr.etaText,
                    builder: (context, state) {
                      return DriverData(
                        onTap: () {
                          context.pushNamedAndRemoveUntil(
                            AppRoutes.orders,
                            predicate: (route) => false,
                          );
                        },
                        date: state.isLoading
                            ? AppLocalizations.of(context)!.loading
                            : state.etaText,
                        driverName: state.trackingEntity?.driverName ?? '',
                        phoneNumber: state.trackingEntity?.driverNumber ?? '',
                        trackingViewModel: context.read<TrackingViewModel>(),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
