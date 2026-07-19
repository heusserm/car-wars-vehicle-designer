class Vehicle {
  const Vehicle({
    required this.name,
    required this.chassis,
    required this.powerPlant,
    this.notes = '',
    this.armorFront = 0,
    this.armorBack = 0,
    this.armorLeft = 0,
    this.armorRight = 0,
    this.armorTop = 0,
    this.armorUnderbody = 0,
    this.tireDp = 0,
    this.weapons = const [],
  });

  final String name;
  final String chassis;
  final String powerPlant;
  final String notes;
  final int armorFront;
  final int armorBack;
  final int armorLeft;
  final int armorRight;
  final int armorTop;
  final int armorUnderbody;
  final int tireDp;
  final List<String> weapons;
}
