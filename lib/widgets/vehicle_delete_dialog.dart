import 'package:flutter/material.dart';

import '../models/vehicle.dart';
import '../models/vehicle_garage.dart';

/// Shows a delete confirmation dialog; if confirmed, deletes [vehicle] from
/// the garage and persists the change. Returns true if the vehicle was deleted.
Future<bool> confirmDeleteVehicle(BuildContext context, Vehicle vehicle) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete vehicle'),
      content: Text('Delete "${vehicle.name}"? This can\'t be undone.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  if (confirmed == true) {
    await VehicleGarage.delete(vehicle);
    return true;
  }
  return false;
}
