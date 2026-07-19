import 'package:flutter/material.dart';

import '../models/vehicle.dart';
import '../models/vehicle_garage.dart';
import '../widgets/vehicle_delete_dialog.dart';
import 'vehicle_detail_screen.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  late final Future<void> _loadFuture = VehicleGarage.load();

  Future<void> _confirmDelete(Vehicle vehicle) async {
    final deleted = await confirmDeleteVehicle(context, vehicle);
    if (deleted && mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Vehicles')),
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final vehicles = VehicleGarage.savedVehicles;
          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return ListTile(
                leading: const Icon(Icons.directions_car_filled),
                title: Text(vehicle.name),
                subtitle: Text(vehicle.chassis),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _confirmDelete(vehicle),
                ),
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => VehicleDetailScreen(vehicle: vehicle),
                    ),
                  );
                  if (mounted) setState(() {});
                },
              );
            },
          );
        },
      ),
    );
  }
}
