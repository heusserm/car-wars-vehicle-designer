class ChassisType {
  const ChassisType({
    required this.name,
    required this.maxLoadModifier,
    required this.priceModifier,
  });

  final String name;
  /// Fractional change to the body's max load (e.g. -0.10 for Light).
  final double maxLoadModifier;
  /// Fractional change to the body's price (e.g. 0.50 for Heavy).
  final double priceModifier;
}

const List<ChassisType> chassisTypes = [
  ChassisType(name: 'Light', maxLoadModifier: -0.10, priceModifier: -0.20),
  ChassisType(name: 'Standard', maxLoadModifier: 0, priceModifier: 0),
  ChassisType(name: 'Heavy', maxLoadModifier: 0.10, priceModifier: 0.50),
  ChassisType(name: 'Extra Heavy', maxLoadModifier: 0.20, priceModifier: 1.00),
];
