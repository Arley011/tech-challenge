import 'dart:ui';

import 'package:hymate_test/features/challenge/domain/data_point.dart';


class Graph {
  final String id;
  final String name;
  final List<DataPoint> dataPoints;
  final List<dynamic>? availableXData;
  final Color? color;
  final List<double?>? values;

  Graph({
    required this.id,
    required this.name,
    required this.dataPoints,
    this.availableXData,
    this.color,
    this.values,
  });
}
