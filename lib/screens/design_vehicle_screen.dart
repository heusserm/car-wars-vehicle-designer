import 'dart:async';

import 'package:flutter/material.dart';

import '../models/armor.dart';
import '../models/body_type.dart';
import '../models/chassis.dart';
import '../models/mounted_weapon.dart';
import '../models/power_plant.dart';
import '../models/suspension.dart';
import '../models/tire.dart';
import '../models/vehicle.dart';
import '../models/vehicle_garage.dart';
import '../models/weapon.dart';
import '../services/vehicle_calculator.dart';

class DesignVehicleScreen extends StatefulWidget {
  const DesignVehicleScreen({super.key});

  @override
  State<DesignVehicleScreen> createState() => _DesignVehicleScreenState();
}

class _DesignVehicleScreenState extends State<DesignVehicleScreen> {
  final _nameController = TextEditingController();
  final _gallonsController = TextEditingController(text: '10');

  BodyType _bodyType = bodyTypes.first;
  ChassisType _chassisType = chassisTypes[1]; // Standard
  SuspensionType _suspensionType = suspensionTypes.first;
  TireType _tireType = tireTypes.first;

  bool _isElectric = true;
  ElectricPowerPlant _electricPlant = electricPowerPlants.first;
  GasEngine _gasEngine = gasEngines.first;
  GasTankType _gasTankType = gasTankTypes.first;

  final VehicleArmor _armor = VehicleArmor();
  final List<MountedWeapon> _mountedWeapons = [];
  Weapon _weaponToAdd = weapons.first;

  @override
  void dispose() {
    _nameController.dispose();
    _gallonsController.dispose();
    super.dispose();
  }

  double get _gallons => double.tryParse(_gallonsController.text) ?? 0;

  VehicleStats get _stats => computeVehicleStats(
        body: _bodyType,
        chassis: _chassisType,
        suspension: _suspensionType,
        isElectric: _isElectric,
        electricPlant: _isElectric ? _electricPlant : null,
        gasEngine: _isElectric ? null : _gasEngine,
        gasTankType: _isElectric ? null : _gasTankType,
        gasGallons: _isElectric ? 0 : _gallons,
        tire: _tireType,
        armor: _armor,
        mountedWeapons: _mountedWeapons,
      );

