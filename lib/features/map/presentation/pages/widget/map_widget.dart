import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/core/utils/app_images.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/widget/custom_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class MapWidgetTracking extends StatefulWidget {
  const MapWidgetTracking({
    super.key,
    required this.driverPosition,
    required this.storePosition,
    required this.homePosition,
    required this.mapController,
  });
  final LatLng driverPosition;
  final LatLng storePosition;
  final LatLng homePosition;
  final MapController mapController;

  @override
  State<MapWidgetTracking> createState() => _MapWidgetTrackingState();
}

class _MapWidgetTrackingState extends State<MapWidgetTracking> {
  @override
  void didUpdateWidget(covariant MapWidgetTracking oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.driverPosition != widget.driverPosition) {
      final currentZoom = widget.mapController.camera.zoom;
      widget.mapController.move(widget.driverPosition, currentZoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(initialCenter: widget.storePosition, initialZoom: 12),
      children: [
        TileLayer(
          urlTemplate: AppImages.urlTemplate,
          userAgentPackageName: AppImages.userAgentPackageName,
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: widget.driverPosition,
              width: 100,
              height: 100,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(AppImages.motorCycle),
              ),
            ),
            Marker(
              point: widget.storePosition,
              width: 100,
              height: 100,
              child: CustomMarker(
                title: AppLocalizations.of(context)!.flowery,
                imagePath: AppImages.flowerPhoto,
              ),
            ),
            Marker(
              point: widget.homePosition,
              width: 100,
              height: 100,
              child: CustomMarker(
                title: AppLocalizations.of(context)!.apartment,
                imagePath: AppImages.homeIcon,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
