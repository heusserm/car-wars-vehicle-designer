class Weapon {
  const Weapon({
    required this.name,
    required this.abbreviation,
    required this.toHit,
    required this.damage,
    required this.dp,
    required this.cost,
    required this.weight,
    required this.space,
    this.ammoPerBox = 0,
    this.costPerShot = 0,
    this.weightPerShot = 0,
  });

  final String name;
  final String abbreviation;
  final String toHit;
  final String damage;
  final int dp;
  final int cost;
  final int weight;
  final double space;

  /// Rounds per box of ammo; 0 means the weapon doesn't use purchasable ammo (energy weapons, single-shot rounds).
  final int ammoPerBox;

  /// Cost per shot fired, in dollars; 0 when ammoPerBox is 0.
  final double costPerShot;

  /// Weight per shot fired, in pounds; 0 when ammoPerBox is 0.
  final double weightPerShot;
}

/// Core offensive weapons from the Weapon Charts (Small/Large-Bore Projectile,
/// Rockets, Lasers, Flamethrowers). Dropped gases/liquids/solids and hand
/// dischargers are left out of this pass.
///
/// ammoPerBox/costPerShot/weightPerShot are cross-checked against the Weapon
/// Charts in the Car Wars Compendium (SJG30-7142), pages 50-51. Where a weapon
/// has multiple ammo types (HEAT/APFSDS/HESH, standard/incendiary, etc.), the
/// base/standard round is used. Grenade Launcher, Mine-Flinger, Micromissile
/// Launcher, and Variable-Fire Rocket Pod are left out: their ammo rules
/// (variable-cost loads, multi-shot pods) are more complex than this app models.
const List<Weapon> weapons = [
  // Small-Bore Projectile Weapons
  Weapon(name: 'Machine Gun', abbreviation: 'MG', toHit: '7', damage: '1d', dp: 3, cost: 1000, weight: 150, space: 1, ammoPerBox: 20, costPerShot: 25, weightPerShot: 2.5),
  Weapon(name: 'Vulcan MG', abbreviation: 'VMG', toHit: '6', damage: '2d', dp: 3, cost: 2000, weight: 350, space: 2, ammoPerBox: 20, costPerShot: 35, weightPerShot: 5),
  Weapon(name: 'Flechette Gun', abbreviation: 'FG', toHit: '6', damage: '1d+1', dp: 2, cost: 700, weight: 100, space: 1, ammoPerBox: 20, costPerShot: 10, weightPerShot: 2.5),
  Weapon(name: 'Vehicular Shotgun', abbreviation: 'VS', toHit: '6', damage: '2 hits', dp: 2, cost: 950, weight: 90, space: 1, ammoPerBox: 10, costPerShot: 5, weightPerShot: 1),
  Weapon(name: 'Gauss Gun', abbreviation: 'GG', toHit: '6', damage: '3d', dp: 4, cost: 10000, weight: 300, space: 2, ammoPerBox: 10, costPerShot: 50, weightPerShot: 10),
  Weapon(name: 'Recoilless Rifle', abbreviation: 'RR', toHit: '7', damage: '2d', dp: 4, cost: 1500, weight: 300, space: 2, ammoPerBox: 10, costPerShot: 35, weightPerShot: 5),
  Weapon(name: 'Autocannon', abbreviation: 'AC', toHit: '6', damage: '3d', dp: 4, cost: 6500, weight: 500, space: 3, ammoPerBox: 10, costPerShot: 75, weightPerShot: 10),

  // Large-Bore Projectile Weapons
  Weapon(name: 'Bomb', abbreviation: 'B', toHit: '9', damage: '4d', dp: 2, cost: 100, weight: 100, space: 2),
  Weapon(name: 'Cluster Bomb', abbreviation: 'CB', toHit: '9', damage: '2d', dp: 2, cost: 200, weight: 150, space: 2),
  Weapon(name: 'Starshell Launcher', abbreviation: 'SL', toHit: '-', damage: '-', dp: 2, cost: 500, weight: 100, space: 1, ammoPerBox: 5, costPerShot: 50, weightPerShot: 5),
  Weapon(name: 'Spike Gun', abbreviation: 'SG', toHit: '7', damage: '1d', dp: 2, cost: 750, weight: 150, space: 2, ammoPerBox: 10, costPerShot: 40, weightPerShot: 10),
  Weapon(name: 'Anti-Tank Gun', abbreviation: 'ATG', toHit: '8', damage: '3d', dp: 6, cost: 2000, weight: 600, space: 3, ammoPerBox: 10, costPerShot: 50, weightPerShot: 10),
  Weapon(name: 'Oil Gun', abbreviation: 'OG', toHit: '7/5', damage: '-', dp: 3, cost: 1000, weight: 250, space: 3, ammoPerBox: 10, costPerShot: 25, weightPerShot: 5),
  Weapon(name: 'Paint Gun', abbreviation: 'PG', toHit: '7/5', damage: '-', dp: 3, cost: 1000, weight: 250, space: 3, ammoPerBox: 10, costPerShot: 25, weightPerShot: 5),
  Weapon(name: 'Blast Cannon', abbreviation: 'BC', toHit: '7', damage: '4d', dp: 5, cost: 4500, weight: 500, space: 4, ammoPerBox: 10, costPerShot: 100, weightPerShot: 10),
  Weapon(name: 'Tank Gun', abbreviation: 'TG', toHit: '7', damage: '8d', dp: 10, cost: 10000, weight: 1200, space: 10, ammoPerBox: 10, costPerShot: 100, weightPerShot: 20),

  // Rockets - most are single-shot rounds where the listed cost already prices
  // one round, so no separate ammo purchase is modeled. Rocket Launcher is
  // magazine-fed per the chart and does have purchasable ammo.
  Weapon(name: 'Mini Rocket', abbreviation: 'MNR', toHit: '9', damage: '1d-1', dp: 1, cost: 50, weight: 20, space: 1 / 3),
  Weapon(name: 'Light Rocket', abbreviation: 'LtR', toHit: '9', damage: '1d', dp: 1, cost: 75, weight: 25, space: 0.5),
  Weapon(name: 'Medium Rocket', abbreviation: 'MR', toHit: '9', damage: '2d', dp: 2, cost: 140, weight: 50, space: 1),
  Weapon(name: 'Heavy Rocket', abbreviation: 'HR', toHit: '9', damage: '3d', dp: 2, cost: 200, weight: 100, space: 1),
  Weapon(name: 'Anti-Power-Plant Rocket', abbreviation: 'APPR', toHit: '9', damage: '1d-1*', dp: 3, cost: 500, weight: 40, space: 1),
  Weapon(name: 'Surface-to-Air Missile', abbreviation: 'SAM', toHit: '6/11', damage: '4d', dp: 1, cost: 500, weight: 150, space: 1),
  Weapon(name: 'Radar-Guided Missile', abbreviation: 'RGM', toHit: '7', damage: '3d', dp: 1, cost: 3000, weight: 100, space: 1),
  Weapon(name: 'Wire-Guided Missile', abbreviation: 'WGM', toHit: '6', damage: '3d', dp: 1, cost: 2000, weight: 100, space: 1),
  Weapon(name: 'Six-Shooter', abbreviation: '-', toHit: '9', damage: '1d*', dp: 2, cost: 450, weight: 150, space: 2),
  Weapon(name: 'Rocket Launcher', abbreviation: 'RL', toHit: '8', damage: '2d', dp: 2, cost: 1000, weight: 200, space: 2, ammoPerBox: 10, costPerShot: 35, weightPerShot: 5),

  // Lasers - draw power from the plant, no purchasable ammo.
  Weapon(name: 'Targeting Laser', abbreviation: 'TL', toHit: '6', damage: '-', dp: 1, cost: 1000, weight: 50, space: 0),
  Weapon(name: 'Light Laser', abbreviation: 'LL', toHit: '6', damage: '1d', dp: 2, cost: 3000, weight: 200, space: 1),
  Weapon(name: 'Medium Laser', abbreviation: 'ML', toHit: '6', damage: '2d', dp: 2, cost: 5500, weight: 350, space: 2),
  Weapon(name: 'Laser', abbreviation: 'L', toHit: '6', damage: '3d', dp: 2, cost: 8000, weight: 500, space: 2),
  Weapon(name: 'Twin Laser', abbreviation: 'TwL', toHit: '6', damage: '2d+6', dp: 3, cost: 10000, weight: 750, space: 2),
  Weapon(name: 'Heavy Laser', abbreviation: 'HL', toHit: '6', damage: '4d', dp: 2, cost: 12000, weight: 500, space: 3),
  Weapon(name: 'X-ray Laser', abbreviation: 'XL', toHit: '7', damage: '4d', dp: 3, cost: 15000, weight: 750, space: 3),
  Weapon(name: 'Heavy X-ray Laser', abbreviation: 'HXL', toHit: '7', damage: '5d', dp: 3, cost: 20000, weight: 1500, space: 3),

  // Flamethrowers
  Weapon(name: 'Light Flamethrower', abbreviation: 'LFT', toHit: '6', damage: '1d-2', dp: 1, cost: 350, weight: 250, space: 1, ammoPerBox: 10, costPerShot: 15, weightPerShot: 3),
  Weapon(name: 'Flamethrower', abbreviation: 'FT', toHit: '6', damage: '1d', dp: 2, cost: 500, weight: 450, space: 2, ammoPerBox: 10, costPerShot: 25, weightPerShot: 5),
  Weapon(name: 'HD Flamethrower', abbreviation: 'HDFT', toHit: '6', damage: '2d', dp: 3, cost: 1250, weight: 650, space: 3, ammoPerBox: 10, costPerShot: 50, weightPerShot: 10),
];
