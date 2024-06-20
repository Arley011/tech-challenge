import 'package:equatable/equatable.dart';

class ElectricityPriceDataEntity extends Equatable {
  final List<double> prices;
  final List<DateTime> times;
  final String unit;

  const ElectricityPriceDataEntity({
    required this.prices,
    required this.times,
    required this.unit,
  });

  @override
  List<Object?> get props => [
        prices,
        times,
        unit,
      ];
}
