import 'package:json_annotation/json_annotation.dart';

class EpochSinceEpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochSinceEpochDateTimeConverter();

  @override
  DateTime fromJson(int json) =>
      DateTime.fromMillisecondsSinceEpoch(json * 1000);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch ~/ 1000;
}
