import 'package:flutter/material.dart';

import 'design_vehicle_screen.dart';
import 'vehicle_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car Wars Vehicle Designer')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.directions_car, size: 96),
              const SizedBox(height: 16),
              const Text(
                'Design and manage your Car Wars vehicles.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const VehicleListScreen()),
                ),
                icon: const Icon(Icons.list),
                label: const Text('View My Vehicles'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DesignVehicleScreen()),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Design New Vehicle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
