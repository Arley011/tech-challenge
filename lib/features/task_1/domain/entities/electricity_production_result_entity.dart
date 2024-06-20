import 'package:hymate_test/features/task_1/domain/entities/electricity_production_data_entity.dart';

class ElectricityProductionResultEntity {
  final List<DateTime> timestamps;
  final List<ElectricityProductionDataEntity> productionData;

  ElectricityProductionResultEntity({
    required this.timestamps,
    required this.productionData,
  });
}
