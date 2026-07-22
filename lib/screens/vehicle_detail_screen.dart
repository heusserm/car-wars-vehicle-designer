import 'package:flutter/material.dart';

import '../models/vehicle.dart';
import '../services/vehicle_calculator.dart';
import '../widgets/vehicle_delete_dialog.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final weapons = vehicle.weapons.isEmpty ? 'No weapons mounted.' : vehicle.weapons.join('\r\n\r\n');
    final accessories = vehicle.accessories.isEmpty ? 'No accessories.' : vehicle.accessories.join('\r\n');
    final acceleration = vehicle.isUnderpowered ? 'Underpowered – vehicle will not move' : '${vehicle.acceleration} mph';
    final driverDp = baseDriverDp + (vehicle.hasBodyArmor ? bodyArmorDpBonus : 0);

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
          _PlainRow('Body: ${vehicle.bodyType}'),
          _PlainRow('Chassis: ${vehicle.chassisType}'),
          _PlainRow('Suspension: ${vehicle.suspensionType}', marginBottom: 16),
          _DetailRow(label: 'Power Plant', value: vehicle.powerPlant),
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text('Armor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          _ArmorPairRow('Front: ${vehicle.armorFront} DP', 'Back: ${vehicle.armorBack} DP'),
          _ArmorPairRow('Left: ${vehicle.armorLeft} DP', 'Right: ${vehicle.armorRight} DP'),
          _ArmorPairRow('Top: ${vehicle.armorTop} DP', 'Under: ${vehicle.armorUnderbody} DP'),
          _PlainRow('Tires: ${vehicle.tireDp} DP each', marginTop: 12),
          _PlainRow(
            'Driver: $driverWeight lb, $driverDp DP'
            '${vehicle.hasBodyArmor ? ' (body armor)' : ''}',
            marginTop: 12,
          ),
          _PlainRow('Targeting: ${vehicle.targetingComputer}', marginBottom: 16),
          _DetailRow(label: 'Weapons', value: weapons),
          _DetailRow(label: 'Accessories', value: accessories),
          if (vehicle.notes.isNotEmpty) _DetailRow(label: 'Notes', value: vehicle.notes),
          _PlainRow('HC: ${vehicle.handlingClass}'),
          _PlainRow('Weight: ${vehicle.weight.toStringAsFixed(0)} lb'),
          _PlainRow('Accel: $acceleration'),
          _PlainRow('Top Speed: ${vehicle.topSpeed.toStringAsFixed(1)} mph'),
          _PlainRow('Cost: \$${vehicle.totalCost.toStringAsFixed(0)}'),
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

class _PlainRow extends StatelessWidget {
  const _PlainRow(this.text, {this.marginTop = 2, this.marginBottom = 0});

  final String text;
  final double marginTop;
  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}

class _ArmorPairRow extends StatelessWidget {
  const _ArmorPairRow(this.left, this.right);

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Expanded(child: Text(left, style: const TextStyle(fontSize: 16))),
          Expanded(child: Text(right, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
