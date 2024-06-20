import 'package:hymate_test/core/beans/plot_dataset.dart';
import 'package:hymate_test/core/utils/color_utils.dart';
import 'package:hymate_test/features/task_1/domain/entities/electricity_price_data_entity.dart';

extension ElectricityPriceDataEntityExtension on ElectricityPriceDataEntity {
  List<PlotDataset<DateTime, double>> toSortedPlotDatasets() {
    final color = ColorUtils.generateLinearColors(1);
    return [
      PlotDataset<DateTime, double>(
        xValues: times,
        yValues: prices,
        info: PlotDatasetInfo(
          color: color.first,
          yLabel: unit,
          plotLabel: 'Electricity Price',
        ),
      ),
    ];
  }
}
