class ElectricPowerPlant {
  const ElectricPowerPlant({
    required this.name,
    required this.cost,
    required this.weight,
    required this.spaces,
    required this.dp,
    required this.powerFactors,
  });

  final String name;
  final int cost;
  final int weight;
  final int spaces;
  final int dp;
  final int powerFactors;
}

const List<ElectricPowerPlant> electricPowerPlants = [
  ElectricPowerPlant(name: 'Small', cost: 500, weight: 500, spaces: 3, dp: 5, powerFactors: 800),
  ElectricPowerPlant(name: 'Medium', cost: 1000, weight: 700, spaces: 4, dp: 8, powerFactors: 1400),
  ElectricPowerPlant(name: 'Large', cost: 2000, weight: 900, spaces: 5, dp: 10, powerFactors: 2000),
  ElectricPowerPlant(name: 'Super', cost: 3000, weight: 1100, spaces: 6, dp: 12, powerFactors: 2600),
  ElectricPowerPlant(name: 'Sport', cost: 6000, weight: 1000, spaces: 6, dp: 12, powerFactors: 3000),
  ElectricPowerPlant(name: 'Thundercat', cost: 12000, weight: 2000, spaces: 8, dp: 15, powerFactors: 6700),
];

class GasEngine {
  const GasEngine({
    required this.name,
    required this.cost,
    required this.weight,
    required this.spaces,
    required this.dp,
    required this.power,
    required this.baseMpg,
  });

  final String name;
  final int cost;
  final int weight;
  final int spaces;
  final int dp;
  final int power;
  final int baseMpg;
}

const List<GasEngine> gasEngines = [
  GasEngine(name: '10 cid', cost: 400, weight: 60, spaces: 1, dp: 1, power: 300, baseMpg: 80),
  GasEngine(name: '30 cid', cost: 750, weight: 115, spaces: 1, dp: 2, power: 500, baseMpg: 70),
  GasEngine(name: '50 cid', cost: 1250, weight: 150, spaces: 1, dp: 3, power: 700, baseMpg: 60),
  GasEngine(name: '100 cid', cost: 2500, weight: 265, spaces: 2, dp: 6, power: 1300, baseMpg: 50),
  GasEngine(name: '150 cid', cost: 4000, weight: 375, spaces: 3, dp: 9, power: 1900, baseMpg: 45),
  GasEngine(name: '200 cid', cost: 5500, weight: 480, spaces: 4, dp: 12, power: 2500, baseMpg: 35),
  GasEngine(name: '250 cid', cost: 6500, weight: 715, spaces: 5, dp: 14, power: 3200, baseMpg: 28),
  GasEngine(name: '300 cid', cost: 7800, weight: 825, spaces: 6, dp: 16, power: 4000, baseMpg: 22),
  GasEngine(name: '350 cid', cost: 9500, weight: 975, spaces: 7, dp: 19, power: 5000, baseMpg: 18),
  GasEngine(name: '400 cid', cost: 10500, weight: 1050, spaces: 8, dp: 22, power: 6300, baseMpg: 15),
  GasEngine(name: '450 cid', cost: 11700, weight: 1125, spaces: 9, dp: 24, power: 7800, baseMpg: 13),
  GasEngine(name: '500 cid', cost: 13000, weight: 1200, spaces: 10, dp: 26, power: 9500, baseMpg: 12),
  GasEngine(name: '700 cid', cost: 19000, weight: 1275, spaces: 14, dp: 30, power: 13000, baseMpg: 10),
];

class GasTankType {
  const GasTankType({
    required this.name,
    required this.dp,
    required this.weightPerGallon,
    required this.costPerGallon,
  });

  final String name;
  final int dp;
  final double weightPerGallon;
  final double costPerGallon;
}

const List<GasTankType> gasTankTypes = [
  GasTankType(name: 'Economy', dp: 2, weightPerGallon: 1, costPerGallon: 2),
  GasTankType(name: 'Heavy-Duty', dp: 4, weightPerGallon: 2, costPerGallon: 5),
  GasTankType(name: 'Racing', dp: 4, weightPerGallon: 5, costPerGallon: 10),
  GasTankType(name: 'Duelling', dp: 8, weightPerGallon: 10, costPerGallon: 25),
];

/// Spaces taken by a gas tank of the given total gallon capacity.
int gasTankSpaces(double gallons) {
  if (gallons <= 5) return 0;
  return ((gallons - 5) / 10).ceil();
}
