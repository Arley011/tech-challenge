import 'package:hymate_test/core/beans/plot_dataset.dart';
import 'package:hymate_test/core/utils/color_utils.dart';
import 'package:hymate_test/features/task_1/domain/entities/electricity_production_result_entity.dart';

extension ElectricityProductionResultEntityExtension
    on ElectricityProductionResultEntity {
  List<PlotDataset<DateTime, double?>> toSortedPlotDatasets() {
    final numberOfPlots = productionData.length;
    final colors = ColorUtils.generateLinearColors(numberOfPlots);
    productionData.sort((a, b) {
      final sumAValue =
          a.data.fold<double>(0, (prev, element) => prev + (element ?? 0));
      final sumBValue =
          b.data.fold<double>(0, (prev, element) => prev + (element ?? 0));
      return sumBValue.compareTo(sumAValue);
    });

    return productionData.map((data) {
      final index = productionData.indexOf(data);
      return PlotDataset<DateTime, double?>(
        xValues: timestamps,
        yValues: data.data,
        info: PlotDatasetInfo(
          color: colors.elementAt(index),
          plotLabel: data.name,
        ),
      );
    }).toList();
  }
}
