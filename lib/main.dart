import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const CarWarsVehicleDesignerApp());
}

class CarWarsVehicleDesignerApp extends StatelessWidget {
  const CarWarsVehicleDesignerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Wars Vehicle Designer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: mediaQuery.textScaler.clamp(maxScaleFactor: 0.85),
          ),
          child: child!,
        );
      },
      home: const HomeScreen(),
    );
  }
}
