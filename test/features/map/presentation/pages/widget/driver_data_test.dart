import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/widget/driver_data.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'driver_data_test.mocks.dart';

@GenerateMocks([TrackingViewModel])
void main() {
  testWidgets('DriverData test ', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: DriverData(
            onTap: () => {},
            trackingViewModel: MockTrackingViewModel(),
            phoneNumber: '01289077897',
            driverName: 'yahya',
            date: '22/12/2025',
          ),
        ),
      ),
    );
    expect(find.byType(Text), findsNWidgets(5));
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
