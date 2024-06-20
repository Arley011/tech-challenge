import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hymate_test/core/beans/enums/energy_charts_type.dart';
import 'package:hymate_test/core/beans/enums/state_status_enum.dart';
import 'package:hymate_test/core/beans/optional.dart';
import 'package:hymate_test/core/beans/plot_dataset.dart';
import 'package:hymate_test/core/utils/numbers_util.dart';
import 'package:hymate_test/features/task_1/data/data.dart';
import 'package:hymate_test/features/task_1/presentation/_helpers/_helpers.dart';

part 'energy_charts_state.dart';

class EnergyChartsCubit extends Cubit<EnergyChartsState> {
  EnergyChartsCubit() : super(EnergyChartsState.initial());

  void setEnergyChartsType(EnergyChartsType? type) {
    if (type == state.chartType) {
      return;
    }

    emit(state.copyWith(chartType: type));
    loadData();
  }

  void setTimeRange(DateTime start, DateTime? end) {
    if (start == state.start && end == state.end) {
      return;
    }

    emit(state.copyWith(start: start, end: end.toOptionalNull));
    loadData();
  }

  void loadData() async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      switch (state.chartType) {
        case EnergyChartsType.production:
          await _loadProductionDate();
          break;
        case EnergyChartsType.price:
          await _loadPriceData();
          break;
      }
    } catch (e, st) {
      log(
        'Unexpected error: $e\n$st',
      );
      emit(state.toErrorState);
    }
  }

  Future<void> _loadProductionDate() async {
    final productionData =
        await ElectricityProductionRepository.getProductionData(
      start: state.start,
      end: state.end,
    );
    productionData.fold(
      (l) => emit(state.toErrorState),
      (r) {
        final datasets = r.toSortedPlotDatasets();

        emit(
          state.copyWith(
            status: StateStatus.success,
            datasets: datasets,
            minY: _getMinYWithPadding(datasets).toOptionalNull,
            maxY: _getMaxYWithPadding(datasets).toOptionalNull,
          ),
        );
      },
    );
  }

  Future<void> _loadPriceData() async {
    final priceData = await ElectricityPriceRepository.getElectricityPrice(
      start: state.start,
      end: state.end,
    );
    priceData.fold(
      (l) => emit(state.toErrorState),
      (r) {
        final datasets = r.toSortedPlotDatasets();
        emit(
          state.copyWith(
            status: StateStatus.success,
            datasets: datasets,
            minY: _getMinYWithPadding(datasets).toOptionalNull,
            maxY: _getMaxYWithPadding(datasets).toOptionalNull,
          ),
        );
      },
    );
  }

  double? _getMinYWithPadding(
    List<PlotDataset<DateTime, double?>> datasets, {
    double padding = 0.1,
  }) {
    final minY = _getMinY(datasets);
    final maxY = _getMaxY(datasets);
    final additionalPadding =
        maxY != null && minY != null ? (maxY - minY) * padding : 0;

    return minY != null ? minY - additionalPadding : null;
  }

  double? _getMaxYWithPadding(
    List<PlotDataset<DateTime, double?>> datasets, {
    double padding = 0.1,
  }) {
    final minY = _getMinY(datasets);
    final maxY = _getMaxY(datasets);
    final additionalPadding =
        maxY != null && minY != null ? (maxY - minY) * padding : 0;

    return maxY != null ? maxY + additionalPadding : null;
  }

  double? _getMinY(List<PlotDataset<DateTime, double?>> datasets) {
    return NumbersUtil.getMinElement(
            datasets.map((e) => e.yValues).expand((element) => element))
        ?.toDouble();
  }

  double? _getMaxY(List<PlotDataset<DateTime, double?>> datasets) {
    return NumbersUtil.getMaxElement(
            datasets.map((e) => e.yValues).expand((element) => element))
        ?.toDouble();
  }
}
