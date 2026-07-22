class TargetingComputer {
  const TargetingComputer({
    required this.name,
    required this.cost,
    this.weight = 0,
    this.space = 0,
  });

  final String name;
  final int cost;
  final double weight;
  final double space;
}

const TargetingComputer noTargetingComputer = TargetingComputer(name: 'None', cost: 0);

/// Regular and Hi-Res Targeting Computers are pure electronics with no
/// weight/space cost. Cyberlink is a driver neural interface that takes up
/// physical space and weight in the vehicle.
const List<TargetingComputer> targetingComputers = [
  noTargetingComputer,
  TargetingComputer(name: 'Targeting Computer', cost: 1000),
  TargetingComputer(name: 'Hi-Res Targeting Computer', cost: 4000),
  TargetingComputer(name: 'Cyberlink', cost: 16000, weight: 100, space: 1),
];
