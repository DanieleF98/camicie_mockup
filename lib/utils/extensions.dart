import 'package:stack/stack.dart';

// ignore: always_specify_types
extension StackExtension on Stack {
  dynamic clear() {
    while (size() != 0) {
      pop();
    }
  }
}