  @override
  Widget build(BuildContext context) {
    final stats = _stats;
    return Scaffold(
      appBar: AppBar(title: const Text('Design New Vehicle')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Vehicle Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Body'),
          DropdownButtonFormField<BodyType>(
            initialValue: _bodyType,
            decoration: const InputDecoration(labelText: 'Body Type', border: OutlineInputBorder()),
            items: bodyTypes
                .map((b) => DropdownMenuItem(value: b, child: Text(b.name)))
                .toList(),
            onChanged: (value) => setState(() => _bodyType = value!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<ChassisType>(
            initialValue: _chassisType,
            decoration: const InputDecoration(labelText: 'Chassis', border: OutlineInputBorder()),
            items: chassisTypes
                .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                .toList(),
            onChanged: (value) => setState(() => _chassisType = value!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<SuspensionType>(
            initialValue: _suspensionType,
            decoration: const InputDecoration(labelText: 'Suspension', border: OutlineInputBorder()),
            items: suspensionTypes
                .map((s) => DropdownMenuItem(value: s, child: Text(s.name)))
                .toList(),
            onChanged: (value) => setState(() => _suspensionType = value!),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Power Plant'),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Electric')),
              ButtonSegment(value: false, label: Text('Gas')),
            ],
            selected: {_isElectric},
            onSelectionChanged: (selection) => setState(() => _isElectric = selection.first),
          ),
          const SizedBox(height: 12),
          if (_isElectric)
            DropdownButtonFormField<ElectricPowerPlant>(
              initialValue: _electricPlant,
              decoration: const InputDecoration(labelText: 'Electric Plant', border: OutlineInputBorder()),
              items: electricPowerPlants
                  .map((p) => DropdownMenuItem(value: p, child: Text('${p.name} (${p.powerFactors} PF)')))
                  .toList(),
              onChanged: (value) => setState(() => _electricPlant = value!),
            )
          else ...[
            DropdownButtonFormField<GasEngine>(
              initialValue: _gasEngine,
              decoration: const InputDecoration(labelText: 'Gas Engine', border: OutlineInputBorder()),
              items: gasEngines
                  .map((e) => DropdownMenuItem(value: e, child: Text('${e.name} (${e.power} PF)')))
                  .toList(),
              onChanged: (value) => setState(() => _gasEngine = value!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<GasTankType>(
              initialValue: _gasTankType,
              decoration: const InputDecoration(labelText: 'Gas Tank Type', border: OutlineInputBorder()),
              items: gasTankTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                  .toList(),
              onChanged: (value) => setState(() => _gasTankType = value!),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _gallonsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Gas Tank Size (gallons)', border: OutlineInputBorder()),
              onChanged: (_) => setState(() {}),
            ),
          ],
          const SizedBox(height: 24),
          _SectionHeader('Tires'),
          DropdownButtonFormField<TireType>(
            initialValue: _tireType,
            decoration: const InputDecoration(labelText: 'Tire Type (x4)', border: OutlineInputBorder()),
            items: tireTypes
                .map((t) => DropdownMenuItem(value: t, child: Text('${t.name} (${t.dp} DP)')))
                .toList(),
            onChanged: (value) => setState(() => _tireType = value!),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Armor (points per facing)'),
          _ArmorGrid(armor: _armor, onChanged: () => setState(() {})),
          const SizedBox(height: 24),
          _SectionHeader('Weapons'),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Weapon>(
                  initialValue: _weaponToAdd,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Weapon', border: OutlineInputBorder()),
                  items: weapons
                      .map((w) => DropdownMenuItem(value: w, child: Text('${w.name} (${w.damage})')))
                      .toList(),
                  onChanged: (value) => setState(() => _weaponToAdd = value!),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => setState(() => _mountedWeapons.add(MountedWeapon(_weaponToAdd))),
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_mountedWeapons.isEmpty)
            const Text('No weapons mounted.', style: TextStyle(color: Colors.grey))
          else
            ..._mountedWeapons.asMap().entries.map(
                  (entry) => _MountedWeaponRow(
                    mounted: entry.value,
                    onAmmoChanged: () => setState(() {}),
                    onRemove: () => setState(() => _mountedWeapons.removeAt(entry.key)),
                  ),
                ),
          const SizedBox(height: 24),
          _SummaryCard(stats: stats),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => unawaited(_saveVehicle(stats)),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveVehicle(VehicleStats stats) async {
    var name = _nameController.text.trim();
    if (name.isEmpty) {
      name = 'Unnamed Vehicle';
    }

    final powerPlantSummary = _isElectric ? _electricPlant.name : _gasEngine.name;

    final weaponLines = _mountedWeapons.map((mounted) {
      final weapon = mounted.weapon;
      var line = '${weapon.name} ${weapon.damage} — '
          '\$${weapon.cost}, ${weapon.weight} lb, ${_formatSpace(weapon.space)} sp';
      if (weapon.ammoPerBox > 0) {
        line += ' — Ammo: ${mounted.ammoRounds} rounds (\$${mounted.ammoCost.toStringAsFixed(0)})';
      }
      return line;
    }).toList();

    await VehicleGarage.load();
    VehicleGarage.savedVehicles.add(Vehicle(
      name: name,
      bodyType: _bodyType.name,
      chassisType: _chassisType.name,
      suspensionType: _suspensionType.name,
      powerPlant: powerPlantSummary,
      armorFront: _armor.front,
      armorBack: _armor.back,
      armorLeft: _armor.left,
      armorRight: _armor.right,
      armorTop: _armor.top,
      armorUnderbody: _armor.underbody,
      tireDp: _tireType.dp,
      weapons: weaponLines,
      totalCost: stats.totalCost,
      weight: stats.totalWeight,
      handlingClass: stats.handlingClass,
      acceleration: stats.acceleration,
      isUnderpowered: stats.isUnderpowered,
      topSpeed: stats.topSpeed,
    ));
    await VehicleGarage.persist();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name saved')));
    Navigator.of(context).pop();
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

String _formatSpace(double space) {
  return space == space.floorToDouble() ? space.toInt().toString() : space.toStringAsFixed(2);
}

class _MountedWeaponRow extends StatelessWidget {
  const _MountedWeaponRow({
    required this.mounted,
    required this.onAmmoChanged,
    required this.onRemove,
  });

  final MountedWeapon mounted;
  final VoidCallback onAmmoChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final weapon = mounted.weapon;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weapon.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'Dam ${weapon.damage} | \$${weapon.cost} | ${weapon.weight} lb | ${_formatSpace(weapon.space)} sp',
                  style: const TextStyle(color: Colors.grey),
                ),
                if (weapon.ammoPerBox > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        const Text('Ammo:'),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            mounted.ammoRounds = (mounted.ammoRounds - weapon.ammoPerBox).clamp(0, 1 << 30);
                            onAmmoChanged();
                          },
                        ),
                        Text('${mounted.ammoRounds} rounds'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            mounted.ammoRounds += weapon.ammoPerBox;
                            onAmmoChanged();
                          },
                        ),
                        Text('\$${mounted.ammoCost.toStringAsFixed(0)}'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _ArmorGrid extends StatelessWidget {
  const _ArmorGrid({required this.armor, required this.onChanged});

  final VehicleArmor armor;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _armorField('Front', armor.front, (v) => armor.front = v)),
            const SizedBox(width: 8),
            Expanded(child: _armorField('Back', armor.back, (v) => armor.back = v)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _armorField('Left', armor.left, (v) => armor.left = v)),
            const SizedBox(width: 8),
            Expanded(child: _armorField('Right', armor.right, (v) => armor.right = v)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _armorField('Top', armor.top, (v) => armor.top = v)),
            const SizedBox(width: 8),
            Expanded(child: _armorField('Underbody', armor.underbody, (v) => armor.underbody = v)),
          ],
        ),
      ],
    );
  }

  Widget _armorField(String label, int value, ValueChanged<int> onSet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                onSet((value - 1).clamp(0, 1 << 30));
                onChanged();
              },
            ),
            Expanded(
              child: TextFormField(
                key: ValueKey('$label-$value'),
                initialValue: value.toString(),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
                onChanged: (text) {
                  onSet(int.tryParse(text) ?? 0);
                  onChanged();
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                onSet(value + 1);
                onChanged();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.stats});

  final VehicleStats stats;

  @override
  Widget build(BuildContext context) {
    final overWeight = stats.weightAvailable < 0;
    final overSpace = stats.spacesAvailable < 0;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Summary', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _statRow('Total Cost', '\$${stats.totalCost.toStringAsFixed(0)}'
                ' (includes \$${stats.ammoCost.toStringAsFixed(0)} of ammo)'),
            _statRow('Driver', '${stats.driverWeight} lb, ${stats.driverSpaces} sp (included above)'),
            _statRow(
              'Spaces Used / Available',
              '${stats.spacesUsed.toStringAsFixed(1)} used, ${stats.spacesAvailable.toStringAsFixed(1)} available',
              isWarning: overSpace,
            ),
            _statRow(
              'Weight / Max Load',
              '${stats.totalWeight.toStringAsFixed(0)} / ${stats.maxLoad.toStringAsFixed(0)} lb '
                  '(${stats.weightAvailable.toStringAsFixed(0)} available)',
              isWarning: overWeight,
            ),
            _statRow('Handling Class', '${stats.handlingClass}'),
            _statRow(
              'Acceleration',
              stats.isUnderpowered ? 'Underpowered – vehicle will not move' : '${stats.acceleration} mph',
              isWarning: stats.isUnderpowered,
            ),
            _statRow('Top Speed', '${stats.topSpeed.toStringAsFixed(1)} mph'),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String label, String value, {bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isWarning ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
