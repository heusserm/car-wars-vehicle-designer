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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          // Cap runaway text sizes so the dense stat rows still fit, but leave
          // headroom above 1.0 so Dynamic Type actually does something. A cap
          // below 1.0 would shrink text for everyone and ignore the user's
          // accessibility setting entirely.
          data: mediaQuery.copyWith(
            textScaler: mediaQuery.textScaler.clamp(maxScaleFactor: 1.3),
          ),
          child: child!,
        );
      },
      home: const HomeScreen(),
    );
  }
}
