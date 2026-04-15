import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/widget/custom_marker.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/widget/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  testWidgets('map widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: MapWidgetTracking(
            driverPosition: const LatLng(2, 2),
            storePosition: const LatLng(2, 2),
            homePosition: const LatLng(2, 2),
            mapController: MapController(),
          ),
        ),
      ),
    );
    expect(find.byType(FlutterMap), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(3));
    expect(find.byType(CustomMarker), findsNWidgets(2));
  });
}
