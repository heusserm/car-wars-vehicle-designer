import 'weapon.dart';

/// A weapon mounted on the vehicle under design, plus how much ammo was bought for it.
class MountedWeapon {
  MountedWeapon(this.weapon) : ammoRounds = weapon.ammoPerBox;

  final Weapon weapon;
  int ammoRounds;

  double get ammoCost => ammoRounds * weapon.costPerShot;

  double get ammoWeight => ammoRounds * weapon.weightPerShot;

  /// How many magazines (boxes) of ammo are loaded. Ammo is always bought in
  /// whole boxes of [Weapon.ammoPerBox], so this divides evenly.
  int get magazineCount =>
      weapon.ammoPerBox > 0 ? (ammoRounds / weapon.ammoPerBox).round() : 0;

  /// Magazines beyond the first. The base load comes with the weapon; each
  /// extra magazine adds its own cost/weight/space (see vehicle_calculator).
  int get extraMagazines => magazineCount > 1 ? magazineCount - 1 : 0;
}
