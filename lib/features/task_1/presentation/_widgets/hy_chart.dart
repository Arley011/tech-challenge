import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hymate_test/common_widgets/loading_widget.dart';
import 'package:hymate_test/core/beans/plot_dataset.dart';
import 'package:hymate_test/core/extenstions/date_time_extenstion.dart';

class HyTimeChart extends StatelessWidget {
  const HyTimeChart({
    super.key,
    required this.datasets,
    this.maxY,
    this.minY,
    this.isLoading = false,
    this.isError = false,
    required this.onReload,
  });

  final List<PlotDataset<DateTime, double?>> datasets;
  final double? maxY;
  final double? minY;
  final bool isLoading;
  final bool isError;
  final VoidCallback onReload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final xInterval = _getXInterval();
    return AspectRatio(
      aspectRatio: 2.0,
      child: LoadingWidget(
        isLoading: isLoading,
        isError: isError,
        onRetry: onReload,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              for (final dataset in datasets)
                LineChartBarData(
                  show: true,
                  color: dataset.info.color,
                  belowBarData: BarAreaData(
                    show: datasets.length < 5,
                    gradient: LinearGradient(
                      colors: [
                        dataset.info.color.withOpacity(0.3),
                        dataset.info.color.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  spots: dataset.xValues.where((e) {
                    final index = dataset.xValues.indexOf(e);
                    return dataset.yValues[index] != null;
                  }).mapWithIndex((val, index) {
                    return FlSpot(
                      val.secondsSinceEpoch.toDouble(),
                      dataset.yValues[index]!,
                    );
                  }).toList(),
                  dotData: const FlDotData(
                    show: false,
                  ),
                ),
            ],
            lineTouchData: const LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                fitInsideVertically: true,
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 50,
                  showTitles: true,
                  interval: xInterval?.toDouble(),
                  getTitlesWidget: (value, meta) {
                    if (value % meta.appliedInterval != 0) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _getTimeString(
                          value.toInt(),
                          xInterval ?? meta.appliedInterval,
                        ),
                        style: theme.textTheme.labelSmall,
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                axisNameSize: 50,
                axisNameWidget:
                datasets.isNotEmpty && datasets.first.info.yLabel != null
                    ? Text(
                  datasets.first.info.yLabel!,
                  style: theme.textTheme.titleMedium,
                )
                    : null,
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    if (value % meta.appliedInterval != 0) {
                      return const SizedBox();
                    }
                    return Text(
                      value.toString(),
                      style: theme.textTheme.labelSmall,
                    );
                  },
                ),
              ),
              rightTitles: const AxisTitles(),
              topTitles: const AxisTitles(),
            ),
            maxY: maxY,
            minY: minY,
          ),
        ),
      ),
    );
  }

  String _getTimeString(int val, double interval) {
    final intervalDuration = Duration(seconds: interval.toInt());
    if (intervalDuration.inDays > 0) {
      return DateTimeExtension.fromSecondsSinceEpoch(val).shortDateString;
    } else if (intervalDuration.inMinutes / 60 > 2.4) {
      return DateTimeExtension.fromSecondsSinceEpoch(val)
          .shortDateTimeStringTwoLines;
    } else {
      return DateTimeExtension.fromSecondsSinceEpoch(val).shortTimeString;
    }
  }

  double? _getXInterval() {
    if (datasets.isEmpty ||
        datasets.first.xValues.isEmpty ||
        datasets.first.xValues.length < 10) {
      return null;
    }
    final first = datasets.first;
    final last = datasets.last;
    final diff = last.xValues.last.difference(first.xValues.first);
    return (diff.inSeconds ~/ 10).toDouble();
  }
}
