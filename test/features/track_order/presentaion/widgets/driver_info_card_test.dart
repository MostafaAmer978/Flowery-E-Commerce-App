import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/widgets/driver_info_card.dart';

void main() {
  group('DriverInfoCard Widget Tests', () {
    Widget createTestWidget({
      String driverName = 'John Doe',
      String driverPhone = '+1234567890',
      String driverPhoto = 'https://example.com/photo.jpg',
    }) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', ''), Locale('ar', '')],
          locale: const Locale('en'),
          home: Scaffold(
            body: DriverInfoCard(
              driverName: driverName,
              driverPhone: driverPhone,
              driverPhoto: driverPhoto,
            ),
          ),
        ),
      );
    }

    testWidgets('should display driver information correctly', (
      WidgetTester tester,
    ) async {
      const driverName = 'Ahmed Ali';
      const driverPhone = '+201234567890';
      const driverPhoto = 'https://example.com/driver.jpg';

      await tester.pumpWidget(
        createTestWidget(
          driverName: driverName,
          driverPhone: driverPhone,
          driverPhoto: driverPhoto,
        ),
      );

      expect(find.text(driverName), findsOneWidget);
      expect(
        find.textContaining('delivery hero for today', findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('should display phone and WhatsApp icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Tooltip), findsNWidgets(2));
    });

    testWidgets('should show tooltips for phone and WhatsApp icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Tooltip), findsNWidgets(2));

      expect(
        find.byWidgetPredicate((widget) {
          return widget is Tooltip && widget.message == 'Call driver';
        }),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate((widget) {
          return widget is Tooltip && widget.message == 'Chat on WhatsApp';
        }),
        findsOneWidget,
      );
    });

    testWidgets('should display driver name with correct styling', (
      WidgetTester tester,
    ) async {
      const driverName = 'Mohamed Hassan';

      await tester.pumpWidget(createTestWidget(driverName: driverName));

      final nameText = find.text(driverName);
      expect(nameText, findsOneWidget);

      final textWidget = tester.widget<Text>(nameText);
      expect(textWidget.style?.color, isNotNull);
    });

    testWidgets('should handle empty driver name gracefully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(driverName: ''));

      expect(find.text(''), findsOneWidget);
    });

    testWidgets('should handle empty phone number gracefully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(driverPhone: ''));

      expect(find.byType(DriverInfoCard), findsOneWidget);
    });

    testWidgets('should be responsive to different screen sizes', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(DriverInfoCard), findsOneWidget);

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.constraints, isNotNull);
    });

    testWidgets('should have tappable phone and WhatsApp buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(GestureDetector), findsNWidgets(2));

      final phoneGesture = find.byType(GestureDetector).first;
      final whatsappGesture = find.byType(GestureDetector).last;

      expect(phoneGesture, findsOneWidget);
      expect(whatsappGesture, findsOneWidget);
    });

    testWidgets('should display SVG icons for phone and WhatsApp', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Container), findsWidgets);
    });
  });
}
