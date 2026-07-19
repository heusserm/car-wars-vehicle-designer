enum HandlingCategory { subcompact, van, regular }

class BodyType {
  const BodyType({
    required this.name,
    required this.price,
    required this.weight,
    required this.maxLoad,
    required this.spaces,
    required this.cargoSpaces,
    required this.armorCostPerPoint,
    required this.armorWeightPerPoint,
    required this.handlingCategory,
  });

  final String name;
  final int price;
  final int weight;
  final int maxLoad;
  final int spaces;
  final int cargoSpaces;
  final int armorCostPerPoint;
  final int armorWeightPerPoint;
  final HandlingCategory handlingCategory;
}

const List<BodyType> bodyTypes = [
  BodyType(
    name: 'Subcompact',
    price: 300,
    weight: 1000,
    maxLoad: 2300,
    spaces: 7,
    cargoSpaces: 0,
    armorCostPerPoint: 11,
    armorWeightPerPoint: 5,
    handlingCategory: HandlingCategory.subcompact,
  ),
  BodyType(
    name: 'Compact',
    price: 400,
    weight: 1300,
    maxLoad: 3700,
    spaces: 10,
    cargoSpaces: 0,
    armorCostPerPoint: 13,
    armorWeightPerPoint: 6,
    handlingCategory: HandlingCategory.regular,
  ),
  BodyType(
    name: 'Mid-sized',
    price: 600,
    weight: 1600,
    maxLoad: 4800,
    spaces: 13,
    cargoSpaces: 0,
    armorCostPerPoint: 16,
    armorWeightPerPoint: 8,
    handlingCategory: HandlingCategory.regular,
  ),
  BodyType(
    name: 'Sedan',
    price: 700,
    weight: 1700,
    maxLoad: 5100,
    spaces: 16,
    cargoSpaces: 0,
    armorCostPerPoint: 18,
    armorWeightPerPoint: 9,
    handlingCategory: HandlingCategory.regular,
  ),
  BodyType(
    name: 'Luxury',
    price: 800,
    weight: 1800,
    maxLoad: 5500,
    spaces: 19,
    cargoSpaces: 0,
    armorCostPerPoint: 20,
    armorWeightPerPoint: 10,
    handlingCategory: HandlingCategory.regular,
  ),
  BodyType(
    name: 'Station Wagon',
    price: 800,
    weight: 1800,
    maxLoad: 5500,
    spaces: 14,
    cargoSpaces: 7,
    armorCostPerPoint: 20,
    armorWeightPerPoint: 10,
    handlingCategory: HandlingCategory.regular,
  ),
  BodyType(
    name: 'Pickup',
    price: 900,
    weight: 2100,
    maxLoad: 6500,
    spaces: 13,
    cargoSpaces: 11,
    armorCostPerPoint: 22,
    armorWeightPerPoint: 11,
    handlingCategory: HandlingCategory.van,
  ),
  BodyType(
    name: 'Camper',
    price: 1400,
    weight: 2300,
    maxLoad: 6500,
    spaces: 17,
    cargoSpaces: 7,
    armorCostPerPoint: 30,
    armorWeightPerPoint: 14,
    handlingCategory: HandlingCategory.van,
  ),
  BodyType(
    name: 'Van',
    price: 1000,
    weight: 2000,
    maxLoad: 6000,
    spaces: 24,
    cargoSpaces: 6,
    armorCostPerPoint: 30,
    armorWeightPerPoint: 14,
    handlingCategory: HandlingCategory.van,
  ),
];
