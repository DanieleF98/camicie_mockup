import 'package:camicie_mockup/core/stats/models/stat.dart';

class StatBuilder {
  static Stat builder(
    dynamic snapshot,
  ) {
    return Stat(
      snapshot['Id'] as String,
      snapshot['FabricId'] as String,
      (snapshot['BuyDates'] as Map<String, dynamic>).map(
        (String k, dynamic e) =>
            MapEntry<DateTime, int>(DateTime.parse(k), e as int),
      ),
    );
  }
}
