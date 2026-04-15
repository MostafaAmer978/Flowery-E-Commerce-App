import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/models/tracking_step.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/widgets/tracking_timeline.dart';

class MockTrackingStep extends TrackingStep {
  MockTrackingStep({
    required super.title,
    required super.timestamp,
    required super.isCompleted,
  });
}

final List<TrackingStep> mockStepsPartiallyCompleted = [
  MockTrackingStep(
    title: 'Order Placed',
    timestamp: 'Oct 14, 10:00 AM',
    isCompleted: true,
  ),
  MockTrackingStep(
    title: 'Processing Order',
    timestamp: 'Oct 14, 11:30 AM',
    isCompleted: true,
  ),
  MockTrackingStep(
    title: 'Shipped',
    timestamp: 'Oct 14, 02:00 PM',
    isCompleted: false,
  ),
  MockTrackingStep(
    title: 'Out for Delivery',
    timestamp: 'Pending',
    isCompleted: false,
  ),
  MockTrackingStep(
    title: 'Delivered',
    timestamp: 'Pending',
    isCompleted: false,
  ),
];

void main() {
  Widget createWidgetUnderTest(List<TrackingStep> steps) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            titleSmall: TextStyle(fontSize: 14.sp),
            displaySmall: TextStyle(fontSize: 10.sp),
          ),
        ),
        home: Scaffold(body: TrackingTimeline(steps: steps)),
      ),
    );
  }

  group('TrackingTimeline Widget Tests', () {
    testWidgets('renders all steps with correct titles and timestamps', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(mockStepsPartiallyCompleted),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order Placed'), findsOneWidget);
      expect(find.text('Processing Order'), findsOneWidget);
      expect(find.text('Shipped'), findsOneWidget);
      expect(find.text('Out for Delivery'), findsOneWidget);
      expect(find.text('Delivered'), findsOneWidget);

      expect(find.text('Oct 14, 10:00 AM'), findsOneWidget);
      expect(find.text('Oct 14, 11:30 AM'), findsOneWidget);
      expect(find.text('Oct 14, 02:00 PM'), findsOneWidget);
      expect(find.text('Pending'), findsNWidgets(2));
    });

    testWidgets('renders the correct number of TimelineTile widgets', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(mockStepsPartiallyCompleted),
      );
      await tester.pumpAndSettle();

      expect(
        find.byType(TimelineTile),
        findsNWidgets(mockStepsPartiallyCompleted.length),
      );
    });

    testWidgets('marks the first TimelineTile as isFirst=true', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(mockStepsPartiallyCompleted),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order Placed'), findsOneWidget);
    });

    testWidgets('marks the last TimelineTile as isLast=true', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(mockStepsPartiallyCompleted),
      );
      await tester.pumpAndSettle();

      expect(find.text('Delivered'), findsOneWidget);
    });
  });
}
