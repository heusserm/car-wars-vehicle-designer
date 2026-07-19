class TireType {
  const TireType({
    required this.name,
    required this.price,
    required this.weight,
    required this.dp,
  });

  final String name;
  final int price;
  final int weight;
  final int dp;
}

const List<TireType> tireTypes = [
  TireType(name: 'Standard', price: 50, weight: 30, dp: 4),
  TireType(name: 'Heavy-Duty', price: 100, weight: 40, dp: 6),
  TireType(name: 'Puncture-Resistant', price: 200, weight: 50, dp: 9),
  TireType(name: 'Solid', price: 500, weight: 75, dp: 12),
  TireType(name: 'Plasticore', price: 1000, weight: 150, dp: 25),
];
