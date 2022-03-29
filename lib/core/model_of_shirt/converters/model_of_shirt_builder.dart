import 'package:camicie_mockup/core/model_of_shirt/models/model_of_shirt.dart';
import 'package:camicie_mockup/utils/utils.dart';

class ModelOfShirtBuilder {
  static ModelOfShirt builder(
    dynamic snapshot,
  ) {
    return ModelOfShirt(
      snapshot['Id'] as String,
      getModelEnumFromString(snapshot['ModelOfShirtEnum'] as String),
    );
  }
}
