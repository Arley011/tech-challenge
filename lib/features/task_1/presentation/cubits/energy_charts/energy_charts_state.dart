part of 'energy_charts_cubit.dart';

class EnergyChartsState extends Equatable {
  const EnergyChartsState({
    required this.chartType,
    required this.status,
    required this.datasets,
    required this.start,
    this.end,
    this.minY,
    this.maxY,
  });

  factory EnergyChartsState.initial() {
    return EnergyChartsState(
      chartType: EnergyChartsType.price,
      status: StateStatus.initial,
      datasets: const [],
      start: DateTime.now(),
    );
  }

  final EnergyChartsType chartType;
  final StateStatus status;
  final List<PlotDataset<DateTime, double?>> datasets;
  final DateTime start;
  final DateTime? end;
  final double? minY;
  final double? maxY;

  EnergyChartsState get toErrorState => copyWith(
        status: StateStatus.error,
        datasets: [],
        minY: const Optional.empty(),
        maxY: const Optional.empty(),
      );

  EnergyChartsState copyWith({
    EnergyChartsType? chartType,
    StateStatus? status,
    List<PlotDataset<DateTime, double?>>? datasets,
    DateTime? start,
    Optional<DateTime?>? end,
    Optional<double?>? minY,
    Optional<double?>? maxY,
  }) {
    return EnergyChartsState(
      chartType: chartType ?? this.chartType,
      status: status ?? this.status,
      datasets: datasets ?? this.datasets,
      start: start ?? this.start,
      end: Optional.resolve(end, this.end),
      minY: Optional.resolve(minY, this.minY),
      maxY: Optional.resolve(maxY, this.maxY),
    );
  }

  @override
  List<Object?> get props => [
        chartType,
        status,
        datasets,
        start,
        end,
        minY,
        maxY,
      ];
}
