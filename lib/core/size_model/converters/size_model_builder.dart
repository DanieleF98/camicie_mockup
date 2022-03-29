import 'package:camicie_mockup/core/size_model/models/size_model.dart';
import 'package:camicie_mockup/utils/utils.dart';

class SizeModelBuilder {
  static SizeModel builder(
    dynamic snapshot,
  ) {
    return SizeModel(
      snapshot['Id'] as String,
      getModelEnumFromString(snapshot['ModelOfShirtEnum'] as String),
      snapshot['Size'] as int,
    );
  }
}
