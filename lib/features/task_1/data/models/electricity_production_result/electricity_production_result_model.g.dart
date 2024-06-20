// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricity_production_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectricityProductionResultModel _$ElectricityProductionResultModelFromJson(
        Map<String, dynamic> json) =>
    ElectricityProductionResultModel(
      timestamps: (json['unix_seconds'] as List<dynamic>)
          .map((e) => const EpochSinceEpochDateTimeConverter()
              .fromJson((e as num).toInt()))
          .toList(),
      productionData: (json['production_types'] as List<dynamic>)
          .map((e) => ElectricityProductionDataModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ElectricityProductionResultModelToJson(
        ElectricityProductionResultModel instance) =>
    <String, dynamic>{
      'unix_seconds': instance.timestamps
          .map(const EpochSinceEpochDateTimeConverter().toJson)
          .toList(),
      'production_types': instance.productionData,
    };
