import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:car_wars_vehicle_designer/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Home screen shows navigation entry points', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CarWarsVehicleDesignerApp());

    expect(find.text('Car Wars Vehicle Designer'), findsOneWidget);
    expect(find.text('View My Vehicles'), findsOneWidget);
    expect(find.text('Design New Vehicle'), findsOneWidget);
  });

  testWidgets('Navigating to vehicle list shows an empty garage', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CarWarsVehicleDesignerApp());

    await tester.tap(find.text('View My Vehicles'));
    await tester.pumpAndSettle();

    expect(find.text('My Vehicles'), findsOneWidget);
    expect(find.byIcon(Icons.directions_car_filled), findsNothing);
  });
}
