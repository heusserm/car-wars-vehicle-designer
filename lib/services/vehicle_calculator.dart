import '../models/armor.dart';
import '../models/body_type.dart';
import '../models/chassis.dart';
import '../models/mounted_weapon.dart';
import '../models/power_plant.dart';
import '../models/suspension.dart';
import '../models/tire.dart';

const int driverWeight = 150;
const int driverSpaces = 2;
const int driverDp = 3;
const int tireCount = 4;

class VehicleStats {
  const VehicleStats({
    required this.totalCost,
    required this.ammoCost,
    required this.totalWeight,
    required this.maxLoad,
    required this.spacesUsed,
    required this.spacesAvailable,
    required this.handlingClass,
    required this.powerFactors,
    required this.acceleration,
    required this.topSpeed,
    required this.isUnderpowered,
    required this.driverWeight,
    required this.driverSpaces,
  });

  final double totalCost;
  final double ammoCost;
  final double totalWeight;
  final double maxLoad;
  final double spacesUsed;
  final double spacesAvailable;
  final int handlingClass;
  final int powerFactors;
  final int acceleration;
  final double topSpeed;
  final bool isUnderpowered;
  final int driverWeight;
  final int driverSpaces;

  double get weightAvailable => maxLoad - totalWeight;
}

VehicleStats computeVehicleStats({
  required BodyType body,
  required ChassisType chassis,
  required SuspensionType suspension,
  required bool isElectric,
  ElectricPowerPlant? electricPlant,
  GasEngine? gasEngine,
  GasTankType? gasTankType,
  double gasGallons = 0,
  required TireType tire,
  required VehicleArmor armor,
  required List<MountedWeapon> mountedWeapons,
}) {
  final maxLoad = body.maxLoad * (1 + chassis.maxLoadModifier);

  final bodyPrice = body.price * (1 + chassis.priceModifier);
  final suspensionCost = body.price * suspension.costFactor;

  final int powerPlantCost;
  final int powerPlantWeight;
  final int powerPlantSpacesUsed;
  final int powerFactors;
  if (isElectric) {
    final plant = electricPlant!;
    powerPlantCost = plant.cost;
    powerPlantWeight = plant.weight;
    powerPlantSpacesUsed = plant.spaces;
    powerFactors = plant.powerFactors;
  } else {
    final engine = gasEngine!;
    final tankType = gasTankType!;
    powerPlantCost = engine.cost + (tankType.costPerGallon * gasGallons).round();
    powerPlantWeight = engine.weight + (tankType.weightPerGallon * gasGallons).round();
    powerPlantSpacesUsed = engine.spaces + gasTankSpaces(gasGallons);
    powerFactors = engine.power;
  }

  final tiresCost = tire.price * tireCount;
  final tiresWeight = tire.weight * tireCount;

  final armorCost = armor.totalPoints * body.armorCostPerPoint;
  final armorWeight = armor.totalPoints * body.armorWeightPerPoint;

  final weaponsCost = mountedWeapons.fold<int>(0, (sum, mw) => sum + mw.weapon.cost);
  final ammoCost = mountedWeapons.fold<double>(0, (sum, mw) => sum + mw.ammoCost);
  final weaponsWeight = mountedWeapons.fold<double>(0, (sum, mw) => sum + mw.weapon.weight);
  final ammoWeight = mountedWeapons.fold<double>(0, (sum, mw) => sum + mw.ammoWeight);
  final weaponsSpace = mountedWeapons.fold<double>(0, (sum, mw) => sum + mw.weapon.space);

  final totalCost = bodyPrice +
      suspensionCost +
      powerPlantCost +
      tiresCost +
      armorCost +
      weaponsCost +
      ammoCost;

  final totalWeight = body.weight +
      powerPlantWeight +
      tiresWeight +
      armorWeight +
      weaponsWeight +
      ammoWeight +
      driverWeight;

  final spacesUsed = powerPlantSpacesUsed + weaponsSpace + driverSpaces;
  final spacesAvailable = body.spaces - spacesUsed;

  final handlingClass = suspension.handlingClassFor(body.handlingCategory);

  final isUnderpowered = powerFactors < totalWeight / 3;
  final int acceleration;
  if (isUnderpowered) {
    acceleration = 0;
  } else if (powerFactors < totalWeight / 2) {
    acceleration = 5;
  } else if (powerFactors < totalWeight) {
    acceleration = 10;
  } else {
    acceleration = 15;
  }

  final speedMultiplier = isElectric ? 360 : 240;
  final rawTopSpeed = isUnderpowered
      ? 0.0
      : speedMultiplier * powerFactors / (powerFactors + totalWeight);
  final topSpeed = (rawTopSpeed / 2.5).floor() * 2.5;

  return VehicleStats(
    totalCost: totalCost,
    ammoCost: ammoCost,
    totalWeight: totalWeight.toDouble(),
    maxLoad: maxLoad,
    spacesUsed: spacesUsed,
    spacesAvailable: spacesAvailable,
    handlingClass: handlingClass,
    powerFactors: powerFactors,
    acceleration: acceleration,
    topSpeed: topSpeed,
    isUnderpowered: isUnderpowered,
    driverWeight: driverWeight,
    driverSpaces: driverSpaces,
  );
}
