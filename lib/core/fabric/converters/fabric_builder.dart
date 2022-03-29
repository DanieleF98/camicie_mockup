import 'package:camicie_mockup/core/fabric/models/fabric.dart';
import 'package:camicie_mockup/utils/utils.dart';

class FabricBuilder {
  static Fabric builder(
    dynamic snapshot,
  ) {
    return Fabric(
      snapshot['Id'] as String,
      snapshot['Size'] as int,
      getModelEnumFromString(snapshot['ModelOfShirtEnum'] as String),
      snapshot['TotalAmount'] as int,
      snapshot['ImageUrl'] as String,
      snapshot['FabricName'] as String,
    );
  }
}
