// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricity_price_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectricityPriceDataModel _$ElectricityPriceDataModelFromJson(
        Map<String, dynamic> json) =>
    ElectricityPriceDataModel(
      prices: (json['price'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      times: (json['unix_seconds'] as List<dynamic>)
          .map((e) => const EpochSinceEpochDateTimeConverter()
              .fromJson((e as num).toInt()))
          .toList(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$ElectricityPriceDataModelToJson(
        ElectricityPriceDataModel instance) =>
    <String, dynamic>{
      'price': instance.prices,
      'unix_seconds': instance.times
          .map(const EpochSinceEpochDateTimeConverter().toJson)
          .toList(),
      'unit': instance.unit,
    };
