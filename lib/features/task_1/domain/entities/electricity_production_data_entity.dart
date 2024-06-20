import 'package:equatable/equatable.dart';

class ElectricityProductionDataEntity extends Equatable {
  final String name;
  final List<double?> data;

  const ElectricityProductionDataEntity({
    required this.name,
    required this.data,
  });

  @override
  List<Object?> get props => [
        name,
        data,
      ];
}
