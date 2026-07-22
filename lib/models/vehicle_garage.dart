import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'vehicle.dart';

/// Vehicles saved by the user, persisted to SharedPreferences as JSON.
class VehicleGarage {
  VehicleGarage._();

  static const _prefsKey = 'saved_vehicles';

  static final List<Vehicle> savedVehicles = [];

  static bool _loaded = false;

  /// Loads persisted vehicles into savedVehicles, once per process.
  static Future<void> load() async {
    if (_loaded) return;
    _loaded = true;

    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_prefsKey);
    if (json == null) return;

    final list = jsonDecode(json) as List<dynamic>;
    savedVehicles.addAll(list.map((entry) {
      final map = entry as Map<String, dynamic>;
      return Vehicle(
        name: map['name'] as String,
        bodyType: map['bodyType'] as String,
        chassisType: map['chassisType'] as String,
        suspensionType: map['suspensionType'] as String,
        powerPlant: map['powerPlant'] as String,
        notes: map['notes'] as String,
        armorFront: map['armorFront'] as int,
        armorBack: map['armorBack'] as int,
        armorLeft: map['armorLeft'] as int,
        armorRight: map['armorRight'] as int,
        armorTop: map['armorTop'] as int,
        armorUnderbody: map['armorUnderbody'] as int,
        tireDp: map['tireDp'] as int,
        weapons: (map['weapons'] as List<dynamic>).cast<String>(),
        hasBodyArmor: map['hasBodyArmor'] as bool? ?? false,
        targetingComputer: map['targetingComputer'] as String? ?? 'None',
        totalCost: (map['totalCost'] as num).toDouble(),
        weight: (map['weight'] as num).toDouble(),
        handlingClass: map['handlingClass'] as int,
        acceleration: map['acceleration'] as int,
        isUnderpowered: map['isUnderpowered'] as bool,
        topSpeed: (map['topSpeed'] as num).toDouble(),
      );
    }));
  }

  /// Writes the current savedVehicles list to SharedPreferences.
  static Future<void> persist() async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(savedVehicles
        .map((v) => {
              'name': v.name,
              'bodyType': v.bodyType,
              'chassisType': v.chassisType,
              'suspensionType': v.suspensionType,
              'powerPlant': v.powerPlant,
              'notes': v.notes,
              'armorFront': v.armorFront,
              'armorBack': v.armorBack,
              'armorLeft': v.armorLeft,
              'armorRight': v.armorRight,
              'armorTop': v.armorTop,
              'armorUnderbody': v.armorUnderbody,
              'tireDp': v.tireDp,
              'weapons': v.weapons,
              'hasBodyArmor': v.hasBodyArmor,
              'targetingComputer': v.targetingComputer,
              'totalCost': v.totalCost,
              'weight': v.weight,
              'handlingClass': v.handlingClass,
              'acceleration': v.acceleration,
              'isUnderpowered': v.isUnderpowered,
              'topSpeed': v.topSpeed,
            })
        .toList());
    await prefs.setString(_prefsKey, json);
  }

  /// Removes a saved vehicle and persists the change. Has no effect on placeholder vehicles.
  static Future<void> delete(Vehicle vehicle) async {
    savedVehicles.remove(vehicle);
    await persist();
  }
}
