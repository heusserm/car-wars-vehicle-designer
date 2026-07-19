import 'package:flutter/material.dart';

import '../models/vehicle.dart';
import '../services/vehicle_calculator.dart';
import '../widgets/vehicle_delete_dialog.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final armor = 'Front: ${vehicle.armorFront} DP\r\n'
        'Back: ${vehicle.armorBack} DP\r\n'
        'Left: ${vehicle.armorLeft} DP\r\n'
        'Right: ${vehicle.armorRight} DP\r\n'
        'Top: ${vehicle.armorTop} DP\r\n'
        'Underbody: ${vehicle.armorUnderbody} DP\r\n\r\n'
        'Tires: ${vehicle.tireDp} DP each\r\n\r\n'
        'Driver: $driverWeight lb, $driverDp DP';

    final weapons = vehicle.weapons.isEmpty ? 'No weapons mounted.' : vehicle.weapons.join('\r\n\r\n');

    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final deleted = await confirmDeleteVehicle(context, vehicle);
              if (deleted && context.mounted) Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _DetailRow(label: 'Chassis', value: vehicle.chassis),
          _DetailRow(label: 'Power Plant', value: vehicle.powerPlant),
          _DetailRow(label: 'Armor', value: armor),
          _DetailRow(label: 'Weapons', value: weapons),
          if (vehicle.notes.isNotEmpty)
            _DetailRow(label: 'Notes', value: vehicle.notes),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
