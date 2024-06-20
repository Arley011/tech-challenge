import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:hymate_test/common_widgets/loading_widget.dart';
import 'package:hymate_test/core/beans/enums/energy_charts_type.dart';
import 'package:hymate_test/core/beans/plot_dataset.dart';
import 'package:hymate_test/core/extenstions/date_time_extenstion.dart';

typedef EnergyChartTypeCallback = void Function(EnergyChartsType? type);
typedef EnergyChartRangeCallback = void Function(
  DateTime start,
  DateTime? end,
);

class EnergyChartsInfo extends StatelessWidget {
  const EnergyChartsInfo({
    super.key,
    required this.selectedType,
    required this.datasetsInfoList,
    required this.onRangeChanged,
    required this.start,
    this.end,
    this.onTypeChanged,
    this.isLoading = false,
  });

  final EnergyChartsType selectedType;
  final EnergyChartTypeCallback? onTypeChanged;
  final EnergyChartRangeCallback onRangeChanged;
  final List<PlotDatasetInfo> datasetsInfoList;
  final bool isLoading;
  final DateTime start;
  final DateTime? end;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LoadingWidget(
      isLoading: isLoading,
      child: Container(
        margin: const EdgeInsets.only(
          left: 24,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: theme.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Text(
                            'Chart Type',
                            style: theme.textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DropdownButton<EnergyChartsType>(
                        items: EnergyChartsType.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.showName,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        alignment: Alignment.center,
                        borderRadius: BorderRadius.circular(8),
                        underline: const SizedBox(),
                        value: selectedType,
                        onChanged: onTypeChanged,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Selected Range',
                            style: theme.textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _showDatePicker(context),
                          child: Text(
                            _getSelectedRangeString(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final e = datasetsInfoList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            width: 16,
                            height: 5,
                            color: e.color,
                          ),
                        ),
                        Text(
                          e.plotLabel ?? 'Unknown label',
                        ),
                      ],
                    ),
                  );
                },
                itemCount: datasetsInfoList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        lastDate: DateTime.now(),
        calendarType: CalendarDatePicker2Type.range,
        firstDayOfWeek: 1,
      ),
      dialogSize: const Size(500, 200),
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        final start = value[0];
        if (start == null) {
          return;
        }
        final end = value.length > 1 ? value[1] : null;
        onRangeChanged(start, end);
      }
    });
  }

  String _getSelectedRangeString() {
    if (end == null) {
      return start.shortDateString;
    }
    return '${start.shortDateString} - ${end!.shortDateString}';
  }
}
