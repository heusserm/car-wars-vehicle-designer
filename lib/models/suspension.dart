import 'body_type.dart';

class SuspensionType {
  const SuspensionType({
    required this.name,
    required this.costFactor,
    required this.hcRegular,
    required this.hcVan,
    required this.hcSubcompact,
  });

  final String name;
  /// Fraction of body price (e.g. 1.50 for Heavy = 150% of body cost).
  final double costFactor;
  final int hcRegular;
  final int hcVan;
  final int hcSubcompact;

  int handlingClassFor(HandlingCategory category) {
    switch (category) {
      case HandlingCategory.subcompact:
        return hcSubcompact;
      case HandlingCategory.van:
        return hcVan;
      case HandlingCategory.regular:
        return hcRegular;
    }
  }
}

const List<SuspensionType> suspensionTypes = [
  SuspensionType(name: 'Light', costFactor: 0, hcRegular: 1, hcVan: 0, hcSubcompact: 2),
  SuspensionType(name: 'Improved', costFactor: 1.00, hcRegular: 2, hcVan: 1, hcSubcompact: 3),
  SuspensionType(name: 'Heavy', costFactor: 1.50, hcRegular: 3, hcVan: 2, hcSubcompact: 4),
  SuspensionType(name: 'Off-road', costFactor: 5.00, hcRegular: 2, hcVan: 1, hcSubcompact: 3),
];
