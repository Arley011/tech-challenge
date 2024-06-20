import 'package:equatable/equatable.dart';
import 'package:hymate_test/core/converters/epoch_date_time_converter.dart';
import 'package:hymate_test/core/mixins/entity_convertible_mixin.dart';
import 'package:hymate_test/features/task_1/domain/entities/electricity_price_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'electricity_price_data_model.g.dart';

@JsonSerializable()
class ElectricityPriceDataModel extends Equatable
    with
        EntityConvertible<ElectricityPriceDataModel,
            ElectricityPriceDataEntity> {
  @JsonKey(name: 'price')
  final List<double> prices;

  @JsonKey(name: 'unix_seconds')
  @EpochSinceEpochDateTimeConverter()
  final List<DateTime> times;

  @JsonKey(name: 'unit')
  final String unit;

  const ElectricityPriceDataModel({
    required this.prices,
    required this.times,
    required this.unit,
  });

  factory ElectricityPriceDataModel.fromJson(Map<String, dynamic> json) =>
      _$ElectricityPriceDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ElectricityPriceDataModelToJson(this);

  @override
  ElectricityPriceDataEntity toEntity() {
    return ElectricityPriceDataEntity(
      prices: prices,
      times: times,
      unit: unit,
    );
  }

  @override
  List<Object?> get props => [
        prices,
        times,
        unit,
      ];
}
