import 'weapon.dart';

/// A weapon mounted on the vehicle under design, plus how much ammo was bought for it.
class MountedWeapon {
  MountedWeapon(this.weapon) : ammoRounds = weapon.ammoPerBox;

  final Weapon weapon;
  int ammoRounds;

  double get ammoCost => ammoRounds * weapon.costPerShot;

  double get ammoWeight => ammoRounds * weapon.weightPerShot;
}
