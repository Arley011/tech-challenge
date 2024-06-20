import 'package:equatable/equatable.dart';
import 'package:hymate_test/core/converters/epoch_date_time_converter.dart';
import 'package:hymate_test/core/mixins/entity_convertible_mixin.dart';
import 'package:hymate_test/features/task_1/data/models/electricity_production_data/electricity_production_data_model.dart';
import 'package:hymate_test/features/task_1/domain/entities/electricity_production_result_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'electricity_production_result_model.g.dart';

@JsonSerializable()
class ElectricityProductionResultModel extends Equatable
    with
        EntityConvertible<ElectricityProductionResultModel,
            ElectricityProductionResultEntity> {
  const ElectricityProductionResultModel({
    required this.timestamps,
    required this.productionData,
  });

  @JsonKey(name: 'unix_seconds')
  @EpochSinceEpochDateTimeConverter()
  final List<DateTime> timestamps;

  @JsonKey(name: 'production_types')
  final List<ElectricityProductionDataModel> productionData;

  @override
  ElectricityProductionResultEntity toEntity() {
    return ElectricityProductionResultEntity(
      timestamps: timestamps,
      productionData: productionData.map((e) => e.toEntity()).toList(),
    );
  }

  factory ElectricityProductionResultModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ElectricityProductionResultModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ElectricityProductionResultModelToJson(this);

  @override
  List<Object?> get props => [
        timestamps,
        productionData,
      ];
}
