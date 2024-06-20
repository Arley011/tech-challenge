import 'package:equatable/equatable.dart';
import 'package:hymate_test/core/mixins/entity_convertible_mixin.dart';
import 'package:hymate_test/features/task_1/domain/entities/electricity_production_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'electricity_production_data_model.g.dart';

@JsonSerializable()
class ElectricityProductionDataModel extends Equatable
    with
        EntityConvertible<ElectricityProductionDataModel,
            ElectricityProductionDataEntity> {
  ElectricityProductionDataModel({
    required this.name,
    required this.data,
  });

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'data')
  final List<double?> data;

  @override
  ElectricityProductionDataEntity toEntity() {
    return ElectricityProductionDataEntity(
      name: name,
      data: data,
    );
  }

  factory ElectricityProductionDataModel.fromJson(Map<String, dynamic> json) =>
      _$ElectricityProductionDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ElectricityProductionDataModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        data,
      ];
}
