import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hymate_test/features/task_1/presentation/_widgets/_widgets.dart';
import 'package:hymate_test/features/task_1/presentation/cubits/energy_charts/energy_charts_cubit.dart';

class Task1View extends StatelessWidget {
  const Task1View({super.key});

  static const String routeName = '/task1';

  static PageRoute<T> route<T>() {
    return MaterialPageRoute<T>(
      builder: (_) => BlocProvider<EnergyChartsCubit>(
        create: (_) => EnergyChartsCubit()..loadData(),
        child: const Task1View(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task 1',
        ),
      ),
      body: BlocBuilder<EnergyChartsCubit, EnergyChartsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              top: mediaQuery.size.height * 0.1,
              bottom: mediaQuery.size.height * 0.1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: mediaQuery.size.width * 0.4,
                    maxWidth: mediaQuery.size.width * 0.7,
                  ),
                  child: HyTimeChart(
                    isLoading: state.status.isLoading,
                    isError: state.status.isError,
                    onReload: context.read<EnergyChartsCubit>().loadData,
                    datasets: state.datasets,
                    maxY: state.maxY,
                    minY: state.minY,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: mediaQuery.size.width * 0.15,
                    maxWidth: mediaQuery.size.width * 0.25,
                  ),
                  child: EnergyChartsInfo(
                    isLoading: state.status.isLoading,
                    datasetsInfoList:
                        state.datasets.map((e) => e.info).toList(),
                    selectedType: state.chartType,
                    onTypeChanged: !state.status.isLoading
                        ? context.read<EnergyChartsCubit>().setEnergyChartsType
                        : null,
                    onRangeChanged:
                        context.read<EnergyChartsCubit>().setTimeRange,
                    start: state.start,
                    end: state.end,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
