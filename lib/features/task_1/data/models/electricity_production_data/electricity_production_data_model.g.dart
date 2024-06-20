// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricity_production_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectricityProductionDataModel _$ElectricityProductionDataModelFromJson(
        Map<String, dynamic> json) =>
    ElectricityProductionDataModel(
      name: json['name'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as num?)?.toDouble())
          .toList(),
    );

Map<String, dynamic> _$ElectricityProductionDataModelToJson(
        ElectricityProductionDataModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
    };
