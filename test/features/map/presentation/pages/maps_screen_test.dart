import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/maps_screen.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/widget/map_widget.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_bloc.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget/driver_data_test.mocks.dart';

@GenerateMocks([TrackingViewModel])
void main() {
  late MockTrackingViewModel mockTrackingViewModel;
  final sl = GetIt.instance;

  setUp(() {
    mockTrackingViewModel = MockTrackingViewModel();

    when(mockTrackingViewModel.state).thenReturn(
      const TrackingState(
        isLoading: false,
        errorMsg: '',
        trackingEntity: null,
        driverLocation: LatLng(30, 30),
        isLoaddingPhone: false,
        errorPhone: '',

        etaText: 'ETA 5 mins',
      ),
    );
    when(mockTrackingViewModel.mapController).thenReturn(MapController());
    when(
      mockTrackingViewModel.stream,
    ).thenAnswer((_) => Stream.value(mockTrackingViewModel.state));
    sl.registerSingleton<TrackingViewModel>(mockTrackingViewModel);
    addTearDown(() async {
      await sl.reset();
    });
  });
  testWidgets('maps screen test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: BlocProvider<TrackingViewModel>.value(
          value: mockTrackingViewModel,
          child: const Scaffold(body: DriverMapPage(orderId: '123')),
        ),
      ),
    );

    expect(find.byType(Stack), findsWidgets);
    expect(find.byType(MapWidgetTracking), findsOneWidget);
  });
}
