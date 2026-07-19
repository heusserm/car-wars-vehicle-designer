class VehicleArmor {
  VehicleArmor({
    this.front = 0,
    this.back = 0,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.underbody = 0,
  });

  int front;
  int back;
  int left;
  int right;
  int top;
  int underbody;

  int get totalPoints => front + back + left + right + top + underbody;
}
