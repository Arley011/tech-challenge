import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hymate_test/core/exceptions/network_exception.dart';
import 'package:hymate_test/core/extenstions/map_extension.dart';
import 'package:hymate_test/core/extenstions/date_time_extenstion.dart';
import 'package:hymate_test/core/network/energy_charts_client.dart';
import 'package:hymate_test/features/task_1/data/models/electricity_price_data/electricity_price_data_model.dart';
import 'package:hymate_test/features/task_1/domain/entities/electricity_price_data_entity.dart';

class ElectricityPriceRepository {
  static Future<Either<NetworkException, ElectricityPriceDataEntity>>
      getElectricityPrice({
    required DateTime start,
    DateTime? end,
  }) async {
    try {
      final priceDataResponse = await EnergyChartsClient.instance.get(
        '/price',
        queryParameters: {
          'bzn': 'DE-LU',
        }
          ..putIfNotNull('start', start.dateInIso8601)
          ..putIfNotNull('end', end?.dateInIso8601),
      );

      final priceDataModel = ElectricityPriceDataModel.fromJson(
        priceDataResponse.data as Map<String, dynamic>,
      );

      return Right(priceDataModel.toEntity());
    } on DioException catch (e, st) {
      log(
        'Error while fetching electricity price data: $e',
        error: e,
        stackTrace: st,
      );
      return Left(NetworkException.fromDioError(e));
    }
  }
}
