import 'package:hymate_test/features/challenge/domain/graph.dart';

class Plot {
  final int id;
  final String name;
  final List<dynamic>? xAxisDataSeries;
  final List<Graph> primaryYAxisDataGraphs;

  Plot({
    required this.id,
    required this.name,
    this.xAxisDataSeries,
    required this.primaryYAxisDataGraphs,
  });

  Map<String, dynamic> toJsonApiMap() {
    final singleDataPoints = primaryYAxisDataGraphs
        .where((e) => e.dataPoints.length == 1)
        .map((e) => e.id)
        .toList();
    final combinedDataPoints = primaryYAxisDataGraphs
        .where((e) => e.dataPoints.length > 1)
        .map((e) => {
              'operation': 'sum',
              'datapoints': e.dataPoints.map((e) => e.id).toList(),
              'label': e.name,
            })
        .toList();

    return {
      'id': id,
      'label': name,
      'data': {
        'datapoints': singleDataPoints,
        'extra': combinedDataPoints,
      },
    };
  }
}
