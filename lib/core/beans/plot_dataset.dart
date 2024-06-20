import 'dart:ui';

import 'package:equatable/equatable.dart';

part 'plot_dataset_info.dart';

class PlotDataset<X, Y> extends Equatable {
  const PlotDataset({
    required this.xValues,
    required this.yValues,
    required this.info,
  });

  final List<X> xValues;
  final List<Y> yValues;
  final PlotDatasetInfo info;

  @override
  List<Object?> get props => [
        xValues,
        yValues,
        info,
      ];
}
