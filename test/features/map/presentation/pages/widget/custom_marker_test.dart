import 'package:flowers_ecommerce_app/features/map/presentation/pages/widget/custom_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomMarker shows title, icon, and image correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomMarker(
            imagePath: 'assets/images/flower.png',
            title: 'Flower',
          ),
        ),
      ),
    );
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
