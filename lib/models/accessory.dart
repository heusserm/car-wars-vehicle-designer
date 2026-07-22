class Accessory {
  const Accessory({
    required this.name,
    required this.cost,
    this.weight = 0,
    this.space = 0,
    this.description = '',
  });

  final String name;
  final int cost;
  final double weight;
  final double space;

  /// Special rules text shown to the user; not used in the calculations.
  final String description;
}

const List<Accessory> accessories = [
  Accessory(
    name: 'Antilock Braking System (ABS)',
    cost: 1000,
    description: 'Eliminates tire damage from rapid deceleration and reduces '
        'braking hazards (rain, snow, ice, oil, gravel) by D1. Cannot be used '
        'on oversized vehicles.',
  ),
  Accessory(
    name: 'Active Suspension',
    cost: 4000,
    weight: 100,
    description: 'Adds 1 to the HC of any car, trike or cycle (not off-road). '
        'If a wheel is lost, the vehicle suffers a D6 hazard instead of going '
        'directly to HC -6, and its HC drops by 2 instead of 3.',
  ),
  Accessory(
    name: 'Gunner',
    cost: 0,
    weight: 150,
    space: 1,
    description: 'A crew member to operate weapons.',
  ),
  Accessory(
    name: 'Gunner w/ Body Armor',
    cost: 250,
    weight: 150,
    space: 1,
    description: 'A crew member to operate weapons, wearing body armor '
        '(3 hits before it is useless, doubling DP from 3 to 6).',
  ),
  Accessory(
    name: 'No-Paint Windshield',
    cost: 1000,
    description: 'Paint clouds have no effect on vehicles equipped with this '
        'windshield. Helmets and gas masks can be modified with this material '
        'for \$100.',
  ),
  Accessory(
    name: 'Laser Battery',
    cost: 500,
    weight: 100,
    space: 1,
    description: '1 DP. Located adjacent to the power plant and destroyed after '
        'it is. Required for a gas-powered vehicle to fire lasers or run '
        'power-draining electronics (radar, IR, etc.). Holds 100 power units. A '
        'recharge costs \$10 and takes two minutes.',
  ),
  Accessory(
    name: 'Link',
    cost: 50,
    description: 'Links two or more pieces of equipment so they can both be '
        'activated by a single firing action. Normally used on weapons, but can '
        'be hooked to other equipment. See Linked Weapons, p. 45.',
  ),
  Accessory(
    name: 'Fire Extinguisher',
    cost: 300,
    weight: 150,
    space: 1,
    description: 'Roll 1 die at the end of each turn the vehicle is on fire. On '
        'a 1 to 3 (1 to 2 with a gas engine), the fire is put out. Destroyed '
        'when the power plant is destroyed.',
  ),
  Accessory(
    name: 'Overdrive',
    cost: 400, // \$100 per wheel; priced for the standard 4-wheel vehicle
    description: r'$100 per wheel (must be bought for all wheels). Increases top '
        'speed by 20 mph when activated, but reduces acceleration by 5 mph '
        '(minimum 2.5 mph). Activation/deactivation is a firing action. If '
        'deactivated above normal top speed, the vehicle must decelerate at '
        'least 15 mph per turn until at or below its pre-overdrive maximum. '
        'Power consumption while active is figured as if going 20 mph slower. '
        'Installation is a Hard job. Cannot be used on hovercraft, boats or '
        'helicopters.',
  ),
];
