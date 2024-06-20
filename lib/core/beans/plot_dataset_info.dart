part of 'plot_dataset.dart';

class PlotDatasetInfo extends Equatable {
  final Color color;
  final String? xLabel;
  final String? yLabel;
  final String? plotLabel;

  const PlotDatasetInfo({
    required this.color,
    this.xLabel,
    this.yLabel,
    this.plotLabel,
  });

  @override
  List<Object?> get props => [
        color,
        xLabel,
        yLabel,
        plotLabel,
      ];
}
