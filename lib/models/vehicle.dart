class Vehicle {
  const Vehicle({
    required this.name,
    required this.bodyType,
    required this.chassisType,
    required this.suspensionType,
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
    this.hasBodyArmor = false,
    this.targetingComputer = 'None',
    this.totalCost = 0,
    this.weight = 0,
    this.handlingClass = 0,
    this.acceleration = 0,
    this.isUnderpowered = false,
    this.topSpeed = 0,
  });

  final String name;
  final String bodyType;
  final String chassisType;
  final String suspensionType;
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
  final bool hasBodyArmor;
  final String targetingComputer;
  final double totalCost;
  final double weight;
  final int handlingClass;
  final int acceleration;
  final bool isUnderpowered;
  final double topSpeed;
}
